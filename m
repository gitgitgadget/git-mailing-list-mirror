From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix approxidate() to understand more extended numbers
Date: Thu, 28 Sep 2006 12:14:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 28 21:14:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1LE-0000x2-LI
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWI1TOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWI1TOi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:14:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161011AbWI1TOh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 15:14:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SJEWnW026979
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 12:14:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SJERuD019783;
	Thu, 28 Sep 2006 12:14:29 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28038>


You can now say "5:35 PM yesterday", and approxidate() gets the right answer.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Useful? Of course. In a sick and twisted sort of way.

Try to say "yesterday at 5 PM" before and after this. It _really_ was 
confused before.

diff --git a/date.c b/date.c
index 4ff6604..db4c185 100644
--- a/date.c
+++ b/date.c
@@ -598,6 +598,32 @@ static void date_tea(struct tm *tm, int 
 	date_time(tm, 17);
 }
 
+static void date_pm(struct tm *tm, int *num)
+{
+	int hour = *num;
+	*num = 0;
+
+	if (hour > 0 && hour < 12) {
+		tm->tm_hour = hour;
+		tm->tm_min = 0;
+		tm->tm_sec = 0;
+	}
+	if (tm->tm_hour > 0 && tm->tm_hour < 12)
+		tm->tm_hour += 12;
+}
+
+static void date_am(struct tm *tm, int *num)
+{
+	int hour = *num;
+	*num = 0;
+
+	if (hour > 0 && hour < 12) {
+		tm->tm_hour = hour;
+		tm->tm_min = 0;
+		tm->tm_sec = 0;
+	}
+}
+
 static const struct special {
 	const char *name;
 	void (*fn)(struct tm *, int *);
@@ -606,6 +632,8 @@ static const struct special {
 	{ "noon", date_noon },
 	{ "midnight", date_midnight },
 	{ "tea", date_tea },
+	{ "PM", date_pm },
+	{ "AM", date_am },
 	{ NULL }
 };
 
@@ -717,6 +745,18 @@ static const char *approxidate_digit(con
 	char *end;
 	unsigned long number = strtoul(date, &end, 10);
 
+	switch (*end) {
+	case ':':
+	case '.':
+	case '/':
+	case '-':
+		if (isdigit(end[1])) {
+			int match = match_multi_number(number, *end, date, end, tm);
+			if (match)
+				return date + match;
+		}
+	}
+
 	*num = number;
 	return end;
 }
