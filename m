From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add date formatting and parsing functions relative to
	a given time
Date: Sun, 30 Aug 2009 11:13:46 +0200
Message-ID: <20090830091346.GA14928@blimp.localdomain>
References: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com> <20090828150212.GA6013@coredump.intra.peff.net> <alpine.LFD.2.00.0908281307510.6044@xanadu.home> <20090828190319.GA9233@blimp.localdomain> <20090828191521.GA12292@coredump.intra.peff.net> <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com> <20090828193302.GB9233@blimp.localdomain> <20090828205232.GD9233@blimp.localdomain> <7vk50mz41e.fsf@alter.siamese.dyndns.org> <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 11:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhgWC-0007LC-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZH3JOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbZH3JOE
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:14:04 -0400
Received: from mout3.freenet.de ([195.4.92.93]:58753 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbZH3JOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 05:14:03 -0400
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MhgTv-0007Zh-DJ; Sun, 30 Aug 2009 11:13:51 +0200
Received: from x5b2e.x.pppool.de ([89.59.91.46]:59298 helo=tigra.home)
	by 9.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #94)
	id 1MhgTv-0007pj-1k; Sun, 30 Aug 2009 11:13:51 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 27AF2277D8;
	Sun, 30 Aug 2009 11:13:47 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id A242136D28; Sun, 30 Aug 2009 11:13:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127402>

The main purpose is to allow predictable testing of the code.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Have show_date_relative supplied the output buffer. As it is a new
interface, it can as well be a little bit more generic than its sole
caller. test-date.c is updated and shall follow in a moment.

And, after a while thinking, I am convinced that Jeff has a point
and used a more "internal" name for approxidate's recent "bottom half".

 cache.h |    5 ++
 date.c  |  152 +++++++++++++++++++++++++++++++++++++--------------------------
 2 files changed, 94 insertions(+), 63 deletions(-)

diff --git a/cache.h b/cache.h
index dd7f71e..1586f33 100644
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
1.6.4.1.294.g16262
