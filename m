From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 4/4] status: introduce status.displayCommentChar to disable display of #
Date: Thu, 29 Aug 2013 15:05:36 +0200
Message-ID: <1377781536-31955-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 15:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF20H-0000RD-8X
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab3H2NLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:11:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59444 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab3H2NLB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:11:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TD5m8U019331
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 15:05:48 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF1v3-0008HE-VJ; Thu, 29 Aug 2013 15:05:50 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF1v3-0008Kk-Lm; Thu, 29 Aug 2013 15:05:49 +0200
X-Mailer: git-send-email 1.8.4.12.gf9d53a3.dirty
In-Reply-To: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 15:05:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TD5m8U019331
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378386349.51673@PtSs1yobQUA7jw8+odjumg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233256>

Historically, "git status" needed to prefix each output line with '#' so
that the output could be added as comment to the commit message. This
prefix comment has no real purpose when "git status" is ran from the
command-line, and this may distract users from the real content.

Allow the user to disable this prefix comment. In the long run, if users
like the non-prefix output, it may make sense to flip the default value
to true.

Obviously, status.displayCommentChar applies to "git status" but is
ignored by "git commit", so the status is still commented in
COMMIT_EDITMSG.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |  5 +++++
 builtin/commit.c         |  9 +++++++++
 t/t7508-status.sh        | 43 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c              | 35 +++++++++++++++++++++++++----------
 wt-status.h              |  1 +
 5 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..0afa531 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2118,6 +2118,11 @@ status.branch::
 	Set to true to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
+status.displayCommentChar::
+	If set to false, linkgit:git-status[1] will not prefix each
+	line with the comment char (`core.commentChar`, i.e. `#` by
+	default). Defaults to true.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..d4cfced 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1182,6 +1182,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.displaycommentchar")) {
+		s->display_comment_char = git_config_bool(k, v);
+		return 0;
+	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
 		if (slot < 0)
@@ -1496,6 +1500,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_commit_config, &s);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
+	/*
+	 * Ignore status.displayCommentChar: we do need comments in
+	 * COMMIT_EDITMSG.
+	 */
+	s.display_comment_char = 1;
 	determine_whence(&s);
 	s.colopts = 0;
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index ac3d0fe..d0d7c4a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -113,6 +113,39 @@ test_expect_success 'status (2)' '
 	test_i18ncmp expect output
 '
 
+strip_comments () {
+	sed "s/^\# //; s/^\#$//; s/^#\t/\t/" <"$1" >"$1".tmp &&
+	rm "$1" && mv "$1".tmp "$1"
+}
+
+test_expect_success 'status with status.displayCommentChar=false' '
+	strip_comments expect &&
+	git -c status.displayCommentChar=false status >output &&
+	test_i18ncmp expect output
+'
+
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
+test_expect_success 'commit ignores status.displayCommentChar=false in COMMIT_EDITMSG' '
+	commit_template_commented
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
@@ -872,6 +905,16 @@ test_expect_success 'status submodule summary' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'status submodule summary with status.displayCommentChar=false' '
+	strip_comments expect &&
+	git -c status.displayCommentChar=false status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'commit with submodule summary ignores displayCommentChar' '
+	commit_template_commented
+'
+
 cat >expect <<EOF
  M dir1/modified
 A  dir2/added
diff --git a/wt-status.c b/wt-status.c
index d91661d..cdbcd6f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -46,9 +46,11 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
 	strbuf_vaddf(&sb, fmt, ap);
 	if (!sb.len) {
-		strbuf_addch(&sb, comment_line_char);
-		if (!trail)
-			strbuf_addch(&sb, ' ');
+		if (s->display_comment_char) {
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
+		if (at_bol && s->display_comment_char) {
 			strbuf_addch(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
@@ -129,6 +131,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
+	s->display_comment_char = 1;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -706,9 +709,11 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	strbuf_addbuf(&summary, &cmd_stdout);
 	strbuf_release(&cmd_stdout);
 
-	summary_content = strbuf_detach(&summary, &len);
-	strbuf_add_commented_lines(&summary, summary_content, len);
-	free(summary_content);
+	if (s->display_comment_char) {
+		summary_content = strbuf_detach(&summary, &len);
+		strbuf_add_commented_lines(&summary, summary_content, len);
+		free(summary_content);
+	}
 
 	summary_content = strbuf_detach(&summary, &len);
 	fprintf(s->fp, summary_content);
@@ -793,6 +798,8 @@ static void wt_status_print_tracking(struct wt_status *s)
 	struct strbuf sb = STRBUF_INIT;
 	const char *cp, *ep;
 	struct branch *branch;
+	char comment_line_string[3];
+	int i;
 
 	assert(s->branch && !s->is_initial);
 	if (prefixcmp(s->branch, "refs/heads/"))
@@ -801,12 +808,20 @@ static void wt_status_print_tracking(struct wt_status *s)
 	if (!format_tracking_info(branch, &sb))
 		return;
 
+	i = 0;
+	if (s->display_comment_char) {
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
+	if (s->display_comment_char)
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
+				 comment_line_char);
 }
 
 static int has_unmerged(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index fb7152e..ac02c64 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -50,6 +50,7 @@ struct wt_status {
 	enum commit_whence whence;
 	int nowarn;
 	int use_color;
+	int display_comment_char;
 	int relative_paths;
 	int submodule_summary;
 	int show_ignored_files;
-- 
1.8.4.12.gf9d53a3.dirty
