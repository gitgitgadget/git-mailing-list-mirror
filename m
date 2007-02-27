From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 16:21:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM48d-0004RW-Ap
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbXB0PVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbXB0PVH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:21:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:42783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932124AbXB0PVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:21:06 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:21:05 -0000
X-Provags-ID: V01U2FsdGVkX1/iTA9YdGTihDpZucU/YMgAbPtTT7gzomdANRiy56
	lbLQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40744>


Now, show_date() can print three different kinds of dates: normal,
relative and short (%Y-%m-%s) dates.

To achieve this, the "int relative" was changed to "enum date_mode
mode", which has three states: DATE_NORMAL, DATE_RELATIVE and
DATE_SHORT.

Since existing users of show_date() only call it with relative_date
being either 0 or 1, and DATE_NORMAL and DATE_RELATIVE having these
values, no behaviour is changed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |    3 ++-
 date.c  |   20 ++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 8bbc142..8f89a8b 100644
--- a/cache.h
+++ b/cache.h
@@ -326,7 +326,8 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-const char *show_date(unsigned long time, int timezone, int relative);
+enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT };
+const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
diff --git a/date.c b/date.c
index 542c004..0ceccbe 100644
--- a/date.c
+++ b/date.c
@@ -55,12 +55,12 @@ static struct tm *time_to_tm(unsigned long time, int tz)
 	return gmtime(&t);
 }
 
-const char *show_date(unsigned long time, int tz, int relative)
+const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
-	if (relative) {
+	if (mode == DATE_RELATIVE) {
 		unsigned long diff;
 		struct timeval now;
 		gettimeofday(&now, NULL);
@@ -105,12 +105,16 @@ const char *show_date(unsigned long time, int tz, int relative)
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
-	sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d %+05d",
-		weekday_names[tm->tm_wday],
-		month_names[tm->tm_mon],
-		tm->tm_mday,
-		tm->tm_hour, tm->tm_min, tm->tm_sec,
-		tm->tm_year + 1900, tz);
+	if (mode == DATE_SHORT)
+		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
+				tm->tm_mon + 1, tm->tm_mday);
+	else
+		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d %+05d",
+				weekday_names[tm->tm_wday],
+				month_names[tm->tm_mon],
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec,
+				tm->tm_year + 1900, tz);
 	return timebuf;
 }
 
-- 
1.5.0.2.2410.g737b
