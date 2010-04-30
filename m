From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 1/5] pretty: add conditional %C?colorname placeholders
Date: Fri, 30 Apr 2010 20:35:24 +0100
Message-ID: <1272656128-2002-2-git-send-email-wmpalmer@gmail.com>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:35:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w08-0005vp-8n
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934196Ab0D3Tfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:35:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57368 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933072Ab0D3Tfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:35:41 -0400
Received: by wwb34 with SMTP id 34so446912wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2hto0EIxNTH9sisMDHmXz0FYSdLnuBwzLdJsf1bsuyg=;
        b=CJPPQk+aDW2XMv/dswXEHQhoE/PpN7yPBjSRO6N/kykFSRoyUAIA+icBYfSVp1ZxiI
         5v6EmVRR685x2qAOFie+0Ce+2eqvRgjxIhXHwAJLsmaz8ByfhUsaU1m//DFY6Y5tiFxp
         DFCHwY27v2s5QHoT4AFr6iDM/Gx2FKwqqLLAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tMeMngpk2/WDRPAwuSvOenCmbF4EDb+yElL4pA4AZDBJWsF0zASJpcLQy6HxF/mz5A
         4NtEenf+KQgxFUDiKC6snQ9Vk0Xz0eVo74OaoIDiqsdaMz8KMQQyYILMg7pDXJieVFns
         NZ34LK+0vxvkJ7PRxHBirQ5Mkhvch9oCxVWmU=
Received: by 10.216.186.10 with SMTP id v10mr3918337wem.111.1272656139501;
        Fri, 30 Apr 2010 12:35:39 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146051>

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
 Documentation/pretty-formats.txt |    2 +
 builtin/log.c                    |    2 +-
 builtin/rev-list.c               |    1 +
 builtin/shortlog.c               |    5 ++-
 commit.h                         |    1 +
 log-tree.c                       |    1 +
 pretty.c                         |   49 +++++++++++++++++++++++------------
 shortlog.h                       |    2 +-
 t/t4205-log-pretty-formats.sh    |   52 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 94 insertions(+), 21 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..5861256 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -132,6 +132,8 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* config option
+- '%C?...': switch to specified color, as in %Cred, %Creset, etc, if color output is enabled
+- '%C?(...)': switch to specified color specification, as in %C(...), if color output is enabled
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
index d3ae969..6bb4748 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,7 @@ void show_log(struct rev_info *opt)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	ctx.use_color = DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
 
 	opt->loginfo = NULL;
 	ctx.show_notes = opt->show_notes;
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
index 0000000..b7ec943
--- /dev/null
+++ b/t/t4205-log-pretty-formats.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# Released into Public Domain by Will Palmer 2010
+#
+
+test_description='Test pretty formats'
+. ./test-lib.sh
+
+test_expect_success "set up basic repos" \
+	">foo &&
+	>bar &&
+	git add foo &&
+	test_tick &&
+	git commit -m initial &&
+	git add bar &&
+	test_tick &&
+	git commit -m 'add bar'"
+
+for flag in false true always; do
+for color in red green blue reset; do
+
+	make_expected="git config --get-color no.such.slot $color >expected"
+	test_expect_success "%C$color with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C$color' > actual &&
+		test_cmp expected actual"
+
+
+	test_expect_success "%C($color) with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C($color)' > actual &&
+		test_cmp expected actual"
+
+	[ ! "$flag" = "always" ] && make_expected=">expected"
+	test_expect_success "%C?$color with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C?$color' > actual &&
+		test_cmp expected actual"
+
+	test_expect_success "%C?($color) with color.ui $flag" \
+		"$make_expected &&
+		git config color.ui $flag &&
+		git log -1 --pretty=format:'%C?($color)' > actual &&
+		test_cmp expected actual"
+
+done
+done
+
+test_done
-- 
1.7.1.rc1.13.gbb0a0a.dirty
