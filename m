From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 5/5] git-init: set core.worktree when GIT_WORK_TREE is specified
Date: Sat, 17 Mar 2007 15:45:31 +0100
Message-ID: <20070317144531.GE26290@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSaA5-0007aW-9K
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbXCQOpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXCQOpe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:45:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:60757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752679AbXCQOpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:45:33 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:45:32 -0000
X-Provags-ID: V01U2FsdGVkX19Y8pQ0W0tYuq1Jo1vLmQK+JVhUmkgd8MbX1PEYC+
	BrJtKJJzRmeADl
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317143452.GA21140@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42441>

git init will die with an error message before doing anything if the
value of GIT_WORK_TREE is no valid directory.  GIT_WORK_TREE is also
expanded to an absolute path for the config file.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 builtin-init-db.c   |   31 ++++++++++++++++++++++++++++++-
 t/t1501-worktree.sh |   15 +++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4df9fd0..4ea8c1f 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -182,6 +182,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	char repo_version_string[10];
 	int reinit;
 	int filemode;
+	const char *git_work_tree = getenv(GIT_WORKING_TREE_ENVIRONMENT);
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -252,7 +253,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository()) {
+	if (is_bare_repository() && !git_work_tree) {
 		git_config_set("core.bare", "true");
 	}
 	else {
@@ -260,6 +261,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
+		if (git_work_tree)
+			git_config_set("core.worktree", git_work_tree);
 	}
 	return reinit;
 }
@@ -276,6 +279,7 @@ static const char init_db_usage[] =
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *git_work_tree;
 	const char *sha1_dir;
 	const char *template_dir = NULL;
 	char *path;
@@ -294,6 +298,31 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	}
 
 	/*
+	 * check value of $GIT_WORK_TREE
+	 * if it is set it has to be a valid directory
+	 */
+	git_work_tree = getenv(GIT_WORKING_TREE_ENVIRONMENT);
+	if (git_work_tree) {
+		char cwd[PATH_MAX];
+
+		if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(git_work_tree))
+			die("chdir to specified working tree '%s' failed",
+				git_work_tree);
+		/* get absolute path */
+		if (git_work_tree[0] != '/') {
+			char worktree[PATH_MAX];
+			if (!getcwd(worktree, sizeof(worktree)) ||
+				worktree[0] != '/')
+				die("Unable to read current working directory");
+			setenv(GIT_WORKING_TREE_ENVIRONMENT, worktree, 1);
+		}
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+	}
+
+	/*
 	 * Set up the default .git directory contents
 	 */
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index bc08994..4db4b6a 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -88,4 +88,19 @@ test_expect_success 'repository/worktree: --is-bare-repository' \
 test_expect_success 'repository/worktree: --is-inside-git-dir' \
 	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
 
+# git init
+cd "$top" || exit 1
+export GIT_DIR=$(pwd)/repository2
+test_expect_failure 'git --work-tree non-existent init' \
+	'git --work-tree non-existent init'
+test_expect_success 'git --work-tree working/tree init' \
+	'git --work-tree working/tree init'
+test_expect_success 'config knows core.worktree' \
+	'git config core.worktree'
+git config --unset core.worktree || exit 1
+test_expect_success 'git --work-tree `pwd`/working init' \
+	'git --work-tree "$(pwd)"/working init'
+test_expect_success 'config knows core.worktree' \
+	'git config core.worktree'
+
 test_done
-- 
1.5.0.4.414.g32da9
