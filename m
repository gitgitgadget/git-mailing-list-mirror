From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 22:26:05 -0400
Message-ID: <20090831022605.GA5507@coredump.intra.peff.net>
References: <20090831022228.GA4833@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 04:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhwb6-0005CK-7d
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 04:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbZHaC0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 22:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbZHaC0I
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 22:26:08 -0400
Received: from peff.net ([208.65.91.99]:41773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbZHaC0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 22:26:07 -0400
Received: (qmail 20285 invoked by uid 107); 31 Aug 2009 02:26:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 22:26:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 22:26:05 -0400
Content-Disposition: inline
In-Reply-To: <20090831022228.GA4833@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127452>

From: Alex Riesen <raa.lkml@gmail.com>

The main purpose is to allow predictable testing of the code.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Same as previous 1/3, but rebased onto lt/approxidate topic. The merge
ended up as quite a mess because of textual differences, so I had to
fix up a fair bit by hand; Alex, please confirm that I didn't screw
anything up too badly right before putting your name at the top. ;)

 cache.h |    5 ++
 date.c  |  150 ++++++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 92 insertions(+), 63 deletions(-)

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
index e848d96..8e57e5e 100644
--- a/date.c
+++ b/date.c
@@ -86,6 +86,67 @@ static int local_tzoffset(unsigned long time)
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
+				years, (years > 1 ? "s" : ""));
+		if (months)
+			snprintf(timebuf + n, timebuf_size - n,
+					", %lu month%s ago",
+					months, (months > 1 ? "s" : ""));
+		else
+			snprintf(timebuf + n, timebuf_size - n, " ago");
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
@@ -97,63 +158,10 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
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
@@ -918,19 +926,13 @@ static void pending_number(struct tm *tm, int *num)
 	}
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
 
@@ -954,3 +956,25 @@ unsigned long approxidate(const char *date)
 	pending_number(&tm, &number);
 	return update_tm(&tm, &now, 0);
 }
+
+unsigned long approxidate_relative(const char *date, const struct timeval *tv)
+{
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 0);
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
+		return strtoul(buffer, NULL, 0);
+
+	gettimeofday(&tv, NULL);
+	return approxidate_str(date, &tv);
+}
-- 
1.6.4.2.373.g5881fd
