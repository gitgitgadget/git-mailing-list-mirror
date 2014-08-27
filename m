From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/6] use strbufs in date functions
Date: Wed, 27 Aug 2014 03:57:08 -0400
Message-ID: <20140827075708.GD26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:57:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY6W-0002Zk-9p
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbaH0H5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:57:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59895 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752578AbaH0H5K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:57:10 -0400
Received: (qmail 14676 invoked by uid 102); 27 Aug 2014 07:57:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:57:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:57:08 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255986>

Many of the date functions write into fixed-size buffers.
This is a minor pain, as we have to take special
precautions, and frequently end up copying the result into a
strbuf or heap-allocated buffer anyway (for which we
sometimes use strcpy!).

Let's instead teach parse_date, datestamp, etc to write to a
strbuf. The obvious downside is that we might need to
perform a heap allocation where we otherwise would not need
to. However, it turns out that the only two new allocations
required are:

  1. In test-date.c, where we don't care about efficiency.

  2. In determine_author_info, which is not performance
     critical (and where the use of a strbuf will help later
     refactoring).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 20 ++++++++++----------
 cache.h          |  4 ++--
 date.c           | 13 +++++++------
 fast-import.c    | 20 +++++++++-----------
 ident.c          | 26 +++++++++++---------------
 test-date.c      | 10 ++++++----
 6 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..8da0a9f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -520,19 +520,16 @@ static int sane_ident_split(struct ident_split *person)
 	return 1;
 }
 
-static int parse_force_date(const char *in, char *out, int len)
+static int parse_force_date(const char *in, struct strbuf *out)
 {
-	if (len < 1)
-		return -1;
-	*out++ = '@';
-	len--;
+	strbuf_addch(out, '@');
 
-	if (parse_date(in, out, len) < 0) {
+	if (parse_date(in, out) < 0) {
 		int errors = 0;
 		unsigned long t = approxidate_careful(in, &errors);
 		if (errors)
 			return -1;
-		snprintf(out, len, "%lu", t);
+		strbuf_addf(out, "%lu", t);
 	}
 
 	return 0;
@@ -542,7 +539,7 @@ static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
-	char date_buf[64];
+	struct strbuf date_buf = STRBUF_INIT;
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -588,9 +585,10 @@ static void determine_author_info(struct strbuf *author_ident)
 	}
 
 	if (force_date) {
-		if (parse_force_date(force_date, date_buf, sizeof(date_buf)))
+		strbuf_reset(&date_buf);
+		if (parse_force_date(force_date, &date_buf))
 			die(_("invalid date format: %s"), force_date);
-		date = date_buf;
+		date = date_buf.buf;
 	}
 
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
@@ -600,6 +598,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		export_one("GIT_AUTHOR_EMAIL", author.mail_begin, author.mail_end, 0);
 		export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
 	}
+
+	strbuf_release(&date_buf);
 }
 
 static void split_ident_or_die(struct ident_split *id, const struct strbuf *buf)
diff --git a/cache.h b/cache.h
index fcb511d..96ecc1f 100644
--- a/cache.h
+++ b/cache.h
@@ -1044,10 +1044,10 @@ enum date_mode {
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 void show_date_relative(unsigned long time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
-int parse_date(const char *date, char *buf, int bufsize);
+int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
 int parse_expiry_date(const char *date, unsigned long *timestamp);
-void datestamp(char *buf, int bufsize);
+void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
diff --git a/date.c b/date.c
index 782de95..2c33468 100644
--- a/date.c
+++ b/date.c
@@ -605,7 +605,7 @@ static int match_tz(const char *date, int *offp)
 	return end - date;
 }
 
-static int date_string(unsigned long date, int offset, char *buf, int len)
+static void date_string(unsigned long date, int offset, struct strbuf *buf)
 {
 	int sign = '+';
 
@@ -613,7 +613,7 @@ static int date_string(unsigned long date, int offset, char *buf, int len)
 		offset = -offset;
 		sign = '-';
 	}
-	return snprintf(buf, len, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
+	strbuf_addf(buf, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
 /*
@@ -735,13 +735,14 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 	return errors;
 }
 
-int parse_date(const char *date, char *result, int maxlen)
+int parse_date(const char *date, struct strbuf *result)
 {
 	unsigned long timestamp;
 	int offset;
 	if (parse_date_basic(date, &timestamp, &offset))
 		return -1;
-	return date_string(timestamp, offset, result, maxlen);
+	date_string(timestamp, offset, result);
+	return 0;
 }
 
 enum date_mode parse_date_format(const char *format)
@@ -766,7 +767,7 @@ enum date_mode parse_date_format(const char *format)
 		die("unknown date format %s", format);
 }
 
-void datestamp(char *buf, int bufsize)
+void datestamp(struct strbuf *out)
 {
 	time_t now;
 	int offset;
@@ -776,7 +777,7 @@ void datestamp(char *buf, int bufsize)
 	offset = tm_to_time_t(localtime(&now)) - now;
 	offset /= 60;
 
-	date_string(now, offset, buf, bufsize);
+	date_string(now, offset, out);
 }
 
 /*
diff --git a/fast-import.c b/fast-import.c
index d73f58c..dc9f7a8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1971,7 +1971,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 	return 1;
 }
 
-static int validate_raw_date(const char *src, char *result, int maxlen)
+static int validate_raw_date(const char *src, struct strbuf *result)
 {
 	const char *orig_src = src;
 	char *endp;
@@ -1989,11 +1989,10 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 		return -1;
 
 	num = strtoul(src + 1, &endp, 10);
-	if (errno || endp == src + 1 || *endp || (endp - orig_src) >= maxlen ||
-	    1400 < num)
+	if (errno || endp == src + 1 || *endp || 1400 < num)
 		return -1;
 
-	strcpy(result, orig_src);
+	strbuf_addstr(result, orig_src);
 	return 0;
 }
 
@@ -2001,7 +2000,7 @@ static char *parse_ident(const char *buf)
 {
 	const char *ltgt;
 	size_t name_len;
-	char *ident;
+	struct strbuf ident = STRBUF_INIT;
 
 	/* ensure there is a space delimiter even if there is no name */
 	if (*buf == '<')
@@ -2020,26 +2019,25 @@ static char *parse_ident(const char *buf)
 		die("Missing space after > in ident string: %s", buf);
 	ltgt++;
 	name_len = ltgt - buf;
-	ident = xmalloc(name_len + 24);
-	strncpy(ident, buf, name_len);
+	strbuf_add(&ident, buf, name_len);
 
 	switch (whenspec) {
 	case WHENSPEC_RAW:
-		if (validate_raw_date(ltgt, ident + name_len, 24) < 0)
+		if (validate_raw_date(ltgt, &ident) < 0)
 			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
 		break;
 	case WHENSPEC_RFC2822:
-		if (parse_date(ltgt, ident + name_len, 24) < 0)
+		if (parse_date(ltgt, &ident) < 0)
 			die("Invalid rfc2822 date \"%s\" in ident: %s", ltgt, buf);
 		break;
 	case WHENSPEC_NOW:
 		if (strcmp("now", ltgt))
 			die("Date in ident must be 'now': %s", buf);
-		datestamp(ident + name_len, 24);
+		datestamp(&ident);
 		break;
 	}
 
-	return ident;
+	return strbuf_detach(&ident, NULL);
 }
 
 static void parse_and_store_blob(
diff --git a/ident.c b/ident.c
index 1d9b6e7..9bcc4e1 100644
--- a/ident.c
+++ b/ident.c
@@ -9,7 +9,7 @@
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
-static char git_default_date[50];
+static struct strbuf git_default_date = STRBUF_INIT;
 
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
@@ -129,9 +129,9 @@ const char *ident_default_email(void)
 
 static const char *ident_default_date(void)
 {
-	if (!git_default_date[0])
-		datestamp(git_default_date, sizeof(git_default_date));
-	return git_default_date;
+	if (!git_default_date.len)
+		datestamp(&git_default_date);
+	return git_default_date.buf;
 }
 
 static int crud(unsigned char c)
@@ -292,7 +292,6 @@ const char *fmt_ident(const char *name, const char *email,
 		      const char *date_str, int flag)
 {
 	static struct strbuf ident = STRBUF_INIT;
-	char date[50];
 	int strict = (flag & IDENT_STRICT);
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
@@ -320,15 +319,6 @@ const char *fmt_ident(const char *name, const char *email,
 		die("unable to auto-detect email address (got '%s')", email);
 	}
 
-	if (want_date) {
-		if (date_str && date_str[0]) {
-			if (parse_date(date_str, date, sizeof(date)) < 0)
-				die("invalid date format: %s", date_str);
-		}
-		else
-			strcpy(date, ident_default_date());
-	}
-
 	strbuf_reset(&ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(&ident, name);
@@ -339,8 +329,14 @@ const char *fmt_ident(const char *name, const char *email,
 			strbuf_addch(&ident, '>');
 	if (want_date) {
 		strbuf_addch(&ident, ' ');
-		strbuf_addstr_without_crud(&ident, date);
+		if (date_str && date_str[0]) {
+			if (parse_date(date_str, &ident) < 0)
+				die("invalid date format: %s", date_str);
+		}
+		else
+			strbuf_addstr(&ident, ident_default_date());
 	}
+
 	return ident.buf;
 }
 
diff --git a/test-date.c b/test-date.c
index 10afaab..94a6997 100644
--- a/test-date.c
+++ b/test-date.c
@@ -19,19 +19,21 @@ static void show_dates(char **argv, struct timeval *now)
 
 static void parse_dates(char **argv, struct timeval *now)
 {
+	struct strbuf result = STRBUF_INIT;
+
 	for (; *argv; argv++) {
-		char result[100];
 		unsigned long t;
 		int tz;
 
-		result[0] = 0;
-		parse_date(*argv, result, sizeof(result));
-		if (sscanf(result, "%lu %d", &t, &tz) == 2)
+		strbuf_reset(&result);
+		parse_date(*argv, &result);
+		if (sscanf(result.buf, "%lu %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
 			       *argv, show_date(t, tz, DATE_ISO8601));
 		else
 			printf("%s -> bad\n", *argv);
 	}
+	strbuf_release(&result);
 }
 
 static void parse_approxidate(char **argv, struct timeval *now)
-- 
2.1.0.346.ga0367b9
