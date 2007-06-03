From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] GIT_WORK_TREE
Date: Sun, 3 Jun 2007 16:48:16 +0200
Message-ID: <20070603144816.GE20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPE-0008NF-6k
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbXFCOsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759907AbXFCOsV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:48:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60739 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759002AbXFCOsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:48:19 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:48:17 -0000
Received: from pd9eb8af4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp037) with SMTP; 03 Jun 2007 16:48:17 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+DZYFsBIWDWYTZCzNBMH+mmkWBZEWbDSI6a4iSWd
	RXk5eztLn1Of+Z
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49004>

Up to now to check for a working tree this was used:
	!is_bare && !inside_git_dir
(the check for bare is redundant because is_inside_git_dir
returned already 1 for bare repositories).
Now the check is:
	inside_work_tree && !inside_git_dir

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 builtin-ls-files.c |    2 +-
 git-sh-setup.sh    |    2 +-
 git-svn.perl       |    2 +-
 git.c              |   20 ++++++++++----------
 setup.c            |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f7c066b..48a3135 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -470,7 +470,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	}
 
 	if (require_work_tree &&
-			(is_bare_repository() || is_inside_git_dir()))
+			(!is_inside_work_tree() || is_inside_git_dir()))
 		die("This operation must be run in a work tree");
 
 	pathspec = get_pathspec(prefix, argv + i);
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9ac657a..0de49e8 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -44,7 +44,7 @@ cd_to_toplevel () {
 }
 
 require_work_tree () {
-	test $(is_bare_repository) = false &&
+	test $(git-rev-parse --is-inside-work-tree) = true &&
 	test $(git-rev-parse --is-inside-git-dir) = false ||
 	die "fatal: $0 cannot be used without a working tree."
 }
diff --git a/git-svn.perl b/git-svn.perl
index e3a5cbb..886b898 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -594,7 +594,7 @@ sub post_fetch_checkout {
 	my $index = $ENV{GIT_INDEX_FILE} || "$ENV{GIT_DIR}/index";
 	return if -f $index;
 
-	return if command_oneline(qw/rev-parse --is-bare-repository/) eq 'true';
+	return if command_oneline(qw/rev-parse --is-inside-work-tree/) eq 'false';
 	return if command_oneline(qw/rev-parse --is-inside-git-dir/) eq 'true';
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
 	print STDERR "Checked out HEAD:\n  ",
diff --git a/git.c b/git.c
index 05a391b..cd3910a 100644
--- a/git.c
+++ b/git.c
@@ -224,7 +224,7 @@ const char git_version_string[] = GIT_VERSION;
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NOT_BARE 	(1<<2)
+#define NEED_WORK_TREE	(1<<2)
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
@@ -234,7 +234,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		int (*fn)(int, const char **, const char *);
 		int option;
 	} commands[] = {
-		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
+		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP | USE_PAGER },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
@@ -244,9 +244,9 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
-		{ "check-attr", cmd_check_attr, RUN_SETUP | NOT_BARE },
+		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
-		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NOT_BARE },
+		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
@@ -274,7 +274,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
-		{ "mv", cmd_mv, RUN_SETUP | NOT_BARE },
+		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pickaxe", cmd_blame, RUN_SETUP | USE_PAGER },
@@ -287,9 +287,9 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
-		{ "revert", cmd_revert, RUN_SETUP | NOT_BARE },
-		{ "rm", cmd_rm, RUN_SETUP | NOT_BARE },
-		{ "runstatus", cmd_runstatus, RUN_SETUP | NOT_BARE },
+		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
+		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
@@ -326,8 +326,8 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			prefix = setup_git_directory();
 		if (p->option & USE_PAGER)
 			setup_pager();
-		if ((p->option & NOT_BARE) &&
-				(is_bare_repository() || is_inside_git_dir()))
+		if ((p->option & NEED_WORK_TREE) &&
+				(!is_inside_work_tree() || is_inside_git_dir()))
 			die("%s must be run in a work tree", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");
 
diff --git a/setup.c b/setup.c
index 4856232..ddf4013 100644
--- a/setup.c
+++ b/setup.c
@@ -95,7 +95,7 @@ void verify_non_filename(const char *prefix, const char *arg)
 	const char *name;
 	struct stat st;
 
-	if (is_inside_git_dir())
+	if (!is_inside_work_tree() || is_inside_git_dir())
 		return;
 	if (*arg == '-')
 		return; /* flag */
-- 
1.5.0.3
