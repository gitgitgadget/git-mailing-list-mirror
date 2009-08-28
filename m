From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add date formatting and parsing functions relative to
	a given time
Date: Fri, 28 Aug 2009 23:04:04 +0200
Message-ID: <20090828210404.GA11867@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 23:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh8cZ-0000zJ-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 23:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbZH1VEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZH1VEW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 17:04:22 -0400
Received: from mout0.freenet.de ([195.4.92.90]:60582 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbZH1VEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 17:04:21 -0400
Received: from [195.4.92.10] (helo=0.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1Mh8cC-0005wo-2Y; Fri, 28 Aug 2009 23:04:08 +0200
Received: from x54ff.x.pppool.de ([89.59.84.255]:55897 helo=tigra.home)
	by 0.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1Mh8cB-0004ft-M9; Fri, 28 Aug 2009 23:04:07 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id DEAD4277D8;
	Fri, 28 Aug 2009 23:04:04 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id A2D4436D28; Fri, 28 Aug 2009 23:04:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127351>

The main purpose is to allow predictable testing of the code.
---

Rebased on current master.

 cache.h |    2 +
 date.c  |  150 ++++++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/cache.h b/cache.h
index dd7f71e..3fb0166 100644
--- a/cache.h
+++ b/cache.h
@@ -731,9 +731,11 @@ enum date_mode {
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+const char *show_date_relative(unsigned long time, int tz, const struct timeval *now);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
index f011692..0840e77 100644
--- a/date.c
+++ b/date.c
@@ -84,6 +84,67 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
+const char *show_date_relative(unsigned long time, int tz, const struct timeval *now)
+{
+	static char timebuf[100 /* TODO: can be optimized */];
+	unsigned long diff;
+	if (now->tv_sec < time)
+		return "in the future";
+	diff = now->tv_sec - time;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
+		return timebuf;
+	}
+	/* Turn it into minutes */
+	diff = (diff + 30) / 60;
+	if (diff < 90) {
+		snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
+		return timebuf;
+	}
+	/* Turn it into hours */
+	diff = (diff + 30) / 60;
+	if (diff < 36) {
+		snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
+		return timebuf;
+	}
+	/* We deal with number of days from here on */
+	diff = (diff + 12) / 24;
+	if (diff < 14) {
+		snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
+		return timebuf;
+	}
+	/* Say weeks for the past 10 weeks or so */
+	if (diff < 70) {
+		snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
+		return timebuf;
+	}
+	/* Say months for the past 12 months or so */
+	if (diff < 360) {
+		snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
+		return timebuf;
+	}
+	/* Give years and months for 5 years or so */
+	if (diff < 1825) {
+		unsigned long years = diff / 365;
+		unsigned long months = (diff % 365 + 15) / 30;
+		int n;
+		n = snprintf(timebuf, sizeof(timebuf), "%lu year%s",
+			     years, (years > 1 ? "s" : ""));
+		if (months)
+			snprintf(timebuf + n, sizeof(timebuf) - n,
+				 ", %lu month%s ago",
+				 months, (months > 1 ? "s" : ""));
+		else
+			snprintf(timebuf + n, sizeof(timebuf) - n,
+				 " ago");
+		return timebuf;
+	}
+	/* Otherwise, just years. Centuries is probably overkill. */
+	snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) / 365);
+	return timebuf;
+
+}
+
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
@@ -95,63 +156,9 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
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
+		return show_date_relative(time, tz, &now);
 	}
 
 	if (mode == DATE_LOCAL)
@@ -866,19 +873,13 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	return end;
 }
 
-unsigned long approxidate(const char *date)
+static unsigned long approximation(const char *date, const struct timeval *tv)
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
@@ -899,3 +900,26 @@ unsigned long approxidate(const char *date)
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
+	return approximation(date, tv);
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
+	return approximation(date, &tv);
+}
+
-- 
1.6.4.1.263.g468a
