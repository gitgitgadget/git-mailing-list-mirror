From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 4/7] introduce GIT_WORK_TREE to specify the work tree
Date: Sun, 3 Jun 2007 16:47:14 +0200
Message-ID: <20070603144714.GD20061@moooo.ath.cx>
References: <20070603144401.GA9518@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 16:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HurPC-0008NF-Dm
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 16:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbXFCOrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 10:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758658AbXFCOrV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 10:47:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:45868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754264AbXFCOrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 10:47:18 -0400
Received: (qmail invoked by alias); 03 Jun 2007 14:47:15 -0000
Received: from pD9EB8AF4.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.138.244]
  by mail.gmx.net (mp054) with SMTP; 03 Jun 2007 16:47:15 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18P4xMMLtEPO9NAFGrIEyXLdqTnpDC0C7LB/LZ4Xo
	XbjgHocLssh0+i
Content-Disposition: inline
In-Reply-To: <20070603144401.GA9518@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49000>

setup_gdg is used as abbreviation for setup_git_directory_gently.

The work tree can be specified using the environment variable
GIT_WORK_TREE and the config option core.worktree (the environment
variable has precendence over the config option).  Additionally
there is a command line option --work-tree which sets the
environment variable.

setup_gdg does the following now:

GIT_DIR unspecified
repository in .git directory
    parent directory of the .git directory is used as work tree,
    GIT_WORK_TREE is ignored

GIT_DIR unspecified
repository in cwd
    GIT_DIR is set to cwd
    see the cases with GIT_DIR specified what happens next and
    also see the note below

GIT_DIR specified
GIT_WORK_TREE/core.worktree unspecified
repository is bare (config or guessing)
    no work tree is used

GIT_DIR specified
GIT_WORK_TREE/core.worktree unspecified
repository is not bare (config or guessing)
    cwd is used as work tree

GIT_DIR specified
GIT_WORK_TREE/core.worktree specified
    the specified work tree is used

Note on the case where GIT_DIR is unspecified and repository is in cwd:
    GIT_WORK_TREE is used but is_inside_git_dir is always true.
    I did it this way because setup_gdg might be called multiple
    times (e.g. when doing alias expansion) and in successive calls
    setup_gdg should do the same thing every time.

Meaning of is_bare/is_inside_work_tree/is_inside_git_dir:

(1) is_bare_repository
    A repository is bare if core.bare is true or core.bare is
    unspecified and the name suggests it is bare (directory not
    named .git).  In general a bare repository is intended to be
    used without a work tree.  If such a repository is used with a
    work tree anyway some protection mechanisms which are useful
    with a work tree are disabled.  Currently this changes if a
    repository is bare:
        updates of HEAD are allowed
        git gc packs the refs
        the reflog is disabled by default
        cwd is not used as fallback work tree

(2) is_inside_work_tree
    True if the cwd is inside the associated working tree (if there
    is one), false otherwise.

(3) is_inside_git_dir
    True if the cwd is inside the git directory, false otherwise.
    Before this patch is_inside_git_dir was always true for bare
    repositories.

When setup_gdg finds a repository git_config(git_default_config) is
always called.  This ensure that is_bare_repository makes use of
core.bare and does not guess even though core.bare is specified.

inside_work_tree and inside_git_dir are set if setup_gdg finds a
repository.  The is_inside_work_tree and is_inside_git_dir functions
will die if they are called before a successful call to setup_gdg.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/config.txt        |    7 ++
 Documentation/git-rev-parse.txt |    4 +
 Documentation/git.txt           |   18 +++-
 builtin-rev-parse.c             |    5 +
 cache.h                         |    2 +
 connect.c                       |    1 +
 git.c                           |   12 ++-
 setup.c                         |  217 +++++++++++++++++++++++++++++----------
 t/test-lib.sh                   |    1 +
 9 files changed, 210 insertions(+), 57 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5868d58..4d0bd37 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -172,6 +172,13 @@ repository that ends in "/.git" is assumed to be not bare (bare =
 false), while all other repositories are assumed to be bare (bare
 = true).
 
+core.worktree::
+	Set the path to the working tree.  The value will not be
+	used in combination with repositories found automatically in
+	a .git directory (i.e. $GIT_DIR is not set).
+	This can be overriden by the GIT_WORK_TREE environment
+	variable and the '--work-tree' command line option.
+
 core.logAllRefUpdates::
 	Updates to a ref <ref> is logged to the file
 	"$GIT_DIR/logs/<ref>", by appending the new and old
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c817d16..6e4d158 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -93,6 +93,10 @@ OPTIONS
 	When the current working directory is below the repository
 	directory print "true", otherwise "false".
 
+--is-inside-work-tree::
+	When the current working directory is inside the work tree of the
+	repository print "true", otherwise "false".
+
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 98860af..4b567d8 100644
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
@@ -101,6 +102,14 @@ OPTIONS
 	Set the path to the repository. This can also be controlled by
 	setting the GIT_DIR environment variable.
 
+--work-tree=<path>::
+	Set the path to the working tree.  The value will not be
+	used in combination with repositories found automatically in
+	a .git directory (i.e. $GIT_DIR is not set).
+	This can also be controlled by setting the GIT_WORK_TREE
+	environment variable and the core.worktree configuration
+	variable.
+
 --bare::
 	Same as --git-dir=`pwd`.
 
@@ -345,6 +354,13 @@ git so take care if using Cogito etc.
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 
+'GIT_WORK_TREE'::
+	Set the path to the working tree.  The value will not be
+	used in combination with repositories found automatically in
+	a .git directory (i.e. $GIT_DIR is not set).
+	This can also be controlled by the '--work-tree' command line
+	option and the core.worktree configuration variable.
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 71d5162..497903a 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -352,6 +352,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						: "false");
 				continue;
 			}
+			if (!strcmp(arg, "--is-inside-work-tree")) {
+				printf("%s\n", is_inside_work_tree() ? "true"
+						: "false");
+				continue;
+			}
 			if (!strcmp(arg, "--is-bare-repository")) {
 				printf("%s\n", is_bare_repository() ? "true"
 						: "false");
diff --git a/cache.h b/cache.h
index 8a9d1f3..ae1990a 100644
--- a/cache.h
+++ b/cache.h
@@ -192,6 +192,7 @@ enum object_type {
 };
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -207,6 +208,7 @@ enum object_type {
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
+extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
diff --git a/connect.c b/connect.c
index 8cbda88..aafa416 100644
--- a/connect.c
+++ b/connect.c
@@ -589,6 +589,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
 			unsetenv(DB_ENVIRONMENT);
 			unsetenv(GIT_DIR_ENVIRONMENT);
+			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
 			execlp("sh", "sh", "-c", command, NULL);
diff --git a/git.c b/git.c
index 29b55a1..05a391b 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -69,6 +69,16 @@ static int handle_options(const char*** argv, int* argc)
 			handled++;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+		} else if (!strcmp(cmd, "--work-tree")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --work-tree.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--work-tree=")) {
+			setenv(GIT_WORK_TREE_ENVIRONMENT, cmd + 12, 1);
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
diff --git a/setup.c b/setup.c
index a45ea83..4856232 100644
--- a/setup.c
+++ b/setup.c
@@ -174,41 +174,93 @@ static int inside_git_dir = -1;
 
 int is_inside_git_dir(void)
 {
-	if (inside_git_dir < 0) {
-		char buffer[1024];
-
-		if (is_bare_repository())
-			return (inside_git_dir = 1);
-		if (getcwd(buffer, sizeof(buffer))) {
-			const char *git_dir = get_git_dir(), *cwd = buffer;
-			while (*git_dir && *git_dir == *cwd) {
-				git_dir++;
-				cwd++;
-			}
-			inside_git_dir = !*git_dir;
-		} else
-			inside_git_dir = 0;
+	if (inside_git_dir >= 0)
+		return inside_git_dir;
+	die("BUG: is_inside_git_dir called before setup_git_directory");
+}
+
+static int inside_work_tree = -1;
+
+int is_inside_work_tree(void)
+{
+	if (inside_git_dir >= 0)
+		return inside_work_tree;
+	die("BUG: is_inside_work_tree called before setup_git_directory");
+}
+
+static char *gitworktree_config;
+
+static int git_setup_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "core.worktree")) {
+		if (gitworktree_config)
+			strlcpy(gitworktree_config, value, PATH_MAX);
+		return 0;
 	}
-	return inside_git_dir;
+	return git_default_config(var, value);
 }
 
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
-	const char *gitdirenv;
-	int len, offset;
+	char worktree[PATH_MAX+1], gitdir[PATH_MAX+1];
+	const char *gitdirenv, *gitworktree;
+	int wt_rel_gitdir = 0;
 
-	/*
-	 * If GIT_DIR is set explicitly, we're not going
-	 * to do any discovery, but we still do repository
-	 * validation.
-	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (gitdirenv) {
-		if (PATH_MAX - 40 < strlen(gitdirenv))
-			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
+	if (!gitdirenv) {
+		int len, offset;
+
+		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+			die("Unable to read current working directory");
+
+		offset = len = strlen(cwd);
+		for (;;) {
+			if (is_git_directory(".git"))
+				break;
+			if (offset == 0) {
+				offset = -1;
+				break;
+			}
+			chdir("..");
+			while (cwd[--offset] != '/')
+				; /* do nothing */
+		}
+
+		if (offset >= 0) {
+			inside_work_tree = 1;
+			git_config(git_default_config);
+			if (offset == len) {
+				inside_git_dir = 0;
+				return NULL;
+			}
+
+			cwd[len++] = '/';
+			cwd[len] = '\0';
+			inside_git_dir = !prefixcmp(cwd + offset + 1, ".git/");
+			return cwd + offset + 1;
+		}
+
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+		if (!is_git_directory(".")) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository");
+		}
+		setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
+	}
+
+	if (PATH_MAX - 40 < strlen(gitdirenv)) {
+		if (nongit_ok) {
+			*nongit_ok = 1;
 			return NULL;
+		}
+		die("$%s too big", GIT_DIR_ENVIRONMENT);
+	}
+	if (!is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			return NULL;
@@ -218,41 +270,96 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
 		die("Unable to read current working directory");
+	if (chdir(gitdirenv)) {
+		if (nongit_ok) {
+			*nongit_ok = 1;
+			return NULL;
+		}
+		die("Cannot change directory to $%s '%s'",
+			GIT_DIR_ENVIRONMENT, gitdirenv);
+	}
+	if (!getcwd(gitdir, sizeof(gitdir)-1) || gitdir[0] != '/')
+		die("Unable to read current working directory");
+	if (chdir(cwd))
+		die("Cannot come back to cwd");
 
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
-				}
-				if (nongit_ok) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
-					*nongit_ok = 1;
-					return NULL;
-				}
-				die("Not a git repository");
+	/*
+	 * In case there is a work tree we may change the directory,
+	 * therefore make GIT_DIR an absolute path.
+	 */
+	if (gitdirenv[0] != '/') {
+		setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
+		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+		if (PATH_MAX - 40 < strlen(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
 			}
-		} while (cwd[--offset] != '/');
+			die("$%s too big after expansion to absolute path",
+				GIT_DIR_ENVIRONMENT);
+		}
+	}
+
+	strcat(cwd, "/");
+	strcat(gitdir, "/");
+	inside_git_dir = !prefixcmp(cwd, gitdir);
+
+	gitworktree = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	if (!gitworktree) {
+		gitworktree_config = worktree;
+		worktree[0] = '\0';
+	}
+	git_config(git_setup_config);
+	if (!gitworktree) {
+		gitworktree_config = NULL;
+		if (worktree[0])
+			gitworktree = worktree;
+		if (gitworktree && gitworktree[0] != '/')
+			wt_rel_gitdir = 1;
 	}
 
-	if (offset == len)
+	/* stop if the repository is bare and does not have a work tree */
+	if (!gitworktree && is_bare_repository()) {
+		inside_work_tree = 0;
 		return NULL;
+	}
 
-	/* Make "offset" point to past the '/', and add a '/' at the end */
-	offset++;
-	cwd[len++] = '/';
-	cwd[len] = 0;
-	inside_git_dir = !prefixcmp(cwd + offset, ".git/");
-	return cwd + offset;
+	if (wt_rel_gitdir && chdir(gitdirenv))
+		die("Cannot change directory to $%s '%s'",
+			GIT_DIR_ENVIRONMENT, gitdirenv);
+	if (gitworktree && chdir(gitworktree)) {
+		if (nongit_ok) {
+			if (wt_rel_gitdir && chdir(cwd))
+				die("Cannot come back to cwd");
+			*nongit_ok = 1;
+			return NULL;
+		}
+		if (wt_rel_gitdir)
+			die("Cannot change directory to working tree '%s'"
+				" from $%s", gitworktree, GIT_DIR_ENVIRONMENT);
+		else
+			die("Cannot change directory to working tree '%s'",
+				gitworktree);
+	}
+	if (!getcwd(worktree, sizeof(worktree)-1) || worktree[0] != '/')
+		die("Unable to read current working directory");
+	strcat(worktree, "/");
+	inside_work_tree = !prefixcmp(cwd, worktree);
+
+	if (gitworktree && inside_work_tree && !prefixcmp(worktree, gitdir) &&
+	    strcmp(worktree, gitdir)) {
+		inside_git_dir = 0;
+	}
+
+	if (!inside_work_tree) {
+		if (chdir(cwd))
+			die("Cannot come back to cwd");
+		return NULL;
+	}
+
+	if (!strcmp(cwd, worktree))
+		return NULL;
+	return cwd+strlen(worktree);
 }
 
 int git_config_perm(const char *var, const char *value)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dee3ad7..b61e1d5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -26,6 +26,7 @@ GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
 unset GIT_DIFF_OPTS
 unset GIT_DIR
+unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
-- 
1.5.0.3
