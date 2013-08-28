From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 14:47:04 +0200
Message-ID: <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
 <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: j.sixt@viscovery.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 14:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEfAV-0004K1-6n
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 14:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab3H1MsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 08:48:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57083 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab3H1MsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 08:48:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7SClwIS019198
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 14:47:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VEfAG-0006KC-8Y; Wed, 28 Aug 2013 14:48:00 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VEfAF-0006JC-Vh; Wed, 28 Aug 2013 14:48:00 +0200
X-Mailer: git-send-email 1.8.4.11.g9db5bc7.dirty
In-Reply-To: <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Aug 2013 14:47:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SClwIS019198
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378298880.46923@uZQbcLgWA3zMt/u58ClS/w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233187>

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
Change since v1:

* removed perl -pi use.

* test and fix submodule summary.

 Documentation/config.txt |  5 +++++
 builtin/commit.c         |  9 +++++++++
 t/t7508-status.sh        | 43 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c              | 37 +++++++++++++++++++++++++------------
 wt-status.h              |  1 +
 5 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..dacf4b9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2118,6 +2118,11 @@ status.branch::
 	Set to true to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
+status.displayCommentChar::
+	If set to false, linkgit:git-status[1] will not prefix each
+	line with the comment char (`core.commentchar`, i.e. `#` by
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
index cb24f1f..97068d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -45,9 +45,11 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 
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
@@ -58,7 +60,7 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
 		eol = strchr(line, '\n');
 
 		strbuf_reset(&linebuf);
-		if (at_bol) {
+		if (at_bol && s->display_comment_char) {
 			strbuf_addch(&linebuf, comment_line_char);
 			if (*line != '\n' && *line != '\t')
 				strbuf_addch(&linebuf, ' ');
@@ -128,6 +130,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
+	s->display_comment_char = 1;
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
@@ -663,17 +666,18 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	char summary_limit[64];
 	char index[PATH_MAX];
 	const char *env[] = { NULL, NULL };
-	const char *argv[8];
+	const char *argv[9];
 
 	env[0] =	index;
 	argv[0] =	"submodule";
 	argv[1] =	"summary";
 	argv[2] =	uncommitted ? "--files" : "--cached";
 	argv[3] =	"--for-status";
-	argv[4] =	"--summary-limit";
-	argv[5] =	summary_limit;
-	argv[6] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
-	argv[7] =	NULL;
+	argv[4] =	s->display_comment_char ? "--display-comment-char" : "--no-display-comment-char";
+	argv[5] =	"--summary-limit";
+	argv[6] =	summary_limit;
+	argv[7] =	uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD");
+	argv[8] =	NULL;
 
 	sprintf(summary_limit, "%d", s->submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
@@ -774,12 +778,21 @@ static void wt_status_print_tracking(struct wt_status *s)
 	if (!format_tracking_info(branch, &sb))
 		return;
 
+	char comment_line_string[3];
+	int i = 0;
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
1.8.4.11.g9db5bc7.dirty
