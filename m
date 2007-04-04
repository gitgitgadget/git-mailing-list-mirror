From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH(amend)] introduce GIT_WORK_TREE environment variable
Date: Wed, 4 Apr 2007 22:13:13 +0200
Message-ID: <20070404201313.GB22782@moooo.ath.cx>
References: <20070328141505.GA16600@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 22:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZBr7-0007CG-Jp
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 22:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766920AbXDDUNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766923AbXDDUNS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 16:13:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:39928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1766920AbXDDUNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 16:13:16 -0400
Received: (qmail invoked by alias); 04 Apr 2007 20:13:14 -0000
Received: from pd9eba5e8.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.165.232]
  by mail.gmx.net (mp016) with SMTP; 04 Apr 2007 22:13:14 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+nmJBzARinQK7XbopO+BkHQbeN2iPPZK3QPWPrSy
	RX8S+0RIye7MX5
Content-Disposition: inline
In-Reply-To: <20070328141505.GA16600@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43772>

GIT_WORK_TREE can be used with GIT_DIR to specify the working tree.
As for GIT_DIR there is also the option `git
--work-tree=GIT_WORK_TREE` which overrides the environment
variable and a config setting core.worktree which is used as
default value.

setup_git_directory_gently() is rewritten and does the
following now:

  find the repository directory ($GIT_DIR, ".git" in parent
  directories, ".")

  read the configuration (core.bare and core.worktree are used)

  if core.bare is not set assume the repository is not bare if a
  working tree is specified or guess based on the name of the
  repository directory

  for a bare repository:
    set GIT_DIR if it is not set already and stop (this wont change
    the directory even if the repository was found as .git in a
    parent directory)

  for a non-bare repository:
    if GIT_DIR is specified:
      use GIT_WORK_TREE, core.worktree or "." as working tree
    if the repository was found as .git in a parent directory:
      use the parent directory of the .git directory as working tree
    if the repository was found in ".":
      use "." as working tree

    set inside_git_dir and inside_working_tree based on getcwd() and
    prefixcmp()

is_bare_repository() is also changed to return true if the working
directory is outside of the working tree.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Changes:
    - unsetenv(GIT_WORKING_TREE_ENVIRONMENT) in git_connect(), noted
      by Johannes Sixt
      I also looked at the other places using GIT_DIR_ENVIRONMENT to
      see if I missed something similar
    - call setup_git_env() from setup_git_directory_gently() if needed
---
 Documentation/config.txt |    4 +
 Documentation/git.txt    |   17 ++++-
 cache.h                  |    2 +
 connect.c                |    1 +
 environment.c            |   11 +++-
 git.c                    |   12 +++-
 setup.c                  |  181 ++++++++++++++++++++++++++++++++++++----------
 t/test-lib.sh            |    1 +
 8 files changed, 185 insertions(+), 44 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cf1e040..52b1aa9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -162,6 +162,10 @@ repository that ends in "/.git" is assumed to be not bare (bare =
 false), while all other repositories are assumed to be bare (bare
 = true).
 
+core.worktree::
+	Path to the working tree when GIT_DIR is set.  This can be
+	overriden by GIT_WORK_TREE.
+
 core.logAllRefUpdates::
 	Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9defc33..b37f9fd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
-    [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
+    [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -89,6 +90,14 @@ OPTIONS
 	Set the path to the repository. This can also be controlled by
 	setting the GIT_DIR environment variable.
 
+--work-tree=<path>::
+	Set the path to the working tree.  The value will be used only
+	in combination with $GIT_DIR or '--git-dir'.  If GIT_DIR is
+	set but this option is not git will assume that the current
+	directory is also the working tree.
+	This can also be controlled by setting the GIT_WORK_TREE
+	environment variable.
+
 --bare::
 	Same as --git-dir=`pwd`.
 
@@ -333,6 +342,12 @@ git so take care if using Cogito etc.
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 
+'GIT_WORK_TREE'::
+	Set the path to the working tree.  The value will be used only
+	in combination with $GIT_DIR or '--git-dir'.  If GIT_DIR is
+	set but this option is not git will assume that the current
+	directory is also the working tree.
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index 7b49258..e163a76 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ enum object_type {
 };
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORKING_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -165,6 +166,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern int inside_working_tree;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/connect.c b/connect.c
index da89c9c..ff2c459 100644
--- a/connect.c
+++ b/connect.c
@@ -773,6 +773,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog)
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
 			unsetenv(DB_ENVIRONMENT);
 			unsetenv(GIT_DIR_ENVIRONMENT);
+			unsetenv(GIT_WORKING_TREE_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
 			execlp("sh", "sh", "-c", command, NULL);
diff --git a/environment.c b/environment.c
index 713a011..769d409 100644
--- a/environment.c
+++ b/environment.c
@@ -60,8 +60,15 @@ void setup_git_env(void)
 int is_bare_repository(void)
 {
 	const char *dir, *s;
-	if (0 <= is_bare_repository_cfg)
-		return is_bare_repository_cfg;
+	/* definitely bare */
+	if (is_bare_repository_cfg == 1)
+		return 1;
+	/* bare if cwd is outside of the working tree */
+	if (inside_working_tree >= 0)
+		return !inside_working_tree;
+	/* configuration says it is not bare */
+	if (is_bare_repository_cfg == 0)
+		return 0;
 
 	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
diff --git a/git.c b/git.c
index 5b1bc2a..9c282cd 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -68,6 +68,16 @@ static int handle_options(const char*** argv, int* argc)
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+		} else if (!strcmp(cmd, "--work-tree")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --work-tree.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_WORKING_TREE_ENVIRONMENT, (*argv)[1], 1);
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--work-tree=")) {
+			setenv(GIT_WORKING_TREE_ENVIRONMENT, cmd + 11, 1);
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
diff --git a/setup.c b/setup.c
index a45ea83..794edcf 100644
--- a/setup.c
+++ b/setup.c
@@ -192,67 +192,168 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static char *git_work_tree;
+
+static int git_setup_config(const char *var, const char *value)
+{
+	if (git_work_tree && !strcmp(var, "core.worktree")) {
+		strlcpy(git_work_tree, value, PATH_MAX);
+	}
+	return git_default_config(var, value);
+}
+
+int inside_working_tree = -1;
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
+	char worktree[PATH_MAX+1], gitdir[PATH_MAX+1];
 	const char *gitdirenv;
-	int len, offset;
+	const char *gitwt = NULL;
+	int len;
+	int dotgit = 0;
+	int wt_rel_cwd = 0;
 
-	/*
-	 * If GIT_DIR is set explicitly, we're not going
-	 * to do any discovery, but we still do repository
-	 * validation.
-	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
-			return NULL;
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			return NULL;
+		if (!is_git_directory(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository: '%s'", gitdirenv);
 		}
-		die("Not a git repository: '%s'", gitdirenv);
-	}
-
-	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
-		die("Unable to read current working directory");
-
-	offset = len = strlen(cwd);
-	for (;;) {
-		if (is_git_directory(".git"))
-			break;
-		chdir("..");
-		do {
-			if (!offset) {
-				if (is_git_directory(cwd)) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
-					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
-					inside_git_dir = 1;
-					return NULL;
+	} else {
+		int offset;
+		/* keep 5 bytes for /.git and 40 for files in .git directory */
+		if (!getcwd(cwd, sizeof(cwd) - 5 - 40) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		offset = strlen(cwd);
+		for (;;) {
+			strcat(cwd, "/.git");
+			if (is_git_directory(cwd)) {
+				dotgit = 1;
+				setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+				cwd[offset] = '\0';
+				strcpy(worktree, cwd);
+				gitwt = worktree;
+				break;
+			}
+			if (offset == 0) {
+				if (is_git_directory(".")) {
+					setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+					strcpy(worktree, ".");
+					gitwt = worktree;
+					break;
 				}
 				if (nongit_ok) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
 					*nongit_ok = 1;
 					return NULL;
 				}
 				die("Not a git repository");
 			}
-		} while (cwd[--offset] != '/');
+			cwd[offset] = '\0';
+			while (cwd[offset] != '/')
+				--offset;
+			cwd[offset] = '\0';
+		}
+		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+	}
+
+	if (!gitwt)
+		gitwt = getenv(GIT_WORKING_TREE_ENVIRONMENT);
+	if (gitwt && gitwt[0] != '/')
+		wt_rel_cwd = 1;
+	if (!gitwt) {
+		git_work_tree = worktree;
+		worktree[0] = '\0';
+	}
+	git_config(git_setup_config);
+	if (!gitwt) {
+		git_work_tree = NULL;
+		if (worktree[0])
+			gitwt = worktree;
 	}
 
-	if (offset == len)
+	/*
+	 * try to figure out if this is a bare repository:
+	 * if core.bare is undefined and a worktree is specified we go on and
+	 * try the specified worktree, otherwise use is_bare_repository() to
+	 * decide
+	 */
+	if (!(is_bare_repository_cfg == -1 && gitwt) && is_bare_repository())
 		return NULL;
 
-	/* Make "offset" point to past the '/', and add a '/' at the end */
-	offset++;
-	cwd[len++] = '/';
-	cwd[len] = 0;
-	inside_git_dir = !prefixcmp(cwd + offset, ".git/");
-	return cwd + offset;
+	if (!gitwt) {
+		wt_rel_cwd = 1;
+		strcpy(worktree, ".");
+		gitwt = worktree;
+	}
+
+	/* run getcwd in cwd, GIT_DIR and GIT_WORK_TREE */
+	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+		die("Unable to read current working directory");
+	if (chdir(gitdirenv))
+		die("Cannot change directory to '%s'", gitdirenv);
+	if (!getcwd(gitdir, sizeof(gitdir)-1) || gitdir[0] != '/')
+		die("Unable to read current working directory");
+	/* gitwt is a relative path from the old cwd, go back first */
+	if (wt_rel_cwd && chdir(cwd))
+		die("Cannot come back to cwd");
+	if (chdir(gitwt)) {
+		if (wt_rel_cwd || gitwt[0] == '/')
+			die("Cannot change directory to working tree '%s'",
+				gitwt);
+		else
+			die("Cannot change directory to working tree '%s'"
+				" from $GIT_DIR", gitwt);
+	}
+	if (!getcwd(worktree, sizeof(worktree)-1) || worktree[0] != '/')
+		die("Unable to read current working directory");
+
+	len = strlen(cwd);
+	cwd[len] = '/';
+	cwd[len+1] = '\0';
+
+	len = strlen(worktree);
+	worktree[len] = '/';
+	worktree[len+1] = '\0';
+	inside_working_tree = !prefixcmp(cwd, worktree);
+
+	len = strlen(gitdir);
+	gitdir[len] = '/';
+	gitdir[len+1] = '\0';
+	/*
+	 * if we are inside worktree, worktree is below gitdir and
+	 * worktree != gitdir then we are not really in gitdir
+	 */
+	if (inside_working_tree && !prefixcmp(worktree, gitdir) &&
+	    strcmp(worktree, gitdir)) {
+		inside_git_dir = 0;
+	} else {
+		inside_git_dir = !prefixcmp(cwd, gitdir);
+	}
+	gitdir[len] = '\0';
+
+	if (!inside_working_tree) {
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+		return NULL;
+	}
+
+	if (dotgit) {
+		unsetenv(GIT_DIR_ENVIRONMENT);
+		setup_git_env();
+	} else if (gitdirenv[0] != '/') {
+		setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
+		setup_git_env();
+	}
+
+	if (!strcmp(cwd, worktree))
+		return NULL;
+	return cwd+strlen(worktree);
 }
 
 int git_config_perm(const char *var, const char *value)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c075474..77c6d23 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -25,6 +25,7 @@ GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
 unset GIT_DIFF_OPTS
 unset GIT_DIR
+unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
-- 
1.5.1.4.g446af-dirty
