From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 16:23:54 -0500
Message-ID: <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 22:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSNu-0007VC-QU
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889Ab1BOVYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 16:24:21 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52285 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BOVYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 16:24:19 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so442844vxb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=T74fGWZDcAwYDS/W821GqpFBNLWmxHjGrFkZZPG3kos=;
        b=EXOfVaKqe4bJP0oRDgIXyJRPrasHvplgHdboJZnSiXZpUEEBux5DjKzQdYFFQuh6Xz
         zXLIV12SprBioa+qXclRJPPXY/ztH2KYSOvNyOJyUGLlo+e/vCsXCbBd/bQ51wEAr0Q5
         8fvRlqTGd6Bph4l1OSoAkRRYe+LKdkPePXfyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lMRM5ssEw5rdP8KFTmbNpve5YzzLeQTQt/r9d16Us+rXM/DpnNCp1B4qvxndI9USyn
         6hoFmPSg2jgYOlQCV7+s9pErXTMpmNeE45h93ebZ4Vqz4wShTeY5I1YjTKapoRESPXOd
         fbPTo7JXJpkwbOSqgjDrPeaXK8W1WK89Bu6m8=
Received: by 10.220.199.133 with SMTP id es5mr1533003vcb.136.1297805059024;
        Tue, 15 Feb 2011 13:24:19 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id e37sm1035530vbm.15.2011.02.15.13.24.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 13:24:18 -0800 (PST)
X-Mailer: git-send-email 1.7.4.5.g9affb
In-Reply-To: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166880>

Now that cherry-pick records the original commit id in CHERRY_HEAD
following a conflict, we can teach commit to handle it automatically.

The primary difference between this and 'commit -c CHERRY_HEAD'
(besides saving the user some typing) is that we take only the
authorship from CHERRY_HEAD, while taking the commit message
from MERGE_MSG (which contains the list of conflicts as well
as cherry-pick -x's annotation, if -x was used).

--reset-author can be used to reset authorship.
---
There are several subtle interactions between the sundry commit options that
make my head hurt. I did my best to integrate what happens when there is
a CHERRY_HEAD, but I'm really not sure how CHERRY_HEAD ought to interact
with things like --squash and --fixup, or the message specifying options.

For example, it should probably be an error to use --squash/--fixup when
there's a CHERRY_HEAD, but then again, it should probably be an error to
use those options when there's a MERGE_HEAD (but it's not).

OTOH, it seems valid to specify a commit message manually, so I allow that.

 Documentation/git-commit.txt           |    7 +++--
 builtin/commit.c                       |   35 ++++++++++++++++++++++++++-----
 builtin/revert.c                       |    5 +--
 contrib/completion/git-completion.bash |    2 +
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..fd6a1f7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -84,9 +84,10 @@ OPTIONS
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with -C/-c/--amend options, declare that the
-	authorship of the resulting commit now belongs of the committer.
-	This also renews the author timestamp.
+	When used with -C/-c/--amend options, or when committing after a
+	a conflicting cherry-pick, declare that the authorship of the
+	resulting commit now belongs of the committer. This also renews
+	the author timestamp.
 
 --short::
 	When doing a dry-run, give the output in the short-format. See
diff --git a/builtin/commit.c b/builtin/commit.c
index 8850621..2f0a8fc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -70,7 +70,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, only, amend, signoff, cherry_pick;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -609,7 +609,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			die_errno("could not read log file '%s'",
 				  logfile);
 		hook_arg1 = "message";
-	} else if (use_message) {
+	} else if (use_message && !cherry_pick) {
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (!buffer || buffer[2] == '\0')
 			die("commit has empty message");
@@ -704,6 +704,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"#\n",
 				git_path("MERGE_HEAD"));
 
+		if (cherry_pick)
+			fprintf(fp,
+				"#\n"
+				"# It looks like you may be committing a cherry-pick.\n"
+				"# If this is not correct, please remove the file\n"
+				"#	%s\n"
+				"# and try again.\n"
+				"#\n",
+				git_path("CHERRY_HEAD"));
 		fprintf(fp,
 			"\n"
 			"# Please enter the commit message for your changes.");
@@ -898,6 +907,7 @@ static void handle_untracked_files_arg(struct wt_status *s)
 		die("Invalid untracked files mode '%s'", untracked_files_arg);
 }
 
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix,
@@ -929,6 +939,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("You have nothing to amend.");
 	if (amend && in_merge)
 		die("You are in the middle of a merge -- cannot amend.");
+	if (amend && cherry_pick)
+		die("You are in the middle of a cherry-pick -- cannot amend.");
 	if (fixup_message && squash_message)
 		die("Options --squash and --fixup cannot be used together");
 	if (use_message)
@@ -943,11 +955,19 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("Only one of -c/-C/-F/--fixup can be used.");
 	if (message.len && f > 0)
 		die("Option -m cannot be combined with -c/-C/-F/--fixup.");
+	if (cherry_pick) {
+		/* Let message-specifying options override CHERRY_HEAD */
+		if (f > 0 || message.len)
+			cherry_pick = 0;
+		else
+			/* used for authorship side-effect only */
+			use_message = "CHERRY_HEAD";
+	}
 	if (edit_message)
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
-	if (!use_message && renew_authorship)
+	if (!use_message && !cherry_pick && renew_authorship)
 		die("--reset-author can be used only with -C, -c or --amend.");
 	if (use_message) {
 		const char *out_enc;
@@ -1118,6 +1138,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	gitmodules_config();
 	git_config(git_status_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
+	cherry_pick = file_exists(git_path("CHERRY_HEAD"));
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1140,7 +1161,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	}
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
-	s.in_merge = in_merge;
+	s.in_merge = in_merge || cherry_pick;
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	wt_status_collect(&s);
 
@@ -1303,7 +1324,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
-	s.in_merge = in_merge;
+	cherry_pick = file_exists(git_path("CHERRY_HEAD"));
+	s.in_merge = in_merge || cherry_pick;
 
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
@@ -1369,7 +1391,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parents = reduce_heads(parents);
 	} else {
 		if (!reflog_msg)
-			reflog_msg = "commit";
+			reflog_msg = cherry_pick ? "commit (cherry-pick)"
+						 : "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
 
diff --git a/builtin/revert.c b/builtin/revert.c
index c373e69..678fc8e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -284,11 +284,10 @@ static void print_advice(void)
 
 	advise("after resolving the conflicts, mark the corrected paths");
 	advise("with 'git add <paths>' or 'git rm <paths>'");
+	advice("and commit the result with 'git commit'");
 
-	if (action == CHERRY_PICK) {
+	if (action == CHERRY_PICK)
 		write_cherry_head();
-		advise("and commit the result with 'git commit -c CHERRY_HEAD'");
-	}
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..1d446cf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -246,6 +246,8 @@ __git_ps1 ()
 				fi
 			elif [ -f "$g/MERGE_HEAD" ]; then
 				r="|MERGING"
+			elif [ -f "$g/CHERRY_HEAD" ]; then
+				r="|CHERRY-PICKING"
 			elif [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
-- 
1.7.4.5.g9affb
