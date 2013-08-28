From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 10:32:32 +0200
Message-ID: <1377678752-16302-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 10:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEbFm-0003Gm-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 10:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3H1IhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 04:37:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37833 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab3H1IhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 04:37:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7S8bAIm002070
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 10:37:11 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VEbFX-0004Aw-JM; Wed, 28 Aug 2013 10:37:11 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VEbFX-0004HL-9S; Wed, 28 Aug 2013 10:37:11 +0200
X-Mailer: git-send-email 1.8.4.9.g95f16b1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Aug 2013 10:37:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7S8bAIm002070
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378283833.33454@m4K9MigauglwnB9ZFYOT1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233180>

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
As a beginner (long ago), I found this comment-prefixed output really
weird. I got used to it, so it stopped bugging me and I didn't do
anything to fix it.

 Documentation/config.txt |  5 +++++
 builtin/commit.c         |  5 +++++
 t/t7508-status.sh        | 20 ++++++++++++++++++++
 wt-status.c              | 26 +++++++++++++++++++-------
 wt-status.h              |  1 +
 5 files changed, 50 insertions(+), 7 deletions(-)

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
index 10acc53..6d6b9d2 100644
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
@@ -1496,6 +1500,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_commit_config, &s);
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
+	s.display_comment_char = 1; /* Ignore status.displayCommentChar */
 	determine_whence(&s);
 	s.colopts = 0;
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index ac3d0fe..7736426 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -113,6 +113,26 @@ test_expect_success 'status (2)' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'status with status.displayCommentChar=false' '
+	"$PERL_PATH" -pi -e "s/^\# //; s/^\#$//; s/^#\t/\t/" expect &&
+	git -c status.displayCommentChar=false status >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'commit ignores status.displayCommentChar=false in COMMIT_EDITMSG' '
+	cat >.git/editor <<-\EOF &&
+	#! /bin/sh
+	cp "$1" output
+EOF
+	chmod 755 .git/editor &&
+	(
+		EDITOR=.git/editor &&
+		export EDITOR &&
+		test_must_fail git commit
+	) &&
+	! grep "^[^#]" output
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
diff --git a/wt-status.c b/wt-status.c
index cb24f1f..765599d 100644
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
@@ -774,12 +777,21 @@ static void wt_status_print_tracking(struct wt_status *s)
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
1.8.4.9.g95f16b1
