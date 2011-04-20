From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 3/5] Date Mode: Implementation
Date: Wed, 20 Apr 2011 02:45:18 +0000
Message-ID: <4e4fea2a-c9fe-47ff-b947-64aa4662adae-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNcL-00054R-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1DTC5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:57:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1DTC5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:57:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so83526ewy.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=HmtTXavISNdoV1i6KoXXPizbTrvf4m1SGUSY1RqBdV0=;
        b=H2bjlYIEPdNOcM1lCsnZiOYdGoyjP4OSv2/bhuaMypV7NKSDz4O/6L/FsEm+Krgii9
         V61pB+a+9XCuBqRvSt8UcHmTIygi54FfC0uV8yaGAQWQm+BvLRIC4j0nSMO9YyRpYY40
         Ye2KIQolnGQN58DlBtN9j/Xz8URnY84FoTBYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=VnA80VzAKYlAXjYmZ/POpPDaexP/Zem7bQtYj1zgdbaW3BPVzLABmGlIp5PrTe0P1F
         aqsC4syfw3y04a/uXaDZyj0G1jrUv2FYNtXEFDpJAfqXBGqetvg+rFXBa6PhF7rIMLPb
         k8fTqSS7kZv/tpzbegKMgwVVwZdsA1hGjLhDo=
Received: by 10.14.132.144 with SMTP id o16mr2271180eei.179.1303268272905;
        Tue, 19 Apr 2011 19:57:52 -0700 (PDT)
Received: from gmail.com (server105708.santrex.net [188.165.236.117])
        by mx.google.com with ESMTPS id y7sm338359eeh.0.2011.04.19.19.57.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:57:51 -0700 (PDT)
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171834>

Date: Sat, 12 Feb 2011 03:56:17 +0000
This introduces and employs infrastructure for manipulating
and bundling time zone and date format specifications in
code, on the command line, and in git configuration files.

In particular, this commit includes the following:

  * `struct date_mode' along with functions and macros for
     working with it.

  *  The new `--time-zone' option (which takes as a value
     either `default' or `local').

  *  The new date-type mode specifiers `@default' and `@local'
     for use with the formats of "git for-each-ref".

  *  The configuration variables `log.timezone' and
    `blame.timezone' and the functions for handling their
     parsing.

Moreover, the value `local' for a date mode format has
been deprecated in favor of the value `local' for a
date mode time zone; a use of the deprecated `local'
format causes an informational warning to be emitted
on stderr (though this message might be missed quite
easily due to further normal output on stdout).

Essentially, what was:

  git log --date=local

should now be:

  git log --time-zone=local

or, perhaps more accurately (depending on what the
actual unspecified date mode format is):

  git log --date=default --time-zone=local

The other valid time zone value is `default', which
specifies that the time zone stored by git be used.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 archive.c              |    2 +-
 builtin/blame.c        |   23 +++++++-------
 builtin/cat-file.c     |    3 +-
 builtin/commit.c       |    2 +-
 builtin/for-each-ref.c |   65 +++++++++++++++++++++++++++++----------
 builtin/log.c          |   17 ++++++----
 builtin/shortlog.c     |    2 +-
 builtin/show-branch.c  |    3 +-
 cache.h                |   39 +++++++++++++++++++++--
 commit.h               |    4 +-
 date.c                 |   79 +++++++++++++++++++++++++++++++++++++++++++-----
 fast-import.c          |    4 ++-
 http-backend.c         |    3 +-
 log-tree.c             |   10 ++++--
 pretty.c               |   18 +++++++----
 reflog-walk.c          |    6 ++--
 reflog-walk.h          |    4 +-
 refs.c                 |    6 ++-
 revision.c             |   11 ++++--
 revision.h             |    4 +-
 sha1_name.c            |    5 ++-
 submodule.c            |    2 +-
 test-date.c            |   11 ++++--
 23 files changed, 236 insertions(+), 87 deletions(-)

diff --git a/archive.c b/archive.c
index dd871ca..cb3e731 100644
--- a/archive.c
+++ b/archive.c
@@ -32,7 +32,7 @@ static void format_subst(const struct commit *commit,
 	char *to_free = NULL;
 	struct strbuf fmt = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_DEFAULT;
+	SET_DATE_MODE_DEFAULT(ctx.date_mode);
 	ctx.abbrev = DEFAULT_ABBREV;
 
 	if (src == buf->buf)
diff --git a/builtin/blame.c b/builtin/blame.c
index dd597f4..c28d870 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -43,8 +43,8 @@ static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
 
-static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
+static struct date_mode blame_date_mode = INIT_DATE_MODE_FORMAT(DATE_ISO8601);
 
 static struct string_list mailmap;
 
@@ -2023,6 +2023,8 @@ static void prepare_blame_range(struct scoreboard *sb,
 
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
+	int ret;
+
 	if (!strcmp(var, "blame.showroot")) {
 		show_root = git_config_bool(var, value);
 		return 0;
@@ -2031,12 +2033,9 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "blame.date")) {
-		if (!value)
-			return config_error_nonbool(var);
-		blame_date_mode = parse_date_format(value);
-		return 0;
-	}
+
+	if (parse_date_mode_config("blame", var, value, &blame_date_mode, &ret))
+		return ret;
 
 	switch (userdiff_config(var, value)) {
 	case 0:
@@ -2347,6 +2346,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	sanitize_date_mode("blame", &revs.date_mode);
+
 	if (abbrev == -1)
 		abbrev = default_abbrev;
 	/* one more abbrev length is needed for the boundary commit */
@@ -2357,13 +2358,13 @@ parse_done:
 
 	if (cmd_is_annotate) {
 		output_option |= OUTPUT_ANNOTATE_COMPAT;
-		blame_date_mode = DATE_ISO8601;
+		blame_date_mode.format = DATE_ISO8601;
 	} else {
 		blame_date_mode = revs.date_mode;
 	}
 
 	/* The maximum width used to show the dates */
-	switch (blame_date_mode) {
+	switch (blame_date_mode.format) {
 	case DATE_RFC2822:
 		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
 		break;
@@ -2376,9 +2377,7 @@ parse_done:
 	case DATE_SHORT:
 		blame_date_width = sizeof("2006-10-19");
 		break;
-	case DATE_RELATIVE:
-	case DATE_LOCAL:
-	case DATE_DEFAULT:
+	default:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	}
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94632db..2252c83 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -46,6 +46,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 					char *ep;
 					unsigned long date;
 					long tz;
+					struct date_mode d = INIT_DATE_MODE;
 					while (sp < cp && *sp != '>')
 						sp++;
 					if (sp == cp) {
@@ -60,7 +61,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 					write_or_die(1, tagger, sp - tagger);
 					date = strtoul(sp, &ep, 10);
 					tz = strtol(ep, NULL, 10);
-					sp = show_date(date, tz, 0);
+					sp = show_date(date, tz, d);
 					write_or_die(1, sp, strlen(sp));
 					xwrite(1, "\n", 1);
 					break;
diff --git a/builtin/commit.c b/builtin/commit.c
index 194db99..79343c4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -933,7 +933,7 @@ static const char *find_author_by_nickname(const char *name)
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_DEFAULT;
+		SET_DATE_MODE_DEFAULT(ctx.date_mode);
 		strbuf_release(&buf);
 		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 60d6b32..add9299 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -118,9 +118,8 @@ static int parse_atom(const char *atom, const char *ep)
 		 * shouldn't be used for checking against the valid_atom
 		 * table.
 		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
+		const char *formatp = sp;
+		for (; formatp < ep && *formatp != ':' && *formatp != '@'; ++formatp);
 		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
@@ -361,26 +360,58 @@ static const char *copy_email(const char *buf)
 	return xmemdupz(email, eoemail + 1 - email);
 }
 
+#define PARSE_DATE_MODE(marker_0, parser_0, date_mode_member_0, \
+                        marker_1, parser_1, date_mode_member_1) \
+	if (*atomname == marker_0) { \
+		const char *spec_0 = ++atomname; \
+		do { \
+			if (*atomname == marker_1) { \
+				date_mode_member_1 = parser_1(atomname+1); \
+				char *spec_0_dup  = xmemdupz(spec_0, atomname - spec_0); \
+				date_mode_member_0 = parser_0(spec_0_dup); \
+				free(spec_0_dup); \
+				goto finish; \
+			} \
+		} while (*++atomname); \
+		date_mode_member_0 = parser_0(spec_0); \
+		goto finish; \
+	}
+
+static void parse_date_mode(const char *atomname, struct date_mode *date_mode)
+{
+	static int need_to_warn = 1;
+
+	do {
+		/* :date_format@time_zone */
+		PARSE_DATE_MODE(':', parse_date_format, date_mode->format,
+		                '@', parse_time_zone,   date_mode->zone);
+
+		/* @time_zone:date_format */
+		PARSE_DATE_MODE('@', parse_time_zone,   date_mode->zone,
+		                ':', parse_date_format, date_mode->format);
+
+	} while (*++atomname);
+
+finish:
+
+	if (sanitize_date_mode(NULL, date_mode) && need_to_warn) {
+		need_to_warn = 0;
+		warning("The date format `:local' is deprecated; "
+		        "use the time zone specifier `@local' instead.");
+	}
+}
+
+#undef PARSE_DATE_MODE
+
 static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
 {
 	const char *eoemail = strstr(buf, "> ");
 	char *zone;
 	unsigned long timestamp;
 	long tz;
-	enum date_mode date_mode = DATE_DEFAULT;
-	const char *formatp;
+	struct date_mode date_mode = INIT_DATE_MODE;
 
-	/*
-	 * We got here because atomname ends in "date" or "date<something>";
-	 * it's not possible that <something> is not ":<format>" because
-	 * parse_atom() wouldn't have allowed it, so we can assume that no
-	 * ":" means no format is specified, and use the default.
-	 */
-	formatp = strchr(atomname, ':');
-	if (formatp != NULL) {
-		formatp++;
-		date_mode = parse_date_format(formatp);
-	}
+	parse_date_mode(atomname, &date_mode);
 
 	if (!eoemail)
 		goto bad;
diff --git a/builtin/log.c b/builtin/log.c
index d43ad3a..fd6b212 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -20,8 +20,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 
-/* Set a default date-time format for git log ("log.date" config variable) */
-static const char *default_date_mode = NULL;
+static struct date_mode default_date_mode = INIT_DATE_MODE;
 
 static int default_show_root = 1;
 static int decoration_style;
@@ -61,8 +60,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
-	if (default_date_mode)
-		rev->date_mode = parse_date_format(default_date_mode);
+	rev->date_mode = default_date_mode;
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
@@ -79,6 +77,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		usage(builtin_log_usage);
 	argc = setup_revisions(argc, argv, rev, opt);
 
+	sanitize_date_mode("log", &rev->date_mode);
+
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
@@ -305,12 +305,14 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	int ret;
+
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
-	if (!strcmp(var, "log.date"))
-		return git_config_string(&default_date_mode, var, value);
+	if (parse_date_mode_config("log", var, value, &default_date_mode, &ret))
+		return ret;
 	if (!strcmp(var, "log.decorate")) {
 		decoration_style = parse_decoration_style(var, value);
 		if (decoration_style < 0)
@@ -748,6 +750,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct commit *commit = NULL;
+	struct date_mode date_mode = INIT_DATE_MODE_FORMAT(DATE_RFC2822);
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die(_("Cover letter needs email format"));
@@ -787,7 +790,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			need_8bit_cte = 1;
 
 	msg = body;
-	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
+	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, date_mode,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
 		      encoding, need_8bit_cte);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 5815f55..8560847 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -165,7 +165,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.abbrev = log->abbrev;
 		ctx.subject = "";
 		ctx.after_subject = "";
-		ctx.date_mode = DATE_DEFAULT;
+		SET_DATE_MODE_DEFAULT(ctx.date_mode);
 		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 1abcd9e..4981db2 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -765,6 +765,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			const char *msg;
 			unsigned long timestamp;
 			int tz;
+			struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_RELATIVE);
 
 			if (read_ref_at(ref, 0, base+i, sha1, &logmsg,
 					&timestamp, &tz, NULL)) {
@@ -778,7 +779,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				msg++;
 			m = xmalloc(strlen(msg) + 200);
 			sprintf(m, "(%s) %s",
-				show_date(timestamp, tz, 1),
+				show_date(timestamp, tz, d),
 				msg);
 			reflog_msg[i] = m;
 			free(logmsg);
diff --git a/cache.h b/cache.h
index bf639f7..910eccf 100644
--- a/cache.h
+++ b/cache.h
@@ -828,17 +828,47 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
-enum date_mode {
+enum date_format {
 	DATE_DEFAULT = 0,
 	DATE_RELATIVE,
 	DATE_SHORT,
-	DATE_LOCAL,
+	DATE_LOCAL,           /* Deprecated; use TIME_ZONE_LOCAL */
 	DATE_ISO8601,
 	DATE_RFC2822,
 	DATE_RAW
 };
 
-const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+enum time_zone {
+	TIME_ZONE_DEFAULT = 0,
+	TIME_ZONE_LOCAL
+};
+
+struct date_mode {
+	enum date_format format;
+	enum time_zone zone;
+};
+
+#define INIT_DATE_MODE_FORMAT_AND_ZONE(m,z) { .format = m, .zone = z }
+#define INIT_DATE_MODE_FORMAT(m) INIT_DATE_MODE_FORMAT_AND_ZONE(m, TIME_ZONE_DEFAULT)
+#define INIT_DATE_MODE_ZONE(z) INIT_DATE_MODE_FORMAT_AND_ZONE(DATE_DEFAULT, z)
+#define INIT_DATE_MODE INIT_DATE_MODE_FORMAT_AND_ZONE(DATE_DEFAULT, TIME_ZONE_DEFAULT)
+#define SET_DATE_MODE_DEFAULT(date_mode)   \
+	date_mode.format = DATE_DEFAULT; \
+	date_mode.zone = TIME_ZONE_DEFAULT;
+
+int parse_date_mode_config_internal(const char *var_date,
+                                     const char *var_time_zone,
+                                     const char *var,
+                                     const char *value,
+                                     struct date_mode *d,
+                                     int *ret);
+
+#define parse_date_mode_config(command_name, var, value, date_mode, ret) \
+	parse_date_mode_config_internal(command_name ".date", command_name ".timezone", var, value, date_mode, ret)
+
+int sanitize_date_mode(const char* command_name, struct date_mode *d);
+
+const char *show_date(unsigned long time, int timezone, struct date_mode date_mode);
 const char *show_date_relative(unsigned long time, int tz,
 			       const struct timeval *now,
 			       char *timebuf,
@@ -849,7 +879,8 @@ void datestamp(char *buf, int bufsize);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
-enum date_mode parse_date_format(const char *format);
+enum date_format parse_date_format(const char *format);
+enum time_zone parse_time_zone(const char *time_zone);
 
 #define IDENT_WARN_ON_NO_NAME  1
 #define IDENT_ERROR_ON_NO_NAME 2
diff --git a/commit.h b/commit.h
index 4198513..04b03d1 100644
--- a/commit.h
+++ b/commit.h
@@ -72,7 +72,7 @@ struct pretty_print_context {
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
-	enum date_mode date_mode;
+	struct date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
 	struct reflog_walk_info *reflog_info;
@@ -98,7 +98,7 @@ extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 				struct strbuf *sb,
 				const struct pretty_print_context *context);
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
-		   const char *line, enum date_mode dmode,
+		   const char *line, struct date_mode dmode,
 		   const char *encoding);
 void pp_title_line(enum cmit_fmt fmt,
 		   const char **msg_p,
diff --git a/date.c b/date.c
index caa14fe..879b0e1 100644
--- a/date.c
+++ b/date.c
@@ -147,40 +147,42 @@ const char *show_date_relative(unsigned long time, int tz,
 	return timebuf;
 }
 
-const char *show_date(unsigned long time, int tz, enum date_mode mode)
+const char *show_date(unsigned long time, int tz, struct date_mode date_mode)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
-	if (mode == DATE_RAW) {
+	enum date_format format = date_mode.format;
+
+	if (format == DATE_RAW) {
 		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
 		return timebuf;
 	}
 
-	if (mode == DATE_RELATIVE) {
+	if (format == DATE_RELATIVE) {
 		struct timeval now;
 		gettimeofday(&now, NULL);
 		return show_date_relative(time, tz, &now,
 					  timebuf, sizeof(timebuf));
 	}
 
-	if (mode == DATE_LOCAL)
+	if (date_mode.zone == TIME_ZONE_LOCAL)
 		tz = local_tzoffset(time);
 
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
-	if (mode == DATE_SHORT)
+	if (format == DATE_SHORT)
 		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode == DATE_ISO8601)
+	else if (format == DATE_ISO8601)
 		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode == DATE_RFC2822)
+	else if (format == DATE_RFC2822)
 		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
@@ -653,7 +655,7 @@ int parse_date(const char *date, char *result, int maxlen)
 	return date_string(timestamp, offset, result, maxlen);
 }
 
-enum date_mode parse_date_format(const char *format)
+enum date_format parse_date_format(const char *format)
 {
 	if (!strcmp(format, "relative"))
 		return DATE_RELATIVE;
@@ -675,6 +677,67 @@ enum date_mode parse_date_format(const char *format)
 		die("unknown date format %s", format);
 }
 
+enum time_zone parse_time_zone(const char *time_zone)
+{
+	if (!strcmp(time_zone, "local"))
+		return TIME_ZONE_LOCAL;
+	else if (!strcmp(time_zone, "default"))
+		return TIME_ZONE_DEFAULT;
+	else
+		die("unknown time zone %s", time_zone);
+}
+
+int parse_date_mode_config_internal(const char *var_date,
+                                     const char *var_timezone,
+                                     const char *var,
+                                     const char *value,
+                                     struct date_mode *d,
+                                     int *ret)
+{
+	if (!strcmp(var, var_date)) {
+		if (!value)
+			*ret = config_error_nonbool(var);
+
+		d->format = parse_date_format(value);
+
+		return 1;
+	}
+
+	if (!strcmp(var, var_timezone)) {
+		if (!value)
+			*ret = config_error_nonbool(var);
+
+		d->zone = parse_time_zone(value);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+int sanitize_date_mode(const char* command_name, struct date_mode *d)
+{
+	if (d->format == DATE_LOCAL) {
+		if (command_name)
+			warning("The following are now deprecated:\n\n"
+			        "    %s.date = local\n"
+			        "    --date=local\n\n"
+			        "Use these instead:\n\n"
+			        "    %s.timezone = local\n"
+			        "    --time-zone=local\n\n"
+			        "Now assuming you meant:\n\n"
+			        "    --date=default --time-zone=local",
+			        command_name, command_name);
+
+		d->format = DATE_DEFAULT;
+		d->zone = TIME_ZONE_LOCAL;
+
+		return 1;
+	}
+
+	return 0;
+}
+
 void datestamp(char *buf, int bufsize)
 {
 	time_t now;
diff --git a/fast-import.c b/fast-import.c
index 3e4e655..bd5c113 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -401,6 +401,8 @@ static void write_crash_report(const char *err)
 	unsigned long lu;
 	struct recent_command *rc;
 
+	struct date_mode date_mode = INIT_DATE_MODE_ZONE(TIME_ZONE_LOCAL);
+
 	if (!rpt) {
 		error("can't write crash report %s: %s", loc, strerror(errno));
 		return;
@@ -411,7 +413,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
+	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, date_mode));
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
diff --git a/http-backend.c b/http-backend.c
index 8501504..15794c9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -89,7 +89,8 @@ static void hdr_int(const char *name, uintmax_t value)
 
 static void hdr_date(const char *name, unsigned long when)
 {
-	const char *value = show_date(when, 0, DATE_RFC2822);
+	struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_RFC2822);
+	const char *value = show_date(when, 0, d);
 	hdr_str(name, value);
 }
 
diff --git a/log-tree.c b/log-tree.c
index b059446..3a6e110 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -272,7 +272,7 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 	if (commit) {
 		int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_DEFAULT;
+		SET_DATE_MODE_DEFAULT(ctx.date_mode);
 
 		format_commit_message(commit, "%f", buf, &ctx);
 		if (max_len < buf->len)
@@ -463,11 +463,13 @@ void show_log(struct rev_info *opt)
 			 * so we don't need to worry about printing the
 			 * graph info here.
 			 */
+
+			if (!opt->date_format_from_command_line)
+				opt->date_mode.format = DATE_DEFAULT;
+
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format == CMIT_FMT_ONELINE,
-				    opt->date_mode_from_command_line ?
-					opt->date_mode :
-					DATE_DEFAULT);
+				    opt->date_mode);
 			if (opt->commit_format == CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/pretty.c b/pretty.c
index e1d8a8f..d702575 100644
--- a/pretty.c
+++ b/pretty.c
@@ -267,7 +267,7 @@ needquote:
 }
 
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
-		  const char *line, enum date_mode dmode,
+		  const char *line, struct date_mode dmode,
 		  const char *encoding)
 {
 	char *date;
@@ -306,7 +306,8 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, dmode));
 		break;
 	case CMIT_FMT_EMAIL:
-		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
+		dmode.format = DATE_RFC2822;
+		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, dmode));
 		break;
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, dmode));
@@ -458,7 +459,7 @@ static int mailmap_name(char *email, int email_len, char *name, int name_len)
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
-				 const char *msg, int len, enum date_mode dmode)
+				 const char *msg, int len, struct date_mode dmode)
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
@@ -540,13 +541,16 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
 	case 'D':	/* date, RFC2822 style */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
+		dmode.format = DATE_RFC2822;
+		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
 	case 'r':	/* date, relative */
-		strbuf_addstr(sb, show_date(date, tz, DATE_RELATIVE));
+		dmode.format = DATE_RELATIVE;
+		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
 	case 'i':	/* date, ISO 8601 */
-		strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
+		dmode.format = DATE_ISO8601;
+		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
 	}
 
@@ -1050,7 +1054,7 @@ void format_commit_message(const struct commit *commit,
 
 static void pp_header(enum cmit_fmt fmt,
 		      int abbrev,
-		      enum date_mode dmode,
+		      struct date_mode dmode,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..e1bc64a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -243,7 +243,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 enum date_mode dmode,
+			 struct date_mode dmode,
 			 int shorten)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
@@ -263,7 +263,7 @@ void get_reflog_selector(struct strbuf *sb,
 	}
 
 	strbuf_addf(sb, "%s@{", printed_ref);
-	if (commit_reflog->flag || dmode) {
+	if (commit_reflog->flag || dmode.format) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
 		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
 	} else {
@@ -292,7 +292,7 @@ void get_reflog_message(struct strbuf *sb,
 }
 
 void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
-	enum date_mode dmode)
+	struct date_mode dmode)
 {
 	if (reflog_info && reflog_info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
diff --git a/reflog-walk.h b/reflog-walk.h
index 7bd2cd4..30805cc 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -11,12 +11,12 @@ extern int add_reflog_for_walk(struct reflog_walk_info *info,
 extern void fake_reflog_parent(struct reflog_walk_info *info,
 		struct commit *commit);
 extern void show_reflog_message(struct reflog_walk_info *info, int,
-		enum date_mode);
+		struct date_mode);
 extern void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
 extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
-		enum date_mode dmode,
+		struct date_mode dmode,
 		int shorten);
 
 #endif
diff --git a/refs.c b/refs.c
index e3c0511..75ad7e6 100644
--- a/refs.c
+++ b/refs.c
@@ -1633,8 +1633,9 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
+					struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_RFC2822);
 					warning("Log %s has gap after %s.",
-						logfile, show_date(date, tz, DATE_RFC2822));
+						logfile, show_date(date, tz, d));
 				}
 			}
 			else if (date == at_time) {
@@ -1645,8 +1646,9 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, logged_sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
+					struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_RFC2822);
 					warning("Log %s unexpectedly ended on %s.",
-						logfile, show_date(date, tz, DATE_RFC2822));
+						logfile, show_date(date, tz, d));
 				}
 			}
 			munmap(log_mapped, mapsz);
diff --git a/revision.c b/revision.c
index 462c311..fd87c67 100644
--- a/revision.c
+++ b/revision.c
@@ -1433,11 +1433,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--full-history")) {
 		revs->simplify_history = 0;
 	} else if (!strcmp(arg, "--relative-date")) {
-		revs->date_mode = DATE_RELATIVE;
-		revs->date_mode_from_command_line = 1;
+		revs->date_mode.format = DATE_RELATIVE;
+		revs->date_format_from_command_line = 1;
 	} else if ((argcount = parse_long_opt("date", argv, &optarg))) {
-		revs->date_mode = parse_date_format(optarg);
-		revs->date_mode_from_command_line = 1;
+		revs->date_mode.format = parse_date_format(optarg);
+		revs->date_format_from_command_line = 1;
+		return argcount;
+	} else if ((argcount = parse_long_opt("time-zone", argv, &optarg))) {
+		revs->date_mode.zone = parse_time_zone(optarg);
 		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size = 1;
diff --git a/revision.h b/revision.h
index e5ca939..0ced0fb 100644
--- a/revision.h
+++ b/revision.h
@@ -92,10 +92,10 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-			date_mode_from_command_line:1;
+			date_format_from_command_line:1;
 	unsigned int	disable_stdin:1;
 
-	enum date_mode date_mode;
+	struct date_mode date_mode;
 
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
diff --git a/sha1_name.c b/sha1_name.c
index 69cd6c8..718093c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -428,9 +428,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
+			{
+				struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_RFC2822);
 				warning("Log for '%.*s' only goes "
 					"back to %s.", len, str,
-					show_date(co_time, co_tz, DATE_RFC2822));
+					show_date(co_time, co_tz, d));
+			}
 			else {
 				free(real_ref);
 				die("Log for '%.*s' only has %d entries.",
diff --git a/submodule.c b/submodule.c
index 0a45da9..f61a0a2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -605,7 +605,7 @@ static void print_commit(struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	ctx.date_mode = DATE_DEFAULT;
+	SET_DATE_MODE_DEFAULT(ctx.date_mode);
 	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
 	fprintf(stderr, "%s\n", sb.buf);
 	strbuf_release(&sb);
diff --git a/test-date.c b/test-date.c
index 6bcd5b0..6d49c2d 100644
--- a/test-date.c
+++ b/test-date.c
@@ -26,8 +26,11 @@ static void parse_dates(char **argv, struct timeval *now)
 		result[0] = 0;
 		parse_date(*argv, result, sizeof(result));
 		if (sscanf(result, "%lu %d", &t, &tz) == 2)
+		{
+			struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_ISO8601);
 			printf("%s -> %s\n",
-			       *argv, show_date(t, tz, DATE_ISO8601));
+			       *argv, show_date(t, tz, d));
+		}
 		else
 			printf("%s -> bad\n", *argv);
 	}
@@ -36,9 +39,9 @@ static void parse_dates(char **argv, struct timeval *now)
 static void parse_approxidate(char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
-		time_t t;
-		t = approxidate_relative(*argv, now);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_ISO8601));
+		time_t t = approxidate_relative(*argv, now);
+		struct date_mode d = INIT_DATE_MODE_FORMAT(DATE_ISO8601);
+		printf("%s -> %s\n", *argv, show_date(t, 0, d));
 	}
 }
 
-- 
1.7.4.18.g68fe8
