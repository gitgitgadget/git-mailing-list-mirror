From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Mon, 31 Aug 2015 16:48:32 -0400
Message-ID: <20150831204831.GB10338@sigill.intra.peff.net>
References: <20150831204444.GA4385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWW0N-00005O-Lo
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbHaUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:48:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:52663 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753185AbbHaUse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:48:34 -0400
Received: (qmail 26197 invoked by uid 102); 31 Aug 2015 20:48:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 15:48:34 -0500
Received: (qmail 27071 invoked by uid 107); 31 Aug 2015 20:48:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 16:48:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 16:48:32 -0400
Content-Disposition: inline
In-Reply-To: <20150831204444.GA4385@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276940>

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
---
I wonder if anybody would be confused and try "iso-local-strict", which
does not work with this code. If we bumped "-strict" to become a
modifier (like "-local"), we could easily make the order
interchangeable.

 Documentation/rev-list-options.txt | 21 ++++++++---
 builtin/blame.c                    |  1 -
 cache.h                            |  2 +-
 date.c                             | 77 +++++++++++++++++++++++++-------------
 4 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a9b808f..35dc44b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -702,12 +702,16 @@ include::pretty-options.txt[]
 --date=(relative|local|default|iso|iso-strict|rfc|short|raw)::
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
+`--relative`.
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
index 8f91569..aa57cad 100644
--- a/date.c
+++ b/date.c
@@ -166,6 +166,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	if (type == DATE_STRFTIME)
 		die("BUG: cannot create anonymous strftime date_mode struct");
 	mode.type = type;
+	mode.local = 0;
 	return &mode;
 }
 
@@ -189,7 +190,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
-	if (mode->type == DATE_LOCAL)
+	if (mode->local)
 		tz = local_tzoffset(time);
 
 	tm = time_to_tm(time, tz);
@@ -232,7 +233,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tm->tm_year + 1900,
-				(mode->type == DATE_LOCAL) ? 0 : ' ',
+				mode->local ? 0 : ' ',
 				tz);
 	return timebuf.buf;
 }
@@ -770,32 +771,56 @@ int parse_date(const char *date, struct strbuf *result)
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
-		die("unknown date format %s", format);
+	const char *p;
+
+	/* historical alias */
+	if (!strcmp(format, "local"))
+		format = "default-local";
+
+	mode->type = parse_date_type(format, &p);
+	mode->local = 0;
+
+	if (skip_prefix(p, "-local", &p)) {
+		if (mode->type == DATE_RELATIVE)
+			die("relative-local date format is nonsensical");
+		mode->local = 1;
+	}
+
+	if (mode->type == DATE_STRFTIME) {
+		if (!skip_prefix(p, ":", &p))
+			die("date format missing colon separator: %s", format);
+		mode->strftime_fmt = xstrdup(p);
+	}
+
+	if (*p)
+		die("unknown date-mode modifier: %s", p);
 }
 
 void datestamp(struct strbuf *out)
-- 
2.5.1.739.g7891f6b
