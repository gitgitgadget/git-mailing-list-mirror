From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] Add date formatting and parsing functions relative to
 a given time
Date: Sun, 30 Aug 2009 17:43:09 -0400
Message-ID: <20090830214309.GA16119@coredump.intra.peff.net>
References: <20090830093642.GA30922@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:43:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhsBh-0003rs-B4
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbZH3VnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZH3VnL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:43:11 -0400
Received: from peff.net ([208.65.91.99]:58426 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbZH3VnK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:43:10 -0400
Received: (qmail 19296 invoked by uid 107); 30 Aug 2009 21:43:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 17:43:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 17:43:09 -0400
Content-Disposition: inline
In-Reply-To: <20090830093642.GA30922@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127435>

From: Alex Riesen <raa.lkml@gmail.com>

The main purpose is to allow predictable testing of the code.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    5 ++
 date.c  |  152 +++++++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 94 insertions(+), 63 deletions(-)

diff --git a/cache.h b/cache.h
index 808daba..5fad24c 100644
--- a/cache.h
+++ b/cache.h
@@ -731,9 +731,14 @@ enum date_mode {
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+const char *show_date_relative(unsigned long time, int tz,
+			       const struct timeval *now,
+			       char *timebuf,
+			       size_t timebuf_size);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
index f011692..0b0f7a7 100644
--- a/date.c
+++ b/date.c
@@ -84,6 +84,68 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
+const char *show_date_relative(unsigned long time, int tz,
+			       const struct timeval *now,
+			       char *timebuf,
+			       size_t timebuf_size)
+{
+	unsigned long diff;
+	if (now->tv_sec < time)
+		return "in the future";
+	diff = now->tv_sec - time;
+	if (diff < 90) {
+		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
+		return timebuf;
+	}
+	/* Turn it into minutes */
+	diff = (diff + 30) / 60;
+	if (diff < 90) {
+		snprintf(timebuf, timebuf_size, "%lu minutes ago", diff);
+		return timebuf;
+	}
+	/* Turn it into hours */
+	diff = (diff + 30) / 60;
+	if (diff < 36) {
+		snprintf(timebuf, timebuf_size, "%lu hours ago", diff);
+		return timebuf;
+	}
+	/* We deal with number of days from here on */
+	diff = (diff + 12) / 24;
+	if (diff < 14) {
+		snprintf(timebuf, timebuf_size, "%lu days ago", diff);
+		return timebuf;
+	}
+	/* Say weeks for the past 10 weeks or so */
+	if (diff < 70) {
+		snprintf(timebuf, timebuf_size, "%lu weeks ago", (diff + 3) / 7);
+		return timebuf;
+	}
+	/* Say months for the past 12 months or so */
+	if (diff < 360) {
+		snprintf(timebuf, timebuf_size, "%lu months ago", (diff + 15) / 30);
+		return timebuf;
+	}
+	/* Give years and months for 5 years or so */
+	if (diff < 1825) {
+		unsigned long years = diff / 365;
+		unsigned long months = (diff % 365 + 15) / 30;
+		int n;
+		n = snprintf(timebuf, timebuf_size, "%lu year%s",
+			     years, (years > 1 ? "s" : ""));
+		if (months)
+			snprintf(timebuf + n, timebuf_size - n,
+				 ", %lu month%s ago",
+				 months, (months > 1 ? "s" : ""));
+		else
+			snprintf(timebuf + n, timebuf_size - n,
+				 " ago");
+		return timebuf;
+	}
+	/* Otherwise, just years. Centuries is probably overkill. */
+	snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
+	return timebuf;
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -95,63 +157,10 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	}
 
 	if (mode == DATE_RELATIVE) {
-		unsigned long diff;
 		struct timeval now;
 		gettimeofday(&now, NULL);
-		if (now.tv_sec < time)
-			return "in the future";
-		diff = now.tv_sec - time;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
-			return timebuf;
-		}
-		/* Turn it into minutes */
-		diff = (diff + 30) / 60;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
-			return timebuf;
-		}
-		/* Turn it into hours */
-		diff = (diff + 30) / 60;
-		if (diff < 36) {
-			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
-			return timebuf;
-		}
-		/* We deal with number of days from here on */
-		diff = (diff + 12) / 24;
-		if (diff < 14) {
-			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
-			return timebuf;
-		}
-		/* Say weeks for the past 10 weeks or so */
-		if (diff < 70) {
-			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
-			return timebuf;
-		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
-			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
-			return timebuf;
-		}
-		/* Give years and months for 5 years or so */
-		if (diff < 1825) {
-			unsigned long years = diff / 365;
-			unsigned long months = (diff % 365 + 15) / 30;
-			int n;
-			n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
-					years, (years > 1 ? "s" : ""));
-			if (months)
-				snprintf(timebuf + n, sizeof(timebuf) - n,
-					", %lu month%s ago",
-					months, (months > 1 ? "s" : ""));
-			else
-				snprintf(timebuf + n, sizeof(timebuf) - n,
-					" ago");
-			return timebuf;
-		}
-		/* Otherwise, just years. Centuries is probably overkill. */
-		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
-		return timebuf;
+		return show_date_relative(time, tz, &now,
+					  timebuf, sizeof(timebuf));
 	}
 
 	if (mode == DATE_LOCAL)
@@ -866,19 +875,13 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	return end;
 }
 
-unsigned long approxidate(const char *date)
+static unsigned long approxidate_str(const char *date, const struct timeval *tv)
 {
 	int number = 0;
 	struct tm tm, now;
-	struct timeval tv;
 	time_t time_sec;
-	char buffer[50];
 
-	if (parse_date(date, buffer, sizeof(buffer)) > 0)
-		return strtoul(buffer, NULL, 10);
-
-	gettimeofday(&tv, NULL);
-	time_sec = tv.tv_sec;
+	time_sec = tv->tv_sec;
 	localtime_r(&time_sec, &tm);
 	now = tm;
 	for (;;) {
@@ -899,3 +902,26 @@ unsigned long approxidate(const char *date)
 		tm.tm_year--;
 	return mktime(&tm);
 }
+
+unsigned long approxidate_relative(const char *date, const struct timeval *tv)
+{
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 10);
+
+	return approxidate_str(date, tv);
+}
+
+unsigned long approxidate(const char *date)
+{
+	struct timeval tv;
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 10);
+
+	gettimeofday(&tv, NULL);
+	return approxidate_str(date, &tv);
+}
+
-- 
1.6.4.2.375.g73938
