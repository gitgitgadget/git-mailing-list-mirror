From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Thu, 25 Jun 2015 12:55:02 -0400
Message-ID: <20150625165501.GB23503@peff.net>
References: <20150625165341.GA21949@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:55:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8AQi-0002Yh-7y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 18:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbbFYQzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 12:55:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:51770 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbbFYQzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 12:55:04 -0400
Received: (qmail 19857 invoked by uid 102); 25 Jun 2015 16:55:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 11:55:04 -0500
Received: (qmail 8208 invoked by uid 107); 25 Jun 2015 16:55:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Jun 2015 12:55:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jun 2015 12:55:02 -0400
Content-Disposition: inline
In-Reply-To: <20150625165341.GA21949@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272698>

In preparation for adding date modes that may carry extra
information beyond the mode itself, this patch converts the
date_mode enum into a struct.

Most of the conversion is fairly straightforward; we pass
the struct as a pointer and dereference the type field where
necessary. Locations that declare a date_mode can use a "{}"
constructor.  However, the tricky case is where we use the
enum labels as constants, like:

  show_date(t, tz, DATE_NORMAL);

Ideally we could say:

  show_date(t, tz, &{ DATE_NORMAL });

but of course C does not allow that. Likewise, we cannot
cast the constant to a struct, because we need to pass an
actual address. Our options are basically:

  1. Manually add a "struct date_mode d = { DATE_NORMAL }"
     definition to each caller, and pass "&d". This makes
     the callers uglier, because they sometimes do not even
     have their own scope (e.g., they are inside a switch
     statement).

  2. Provide a pre-made global "date_normal" struct that can
     be passed by address. We'd also need "date_rfc2822",
     "date_iso8601", and so forth. But at least the ugliness
     is defined in one place.

  3. Provide a wrapper that generates the correct struct on
     the fly. The big downside is that we end up pointing to
     a single global, which makes our wrapper non-reentrant.
     But show_date is already not reentrant, so it does not
     matter.

This patch implements 3, along with a minor macro to keep
the size of the callers sane.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c               |  2 +-
 builtin/blame.c         | 10 +++++-----
 builtin/commit.c        |  4 ++--
 builtin/for-each-ref.c  |  6 +++---
 builtin/log.c           |  4 ++--
 builtin/shortlog.c      |  2 +-
 builtin/show-branch.c   |  3 ++-
 cache.h                 | 35 +++++++++++++++++++++++------------
 commit.h                |  2 +-
 date.c                  | 43 +++++++++++++++++++++++++------------------
 fast-import.c           |  2 +-
 http-backend.c          |  2 +-
 log-tree.c              |  2 +-
 pretty.c                | 29 +++++++++++++++--------------
 reflog-walk.c           |  4 ++--
 reflog-walk.h           |  4 ++--
 refs.c                  |  4 ++--
 revision.c              |  4 ++--
 revision.h              |  2 +-
 sha1_name.c             |  2 +-
 submodule.c             |  2 +-
 test-date.c             |  4 ++--
 test-revision-walking.c |  2 +-
 23 files changed, 97 insertions(+), 77 deletions(-)

diff --git a/archive.c b/archive.c
index d37c41d..30bda56 100644
--- a/archive.c
+++ b/archive.c
@@ -33,7 +33,7 @@ static void format_subst(const struct commit *commit,
 	char *to_free = NULL;
 	struct strbuf fmt = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_NORMAL;
+	ctx.date_mode.type = DATE_NORMAL;
 	ctx.abbrev = DEFAULT_ABBREV;
 
 	if (src == buf->buf)
diff --git a/builtin/blame.c b/builtin/blame.c
index b3e948e..43e8473 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -50,7 +50,7 @@ static int xdl_opts;
 static int abbrev = -1;
 static int no_whole_file_rename;
 
-static enum date_mode blame_date_mode = DATE_ISO8601;
+static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
 
 static struct string_list mailmap;
@@ -1827,7 +1827,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 		size_t time_width;
 		int tz;
 		tz = atoi(tz_str);
-		time_str = show_date(time, tz, blame_date_mode);
+		time_str = show_date(time, tz, &blame_date_mode);
 		strbuf_addstr(&time_buf, time_str);
 		/*
 		 * Add space paddings to time_buf to display a fixed width
@@ -2179,7 +2179,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
-		blame_date_mode = parse_date_format(value);
+		parse_date_format(value, &blame_date_mode);
 		return 0;
 	}
 
@@ -2561,13 +2561,13 @@ parse_done:
 
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
-		blame_date_mode = DATE_ISO8601;
+		blame_date_mode.type = DATE_ISO8601;
 	} else {
 		blame_date_mode = revs.date_mode;
 	}
 
 	/* The maximum width used to show the dates */
-	switch (blame_date_mode) {
+	switch (blame_date_mode.type) {
 	case DATE_RFC2822:
 		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
 		break;
diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..7314f33 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -856,7 +856,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("%s"
 				"Date:      %s"),
 				ident_shown++ ? "" : "\n",
-				show_ident_date(&ai, DATE_NORMAL));
+				show_ident_date(&ai, DATE_MODE(NORMAL)));
 
 		if (!committer_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1046,7 +1046,7 @@ static const char *find_author_by_nickname(const char *name)
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_NORMAL;
+		ctx.date_mode.type = DATE_NORMAL;
 		strbuf_release(&buf);
 		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
 		clear_mailmap(&mailmap);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f7e51a7..691daf1 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -389,7 +389,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	char *zone;
 	unsigned long timestamp;
 	long tz;
-	enum date_mode date_mode = DATE_NORMAL;
+	struct date_mode date_mode = { DATE_NORMAL };
 	const char *formatp;
 
 	/*
@@ -401,7 +401,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	formatp = strchr(atomname, ':');
 	if (formatp != NULL) {
 		formatp++;
-		date_mode = parse_date_format(formatp);
+		parse_date_format(formatp, &date_mode);
 	}
 
 	if (!eoemail)
@@ -412,7 +412,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, date_mode));
+	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
 	v->ul = timestamp;
 	return;
  bad:
diff --git a/builtin/log.c b/builtin/log.c
index e67671e..ce1581e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -112,7 +112,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
-		rev->date_mode = parse_date_format(default_date_mode);
+		parse_date_format(default_date_mode, &rev->date_mode);
 	rev->diffopt.touched_flags = 0;
 }
 
@@ -939,7 +939,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
-	pp.date_mode = DATE_RFC2822;
+	pp.date_mode.type = DATE_RFC2822;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
 	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
 	pp_remainder(&pp, &msg, &sb, 0);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c0bab6a..007cc66 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -138,7 +138,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.abbrev = log->abbrev;
 		ctx.subject = "";
 		ctx.after_subject = "";
-		ctx.date_mode = DATE_NORMAL;
+		ctx.date_mode.type = DATE_NORMAL;
 		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d784613..c87c46e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -784,7 +784,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			else
 				msg++;
 			reflog_msg[i] = xstrfmt("(%s) %s",
-						show_date(timestamp, tz, DATE_RELATIVE),
+						show_date(timestamp, tz,
+							  DATE_MODE(RELATIVE)),
 						msg);
 			free(logmsg);
 			sprintf(nth_desc, "%s@{%d}", *av, base+i);
diff --git a/cache.h b/cache.h
index 571c98f..1759011 100644
--- a/cache.h
+++ b/cache.h
@@ -1096,18 +1096,28 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
-enum date_mode {
-	DATE_NORMAL = 0,
-	DATE_RELATIVE,
-	DATE_SHORT,
-	DATE_LOCAL,
-	DATE_ISO8601,
-	DATE_ISO8601_STRICT,
-	DATE_RFC2822,
-	DATE_RAW
+struct date_mode {
+	enum date_mode_type {
+		DATE_NORMAL = 0,
+		DATE_RELATIVE,
+		DATE_SHORT,
+		DATE_LOCAL,
+		DATE_ISO8601,
+		DATE_ISO8601_STRICT,
+		DATE_RFC2822,
+		DATE_RAW
+	} type;
 };
 
-const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+/*
+ * Convenience helper for passing a constant type, like:
+ *
+ *   show_date(t, tz, DATE_MODE(NORMAL));
+ */
+#define DATE_MODE(t) date_mode_from_type(DATE_##t)
+struct date_mode *date_mode_from_type(enum date_mode_type type);
+
+const char *show_date(unsigned long time, int timezone, const struct date_mode *mode);
 void show_date_relative(unsigned long time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
@@ -1117,7 +1127,7 @@ void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
-enum date_mode parse_date_format(const char *format);
+void parse_date_format(const char *format, struct date_mode *mode);
 int date_overflows(unsigned long date);
 
 #define IDENT_STRICT	       1
@@ -1154,7 +1164,8 @@ extern int split_ident_line(struct ident_split *, const char *, int);
  * the ident_split. It will also sanity-check the values and produce
  * a well-known sentinel date if they appear bogus.
  */
-const char *show_ident_date(const struct ident_split *id, enum date_mode mode);
+const char *show_ident_date(const struct ident_split *id,
+			    const struct date_mode *mode);
 
 /*
  * Compare split idents for equality or strict ordering. Note that we
diff --git a/commit.h b/commit.h
index 9a1fa96..1496882 100644
--- a/commit.h
+++ b/commit.h
@@ -145,7 +145,7 @@ struct pretty_print_context {
 	const char *subject;
 	const char *after_subject;
 	int preserve_subject;
-	enum date_mode date_mode;
+	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
 	int need_8bit_cte;
 	char *notes_message;
diff --git a/date.c b/date.c
index 733d1b2..cdad4db 100644
--- a/date.c
+++ b/date.c
@@ -160,18 +160,25 @@ void show_date_relative(unsigned long time, int tz,
 		 (diff + 183) / 365);
 }
 
-const char *show_date(unsigned long time, int tz, enum date_mode mode)
+struct date_mode *date_mode_from_type(enum date_mode_type type)
+{
+	static struct date_mode mode;
+	mode.type = type;
+	return &mode;
+}
+
+const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
 
-	if (mode == DATE_RAW) {
+	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
 		return timebuf.buf;
 	}
 
-	if (mode == DATE_RELATIVE) {
+	if (mode->type == DATE_RELATIVE) {
 		struct timeval now;
 
 		strbuf_reset(&timebuf);
@@ -180,7 +187,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		return timebuf.buf;
 	}
 
-	if (mode == DATE_LOCAL)
+	if (mode->type == DATE_LOCAL)
 		tz = local_tzoffset(time);
 
 	tm = time_to_tm(time, tz);
@@ -190,17 +197,17 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	}
 
 	strbuf_reset(&timebuf);
-	if (mode == DATE_SHORT)
+	if (mode->type == DATE_SHORT)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode == DATE_ISO8601)
+	else if (mode->type == DATE_ISO8601)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode == DATE_ISO8601_STRICT) {
+	else if (mode->type == DATE_ISO8601_STRICT) {
 		char sign = (tz >= 0) ? '+' : '-';
 		tz = abs(tz);
 		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
@@ -209,7 +216,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				sign, tz / 100, tz % 100);
-	} else if (mode == DATE_RFC2822)
+	} else if (mode->type == DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
@@ -221,7 +228,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tm->tm_year + 1900,
-				(mode == DATE_LOCAL) ? 0 : ' ',
+				(mode->type == DATE_LOCAL) ? 0 : ' ',
 				tz);
 	return timebuf.buf;
 }
@@ -759,27 +766,27 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
-enum date_mode parse_date_format(const char *format)
+void parse_date_format(const char *format, struct date_mode *mode)
 {
 	if (!strcmp(format, "relative"))
-		return DATE_RELATIVE;
+		mode->type = DATE_RELATIVE;
 	else if (!strcmp(format, "iso8601") ||
 		 !strcmp(format, "iso"))
-		return DATE_ISO8601;
+		mode->type = DATE_ISO8601;
 	else if (!strcmp(format, "iso8601-strict") ||
 		 !strcmp(format, "iso-strict"))
-		return DATE_ISO8601_STRICT;
+		mode->type = DATE_ISO8601_STRICT;
 	else if (!strcmp(format, "rfc2822") ||
 		 !strcmp(format, "rfc"))
-		return DATE_RFC2822;
+		mode->type = DATE_RFC2822;
 	else if (!strcmp(format, "short"))
-		return DATE_SHORT;
+		mode->type = DATE_SHORT;
 	else if (!strcmp(format, "local"))
-		return DATE_LOCAL;
+		mode->type = DATE_LOCAL;
 	else if (!strcmp(format, "default"))
-		return DATE_NORMAL;
+		mode->type = DATE_NORMAL;
 	else if (!strcmp(format, "raw"))
-		return DATE_RAW;
+		mode->type = DATE_RAW;
 	else
 		die("unknown date format %s", format);
 }
diff --git a/fast-import.c b/fast-import.c
index 6378726..9363cc7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -421,7 +421,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
+	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(LOCAL)));
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
diff --git a/http-backend.c b/http-backend.c
index 501bf79..b977c00 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -92,7 +92,7 @@ static void hdr_int(const char *name, uintmax_t value)
 
 static void hdr_date(const char *name, unsigned long when)
 {
-	const char *value = show_date(when, 0, DATE_RFC2822);
+	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
 	hdr_str(name, value);
 }
 
diff --git a/log-tree.c b/log-tree.c
index 01beb11..e57e6b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -639,7 +639,7 @@ void show_log(struct rev_info *opt)
 			 */
 			show_reflog_message(opt->reflog_info,
 					    opt->commit_format == CMIT_FMT_ONELINE,
-					    opt->date_mode,
+					    &opt->date_mode,
 					    opt->date_mode_explicit);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
diff --git a/pretty.c b/pretty.c
index 7b49304..151c2ae 100644
--- a/pretty.c
+++ b/pretty.c
@@ -399,7 +399,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 }
 
 const char *show_ident_date(const struct ident_split *ident,
-			    enum date_mode mode)
+			    const struct date_mode *mode)
 {
 	unsigned long date = 0;
 	long tz = 0;
@@ -489,15 +489,15 @@ void pp_user_info(struct pretty_print_context *pp,
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
 		strbuf_addf(sb, "Date:   %s\n",
-			    show_ident_date(&ident, pp->date_mode));
+			    show_ident_date(&ident, &pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
 		strbuf_addf(sb, "Date: %s\n",
-			    show_ident_date(&ident, DATE_RFC2822));
+			    show_ident_date(&ident, DATE_MODE(RFC2822)));
 		break;
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what,
-			    show_ident_date(&ident, pp->date_mode));
+			    show_ident_date(&ident, &pp->date_mode));
 		break;
 	default:
 		/* notin' */
@@ -671,7 +671,8 @@ static int mailmap_name(const char **email, size_t *email_len,
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
-				 const char *msg, int len, enum date_mode dmode)
+				 const char *msg, int len,
+				 const struct date_mode *dmode)
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
@@ -711,16 +712,16 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		strbuf_addstr(sb, show_ident_date(&s, dmode));
 		return placeholder_len;
 	case 'D':	/* date, RFC2822 style */
-		strbuf_addstr(sb, show_ident_date(&s, DATE_RFC2822));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(RFC2822)));
 		return placeholder_len;
 	case 'r':	/* date, relative */
-		strbuf_addstr(sb, show_ident_date(&s, DATE_RELATIVE));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(RELATIVE)));
 		return placeholder_len;
 	case 'i':	/* date, ISO 8601-like */
-		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601)));
 		return placeholder_len;
 	case 'I':	/* date, ISO 8601 strict */
-		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601_STRICT));
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
 	}
 
@@ -933,7 +934,7 @@ static void rewrap_message_tail(struct strbuf *sb,
 static int format_reflog_person(struct strbuf *sb,
 				char part,
 				struct reflog_walk_info *log,
-				enum date_mode dmode)
+				const struct date_mode *dmode)
 {
 	const char *ident;
 
@@ -1185,7 +1186,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_selector(sb,
 						    c->pretty_ctx->reflog_info,
-						    c->pretty_ctx->date_mode,
+						    &c->pretty_ctx->date_mode,
 						    c->pretty_ctx->date_mode_explicit,
 						    (placeholder[1] == 'd'));
 			return 2;
@@ -1200,7 +1201,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			return format_reflog_person(sb,
 						    placeholder[1],
 						    c->pretty_ctx->reflog_info,
-						    c->pretty_ctx->date_mode);
+						    &c->pretty_ctx->date_mode);
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
@@ -1251,11 +1252,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 'a':	/* author ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->author.off, c->author.len,
-				   c->pretty_ctx->date_mode);
+				   &c->pretty_ctx->date_mode);
 	case 'c':	/* committer ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->committer.off, c->committer.len,
-				   c->pretty_ctx->date_mode);
+				   &c->pretty_ctx->date_mode);
 	case 'e':	/* encoding */
 		if (c->commit_encoding)
 			strbuf_addstr(sb, c->commit_encoding);
diff --git a/reflog-walk.c b/reflog-walk.c
index 222de76..f8e743a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -249,7 +249,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 enum date_mode dmode, int force_date,
+			 const struct date_mode *dmode, int force_date,
 			 int shorten)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
@@ -311,7 +311,7 @@ const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 }
 
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
-			 enum date_mode dmode, int force_date)
+			 const struct date_mode *dmode, int force_date)
 {
 	if (reflog_info && reflog_info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
diff --git a/reflog-walk.h b/reflog-walk.h
index a9bd60e..27886f7 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -11,13 +11,13 @@ extern int add_reflog_for_walk(struct reflog_walk_info *info,
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
-				enum date_mode, int force_date);
+				const struct date_mode *, int force_date);
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
 extern const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
-		enum date_mode dmode, int force_date,
+		const struct date_mode *dmode, int force_date,
 		int shorten);
 
 #endif
diff --git a/refs.c b/refs.c
index 26d1ac1..f9b828c 100644
--- a/refs.c
+++ b/refs.c
@@ -3356,14 +3356,14 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 			hashcpy(cb->sha1, nsha1);
 			if (hashcmp(cb->osha1, nsha1))
 				warning("Log for ref %s has gap after %s.",
-					cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
+					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			hashcpy(cb->sha1, nsha1);
 		else if (hashcmp(nsha1, cb->sha1))
 			warning("Log for ref %s unexpectedly ended on %s.",
 				cb->refname, show_date(cb->date, cb->tz,
-						   DATE_RFC2822));
+						       DATE_MODE(RFC2822)));
 		hashcpy(cb->osha1, osha1);
 		hashcpy(cb->nsha1, nsha1);
 		cb->found_it = 1;
diff --git a/revision.c b/revision.c
index 3ff8723..887e65e 100644
--- a/revision.c
+++ b/revision.c
@@ -1996,10 +1996,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--full-history")) {
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
-		revs->date_mode = DATE_RELATIVE;
+		revs->date_mode.type = DATE_RELATIVE;
 		revs->date_mode_explicit = 1;
 	} else if ((argcount = parse_long_opt("date", argv, &optarg))) {
-		revs->date_mode = parse_date_format(optarg);
+		parse_date_format(optarg, &revs->date_mode);
 		revs->date_mode_explicit = 1;
 		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
diff --git a/revision.h b/revision.h
index 0ea8b4e..5bc9686 100644
--- a/revision.h
+++ b/revision.h
@@ -146,7 +146,7 @@ struct rev_info {
 			track_first_time:1,
 			linear:1;
 
-	enum date_mode date_mode;
+	struct date_mode date_mode;
 
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
diff --git a/sha1_name.c b/sha1_name.c
index e57513e..da6874c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -576,7 +576,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 				if (!(flags & GET_SHA1_QUIETLY)) {
 					warning("Log for '%.*s' only goes "
 						"back to %s.", len, str,
-						show_date(co_time, co_tz, DATE_RFC2822));
+						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
 			} else {
 				if (flags & GET_SHA1_QUIETLY) {
diff --git a/submodule.c b/submodule.c
index 15e90d1..700bbf4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -993,7 +993,7 @@ static void print_commit(struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_NORMAL;
+	ctx.date_mode.type = DATE_NORMAL;
 	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
diff --git a/test-date.c b/test-date.c
index 94a6997..63f3735 100644
--- a/test-date.c
+++ b/test-date.c
@@ -29,7 +29,7 @@ static void parse_dates(char **argv, struct timeval *now)
 		parse_date(*argv, &result);
 		if (sscanf(result.buf, "%lu %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
-			       *argv, show_date(t, tz, DATE_ISO8601));
+			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
 		else
 			printf("%s -> bad\n", *argv);
 	}
@@ -41,7 +41,7 @@ static void parse_approxidate(char **argv, struct timeval *now)
 	for (; *argv; argv++) {
 		time_t t;
 		t = approxidate_relative(*argv, now);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_ISO8601));
+		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
 	}
 }
 
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 3ade02c..285f06b 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -17,7 +17,7 @@ static void print_commit(struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_NORMAL;
+	ctx.date_mode.type = DATE_NORMAL;
 	format_commit_message(commit, " %m %s", &sb, &ctx);
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
-- 
2.4.4.742.g862750c
