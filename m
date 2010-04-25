From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 1/3] pretty: add conditional %C?colorname placeholders
Date: Sun, 25 Apr 2010 16:42:53 +0100
Message-ID: <1272210175-20484-2-git-send-email-wmpalmer@gmail.com>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 17:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O640X-0000hW-L1
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 17:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab0DYPoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 11:44:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37866 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0DYPoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 11:44:02 -0400
Received: by mail-wy0-f174.google.com with SMTP id 36so752496wyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I2AUl/ioEYVy9TNltp4/DHynk/+tup4W4vUpPL0OpWw=;
        b=S1Kni/Z+BhVOzeqtAUe7Uhpn0xFQS76FgycxP8vkwSRTNC0rrKjX4+/UCFzugaa4y2
         M/eIQ1r3GTyuyDYT1ONBpX38E5jlaDz9SnApLocD6/p0xvJuvGH+Rw3QKFI+ASO90f8a
         ncu/YUGSw+T1otc5hvnZtK5SXec1BgCf/fCX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZFAzF7xYRgiKXdyx/cMlGgdl3rs7es9FEnO+jLeerMqd1xYL8Iheyt57DXEqsGSdPm
         5r6CDU62HGACm4jvgs4Pd8gLBliGyA6juef5AbCbY3zM4raqQK3dg9kUu4FiK0vi1pyC
         ANwG2yWqy/inD3F7VgpWC/XH5H5bfiNAzE2zg=
Received: by 10.216.188.14 with SMTP id z14mr3378225wem.38.1272210241638;
        Sun, 25 Apr 2010 08:44:01 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id x1sm16755457wbx.19.2010.04.25.08.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 08:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145742>

Many commands are able to colorize, or not, depending on a user's
configuration and whether output is being sent to a terminal. However,
if a user explicitly specifies a --pretty format, color will always be
output, regardless of the destination. This would generally be okay, in
a "do what I tell you, whether or not I should tell you to" sense, but
the assumption fell apart when an alias was defined which may be run in
various contexts: there was no way to specify "use this color, but only
if you normally would display color at all"

Here we add the %C?colorname placeholders which act just as the
%Ccolorname placeholders, with the exception that the pretty_context is
checked to see if color should be used according to configuration

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/pretty-formats.txt |    1 +
 builtin/log.c                    |    2 +-
 builtin/rev-list.c               |    1 +
 builtin/shortlog.c               |    5 ++-
 builtin/show-branch.c            |    1 +
 combine-diff.c                   |   11 +++++---
 commit.h                         |    1 +
 log-tree.c                       |    9 ++++--
 log-tree.h                       |    2 +-
 pretty.c                         |   49 ++++++++++++++++++++++++-------------
 shortlog.h                       |    2 +-
 t/t4205-log-pretty-formats.sh    |   44 ++++++++++++++++++++++++++++++++++
 12 files changed, 99 insertions(+), 29 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..53eb903 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -132,6 +132,7 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* config option
+- '%C?...: switch to specified color, if relevant color.* config option specifies that color is ok
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/builtin/log.c b/builtin/log.c
index 6208703..a9fc6ea 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -740,7 +740,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log.in1 = 2;
 	log.in2 = 4;
 	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
+		shortlog_add_commit(&log, list[i], rev);
 
 	shortlog_output(&log);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 51ceb19..5a53862 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -99,6 +99,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
 		ctx.date_mode = revs->date_mode;
+		ctx.use_color = DIFF_OPT_TST(&revs->diffopt, COLOR_DIFF);
 		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 06320f5..7aee491 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -136,13 +136,14 @@ static void read_from_stdin(struct shortlog *log)
 	}
 }
 
-void shortlog_add_commit(struct shortlog *log, struct commit *commit)
+void shortlog_add_commit(struct shortlog *log, struct commit *commit, struct rev_info *rev)
 {
 	const char *author = NULL, *buffer;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ufbuf = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 
+	ctx.use_color = DIFF_OPT_TST(&rev->diffopt, COLOR_DIFF);
 	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
 	buffer = buf.buf;
 	while (*buffer && *buffer != '\n') {
@@ -183,7 +184,7 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 	if (prepare_revision_walk(rev))
 		die("revision walk setup failed");
 	while ((commit = get_revision(rev)) != NULL)
-		shortlog_add_commit(log, commit);
+		shortlog_add_commit(log, commit, rev);
 }
 
 static int parse_uint(char const **arg, int comma, int defval)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e20fcf3..e324336 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -294,6 +294,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 
 	if (commit->object.parsed) {
 		struct pretty_print_context ctx = {0};
+		ctx.use_color = showbranch_use_color;
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, &pretty, &ctx);
 		pretty_str = pretty.buf;
 	}
diff --git a/combine-diff.c b/combine-diff.c
index 3480dae..5157c62 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -841,7 +841,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		int deleted = 0;
 
 		if (rev->loginfo && !rev->no_commit_id)
-			show_log(rev);
+			show_log(rev, use_color);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
 				 "", elem->path, c_meta, c_reset);
 		printf("%sindex ", c_meta);
@@ -923,8 +923,10 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	if (!line_termination)
 		inter_name_termination = 0;
 
-	if (rev->loginfo && !rev->no_commit_id)
-		show_log(rev);
+	if (rev->loginfo && !rev->no_commit_id) {
+		int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
+		show_log(rev, use_color);
+	}
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
 		offset = strlen(COLONS) - num_parent;
@@ -1005,7 +1007,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		paths = intersect_paths(paths, i, num_parent);
 
 		if (show_log_first && i == 0) {
-			show_log(rev);
+			int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
+			show_log(rev, use_color);
 			if (rev->verbose_header && opt->output_format)
 				putchar(opt->line_termination);
 		}
diff --git a/commit.h b/commit.h
index 26ec8c0..b6caf91 100644
--- a/commit.h
+++ b/commit.h
@@ -71,6 +71,7 @@ struct pretty_print_context
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
+	int use_color;
 	struct reflog_walk_info *reflog_info;
 };
 
diff --git a/log-tree.c b/log-tree.c
index d3ae969..b743c43 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -274,7 +274,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	*extra_headers_p = extra_headers;
 }
 
-void show_log(struct rev_info *opt)
+void show_log(struct rev_info *opt, int use_color)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
@@ -282,6 +282,7 @@ void show_log(struct rev_info *opt)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	ctx.use_color = use_color;
 
 	opt->loginfo = NULL;
 	ctx.show_notes = opt->show_notes;
@@ -457,12 +458,13 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
+		int use_color = DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
 		/* When showing a verbose header (i.e. log message),
 		 * and not in --pretty=oneline format, we would want
 		 * an extra newline between the end of log and the
 		 * output for readability.
 		 */
-		show_log(opt);
+		show_log(opt, use_color);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
@@ -559,8 +561,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
+		int use_color = DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
 		log.parent = NULL;
-		show_log(opt);
+		show_log(opt, use_color);
 		shown = 1;
 	}
 	opt->loginfo = NULL;
diff --git a/log-tree.h b/log-tree.h
index 3f7b400..09f970e 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -11,7 +11,7 @@ void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
 int log_tree_opt_parse(struct rev_info *, const char **, int);
-void show_log(struct rev_info *opt);
+void show_log(struct rev_info *opt, int use_color);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **subject_p,
diff --git a/pretty.c b/pretty.c
index 7cb3a2a..fdb5e16 100644
--- a/pretty.c
+++ b/pretty.c
@@ -634,35 +634,50 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
 	const char *msg = commit->buffer;
+	const char *color_start;
 	struct commit_list *p;
+	int use_color = c->pretty_ctx->use_color;
+	int conditional_color = 0;
 	int h1, h2;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		if (placeholder[1] == '(') {
+		color_start = placeholder;
+		if (placeholder[1] == '?') {
+			color_start++;
+			conditional_color = 1;
+		}
+		if (color_start[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
 			char color[COLOR_MAXLEN];
 			if (!end)
 				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
-					"--pretty format", color);
-			strbuf_addstr(sb, color);
+			if ( !conditional_color || use_color ) {
+				color_parse_mem(color_start + 2,
+						end - (color_start + 2),
+						"--pretty format", color);
+				strbuf_addstr(sb, color);
+			}
 			return end - placeholder + 1;
 		}
-		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, GIT_COLOR_RED);
-			return 4;
-		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, GIT_COLOR_GREEN);
-			return 6;
-		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, GIT_COLOR_BLUE);
-			return 5;
-		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, GIT_COLOR_RESET);
-			return 6;
+
+		if (!prefixcmp(color_start + 1, "red")) {
+			if ( !conditional_color || use_color )
+				strbuf_addstr(sb, GIT_COLOR_RED);
+			return 4 + (conditional_color ? 1 : 0);
+		} else if (!prefixcmp(color_start + 1, "green")) {
+			if ( !conditional_color || use_color )
+				strbuf_addstr(sb, GIT_COLOR_GREEN);
+			return 6 + (conditional_color ? 1 : 0);
+		} else if (!prefixcmp(color_start + 1, "blue")) {
+			if ( !conditional_color || use_color )
+				strbuf_addstr(sb, GIT_COLOR_BLUE);
+			return 5 + (conditional_color ? 1 : 0);
+		} else if (!prefixcmp(color_start + 1, "reset")) {
+			if ( !conditional_color || use_color )
+				strbuf_addstr(sb, GIT_COLOR_RESET);
+			return 6 + (conditional_color ? 1 : 0);
 		} else
 			return 0;
 	case 'n':		/* newline */
diff --git a/shortlog.h b/shortlog.h
index bc02cc2..43498a0 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -20,7 +20,7 @@ struct shortlog {
 
 void shortlog_init(struct shortlog *log);
 
-void shortlog_add_commit(struct shortlog *log, struct commit *commit);
+void shortlog_add_commit(struct shortlog *log, struct commit *commit, struct rev_info *rev);
 
 void shortlog_output(struct shortlog *log);
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
new file mode 100755
index 0000000..28d2948
--- /dev/null
+++ b/t/t4205-log-pretty-formats.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Released into Public Domain by Will Palmer 2010
+#
+
+test_description='Test pretty formats'
+. ./test-lib.sh
+
+test_expect_success "set up basic repos" ">foo && git add foo && git commit -m initial"
+
+for flag in false true always; do
+for color in red green blue reset; do
+
+	make_expected="git config --get-color no.such.slot $color >expected"
+	test_expect_success "%C$color with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C$color' > actual &&
+		cmp expected actual"
+
+
+	test_expect_success "%C($color) with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C($color)' > actual &&
+		cmp expected actual"
+
+	[ ! "$flag" = "always" ] && make_expected=">expected"
+	test_expect_success "%C?$color with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C?$color' > actual &&
+		cmp expected actual"
+
+	test_expect_success "%C?($color) with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C?($color)' > actual &&
+		cmp expected actual"
+
+done
+done
+
+test_done
-- 
1.7.1.rc1.13.gbb0a0a.dirty
