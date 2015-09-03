From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 09/11] date: make "local" orthogonal to date format
Date: Thu,  3 Sep 2015 22:48:59 +0100
Message-ID: <697ac08e0d5faddaaa09e280f7658c07be62f823.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:51:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcPf-0001bN-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689AbbICVvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:51:16 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42566 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674AbbICVvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:51:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6DC2ECDA5F6;
	Thu,  3 Sep 2015 22:51:15 +0100 (BST)
X-Quarantine-ID: <L-hT2ADEOhG5>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L-hT2ADEOhG5; Thu,  3 Sep 2015 22:51:14 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DBA94CDA627;
	Thu,  3 Sep 2015 22:51:00 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277270>

From: Jeff King <peff@peff.net>

Most of our "--date" modes are about the format of the date:
which items we show and in what order. But "--date=local" is
a bit of an oddball. It means "show the date in the normal
format, but using the local timezone". The timezone we use
is orthogonal to the actual format, and there is no reason
we could not have "localized iso8601", etc.

This patch adds a "local" boolean field to "struct
date_mode", and drops the DATE_LOCAL element from the
date_mode_type enum (it's now just DATE_NORMAL plus
local=1). The new feature is accessible to users by adding
"-local" to any date mode (e.g., "iso-local"), and we retain
"local" as an alias for "default-local" for backwards
compatibility.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v2:
- "local" check has moved above DATE_RAW processing as a result of an
  earlier patch
- "relative-local" and "raw-local" are now allowed
- the error message if the format starts with a valid sequence but is
  invalid as a whole is now consistent with the case where there is no
  valid prefix

 Documentation/rev-list-options.txt | 21 ++++++++----
 builtin/blame.c                    |  1 -
 cache.h                            |  2 +-
 date.c                             | 70 ++++++++++++++++++++++++--------------
 4 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 14c4cce..359587c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -702,12 +702,16 @@ include::pretty-options.txt[]
 --date=<format>::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
-	value for the log command's `--date` option.
+	value for the log command's `--date` option. By default, dates
+	are shown in the original time zone (either committer's or
+	author's). If `-local` is appended to the format (e.g.,
+	`iso-local`), the user's local time zone is used instead.
 +
 `--date=relative` shows dates relative to the current time,
-e.g. ``2 hours ago''.
+e.g. ``2 hours ago''. The `-local` option cannot be used with
+`--raw` or `--relative`.
 +
-`--date=local` shows timestamps in user's local time zone.
+`--date=local` is an alias for `--date=default-local`.
 +
 `--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
 The differences to the strict ISO 8601 format are:
@@ -730,10 +734,15 @@ format, often found in email messages.
 `--date=format:...` feeds the format `...` to your system `strftime`.
 Use `--date=format:%c` to show the date in your system locale's
 preferred format.  See the `strftime` manual for a complete list of
-format placeholders.
+format placeholders. When using `-local`, the correct syntax is
+`--date=format-local:...`.
 +
-`--date=default` shows timestamps in the original time zone
-(either committer's or author's).
+`--date=default` is the default format, and is similar to
+`--date=rfc2822`, with a few exceptions:
+
+	- there is no comma after the day-of-week
+
+	- the time zone is omitted when the local time zone is used
 
 ifdef::git-rev-list[]
 --header::
diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..6fd1a63 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2600,7 +2600,6 @@ parse_done:
 		   fewer display columns. */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
-	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
diff --git a/cache.h b/cache.h
index 4e25271..9a91b1d 100644
--- a/cache.h
+++ b/cache.h
@@ -1091,7 +1091,6 @@ struct date_mode {
 		DATE_NORMAL = 0,
 		DATE_RELATIVE,
 		DATE_SHORT,
-		DATE_LOCAL,
 		DATE_ISO8601,
 		DATE_ISO8601_STRICT,
 		DATE_RFC2822,
@@ -1099,6 +1098,7 @@ struct date_mode {
 		DATE_RAW
 	} type;
 	const char *strftime_fmt;
+	int local;
 };
 
 /*
diff --git a/date.c b/date.c
index 9f0a5dd..7c9f769 100644
--- a/date.c
+++ b/date.c
@@ -166,6 +166,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	if (type == DATE_STRFTIME)
 		die("BUG: cannot create anonymous strftime date_mode struct");
 	mode.type = type;
+	mode.local = 0;
 	return &mode;
 }
 
@@ -174,7 +175,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
 
-	if (mode->type == DATE_LOCAL)
+	if (mode->local)
 		tz = local_tzoffset(time);
 
 	if (mode->type == DATE_RAW) {
@@ -232,7 +233,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tm->tm_year + 1900,
-				(mode->type == DATE_LOCAL) ? 0 : ' ',
+				mode->local ? 0 : ' ',
 				tz);
 	return timebuf.buf;
 }
@@ -770,31 +771,50 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
+static enum date_mode_type parse_date_type(const char *format, const char **end)
+{
+	if (skip_prefix(format, "relative", end))
+		return DATE_RELATIVE;
+	if (skip_prefix(format, "iso8601-strict", end) ||
+	    skip_prefix(format, "iso-strict", end))
+		return DATE_ISO8601_STRICT;
+	if (skip_prefix(format, "iso8601", end) ||
+	    skip_prefix(format, "iso", end))
+		return DATE_ISO8601;
+	if (skip_prefix(format, "rfc2822", end) ||
+	    skip_prefix(format, "rfc", end))
+		return DATE_RFC2822;
+	if (skip_prefix(format, "short", end))
+		return DATE_SHORT;
+	if (skip_prefix(format, "default", end))
+		return DATE_NORMAL;
+	if (skip_prefix(format, "raw", end))
+		return DATE_RAW;
+	if (skip_prefix(format, "format", end))
+		return DATE_STRFTIME;
+
+	die("unknown date format %s", format);
+}
+
 void parse_date_format(const char *format, struct date_mode *mode)
 {
-	if (!strcmp(format, "relative"))
-		mode->type = DATE_RELATIVE;
-	else if (!strcmp(format, "iso8601") ||
-		 !strcmp(format, "iso"))
-		mode->type = DATE_ISO8601;
-	else if (!strcmp(format, "iso8601-strict") ||
-		 !strcmp(format, "iso-strict"))
-		mode->type = DATE_ISO8601_STRICT;
-	else if (!strcmp(format, "rfc2822") ||
-		 !strcmp(format, "rfc"))
-		mode->type = DATE_RFC2822;
-	else if (!strcmp(format, "short"))
-		mode->type = DATE_SHORT;
-	else if (!strcmp(format, "local"))
-		mode->type = DATE_LOCAL;
-	else if (!strcmp(format, "default"))
-		mode->type = DATE_NORMAL;
-	else if (!strcmp(format, "raw"))
-		mode->type = DATE_RAW;
-	else if (skip_prefix(format, "format:", &format)) {
-		mode->type = DATE_STRFTIME;
-		mode->strftime_fmt = xstrdup(format);
-	} else
+	const char *p;
+
+	/* historical alias */
+	if (!strcmp(format, "local"))
+		format = "default-local";
+
+	mode->type = parse_date_type(format, &p);
+	mode->local = 0;
+
+	if (skip_prefix(p, "-local", &p))
+		mode->local = 1;
+
+	if (mode->type == DATE_STRFTIME) {
+		if (!skip_prefix(p, ":", &p))
+			die("date format missing colon separator: %s", format);
+		mode->strftime_fmt = xstrdup(p);
+	} else if (*p)
 		die("unknown date format %s", format);
 }
 
-- 
2.5.0.466.g9af26fa
