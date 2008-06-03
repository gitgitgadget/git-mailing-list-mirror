From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add an optional <mode> argument to commit/status -u|--untracked-files option
Date: Tue, 3 Jun 2008 15:09:10 +0200
Message-ID: <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jun 03 15:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3WSL-0000Yd-9P
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYFCNUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbYFCNUq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:20:46 -0400
Received: from hoat.troll.no ([62.70.27.150]:44408 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbYFCNUp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 09:20:45 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 7BAA520A70;
	Tue,  3 Jun 2008 15:20:39 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 6A8C320838;
	Tue,  3 Jun 2008 15:20:39 +0200 (CEST)
Content-Disposition: inline
Apparently-To: <marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83654>

Determining untracked files can be a very slow operation on large trees.
This commit adds a <mode> argument, which allows you to avoid showing the
untracked files in a repository. Possible options are:
    none   - Show no untracked files
    normal - Show untracked files and directories
    all    - Show all untracked files

If the optional argument is not specified, the option defaults to 'all'.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/git-commit.txt |   15 +++++++++------
 builtin-commit.c             |   18 +++++++++++++++---
 wt-status.c                  |    8 +++++++-
 wt-status.h                  |    7 +++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3c9f5b..d8a3aa3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -150,12 +150,15 @@ but can be used to amend a merge commit.
 	the last commit without committing changes that have
 	already been staged.
 
--u|--untracked-files::
-	Show all untracked files, also those in uninteresting
-	directories, in the "Untracked files:" section of commit
-	message template.  Without this option only its name and
-	a trailing slash are displayed for each untracked
-	directory.
+-u[<mode>]|--untracked-files[=<mode>]::
+	Show all untracked files.
+	The mode parameter is optional, and is used to specify
+	the handling of untracked files. The possible options are:
+		none   - Show no untracked files
+		normal - Shows untracked files and directories
+		all    - Also shows individual files in untracked directories.
+	If the mode parameter is not specified, the defaults is
+	'all'.
 
 -v|--verbose::
 	Show unified diff between the HEAD commit and what
diff --git a/builtin-commit.c b/builtin-commit.c
index 90200ed..28db2ba 100644
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
+	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, none. (Default: all)", PARSE_OPT_OPTARG, NULL, (int)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
@@ -347,7 +348,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		s.reference = "HEAD^1";
 	}
 	s.verbose = verbose;
-	s.untracked = untracked_files;
+	s.untracked = (show_untracked_files == ALL_UNTRACKED);
 	s.index_file = index_file;
 	s.fp = fp;
 	s.nowarn = nowarn;
@@ -795,6 +796,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else
 		die("Invalid cleanup mode %s", cleanup_arg);
 
+	if (!untracked_files_arg)
+		; /* default already initialized */
+	else if (!strcmp(untracked_files_arg, "none"))
+		show_untracked_files = NONE_UNTRACKED;
+	else if (!strcmp(untracked_files_arg, "normal"))
+		show_untracked_files = NORMAL_UNTRACKED;
+	else if (!strcmp(untracked_files_arg, "all"))
+		show_untracked_files = ALL_UNTRACKED;
+	else
+		die("Invalid untracked files mode '%s'", untracked_files_arg);
+
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
 	else if (interactive && argc > 0)
diff --git a/wt-status.c b/wt-status.c
index 5b4d74c..742a474 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -27,6 +27,7 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
+enum untracked_status_type show_untracked_files = NORMAL_UNTRACKED;
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -347,7 +348,10 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_changed(s);
 	if (wt_status_submodule_summary)
 		wt_status_print_submodule_summary(s);
-	wt_status_print_untracked(s);
+	if (show_untracked_files)
+		wt_status_print_untracked(s);
+	else if (s->commitable)
+		fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
@@ -362,6 +366,8 @@ void wt_status_print(struct wt_status *s)
 			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
 		else if (s->is_initial)
 			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+		else if (!show_untracked_files)
+			printf("nothing to commit (use -u to show untracked files)\n");
 		else
 			printf("nothing to commit (working directory clean)\n");
 	}
diff --git a/wt-status.h b/wt-status.h
index 597c7ea..343d975 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -11,6 +11,13 @@ enum color_wt_status {
 	WT_STATUS_NOBRANCH,
 };
 
+enum untracked_status_type {
+	NONE_UNTRACKED,
+	NORMAL_UNTRACKED,
+	ALL_UNTRACKED
+};
+extern enum untracked_status_type show_untracked_files;
+
 struct wt_status {
 	int is_initial;
 	char *branch;
-- 
1.5.5.GIT
