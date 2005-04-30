From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sun, 1 May 2005 00:54:34 +0200
Message-ID: <20050501005434.2d47131a.froese@gmx.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<87zmvganq9.fsf@windlord.stanford.edu>
	<1114848175.24014.35.camel@localhost.localdomain>
	<20050430124048.79119cac.froese@gmx.de>
	<87r7gs87a9.fsf@windlord.stanford.edu>
	<Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:59:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3ig-0001qL-6p
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVD3WzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVD3WzX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 18:55:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:22172 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261447AbVD3Wym (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 18:54:42 -0400
Received: (qmail invoked by alias); 30 Apr 2005 22:54:40 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp031) with SMTP; 01 May 2005 00:54:40 +0200
X-Authenticated: #271361
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>
> [...] I just rewrote it to give "almost correct 
> results" for "pretty much any crap you throw at it".

And I had the impression the strict checks in the original
version were intentionally ;-)

> I'll probably tweak it a bit more (make "no timezone means local 
> timezone", for example, rather than UTC like it is now).

Here's my try on that.  But whether it works everywhere ...

Btw, your %+03d%02d printf gave wrong results for i.e. -0130 (-01-30).



--- k/date.c  (mode:100644)
+++ l/date.c  (mode:100644)
@@ -10,7 +10,9 @@
 #include <ctype.h>
 #include <time.h>
 
-static time_t my_mktime(struct tm *tm)
+#define NO_TZ	11111
+
+static time_t utc_mktime(struct tm *tm)
 {
 	static const int mdays[] = {
 	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
@@ -23,12 +25,19 @@ static time_t my_mktime(struct tm *tm)
 		return -1;
 	if (month < 0 || month > 11) /* array bounds */
 		return -1;
+	if (day < 1 || day > 31)
+		return -1;
 	if (month < 2 || (year + 2) % 4)
 		day--;
 	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
 		tm->tm_hour * 60*60 + tm->tm_min * 60 + tm->tm_sec;
 }
 
+static int local_offset(time_t *when)
+{
+	return (utc_mktime(localtime(when)) - *when) / 60;
+}
+
 static const char *month_names[] = {
 	"January", "February", "March", "April", "May", "June",
 	"July", "August", "September", "October", "November", "December"
@@ -138,7 +147,8 @@ static int match_alpha(const char *date,
 	for (i = 0; i < NR_TZ; i++) {
 		int match = match_string(date, timezone_names[i].name);
 		if (match >= 3) {
-			*offset = 60*timezone_names[i].offset;
+			if (*offset == NO_TZ)
+				*offset = 60*timezone_names[i].offset;
 			return match;
 		}
 	}
@@ -245,7 +255,7 @@ void parse_date(char *date, char *result
 	tm.tm_year = -1;
 	tm.tm_mon = -1;
 	tm.tm_mday = -1;
-	offset = 0;
+	offset = NO_TZ;
 
 	for (;;) {
 		int match = 0;
@@ -270,13 +280,20 @@ void parse_date(char *date, char *result
 		date += match;
 	}
 
-	then = my_mktime(&tm); /* mktime uses local timezone */
-	if (then == -1)
-		return;
-
-	then -= offset * 60;
+	if (offset == NO_TZ) {
+		tm.tm_isdst = -1;
+		then = mktime(&tm);
+		if (then == -1)
+			return;
+		offset = local_offset(&then);
+	} else {
+		then = utc_mktime(&tm);
+		if (then == -1)
+			return;
+		then -= offset * 60;
+	}
 
-	snprintf(result, maxlen, "%lu %+03d%02d", then, offset/60, offset % 60);
+	snprintf(result, maxlen, "%lu %+05d", then, offset/60*100 + offset%60);
 }
 
 void datestamp(char *buf, int bufsize)
@@ -285,9 +302,7 @@ void datestamp(char *buf, int bufsize)
 	int offset;
 
 	time(&now);
-
-	offset = my_mktime(localtime(&now)) - now;
-	offset /= 60;
+	offset = local_offset(&now);
 
 	snprintf(buf, bufsize, "%lu %+05d", now, offset/60*100 + offset%60);
 }

Ciao, ET.
