From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 2/3] Add argument 'no' commit/status option -u|--untracked-files
Date: Thu, 5 Jun 2008 14:22:56 +0200
Message-ID: <f7c043b61ce898036d900fefff8421a30b58c38d.1212670149.git.marius@trolltech.com>
References: <5f0ab026ce200e501be81a3b5082e482e1580e42.1212670149.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4F2B-0000oz-UW
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494AbYFEM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757344AbYFEM4s
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:56:48 -0400
Received: from hoat.troll.no ([62.70.27.150]:56157 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757045AbYFEM4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 08:56:44 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 74D09205A9;
	Thu,  5 Jun 2008 14:56:38 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 62E9420020;
	Thu,  5 Jun 2008 14:56:38 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83919>

This new argument teaches Git to not look for any untracked files,
saving cycles on slow file systems, or large repos.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/git-commit.txt |    1 +
 builtin-commit.c             |    4 +++-
 t/t7502-status.sh            |   25 ++++++++++++++++++++++---
 wt-status.c                  |    7 ++++++-
 wt-status.h                  |    3 ++-
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index cc4374a..a6db831 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -157,6 +157,7 @@ The mode parameter is optional, and is used to specify
 the handling of untracked files. The possible options are:
 +
 --
+		- 'no'     - Show no untracked files
 		- 'normal' - Shows untracked files and directories
 		- 'all'    - Also shows individual files in untracked directories.
 --
diff --git a/builtin-commit.c b/builtin-commit.c
index 1f4986b..aae2c60 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -103,7 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
-	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal. (Default: all)", PARSE_OPT_OPTARG, NULL, (int)"all" },
+	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (int)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
@@ -798,6 +798,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (!untracked_files_arg)
 		; /* default already initialized */
+	else if (!strcmp(untracked_files_arg, "no"))
+		show_untracked_files = SHOW_NO_UNTRACKED_FILES;
 	else if (!strcmp(untracked_files_arg, "normal"))
 		show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	else if (!strcmp(untracked_files_arg, "all"))
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 0d24e25..d84bda1 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -79,6 +79,28 @@ cat >expect <<EOF
 #
 #	modified:   dir1/modified
 #
+# Untracked files not listed (use -u option to show untracked files)
+EOF
+test_expect_success 'status -uno' '
+	mkdir dir3 &&
+	: > dir3/untracked1 &&
+	: > dir3/untracked2 &&
+	git status -uno >output &&
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
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
@@ -91,9 +113,6 @@ cat >expect <<EOF
 #	untracked
 EOF
 test_expect_success 'status -unormal' '
-	mkdir dir3 &&
-	: > dir3/untracked1 &&
-	: > dir3/untracked2 &&
 	git status -unormal >output &&
 	test_cmp expect output
 '
diff --git a/wt-status.c b/wt-status.c
index 25d9985..23017e4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -348,7 +348,10 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-	wt_status_print_untracked(s);
+	if (show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
@@ -363,6 +366,8 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+		else if (!show_untracked_files)
+			printf("nothing to commit (use -u to show untracked files)\n");
 		else
 			printf("nothing to commit (working directory clean)\n");
 	}
diff --git a/wt-status.h b/wt-status.h
index 54f756d..78add09 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -12,7 +12,8 @@ enum color_wt_status {
 };
 
 enum untracked_status_type {
-	SHOW_NORMAL_UNTRACKED_FILES = 1,
+	SHOW_NO_UNTRACKED_FILES,
+	SHOW_NORMAL_UNTRACKED_FILES,
 	SHOW_ALL_UNTRACKED_FILES
 };
 extern enum untracked_status_type show_untracked_files;
-- 
1.5.6.rc0.160.gf7c043.dirty
