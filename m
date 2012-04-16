From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 02/11] i18n: mark relative dates for translation
Date: Mon, 16 Apr 2012 19:49:54 +0700
Message-ID: <1334580603-11577-3-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlOs-0006Vu-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab2DPMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:17 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33059 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab2DPMvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:16 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so6880805dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Nk6dDY35UUVkLMopjLN/zJ6oVL1RgNvPdSADEBLf0zE=;
        b=kKsk8c+CkkB58i7SSdROwzRl4JG5o7j8/wjYzAljvzy8utV82fszCNSSo4orahOzCH
         7wShEfcoa6gOq3e0x8WQSheTyRtCXY+FxvuiXVPiF6ZqU55baZD5C+j1gCeHZREEn0Y6
         GiZvF8KsuNRvmSdx1FTMEQXKJIICxMYeT9D+DNQFghpg0Hj1zsIxe69GDaJtFhclHR57
         mcLYsKG0pG5e7mXrl1a0YeLbzYp/sXYLt0IDEm0IeRjfCJnN+dL0wzNTjCrsqDgYqU06
         3kJZLuSnuzb/Q7ouBQx1BpLGfYPqprBS+uxFmYoA1qM5Asho9Ett8Sekf/muzXKaujCT
         vHCQ==
Received: by 10.68.200.162 with SMTP id jt2mr27512348pbc.54.1334580676385;
        Mon, 16 Apr 2012 05:51:16 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id it8sm1524525pbc.56.2012.04.16.05.51.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:24 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195625>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h     |    6 +--
 date.c      |   95 ++++++++++++++++++++++++++++++++++------------------------
 test-date.c |    7 ++--
 3 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/cache.h b/cache.h
index a8aceb5..aa9f8f9 100644
--- a/cache.h
+++ b/cache.h
@@ -906,10 +906,8 @@ enum date_mode {
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
-const char *show_date_relative(unsigned long time, int tz,
-			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size);
+void show_date_relative(unsigned long time, int tz, const struct timeval *now,
+			struct strbuf *timebuf);
 int parse_date(const char *date, char *buf, int bufsize);
 int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
 void datestamp(char *buf, int bufsize);
diff --git a/date.c b/date.c
index a5055ca..1fdcf7c 100644
--- a/date.c
+++ b/date.c
@@ -86,83 +86,98 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
-const char *show_date_relative(unsigned long time, int tz,
+void show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
-			       char *timebuf,
-			       size_t timebuf_size)
+			       struct strbuf *timebuf)
 {
 	unsigned long diff;
-	if (now->tv_sec < time)
-		return "in the future";
+	if (now->tv_sec < time) {
+		strbuf_addstr(timebuf, _("in the future"));
+		return;
+	}
 	diff = now->tv_sec - time;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+		return;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu minutes ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+		return;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
-		snprintf(timebuf, timebuf_size, "%lu hours ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+		return;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
-		snprintf(timebuf, timebuf_size, "%lu days ago", diff);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu day ago", "%lu days ago", diff), diff);
+		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
-		snprintf(timebuf, timebuf_size, "%lu weeks ago", (diff + 3) / 7);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 (diff + 3) / 7);
+		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
-		snprintf(timebuf, timebuf_size, "%lu months ago", (diff + 15) / 30);
-		return timebuf;
+		strbuf_addf(timebuf,
+			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 (diff + 15) / 30);
+		return;
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
 		unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
 		unsigned long years = totalmonths / 12;
 		unsigned long months = totalmonths % 12;
-		int n;
-		n = snprintf(timebuf, timebuf_size, "%lu year%s",
-				years, (years > 1 ? "s" : ""));
-		if (months)
-			snprintf(timebuf + n, timebuf_size - n,
-					", %lu month%s ago",
-					months, (months > 1 ? "s" : ""));
-		else
-			snprintf(timebuf + n, timebuf_size - n, " ago");
-		return timebuf;
+		if (months) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			/* TRANSLATORS: "%s" is "<n> years" */
+			strbuf_addf(timebuf,
+				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 sb.buf, months);
+			strbuf_release(&sb);
+		} else
+			strbuf_addf(timebuf,
+				 Q_("%lu year ago", "%lu years ago", years), years);
+		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
-	snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
-	return timebuf;
+	strbuf_addf(timebuf,
+		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 (diff + 183) / 365);
 }
 
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
-	static char timebuf[200];
+	static struct strbuf timebuf = STRBUF_INIT;
 
 	if (mode == DATE_RAW) {
-		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
-		return timebuf;
+		strbuf_reset(&timebuf);
+		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		return timebuf.buf;
 	}
 
 	if (mode == DATE_RELATIVE) {
 		struct timeval now;
+
+		strbuf_reset(&timebuf);
 		gettimeofday(&now, NULL);
-		return show_date_relative(time, tz, &now,
-					  timebuf, sizeof(timebuf));
+		show_date_relative(time, tz, &now, &timebuf);
+		return timebuf.buf;
 	}
 
 	if (mode == DATE_LOCAL)
@@ -171,23 +186,25 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
+
+	strbuf_reset(&timebuf);
 	if (mode == DATE_SHORT)
-		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
+		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
 	else if (mode == DATE_ISO8601)
-		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
 	else if (mode == DATE_RFC2822)
-		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else
-		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
+		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
 				month_names[tm->tm_mon],
 				tm->tm_mday,
@@ -195,7 +212,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_year + 1900,
 				(mode == DATE_LOCAL) ? 0 : ' ',
 				tz);
-	return timebuf;
+	return timebuf.buf;
 }
 
 /*
diff --git a/test-date.c b/test-date.c
index 6bcd5b0..10afaab 100644
--- a/test-date.c
+++ b/test-date.c
@@ -7,13 +7,14 @@ static const char *usage_msg = "\n"
 
 static void show_dates(char **argv, struct timeval *now)
 {
-	char buf[128];
+	struct strbuf buf = STRBUF_INIT;
 
 	for (; *argv; argv++) {
 		time_t t = atoi(*argv);
-		show_date_relative(t, 0, now, buf, sizeof(buf));
-		printf("%s -> %s\n", *argv, buf);
+		show_date_relative(t, 0, now, &buf);
+		printf("%s -> %s\n", *argv, buf.buf);
 	}
+	strbuf_release(&buf);
 }
 
 static void parse_dates(char **argv, struct timeval *now)
-- 
1.7.3.1.256.g2539c.dirty
