From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 1/3] Add an optional <mode> argument to commit/status -u|--untracked-files option
Date: Thu, 5 Jun 2008 10:31:19 +0200
Message-ID: <c756e040b06883cc070bb24954111b4dcd457d2c.1212995703.git.marius@trolltech.com>
References: <484CD3A7.8090303@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 09:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5bic-00023e-JP
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 09:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbYFIHWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 03:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757552AbYFIHWD
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 03:22:03 -0400
Received: from hoat.troll.no ([62.70.27.150]:44923 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757551AbYFIHV6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2008 03:21:58 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id BDB2F20A90;
	Mon,  9 Jun 2008 09:21:52 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 971B520A60;
	Mon,  9 Jun 2008 09:21:52 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84367>

This lets you specify how you want untracked files to be listed. The possible
options are:
    normal - Show untracked files and directories
    all    - Show all untracked files

The 'all' mode is used, if the mode is not specified.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/git-commit.txt |   18 +++++++-----
 builtin-commit.c             |   16 +++++++++--
 t/t7502-status.sh            |   61 ++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |    1 +
 wt-status.h                  |    6 ++++
 5 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3c9f5b..cc4374a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v] [-u]
+'git-commit' [-a | --interactive] [-s] [-v] [-u[<mode>]]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
@@ -150,12 +150,16 @@ but can be used to amend a merge commit.
 	the last commit without committing changes that have
 	already been staged.
 
--u|--untracked-files::
-	Show all untracked files, also those in uninteresting
-	directories, in the "Untracked files:" section of commit
-	message template.  Without this option only its name and
-	a trailing slash are displayed for each untracked
-	directory.
+-u[<mode>]|--untracked-files[=<mode>]::
+	Show untracked files (Default: 'all').
++
+The mode parameter is optional, and is used to specify
+the handling of untracked files. The possible options are:
++
+--
+		- 'normal' - Shows untracked files and directories
+		- 'all'    - Also shows individual files in untracked directories.
+--
 
 -v|--verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin-commit.c b/builtin-commit.c
index b294c1f..95cdb82 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -49,7 +49,8 @@ static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, untracked_files, no_verify, allow_empty;
+static int quiet, verbose, no_verify, allow_empty;
+static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -102,7 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
-	OPT_BOOLEAN('u', "untracked-files", &untracked_files, "show all untracked files"),
+	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
@@ -347,7 +348,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		s.reference = "HEAD^1";
 	}
 	s.verbose = verbose;
-	s.untracked = untracked_files;
+	s.untracked = (show_untracked_files == SHOW_ALL_UNTRACKED_FILES);
 	s.index_file = index_file;
 	s.fp = fp;
 	s.nowarn = nowarn;
@@ -795,6 +796,15 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else
 		die("Invalid cleanup mode %s", cleanup_arg);
 
+	if (!untracked_files_arg)
+		; /* default already initialized */
+	else if (!strcmp(untracked_files_arg, "normal"))
+		show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
+	else if (!strcmp(untracked_files_arg, "all"))
+		show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+	else
+		die("Invalid untracked files mode '%s'", untracked_files_arg);
+
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
 	else if (interactive && argc > 0)
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 80a438d..0d24e25 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -67,6 +67,67 @@ test_expect_success 'status (2)' '
 
 '
 
+cat >expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	dir3/
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success 'status -unormal' '
+	mkdir dir3 &&
+	: > dir3/untracked1 &&
+	: > dir3/untracked2 &&
+	git status -unormal >output &&
+	test_cmp expect output
+'
+
+cat >expect <<EOF
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#   (use "git add <file>..." to update what will be committed)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	dir3/untracked1
+#	dir3/untracked2
+#	expect
+#	output
+#	untracked
+EOF
+test_expect_success 'status -uall' '
+	git status -uall >output &&
+	rm -rf dir3 &&
+	test_cmp expect output
+'
+
 cat > expect << \EOF
 # On branch master
 # Changes to be committed:
diff --git a/wt-status.c b/wt-status.c
index 5b4d74c..25d9985 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -27,6 +27,7 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
+enum untracked_status_type show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 
 static int parse_status_slot(const char *var, int offset)
 {
diff --git a/wt-status.h b/wt-status.h
index 597c7ea..54f756d 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -11,6 +11,12 @@ enum color_wt_status {
 	WT_STATUS_NOBRANCH,
 };
 
+enum untracked_status_type {
+	SHOW_NORMAL_UNTRACKED_FILES = 1,
+	SHOW_ALL_UNTRACKED_FILES
+};
+extern enum untracked_status_type show_untracked_files;
+
 struct wt_status {
 	int is_initial;
 	char *branch;
-- 
1.5.6.rc0.160.gf7c043.dirty
