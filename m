From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 7/9] init: use get_git_work_tree() instead of rolling our
 own
Date: Mon, 30 Jul 2007 00:25:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707300025500.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFI9R-0002be-Kz
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbXG2X0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935438AbXG2X0P
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:26:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:60893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935375AbXG2X0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 19:26:14 -0400
Received: (qmail invoked by alias); 29 Jul 2007 23:26:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 30 Jul 2007 01:26:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183HBB5A/A3aFHUlXvP6DovI4udgcwe/DmMhsq5vE
	9dNVwaXBRt0QSK
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54156>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-init-db.c |   48 +++++++++++-------------------------------------
 1 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 66ddaeb..0d9b1e0 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -174,36 +174,7 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	closedir(dir);
 }
 
-/*
- * Get the full path to the working tree specified in $GIT_WORK_TREE
- * or NULL if no working tree is specified.
- */
-static const char *get_work_tree(void)
-{
-	const char *git_work_tree;
-	char cwd[PATH_MAX];
-	static char worktree[PATH_MAX];
-
-	git_work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
-	if (!git_work_tree)
-		return NULL;
-	if (!getcwd(cwd, sizeof(cwd)))
-		die("Unable to read current working directory");
-	if (chdir(git_work_tree))
-		die("Cannot change directory to specified working tree '%s'",
-			git_work_tree);
-	if (git_work_tree[0] != '/') {
-		if (!getcwd(worktree, sizeof(worktree)))
-			die("Unable to read current working directory");
-		git_work_tree = worktree;
-	}
-	if (chdir(cwd))
-		die("Cannot come back to cwd");
-	return git_work_tree;
-}
-
-static int create_default_files(const char *git_dir, const char *git_work_tree,
-	const char *template_path)
+static int create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
@@ -282,16 +253,16 @@ static int create_default_files(const char *git_dir, const char *git_work_tree,
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository() && !git_work_tree) {
+	if (is_bare_repository())
 		git_config_set("core.bare", "true");
-	}
 	else {
+		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (git_work_tree)
-			git_config_set("core.worktree", git_work_tree);
+		if (work_tree != git_work_tree_cfg)
+			git_config_set("core.worktree", work_tree);
 	}
 	return reinit;
 }
@@ -308,7 +279,6 @@ static const char init_db_usage[] =
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
-	const char *git_work_tree;
 	const char *sha1_dir;
 	const char *template_dir = NULL;
 	char *path;
@@ -329,7 +299,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
-	git_work_tree = get_work_tree();
+	git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+	if (!getcwd(git_work_tree_cfg, PATH_MAX))
+		die ("Cannot access current working directory.");
+	if (access(get_git_work_tree(), X_OK))
+		die ("Cannot access work tree '%s'", get_git_work_tree());
 
 	/*
 	 * Set up the default .git directory contents
@@ -346,7 +320,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 */
 	check_repository_format();
 
-	reinit = create_default_files(git_dir, git_work_tree, template_dir);
+	reinit = create_default_files(git_dir, template_dir);
 
 	/*
 	 * And set up the object store.
-- 
1.5.3.rc3.28.g1406
