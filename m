From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] introduce "format" date-mode
Date: Thu, 25 Jun 2015 12:55:45 -0400
Message-ID: <20150625165545.GC23503@peff.net>
References: <20150625165341.GA21949@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ARN-0003BO-1G
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbFYQzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:55:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51774 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbbFYQzr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:55:47 -0400
Received: (qmail 19913 invoked by uid 102); 25 Jun 2015 16:55:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 11:55:47 -0500
Received: (qmail 8226 invoked by uid 107); 25 Jun 2015 16:55:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 12:55:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 12:55:45 -0400
Content-Disposition: inline
In-Reply-To: <20150625165341.GA21949@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272699>

This feeds the format directly to strftime. Besides being a
little more flexible, the main advantage is that your system
strftime may know more about your locale's preferred format
(e.g., how to spell the days of the week).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt |  5 +++++
 builtin/blame.c                    |  3 +++
 cache.h                            |  2 ++
 date.c                             |  9 ++++++++-
 gettext.c                          |  1 +
 strbuf.c                           | 29 +++++++++++++++++++++++++++++
 strbuf.h                           |  5 +++++
 t/t6300-for-each-ref.sh            |  8 ++++++++
 8 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 77ac439..a9b808f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -727,6 +727,11 @@ format, often found in email messages.
 +
 `--date=raw` shows the date in the internal raw Git format `%s %z` format.
 +
+`--date=format:...` feeds the format `...` to your system `strftime`.
+Use `--date=format:%c` to show the date in your system locale's
+preferred format.  See the `strftime` manual for a complete list of
+format placeholders.
++
 `--date=default` shows timestamps in the original time zone
 (either committer's or author's).
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 43e8473..e2e3e75 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2596,6 +2596,9 @@ parse_done:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
+	case DATE_STRFTIME:
+		blame_date_width = strlen(show_date(0, 0, &blame_date_mode)) + 1; /* add the null */
+		break;
 	}
 	blame_date_width -= 1; /* strip the null */
 
diff --git a/cache.h b/cache.h
index 1759011..bb63a58 100644
--- a/cache.h
+++ b/cache.h
@@ -1105,8 +1105,10 @@ struct date_mode {
 		DATE_ISO8601,
 		DATE_ISO8601_STRICT,
 		DATE_RFC2822,
+		DATE_STRFTIME,
 		DATE_RAW
 	} type;
+	const char *strftime_fmt;
 };
 
 /*
diff --git a/date.c b/date.c
index cdad4db..8f91569 100644
--- a/date.c
+++ b/date.c
@@ -163,6 +163,8 @@ void show_date_relative(unsigned long time, int tz,
 struct date_mode *date_mode_from_type(enum date_mode_type type)
 {
 	static struct date_mode mode;
+	if (type == DATE_STRFTIME)
+		die("BUG: cannot create anonymous strftime date_mode struct");
 	mode.type = type;
 	return &mode;
 }
@@ -221,6 +223,8 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
+	else if (mode->type == DATE_STRFTIME)
+		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
@@ -787,7 +791,10 @@ void parse_date_format(const char *format, struct date_mode *mode)
 		mode->type = DATE_NORMAL;
 	else if (!strcmp(format, "raw"))
 		mode->type = DATE_RAW;
-	else
+	else if (skip_prefix(format, "format:", &format)) {
+		mode->type = DATE_STRFTIME;
+		mode->strftime_fmt = xstrdup(format);
+	} else
 		die("unknown date format %s", format);
 }
 
diff --git a/gettext.c b/gettext.c
index 7378ba2..a268a2c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -162,6 +162,7 @@ void git_setup_gettext(void)
 		podir = GIT_LOCALE_PATH;
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
+	setlocale(LC_TIME, "");
 	init_gettext_charset("git");
 	textdomain("git");
 }
diff --git a/strbuf.c b/strbuf.c
index 0d4f4e5..a7ba028 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -709,3 +709,32 @@ char *xstrfmt(const char *fmt, ...)
 
 	return ret;
 }
+
+void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
+{
+	size_t len;
+
+	/*
+	 * strftime reports "0" if it could not fit the result in the buffer.
+	 * Unfortunately, it also reports "0" if the requested time string
+	 * takes 0 bytes. So if we were to probe and grow, we have to choose
+	 * some arbitrary cap beyond which we guess that the format probably
+	 * just results in a 0-length output. Since we have to choose some
+	 * reasonable cap anyway, and since it is not that big, we may
+	 * as well just grow to their in the first place.
+	 */
+	strbuf_grow(sb, 128);
+	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
+
+	if (!len) {
+		/*
+		 * Either we failed, or the format actually produces a 0-length
+		 * output. There's not much we can do, so we leave it blank.
+		 * However, the output array is left in an undefined state, so
+		 * we must re-assert our NUL terminator.
+		 */
+		sb->buf[sb->len] = '\0';
+	} else {
+		sb->len += len;
+	}
+}
diff --git a/strbuf.h b/strbuf.h
index 01c5c63..8c8f8d5 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -345,6 +345,11 @@ __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
+ * Add the time specified by `tm`, as formatted by `strftime`.
+ */
+extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm);
+
+/**
  * Read a given size of data from a FILE* pointer to the buffer.
  *
  * NOTE: The buffer is rewound if the read fails. If -1 is returned,
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 24fc2ba..c7f368c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -227,6 +227,14 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check format of strftime date fields' '
+	echo "my date is 2006-07-03" >expected &&
+	git for-each-ref \
+	  --format="%(authordate:format:my date is %Y-%m-%d)" \
+	  refs/heads >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 refs/heads/master
 refs/remotes/origin/master
-- 
2.4.4.742.g862750c
