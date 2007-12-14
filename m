From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] make git start-up sequence a bit more robust
Date: Thu, 13 Dec 2007 21:03:55 -0800
Message-ID: <7vsl25x3yc.fsf_-_@gitster.siamese.dyndns.org>
References: <20071129122139.GA11176@laptop>
	<7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32iz-0002eX-Op
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbXLNFEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 00:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXLNFEO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:04:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbXLNFEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 00:04:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 353968387;
	Fri, 14 Dec 2007 00:04:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AA1B8386;
	Fri, 14 Dec 2007 00:04:02 -0500 (EST)
In-Reply-To: <7vmysexdvw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Dec 2007 17:29:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68221>

The handle options loop called setup_git_dir() and setup_pager() that
would silently trigger repository discovery while it cycled.  This patch
changes it to collect the options from the user, and uses the
information in a saner, more controlled order, namely:

 - GIT_DIR, GIT_WORK_TREE and GIT_PAGER environments are set as needed;
 - setup_git_directory() is run if needed;
 - setup_work_tree(0 is run if needed;
 - setup_pager() is run if needed; 

The last two wants to read config, which means setup_git_directory()
should come before them, which in turn means GIT_DIR must be set up
before that.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > If you have a bare repository and try this there:
 >
 > 	$ PAGER=head git show HEAD:gcc/ChangeLog
 >
 > it works as expected, but if you explicitly ask for pagination, like
 > this:
 >
 > 	$ PAGER=head git -p show HEAD:gcc/ChangeLog
 >
 > you would get a very funky error message:
 >
 > 	fatal: ambiguous argument 'HEAD:gcc/ChangeLog': unknown revision or path not in the working tree.
 > 	Use '--' to separate paths from revisions
 >
 > as if we are working with a repository with working tree.
 >
 > I originally noticed this with ls-tree.  The symptom is a bit different:
 >
 > 	$ git -p ls-tree HEAD
 > 	fatal: Not a valid object name HEAD
 >
 > I _think_ what is happening is that setup_pager() tries to run
 > git_config(), which runs setup(), and then RUN_SETUP set for "ls-tree"
 > (or "show") internal command runs setup again.  HEAD is given to
 > resolve_ref() and git_path("%s", ref) makes it to ".git/HEAD", even
 > though in a bare repository git_dir should be set to ".", and of course
 > we cannot find such a path in the git directory.

 git.c |   73 ++++++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/git.c b/git.c
index 15fec89..fd756cd 100644
--- a/git.c
+++ b/git.c
@@ -6,7 +6,21 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
-static int handle_options(const char*** argv, int* argc, int* envchanged)
+static int want_pager = -1;
+static const char *want_git_dir;
+static int want_git_dir_badly = 1;
+static const char *want_work_tree;
+
+static void no_env_change_from_alias(const char *alias_command)
+{
+	if (!alias_command)
+		return;
+	die("alias '%s' changes environment variables\n"
+	    "You can use '!git' in the alias to do this.",
+	    alias_command);
+}
+
+static int handle_options(const char ***argv, int *argc, const char *alias_command)
 {
 	int handled = 0;
 
@@ -35,46 +49,42 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-			setup_pager();
+			want_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
-			setenv("GIT_PAGER", "cat", 1);
-			if (envchanged)
-				*envchanged = 1;
+			want_pager = 0;
 		} else if (!strcmp(cmd, "--git-dir")) {
+			no_env_change_from_alias(alias_command);
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
-			if (envchanged)
-				*envchanged = 1;
+			want_git_dir = (*argv)[1];
 			(*argv)++;
 			(*argc)--;
 			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
-			if (envchanged)
-				*envchanged = 1;
+			no_env_change_from_alias(alias_command);
+			want_git_dir = cmd + 10;
 		} else if (!strcmp(cmd, "--work-tree")) {
+			no_env_change_from_alias(alias_command);
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
-			if (envchanged)
-				*envchanged = 1;
+			want_work_tree = (*argv)[1];
 			(*argv)++;
 			(*argc)--;
+			handled++;
 		} else if (!prefixcmp(cmd, "--work-tree=")) {
-			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
-			if (envchanged)
-				*envchanged = 1;
+			no_env_change_from_alias(alias_command);
+			want_work_tree = cmd + 12;
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
+			no_env_change_from_alias(alias_command);
 			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
-			if (envchanged)
-				*envchanged = 1;
+			getcwd(git_dir, sizeof(git_dir));
+			want_git_dir = git_dir;
+			want_git_dir_badly = 0;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
@@ -153,7 +163,7 @@ static int split_cmdline(char *cmdline, const char ***argv)
 
 static int handle_alias(int *argcp, const char ***argv)
 {
-	int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
+	int nongit = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
@@ -183,11 +193,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			    alias_string + 1, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
-		option_count = handle_options(&new_argv, &count, &envchanged);
-		if (envchanged)
-			die("alias '%s' changes environment variables\n"
-				 "You can use '!git' in the alias to do this.",
-				 alias_command);
+		option_count = handle_options(&new_argv, &count, alias_command);
 		memmove(new_argv - option_count, new_argv,
 				count * sizeof(char *));
 		new_argv -= option_count;
@@ -247,11 +253,12 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
-		setup_pager();
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
+	if (0 < want_pager || (p->option & USE_PAGER))
+		setup_pager();
+
 	trace_argv_printf(argv, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
@@ -434,6 +441,13 @@ int main(int argc, const char **argv)
 	}
 	cmd = argv[0];
 
+	if (want_git_dir)
+		setenv(GIT_DIR_ENVIRONMENT, want_git_dir, want_git_dir_badly);
+	if (want_work_tree)
+		setenv(GIT_WORK_TREE_ENVIRONMENT, want_work_tree, 1);
+	if (!want_pager)
+		setenv("GIT_PAGER", "cat", 1);
+
 	/*
 	 * We use PATH to find git commands, but we prepend some higher
 	 * precidence paths: the "--exec-path" option, the GIT_EXEC_PATH
@@ -446,6 +460,9 @@ int main(int argc, const char **argv)
 		/* See if it's an internal command */
 		handle_internal_command(argc, argv);
 
+		if (!done_alias && 0 < want_pager)
+			setup_pager();
+
 		/* .. then try the external ones */
 		execv_git_cmd(argv);
 
