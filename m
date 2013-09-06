From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 4/6] status: disable display of '#' comment prefix by default
Date: Fri,  6 Sep 2013 19:43:07 +0200
Message-ID: <1378489389-25802-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04h-0001In-23
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab3IFRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:43:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54084 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab3IFRn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:43:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhOjB014279
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:24 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI046-0000bD-Bi; Fri, 06 Sep 2013 19:43:26 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI046-0006jV-2O; Fri, 06 Sep 2013 19:43:26 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 19:43:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhOjB014279
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094209.27525@UA9BHRfVxzefrVUvjyz/zA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234074>

Historically, "git status" needed to prefix each output line with '#' so
that the output could be added as comment to the commit message. This
prefix comment has no real purpose when "git status" is ran from the
command-line, and this may distract users from the real content.

Disable this prefix comment by default, and make it re-activable for
users needing backward compatibility with status.displayCommentPrefix.

Obviously, "git commit" ignores status.displayCommentPrefix and keeps the
comment unconditionnaly when writing to COMMIT_EDITMSG (but not when
writing to stdout for an error message or with --dry-run).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt           |  7 +++++
 builtin/commit.c                   | 10 ++++++
 t/t3001-ls-files-others-exclude.sh |  2 +-
 t/t7060-wtstatus.sh                |  4 +++
 t/t7508-status.sh                  | 63 +++++++++++++++++++++++++++++++++++---
 t/t7512-status-help.sh             |  4 +++
 wt-status.c                        | 40 +++++++++++++++++-------
 wt-status.h                        |  1 +
 8 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..60c6bc9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2118,6 +2118,13 @@ status.branch::
 	Set to true to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
+status.displayCommentPrefix::
+	If set to true, linkgit:git-status[1] will insert a comment
+	prefix before each output line (starting with
+	`core.commentChar`, i.e. `#` by default). This was the
+	behavior of linkgit:git-status[1] in Git 1.8.4 and previous.
+	Defaults to false.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..61975ad 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -599,6 +599,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
+	int old_display_comment_prefix;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -696,6 +697,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (s->fp == NULL)
 		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
 
+	/* Ignore status.displayCommentPrefix: we do need comments in COMMIT_EDITMSG. */
+	old_display_comment_prefix = s->display_comment_prefix;
+	s->display_comment_prefix = 1;
+
 	if (clean_message_contents)
 		stripspace(&sb, 0);
 
@@ -821,6 +826,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!commitable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
+		s->display_comment_prefix = old_display_comment_prefix;
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
@@ -1182,6 +1188,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.displaycommentprefix")) {
+		s->display_comment_prefix = git_config_bool(k, v);
+		return 0;
+	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
 		if (slot < 0)
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index f0421c0..b2798fe 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -115,7 +115,7 @@ EOF
 
 git config core.excludesFile excludes-file
 
-git status | grep "^#	" > output
+git -c status.displayCommentPrefix=true status | grep "^#	" > output
 
 cat > expect << EOF
 #	.gitignore
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 52ef06b..5ecafac 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -4,6 +4,10 @@ test_description='basic work tree status reporting'
 
 . ./test-lib.sh
 
+test_expect_success 'use status.displayCommentPrefix by default ' '
+	git config --global status.displayCommentPrefix true
+'
+
 test_expect_success setup '
 	git config --global advice.statusuoption false &&
 	test_commit A &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index ac3d0fe..8d28280 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -7,6 +7,10 @@ test_description='git status'
 
 . ./test-lib.sh
 
+test_expect_success 'use status.displayCommentPrefix by default ' '
+	git config --global status.displayCommentPrefix true
+'
+
 test_expect_success 'status -h in broken repository' '
 	git config --global advice.statusuoption false &&
 	mkdir broken &&
@@ -60,8 +64,12 @@ test_expect_success 'status (1)' '
 	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" output
 '
 
+strip_comments () {
+	sed "s/^\# //; s/^\#$//; s/^#\t/\t/" <"$1" >"$1".tmp &&
+	rm "$1" && mv "$1".tmp "$1"
+}
+
 test_expect_success 'status --column' '
-	COLUMNS=50 git status --column="column dense" >output &&
 	cat >expect <<\EOF &&
 # On branch master
 # Changes to be committed:
@@ -78,9 +86,16 @@ test_expect_success 'status --column' '
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
-#	dir1/untracked dir2/untracked untracked
-#	dir2/modified  output
+#	dir1/untracked dir2/untracked output
+#	dir2/modified  expect         untracked
 EOF
+	COLUMNS=50 git -c status.displayCommentPrefix=true status --column="column dense" >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'status --column status.displayCommentPrefix=false' '
+	strip_comments expect &&
+	COLUMNS=49 git -c status.displayCommentPrefix=false status --column="column dense" >output &&
 	test_i18ncmp expect output
 '
 
@@ -108,11 +123,39 @@ cat >expect <<\EOF
 #	untracked
 EOF
 
-test_expect_success 'status (2)' '
-	git status >output &&
+test_expect_success 'status with status.displayCommentPrefix=true' '
+	git -c status.displayCommentPrefix=true status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'status with status.displayCommentPrefix=false' '
+	strip_comments expect &&
+	git -c status.displayCommentPrefix=false status >output &&
 	test_i18ncmp expect output
 '
 
+test_expect_success 'setup fake editor' '
+	cat >.git/editor <<-\EOF &&
+	#! /bin/sh
+	cp "$1" output
+EOF
+	chmod 755 .git/editor
+'
+
+commit_template_commented () {
+	(
+		EDITOR=.git/editor &&
+		export EDITOR &&
+		# Fails due to empty message
+		test_must_fail git commit
+	) &&
+	! grep '^[^#]' output
+}
+
+test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_EDITMSG' '
+	commit_template_commented
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
@@ -872,6 +915,16 @@ test_expect_success 'status submodule summary' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'status submodule summary with status.displayCommentPrefix=false' '
+	strip_comments expect &&
+	git -c status.displayCommentPrefix=false status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'commit with submodule summary ignores status.displayCommentPrefix' '
+	commit_template_commented
+'
+
 cat >expect <<EOF
  M dir1/modified
 A  dir2/added
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 31a798f..312f417 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -13,6 +13,10 @@ test_description='git status advice'
 
 set_fake_editor
 
+test_expect_success 'use status.displayCommentPrefix by default ' '
+	git config --global status.displayCommentPrefix true
+'
+
 test_expect_success 'prepare for conflicts' '
 	git config --global advice.statusuoption false &&
 	test_commit init main.txt init &&
diff --git a/wt-status.c b/wt-status.c
index 853813f..3c795da 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -46,9 +46,11 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
-		strbuf_addch(&sb, comment_line_char);
-		if (!trail)
-			strbuf_addch(&sb, ' ');
+		if (s->display_comment_prefix) {
+			strbuf_addch(&sb, comment_line_char);
+			if (!trail)
+				strbuf_addch(&sb, ' ');
+		}
 		color_print_strbuf(s->fp, color, &sb);
 		if (trail)
 			fprintf(s->fp, "%s", trail);
@@ -59,7 +61,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 		eol = strchr(line, '\n');
 
 		strbuf_reset(&linebuf);
-		if (at_bol) {
+		if (at_bol && s->display_comment_prefix) {
 			strbuf_addch(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
@@ -129,6 +131,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
+	s->display_comment_prefix = 0;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -707,9 +710,11 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	strbuf_addbuf(&summary, &cmd_stdout);
 	strbuf_release(&cmd_stdout);
 
-	summary_content = strbuf_detach(&summary, &len);
-	strbuf_add_commented_lines(&summary, summary_content, len);
-	free(summary_content);
+	if (s->display_comment_prefix) {
+		summary_content = strbuf_detach(&summary, &len);
+		strbuf_add_commented_lines(&summary, summary_content, len);
+		free(summary_content);
+	}
 
 	fputs(summary.buf, s->fp);
 	strbuf_release(&summary);
@@ -748,8 +753,9 @@ static void wt_status_print_other(struct wt_status *s,
 	if (!column_active(s->colopts))
 		return;
 
-	strbuf_addf(&buf, "%s#\t%s",
+	strbuf_addf(&buf, "%s%s\t%s",
 		    color(WT_STATUS_HEADER, s),
+		    s->display_comment_prefix ? "#" : "",
 		    color(WT_STATUS_UNTRACKED, s));
 	memset(&copts, 0, sizeof(copts));
 	copts.padding = 1;
@@ -793,6 +799,8 @@ static void wt_status_print_tracking(struct wt_status *s)
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep;
 	struct branch *branch;
+	char comment_line_string[3];
+	int i;
 
 	assert(s->branch && !s->is_initial);
 	if (prefixcmp(s->branch, "refs/heads/"))
@@ -801,12 +809,22 @@ static void wt_status_print_tracking(struct wt_status *s)
 	if (!format_tracking_info(branch, &sb))
 		return;
 
+	i = 0;
+	if (s->display_comment_prefix) {
+		comment_line_string[i++] = comment_line_char;
+		comment_line_string[i++] = ' ';
+	}
+	comment_line_string[i] = '\0';
+
 	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s),
-				 "%c %.*s", comment_line_char,
+				 "%s%.*s", comment_line_string,
 				 (int)(ep - cp), cp);
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
-			 comment_line_char);
+	if (s->display_comment_prefix)
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
+				 comment_line_char);
+	else
+		fprintf_ln(s->fp, "");
 }
 
 static int has_unmerged(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index fb7152e..fac16ca 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -50,6 +50,7 @@ struct wt_status {
 	enum commit_whence whence;
 	int nowarn;
 	int use_color;
+	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
 	int show_ignored_files;
-- 
1.8.4.5.g8688bea
