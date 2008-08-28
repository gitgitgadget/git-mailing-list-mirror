From: Marcus Griep <marcus@griep.us>
Subject: [PATCH] git-commit: '--no-status' Allow suppression of status summary in commit msg
Date: Thu, 28 Aug 2008 14:46:55 -0400
Message-ID: <1219949215-10189-1-git-send-email-marcus@griep.us>
Cc: Junio C Hamano <gitster@pobox.com>, Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmXN-0000lu-P6
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbYH1Sq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbYH1Sq5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:46:57 -0400
Received: from boohaunt.net ([209.40.206.144]:52474 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145AbYH1Sqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:46:55 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id 0AEB0298C03B; Thu, 28 Aug 2008 14:46:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc3.286.gd4df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94111>

Currently, using any editor to edit a commit message for 'git commit'
kicks of a 'git status' which is then included as comments to give
the commit author some context. However, in some situations, such as
having a working tree of many hundred thousand files or on an inefficient
filesystem, a 'git status' can take a long time to process before
displaying the commit for editing.

This patch provides an option to disable the status summary, documents it
and provides test cases for its operation.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 Documentation/git-commit.txt |    9 +++++++++
 builtin-commit.c             |   16 +++++++++++-----
 t/t7500-commit.sh            |   32 ++++++++++++++++++++++++++++++++
 t/t7500/check-for-status     |    9 +++++++++
 4 files changed, 61 insertions(+), 5 deletions(-)
 create mode 100755 t/t7500/check-for-status

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0e25bb8..0d5d35c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -190,6 +190,15 @@ specified.
 --quiet::
 	Suppress commit summary message.
 
+-S::
+--no-status::
+	Suppress inclusion of the git status summary comments
+	that are normally included when the commit message
+	editor is invoked. This can be helpful if `git status`
+	is an expensive operation on your machine, and you
+	don't wish to incur that cost when editing a commit
+	message.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 649c8be..153f436 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty;
+static int quiet, verbose, no_verify, no_status, allow_empty;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -103,6 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
+	OPT_BOOLEAN('S', "no-status", &no_status, "don't include status summary comments in editor"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
@@ -590,10 +591,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		if (ident_shown)
 			fprintf(fp, "#\n");
 
-		saved_color_setting = wt_status_use_color;
-		wt_status_use_color = 0;
-		commitable = run_status(fp, index_file, prefix, 1);
-		wt_status_use_color = saved_color_setting;
+		if (!no_status) {
+			saved_color_setting = wt_status_use_color;
+			wt_status_use_color = 0;
+			commitable = run_status(fp, index_file, prefix, 1);
+			wt_status_use_color = saved_color_setting;
+		}
 	} else {
 		struct rev_info rev;
 		unsigned char sha1[20];
@@ -893,6 +896,9 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "commit.template"))
 		return git_config_string(&template_file, k, v);
 
+	if (!strcmp(k, "commit.nostatus"))
+		return git_config_bool_or_int(k, v, &no_status);
+
 	return git_status_config(k, v, cb);
 }
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 7ae0bd0..5579463 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -186,4 +186,36 @@ test_expect_success 'commit message from stdin' '
 	commit_msg_is "Log with foo word"
 '
 
+test_expect_success 'commit message in editor should include status' '
+	echo "Test status" > fooey &&
+	git add fooey &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/check-for-status &&
+		git commit
+	) &&
+	commit_msg_is "Status"
+'
+
+test_expect_success 'no-status flag should suppress including status summary' '
+	echo "Test no-status" > fooey &&
+	git add fooey &&
+	(
+		test_set_editor "$TEST_DIRECTORY"/t7500/check-for-status &&
+		git commit --no-status
+	) &&
+	commit_msg_is "No Status"
+'
+
+test_expect_success 'no-status config should suppress status summary' '
+	echo "Test no-status config" > fooey &&
+	git add fooey &&
+	(
+		git config commit.nostatus true &&
+		test_set_editor "$TEST_DIRECTORY"/t7500/check-for-status &&
+		git commit &&
+		git config --unset commit.nostatus
+	) &&
+	commit_msg_is "No Status"
+'
+
 test_done
diff --git a/t/t7500/check-for-status b/t/t7500/check-for-status
new file mode 100755
index 0000000..5c6efdf
--- /dev/null
+++ b/t/t7500/check-for-status
@@ -0,0 +1,9 @@
+#!/bin/sh
+val=`sed -n 's/^# On branch .*$/1/p' "$1"`
+cat "$1"
+if [ $val ]; then
+	echo Status >> "$1"
+else
+	echo No Status >> "$1"
+fi
+exit 0
-- 
1.6.0.rc3.286.gd4df
