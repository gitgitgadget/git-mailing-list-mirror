From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Improve on 'approxidate'
Date: Sat, 22 Aug 2009 15:10:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 00:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meyn0-0007Sb-GA
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 00:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbZHVWKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933198AbZHVWKL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 18:10:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45859 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755268AbZHVWKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 18:10:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7MMA8YW004950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Aug 2009 15:10:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7MMA7pI010274;
	Sat, 22 Aug 2009 15:10:07 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126823>


This is not a new failure mode - approxidate has always been kind of 
random in the input it accepts, but some of the randomness is more 
irritating than others.

For example:

	Jun 6, 5AM -> Mon Jun 22 05:00:00 2009
	5AM Jun 6 -> Sat Jun  6 05:00:00 2009

Whaa? The reason for the above is that approxidate squirrells away the '6' 
from "Jun 6" to see if it's going to be a relative number, and then 
forgets about it when it sees a new number (the '5' in '5AM'). So the odd 
"June 22" date is because today is July 22nd, and if it doesn't have 
another day of the month, it will just pick todays mday - having ignored 
the '6' entirely due to getting all excited about seeing a new number (5).

There are other oddnesses. This does not fix them all, but I think it 
makes for fewer _really_ perplexing cases. At least now we have

	Jun 6, 5AM -> Sat Jun  6 05:00:00 2009
	5AM, Jun 6 -> Sat Jun  6 05:00:00 2009

which makes me happier. I can still point to cases that don't work as 
well, but those are separate issues.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 date.c |   93 +++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/date.c b/date.c
index 409a17d..51c6461 100644
--- a/date.c
+++ b/date.c
@@ -525,11 +525,8 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		}
 	}
 
-	if (num > 0 && num < 32) {
-		tm->tm_mday = num;
-	} else if (num > 0 && num < 13) {
+	if (num > 0 && num < 13 && tm->tm_mon < 0)
 		tm->tm_mon = num-1;
-	}
 
 	return n;
 }
@@ -657,42 +654,59 @@ void datestamp(char *buf, int bufsize)
 	date_string(now, offset, buf, bufsize);
 }
 
-static void update_tm(struct tm *tm, unsigned long sec)
+/*
+ * Relative time update (eg "2 days ago").  If we haven't set the time
+ * yet, we need to set it from current time.
+ */
+static unsigned long update_tm(struct tm *tm, struct tm *now, unsigned long sec)
 {
-	time_t n = mktime(tm) - sec;
+	time_t n;
+
+	if (tm->tm_mday < 0)
+		tm->tm_mday = now->tm_mday;
+	if (tm->tm_mon < 0)
+		tm->tm_mon = now->tm_mon;
+	if (tm->tm_year < 0) {
+		tm->tm_year = now->tm_year;
+		if (tm->tm_mon > now->tm_mon)
+			tm->tm_year--;
+	}
+
+	n = mktime(tm) - sec;
 	localtime_r(&n, tm);
+	return n;
 }
 
-static void date_yesterday(struct tm *tm, int *num)
+static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 {
-	update_tm(tm, 24*60*60);
+	update_tm(tm, now, 24*60*60);
 }
 
-static void date_time(struct tm *tm, int hour)
+static void date_time(struct tm *tm, struct tm *now, int hour)
 {
 	if (tm->tm_hour < hour)
-		date_yesterday(tm, NULL);
+		date_yesterday(tm, now, NULL);
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
 	tm->tm_sec = 0;
 }
 
-static void date_midnight(struct tm *tm, int *num)
+static void date_midnight(struct tm *tm, struct tm *now, int *num)
 {
-	date_time(tm, 0);
+	date_time(tm, now, 0);
 }
 
-static void date_noon(struct tm *tm, int *num)
+static void date_noon(struct tm *tm, struct tm *now, int *num)
 {
-	date_time(tm, 12);
+	date_time(tm, now, 12);
 }
 
-static void date_tea(struct tm *tm, int *num)
+static void date_tea(struct tm *tm, struct tm *now, int *num)
 {
-	date_time(tm, 17);
+	date_time(tm, now, 17);
 }
 
-static void date_pm(struct tm *tm, int *num)
+static void date_pm(struct tm *tm, struct tm *now, int *num)
 {
 	int hour, n = *num;
 	*num = 0;
@@ -706,7 +720,7 @@ static void date_pm(struct tm *tm, int *num)
 	tm->tm_hour = (hour % 12) + 12;
 }
 
-static void date_am(struct tm *tm, int *num)
+static void date_am(struct tm *tm, struct tm *now, int *num)
 {
 	int hour, n = *num;
 	*num = 0;
@@ -720,7 +734,7 @@ static void date_am(struct tm *tm, int *num)
 	tm->tm_hour = (hour % 12);
 }
 
-static void date_never(struct tm *tm, int *num)
+static void date_never(struct tm *tm, struct tm *now, int *num)
 {
 	time_t n = 0;
 	localtime_r(&n, tm);
@@ -728,7 +742,7 @@ static void date_never(struct tm *tm, int *num)
 
 static const struct special {
 	const char *name;
-	void (*fn)(struct tm *, int *);
+	void (*fn)(struct tm *, struct tm *, int *);
 } special[] = {
 	{ "yesterday", date_yesterday },
 	{ "noon", date_noon },
@@ -757,7 +771,7 @@ static const struct typelen {
 	{ NULL }
 };
 
-static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
+static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm *now, int *num)
 {
 	const struct typelen *tl;
 	const struct special *s;
@@ -778,7 +792,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
 	for (s = special; s->name; s++) {
 		int len = strlen(s->name);
 		if (match_string(date, s->name) == len) {
-			s->fn(tm, num);
+			s->fn(tm, now, num);
 			return end;
 		}
 	}
@@ -800,7 +814,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
 	while (tl->type) {
 		int len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
-			update_tm(tm, tl->length * *num);
+			update_tm(tm, now, tl->length * *num);
 			*num = 0;
 			return end;
 		}
@@ -818,7 +832,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
 				n++;
 			diff += 7*n;
 
-			update_tm(tm, diff * 24 * 60 * 60);
+			update_tm(tm, now, diff * 24 * 60 * 60);
 			return end;
 		}
 	}
@@ -866,6 +880,22 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	return end;
 }
 
+/*
+ * Do we have a pending number at the end, or when
+ * we see a new one? Let's assume it's a month day,
+ * as in "Dec 6, 1992"
+ */
+static void pending_number(struct tm *tm, int *num)
+{
+	int number = *num;
+
+	if (number) {
+		*num = 0;
+		if (tm->tm_mday < 0 && number < 32)
+			tm->tm_mday = number;
+	}
+}
+
 unsigned long approxidate(const char *date)
 {
 	int number = 0;
@@ -881,21 +911,24 @@ unsigned long approxidate(const char *date)
 	time_sec = tv.tv_sec;
 	localtime_r(&time_sec, &tm);
 	now = tm;
+
+	tm.tm_year = -1;
+	tm.tm_mon = -1;
+	tm.tm_mday = -1;
+
 	for (;;) {
 		unsigned char c = *date;
 		if (!c)
 			break;
 		date++;
 		if (isdigit(c)) {
+			pending_number(&tm, &number);
 			date = approxidate_digit(date-1, &tm, &number);
 			continue;
 		}
 		if (isalpha(c))
-			date = approxidate_alpha(date-1, &tm, &number);
+			date = approxidate_alpha(date-1, &tm, &now, &number);
 	}
-	if (number > 0 && number < 32)
-		tm.tm_mday = number;
-	if (tm.tm_mon > now.tm_mon && tm.tm_year == now.tm_year)
-		tm.tm_year--;
-	return mktime(&tm);
+	pending_number(&tm, &number);
+	return update_tm(&tm, &now, 0);
 }
