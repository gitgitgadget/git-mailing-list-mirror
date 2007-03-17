From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 3/5] introduce GIT_WORK_TREE environment variable
Date: Sat, 17 Mar 2007 15:44:03 +0100
Message-ID: <20070317144403.GC26290@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:44:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSa8j-0006oI-3R
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXCQOoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbXCQOoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:44:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:55760 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752683AbXCQOoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:44:05 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:44:04 -0000
X-Provags-ID: V01U2FsdGVkX18fX+VxI20fj3agYVLQblHjmXMoGi9IroXWihM5l0
	COJ0kJJTEbtmWS
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317143452.GA21140@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42439>

This environment variable can be used with GIT_DIR to
specify the working tree.  When GIT_DIR is not set this
variable is ignored.  As for GIT_DIR there is also the
option git --work-tree which overrides the environment
variable and a config setting core.worktree which is used as
default value.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/config.txt |    4 ++
 Documentation/git.txt    |   17 +++++++-
 cache.h                  |    2 +
 environment.c            |   11 ++++-
 git.c                    |   12 +++++-
 setup.c                  |   98 ++++++++++++++++++++++++++++++++++++++++++---
 t/test-lib.sh            |    1 +
 7 files changed, 134 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 953acae..dc1497d 100644
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
index e875e83..e870ac8 100644
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
@@ -81,6 +82,14 @@ OPTIONS
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
 
@@ -325,6 +334,12 @@ git so take care if using Cogito etc.
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
index 3818e10..ced091b 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ enum object_type {
 };
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORKING_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -164,6 +165,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern int inside_working_tree;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/environment.c b/environment.c
index 0151ad0..208b7aa 100644
--- a/environment.c
+++ b/environment.c
@@ -59,8 +59,15 @@ static void setup_git_env(void)
 int is_bare_repository(void)
 {
 	const char *dir, *s;
-	if (0 <= is_bare_repository_cfg)
-		return is_bare_repository_cfg;
+	/* definitely bare */
+	if (is_bare_repository_cfg == 1)
+		return 1;
+	/* GIT_WORK_TREE is set, bare if cwd is outside */
+	if (inside_working_tree >= 0)
+		return !inside_working_tree;
+	/* configuration says it is not bare */
+	if (is_bare_repository_cfg == 0)
+		return 0;
 
 	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
diff --git a/git.c b/git.c
index dde4d07..9d7eeb3 100644
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
index a45ea83..ee0719a 100644
--- a/setup.c
+++ b/setup.c
@@ -192,6 +192,18 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+static char *git_work_tree;
+
+static int git_work_tree_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "core.worktree")) {
+		strlcpy(git_work_tree, value, PATH_MAX);
+	}
+	return 0;
+}
+
+int inside_working_tree = -1;
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
@@ -199,21 +211,93 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	int len, offset;
 
 	/*
-	 * If GIT_DIR is set explicitly, we're not going
-	 * to do any discovery, but we still do repository
-	 * validation.
+	 * If GIT_DIR is set explicitly, we do repository validation
+	 * and check for GIT_WORK_TREE as working tree.
 	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
+		const char *gitwt;
+		char worktree[PATH_MAX+1], gitdir[PATH_MAX+1];
+		int len;
+		int wt_rel_cwd;
+
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
+		if (!is_git_directory(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository: '%s'", gitdirenv);
+		}
+
+		gitwt = getenv(GIT_WORKING_TREE_ENVIRONMENT);
+		wt_rel_cwd = (gitwt && gitwt[0] != '/');
+		/* get worktree from config */
+		if (!gitwt) {
+			wt_rel_cwd = 0;
+			worktree[0] = '\0';
+			git_work_tree = worktree;
+			git_config(git_work_tree_config);
+			git_work_tree = NULL;
+			if (worktree[0])
+				gitwt = worktree;
+		}
+		if (!gitwt)
 			return NULL;
-		if (nongit_ok) {
-			*nongit_ok = 1;
+
+		/* run getcwd in cwd, GIT_DIR and GIT_WORK_TREE */
+		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		if (chdir(gitdirenv))
+			die("Cannot change directory to '%s'", gitdirenv);
+		if (!getcwd(gitdir, sizeof(gitdir)-1) || gitdir[0] != '/')
+			die("Unable to read current working directory");
+		/* relative path from old cwd */
+		if (wt_rel_cwd && chdir(cwd))
+			die("Cannot come back to cwd");
+		if (chdir(gitwt)) {
+			if (wt_rel_cwd || gitwt[0] == '/')
+				die("Cannot change directory to working tree "
+					"'%s'", gitwt);
+			else
+				die("Cannot change directory to working tree "
+					"'%s' from $GIT_DIR", gitwt);
+		}
+		if (!getcwd(worktree, sizeof(worktree)-1) || worktree[0] != '/')
+			die("Unable to read current working directory");
+
+		len = strlen(cwd);
+		cwd[len] = '/';
+		cwd[len+1] = '\0';
+
+		len = strlen(worktree);
+		worktree[len] = '/';
+		worktree[len+1] = '\0';
+		inside_working_tree = !prefixcmp(cwd, worktree);
+
+		if (inside_working_tree) {
+			inside_git_dir = 0;
+		} else {
+			len = strlen(gitdir);
+			gitdir[len] = '/';
+			gitdir[len+1] = '\0';
+			inside_git_dir = !prefixcmp(cwd, gitdir);
+			gitdir[len] = '\0';
+		}
+
+		if (!inside_working_tree) {
+			if (chdir(cwd))
+				die("Cannot come back to cwd");
 			return NULL;
 		}
-		die("Not a git repository: '%s'", gitdirenv);
+		if (gitdirenv[0] != '/')
+			setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
+
+		len = strlen(worktree);
+		if (cwd[len] == '\0')
+			return NULL;
+		return cwd+len;
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
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
1.5.0.4.414.g32da9
