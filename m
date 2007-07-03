From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is specified
Date: Wed, 4 Jul 2007 00:49:19 +0200
Message-ID: <20070703224919.GA22578@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 00:49:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5rBX-0001Cc-9S
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbXGCWtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXGCWtY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:49:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:37025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbXGCWtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:49:23 -0400
Received: (qmail invoked by alias); 03 Jul 2007 22:49:21 -0000
Received: from pD9EBB423.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.180.35]
  by mail.gmx.net (mp042) with SMTP; 04 Jul 2007 00:49:21 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1/imgsaxO3iug4jX3o9qPChuY+iJvjQ8xjcSOWshA
	SIIcQ7Cx56LGcu
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51548>

Now you can do the following to create a repository which
has a separate working tree:

    /tmp/foo$ export GIT_DIR=/tmp/bar
    /tmp/foo$ git --work-tree . init
    Initialized empty Git repository in /tmp/bar/
    /tmp/foo$ git config core.worktree
    /tmp/foo

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Without this I found it quite complicated to create a non bare
repository which is not in a .git directory.

Some stuff I was wondering about while writing this patch:

 * Should we have a function similar to err(3) which prints
   ": " and strerror(errno) after the supplied error message?
   This function could be used instead of die whenever errno contains
   some meaningful value.

 * Should git init create the whole path to the repository and not
   only the last component?  I.e. git --git-dir /tmp/a init suceeds
   but git --git-dir /tmp/a/b/c init fails (unless /tmp/a/b exists).

 * Should git init create the working tree if it does not exist?

 * Is this something which should have a test?  git init doesn't seem
   to have any tests yet beside basic tests if the created repository
   looks ok.
---
 builtin-init-db.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 976f47b..ff5c13b 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -174,7 +174,36 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	closedir(dir);
 }
 
-static int create_default_files(const char *git_dir, const char *template_path)
+/*
+ * Get the full path to the working tree specified in $GIT_WORK_TREE
+ * or NULL if no working tree is specified.
+ */
+static const char *get_work_tree(void)
+{
+	const char *git_work_tree;
+	char cwd[PATH_MAX];
+	static char worktree[PATH_MAX];
+
+	git_work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	if (!git_work_tree)
+		return NULL;
+	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+		die("Unable to read current working directory");
+	if (chdir(git_work_tree))
+		die("Cannot change directory to specified working tree '%s'",
+			git_work_tree);
+	if (git_work_tree[0] != '/') {
+		if (!getcwd(worktree, sizeof(worktree)) || worktree[0] != '/')
+			die("Unable to read current working directory");
+		git_work_tree = worktree;
+	}
+	if (chdir(cwd))
+		die("Cannot come back to cwd");
+	return git_work_tree;
+}
+
+static int create_default_files(const char *git_dir, const char *git_work_tree,
+	const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
@@ -253,7 +282,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository()) {
+	if (is_bare_repository() && !git_work_tree) {
 		git_config_set("core.bare", "true");
 	}
 	else {
@@ -261,6 +290,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
+		if (git_work_tree)
+			git_config_set("core.worktree", git_work_tree);
 	}
 	return reinit;
 }
@@ -277,6 +308,7 @@ static const char init_db_usage[] =
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
+	const char *git_work_tree;
 	const char *sha1_dir;
 	const char *template_dir = NULL;
 	char *path;
@@ -294,6 +326,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			usage(init_db_usage);
 	}
 
+	git_work_tree = get_work_tree();
+
 	/*
 	 * Set up the default .git directory contents
 	 */
@@ -309,7 +343,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 */
 	check_repository_format();
 
-	reinit = create_default_files(git_dir, template_dir);
+	reinit = create_default_files(git_dir, git_work_tree, template_dir);
 
 	/*
 	 * And set up the object store.
-- 
1.5.2.2.646.g71e55-dirty
