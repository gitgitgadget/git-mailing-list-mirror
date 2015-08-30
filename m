From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] date: allow any format to display local time
Date: Sun, 30 Aug 2015 14:54:50 +0100
Message-ID: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 15:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW34j-00068h-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 15:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbbH3NzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 09:55:08 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55285 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbbH3NzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 09:55:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 24147CDA5E4;
	Sun, 30 Aug 2015 14:55:06 +0100 (BST)
X-Quarantine-ID: <7nf+KqsqyGnt>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7nf+KqsqyGnt; Sun, 30 Aug 2015 14:55:04 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 16781CDA59E;
	Sun, 30 Aug 2015 14:54:58 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276820>

Make DATE_LOCAL a bit flag that may be combined with the other formats.
In order to keep date_mode_type as a true enumeration the possible
combinations are included explicitly (except "relative local time" which
is nonsensical).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I primarily want this to make life easier in CGit (so that we can reuse
libgit.a for formatting dates in the originator's timezone), but I think
it makes sense to expose these options to the user in general.

 builtin/blame.c |  3 +--
 cache.h         |  9 +++++++--
 date.c          | 31 ++++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..dff6934 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2575,7 +2575,7 @@ parse_done:
 	}
 
 	/* The maximum width used to show the dates */
-	switch (blame_date_mode.type) {
+	switch (blame_date_mode.type & ~DATE_LOCAL) {
 	case DATE_RFC2822:
 		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
 		break;
@@ -2600,7 +2600,6 @@ parse_done:
 		   fewer display columns. */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
-	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
diff --git a/cache.h b/cache.h
index 4e25271..cda5c51 100644
--- a/cache.h
+++ b/cache.h
@@ -1091,12 +1091,17 @@ struct date_mode {
 		DATE_NORMAL = 0,
 		DATE_RELATIVE,
 		DATE_SHORT,
-		DATE_LOCAL,
 		DATE_ISO8601,
 		DATE_ISO8601_STRICT,
 		DATE_RFC2822,
 		DATE_STRFTIME,
-		DATE_RAW
+		DATE_RAW,
+		DATE_LOCAL = 0x80,
+		DATE_SHORT_LOCAL = (DATE_SHORT | DATE_LOCAL),
+		DATE_ISO8601_LOCAL = (DATE_ISO8601 | DATE_LOCAL),
+		DATE_ISO8601_STRICT_LOCAL = (DATE_ISO8601_STRICT | DATE_LOCAL),
+		DATE_RFC2822_LOCAL = (DATE_RFC2822 | DATE_LOCAL),
+		DATE_STRFTIME_LOCAL = (DATE_STRFTIME | DATE_LOCAL),
 	} type;
 	const char *strftime_fmt;
 };
diff --git a/date.c b/date.c
index 8f91569..e0e0f3b 100644
--- a/date.c
+++ b/date.c
@@ -163,7 +163,7 @@ void show_date_relative(unsigned long time, int tz,
 struct date_mode *date_mode_from_type(enum date_mode_type type)
 {
 	static struct date_mode mode;
-	if (type == DATE_STRFTIME)
+	if (type == DATE_STRFTIME || type == DATE_STRFTIME_LOCAL)
 		die("BUG: cannot create anonymous strftime date_mode struct");
 	mode.type = type;
 	return &mode;
@@ -173,6 +173,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
+	enum date_mode_type type = mode->type;
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
@@ -189,8 +190,10 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
-	if (mode->type == DATE_LOCAL)
+	if (type & DATE_LOCAL) {
 		tz = local_tzoffset(time);
+		type &= ~DATE_LOCAL;
+	}
 
 	tm = time_to_tm(time, tz);
 	if (!tm) {
@@ -199,17 +202,17 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	}
 
 	strbuf_reset(&timebuf);
-	if (mode->type == DATE_SHORT)
+	if (type == DATE_SHORT)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode->type == DATE_ISO8601)
+	else if (type == DATE_ISO8601)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode->type == DATE_ISO8601_STRICT) {
+	else if (type == DATE_ISO8601_STRICT) {
 		char sign = (tz >= 0) ? '+' : '-';
 		tz = abs(tz);
 		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
@@ -218,12 +221,12 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				sign, tz / 100, tz % 100);
-	} else if (mode->type == DATE_RFC2822)
+	} else if (type == DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	else if (mode->type == DATE_STRFTIME)
+	else if (type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
@@ -777,14 +780,25 @@ void parse_date_format(const char *format, struct date_mode *mode)
 	else if (!strcmp(format, "iso8601") ||
 		 !strcmp(format, "iso"))
 		mode->type = DATE_ISO8601;
+	else if (!strcmp(format, "iso8601-local") ||
+		 !strcmp(format, "iso-local"))
+		mode->type = DATE_ISO8601_LOCAL;
 	else if (!strcmp(format, "iso8601-strict") ||
 		 !strcmp(format, "iso-strict"))
 		mode->type = DATE_ISO8601_STRICT;
+	else if (!strcmp(format, "iso8601-strict-local") ||
+		 !strcmp(format, "iso-strict-local"))
+		mode->type = DATE_ISO8601_STRICT_LOCAL;
 	else if (!strcmp(format, "rfc2822") ||
 		 !strcmp(format, "rfc"))
 		mode->type = DATE_RFC2822;
+	else if (!strcmp(format, "rfc2822-local") ||
+		 !strcmp(format, "rfc-local"))
+		mode->type = DATE_RFC2822_LOCAL;
 	else if (!strcmp(format, "short"))
 		mode->type = DATE_SHORT;
+	else if (!strcmp(format, "short-local"))
+		mode->type = DATE_SHORT_LOCAL;
 	else if (!strcmp(format, "local"))
 		mode->type = DATE_LOCAL;
 	else if (!strcmp(format, "default"))
@@ -794,6 +808,9 @@ void parse_date_format(const char *format, struct date_mode *mode)
 	else if (skip_prefix(format, "format:", &format)) {
 		mode->type = DATE_STRFTIME;
 		mode->strftime_fmt = xstrdup(format);
+	} else if (skip_prefix(format, "format-local:", &format)) {
+		mode->type = DATE_STRFTIME_LOCAL;
+		mode->strftime_fmt = xstrdup(format);
 	} else
 		die("unknown date format %s", format);
 }
-- 
2.5.0.466.g9af26fa
