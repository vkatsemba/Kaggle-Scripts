---
title: "Hillary Clinton Emails"
author: "Vadim Katsemba"
date: "December 21, 2015"
output: html_document
---

The Hillary Clinton email controversy is still ongoing, let's investigate some of the emails.

First, we must connect to the database.
```{r}
library(RSQLite)
database <- dbConnect(dbDriver("SQLite"), "database.sqlite")
```

Then we shall look at 5 random e-mail senders.
```{r}
senders <- dbGetQuery(database, "SELECT p.Name, COUNT(p.Name) SentEmails
FROM Emails e
INNER JOIN Persons p ON e.SenderPersonId=p.Id
GROUP BY p.Name
ORDER BY RANDOM() DESC
LIMIT 5")
```

We shall use a bar graph to represent the number of emails sent for every random sender.
```{r}
library(ggplot2)
ggplot(senders, aes(x=reorder(Name, SentEmails), y=SentEmails)) + geom_bar(stat="identity") + labs(x="Sender", y="Emails Sent")
```

We are going to repeat the same process for the e-mail recipients.
```{r}
recipients <- dbGetQuery(database, "SELECT p.Name, COUNT(p.Name) ReceivedEmails
FROM Emails e
INNER JOIN EmailReceivers r ON r.EmailId=e.Id
INNER JOIN Persons p ON r.PersonId=p.Id
GROUP BY p.Name
ORDER BY RANDOM() DESC
LIMIT 5")
```

And again, a bar graph represents the amount of emails for every random recipient.
```{r}
library(ggplot2)
ggplot(recipients, aes(x=reorder(Name, ReceivedEmails), y=ReceivedEmails)) + geom_bar(stat="identity") + labs(x="Recipient", y="Emails Received")
```


