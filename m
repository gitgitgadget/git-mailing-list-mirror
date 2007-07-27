From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/8] Clean up work-tree handling
Date: Fri, 27 Jul 2007 19:56:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271956420.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:57:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEUzz-000768-BF
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXG0S5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760956AbXG0S5J
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:57:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:55922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760386AbXG0S5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:57:07 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:57:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 27 Jul 2007 20:57:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hSDN8lCThZLc/FVRa998/ZQLvO+Mvp75dLNYU08
	TwRX5jpC2hGZqb
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53942>


The old version of work-tree support was an unholy mess, barely readable,
and not to the point.

For example, why do you have to provide a worktree, when it is not used?
As in "git status".  Now it works.

Another riddle was: if you can have work trees inside the git dir, why
are some programs complaining that they need a work tree?

IOW when inside repo.git/work, where GIT_DIR points to repo.git
and GIT_WORK_TREE to work, and cwd is work, --is-inside-git-dir _must_
return true, because it is _in the git dir_, but scripts _must_ test
for the right thing.

Also, GIT_DIR=../.git should behave the same as if no GIT_DIR was
specified, unless there is a repository in the current working directory.
It does now.

In related news, a long standing bug was fixed: when in .git/bla/x.git/,
which is a bare repository, git formerly assumed ../.. to be the
appropriate git dir.  This problem was reported by Shawn Pearce to have
caused much pain, where a colleague mistakenly ran "git init" in "/" a
long time ago, and bare repositories just would not work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	Not only because of ohloh am I proud that in spite of removing
	more lines than I added, there were more comments added than
	removed...

 builtin-rev-parse.c |   12 +--
 cache.h             |    2 +
 environment.c       |   32 +++++--
 setup.c             |  270 ++++++++++++++++++++++-----------------------------
 4 files changed, 143 insertions(+), 173 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 497903a..3f787a8 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -320,15 +320,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
-				const char *pfx = prefix;
-				while (pfx) {
-					pfx = strchr(pfx, '/');
-					if (pfx) {
-						pfx++;
-						printf("../");
-					}
-				}
-				putchar('\n');
+				const char *work_tree = get_git_work_tree();
+				if (work_tree)
+					printf("%s\n", work_tree);
 				continue;
 			}
 			if (!strcmp(arg, "--git-dir")) {
diff --git a/cache.h b/cache.h
index 98af530..c0cab34 100644
--- a/cache.h
+++ b/cache.h
@@ -208,12 +208,14 @@ enum object_type {
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
+extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
+extern const char *get_git_work_tree(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index f83fb9e..cb112a4 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,10 @@ int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 
+/* This is set by setup_git_dir_gently() and/or git_default_config() */
+char *git_work_tree_cfg;
+static const char *work_tree;
+
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
@@ -62,15 +66,8 @@ static void setup_git_env(void)
 
 int is_bare_repository(void)
 {
-	const char *dir, *s;
-	if (0 <= is_bare_repository_cfg)
-		return is_bare_repository_cfg;
-
-	dir = get_git_dir();
-	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		return 0;
-	s = strrchr(dir, '/');
-	return !s || strcmp(s + 1, DEFAULT_GIT_DIR_ENVIRONMENT);
+	/* if core.bare is not 'false', let's see if there is a work tree */
+	return is_bare_repository_cfg && !get_git_work_tree();
 }
 
 const char *get_git_dir(void)
@@ -80,6 +77,23 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+const char *get_git_work_tree(void)
+{
+	static int initialized = 0;
+	if (!initialized) {
+		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
+		if (!work_tree) {
+			work_tree = git_work_tree_cfg;
+			if (work_tree && !is_absolute_path(work_tree))
+				work_tree = xstrdup(git_path(work_tree));
+		}
+		if (work_tree && !is_absolute_path(work_tree))
+			work_tree = xstrdup(make_absolute_path(work_tree));
+		initialized = 1;
+	}
+	return work_tree;
+}
+
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
diff --git a/setup.c b/setup.c
index 7b07144..0323d25 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,8 @@
 #include "cache.h"
+#include "dir.h"
+
+static int inside_git_dir = -1;
+static int inside_work_tree = -1;
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
@@ -170,100 +174,80 @@ static int is_git_directory(const char *suspect)
 	return 1;
 }
 
-static int inside_git_dir = -1;
-
 int is_inside_git_dir(void)
 {
-	if (inside_git_dir >= 0)
-		return inside_git_dir;
-	die("BUG: is_inside_git_dir called before setup_git_directory");
+	if (inside_git_dir < 0)
+		inside_git_dir = is_inside_dir(get_git_dir());
+	return inside_git_dir;
 }
 
-static int inside_work_tree = -1;
-
 int is_inside_work_tree(void)
 {
-	if (inside_git_dir >= 0)
-		return inside_work_tree;
-	die("BUG: is_inside_work_tree called before setup_git_directory");
+	if (inside_work_tree < 0)
+		inside_work_tree = is_inside_dir(get_git_work_tree());
+	return inside_work_tree;
 }
 
-static char *gitworktree_config;
-
-static int git_setup_config(const char *var, const char *value)
+/*
+ * If no worktree was given, and we are outside of a default work tree,
+ * now is the time to set it.
+ *
+ * In other words, if the user calls git with something like
+ *
+ *	git --git-dir=/some/where/else bla
+ *
+ * default to the current working directory for the work-tree root.
+ */
+const char* set_work_tree(const char *dir)
 {
-	if (!strcmp(var, "core.worktree")) {
-		if (gitworktree_config)
-			strlcpy(gitworktree_config, value, PATH_MAX);
-		return 0;
+	char dir_buffer[PATH_MAX];
+	static char buffer[PATH_MAX + 1], *rel;
+	int len, postfix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT);
+
+	len = strlen(dir);
+	if (len > postfix_len + 1 && dir[len - postfix_len - 1] == '/' &&
+			!strcmp(dir + len - postfix_len,
+				DEFAULT_GIT_DIR_ENVIRONMENT))
+		dir = strncpy(dir_buffer, dir, len - postfix_len - 1);
+
+	rel = get_relative_cwd(buffer, sizeof(buffer), dir);
+	if (rel && *rel)
+		strcat(rel, "/");
+	else {
+		rel = NULL;
+		dir = getcwd(buffer, sizeof(buffer));
 	}
-	return git_default_config(var, value);
+	git_work_tree_cfg = xstrdup(dir);
+	inside_work_tree = 1;
+
+	return rel;
 }
 
+/*
+ * We cannot decide in this function whether we are in the work tree or
+ * not, since the config can only be read _after_ this function was called.
+ */
 const char *setup_git_directory_gently(int *nongit_ok)
 {
+	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
-	char worktree[PATH_MAX+1], gitdir[PATH_MAX+1];
-	const char *gitdirenv, *gitworktree;
-	int wt_rel_gitdir = 0;
+	const char *gitdirenv;
+	int len, offset;
 
+	/*
+	 * If GIT_DIR is set explicitly, we're not going
+	 * to do any discovery, but we still do repository
+	 * validation.
+	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-	if (!gitdirenv) {
-		int len, offset;
-
-		if (!getcwd(cwd, sizeof(cwd)-1))
-			die("Unable to read current working directory");
-
-		offset = len = strlen(cwd);
-		for (;;) {
-			if (is_git_directory(".git"))
-				break;
-			if (offset == 0) {
-				offset = -1;
-				break;
-			}
-			chdir("..");
-			while (cwd[--offset] != '/')
-				; /* do nothing */
-		}
-
-		if (offset >= 0) {
-			inside_work_tree = 1;
-			git_config(git_default_config);
-			if (offset == len) {
-				inside_git_dir = 0;
-				return NULL;
-			}
-
-			cwd[len++] = '/';
-			cwd[len] = '\0';
-			inside_git_dir = !prefixcmp(cwd + offset + 1, ".git/");
-			return cwd + offset + 1;
-		}
-
-		if (chdir(cwd))
-			die("Cannot come back to cwd");
-		if (!is_git_directory(".")) {
-			if (nongit_ok) {
-				*nongit_ok = 1;
-				return NULL;
-			}
-			die("Not a git repository");
-		}
-		setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
-		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-		if (!gitdirenv)
-			die("getenv after setenv failed");
-	}
-
-	if (PATH_MAX - 40 < strlen(gitdirenv)) {
-		if (nongit_ok) {
-			*nongit_ok = 1;
+	if (gitdirenv) {
+		if (PATH_MAX - 40 < strlen(gitdirenv))
+			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
+		if (is_git_directory(gitdirenv)) {
+			if (!work_tree_env)
+				return set_work_tree(gitdirenv);
 			return NULL;
 		}
-		die("$%s too big", GIT_DIR_ENVIRONMENT);
-	}
-	if (!is_git_directory(gitdirenv)) {
 		if (nongit_ok) {
 			*nongit_ok = 1;
 			return NULL;
@@ -273,92 +257,53 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
-	if (chdir(gitdirenv)) {
-		if (nongit_ok) {
-			*nongit_ok = 1;
-			return NULL;
-		}
-		die("Cannot change directory to $%s '%s'",
-			GIT_DIR_ENVIRONMENT, gitdirenv);
-	}
-	if (!getcwd(gitdir, sizeof(gitdir)-1))
-		die("Unable to read current working directory");
-	if (chdir(cwd))
-		die("Cannot come back to cwd");
 
 	/*
-	 * In case there is a work tree we may change the directory,
-	 * therefore make GIT_DIR an absolute path.
+	 * Test in the following order (relative to the cwd):
+	 * - .git/
+	 * - ./ (bare)
+	 * - ../.git/
+	 * - ../ (bare)
+	 * - ../../.git/
+	 *   etc.
 	 */
-	if (gitdirenv[0] != '/') {
-		setenv(GIT_DIR_ENVIRONMENT, gitdir, 1);
-		gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
-		if (!gitdirenv)
-			die("getenv after setenv failed");
-		if (PATH_MAX - 40 < strlen(gitdirenv)) {
-			if (nongit_ok) {
-				*nongit_ok = 1;
-				return NULL;
-			}
-			die("$%s too big after expansion to absolute path",
-				GIT_DIR_ENVIRONMENT);
-		}
-	}
-
-	strcat(cwd, "/");
-	strcat(gitdir, "/");
-	inside_git_dir = !prefixcmp(cwd, gitdir);
-
-	gitworktree = getenv(GIT_WORK_TREE_ENVIRONMENT);
-	if (!gitworktree) {
-		gitworktree_config = worktree;
-		worktree[0] = '\0';
-	}
-	git_config(git_setup_config);
-	if (!gitworktree) {
-		gitworktree_config = NULL;
-		if (worktree[0])
-			gitworktree = worktree;
-		if (gitworktree && gitworktree[0] != '/')
-			wt_rel_gitdir = 1;
-	}
-
-	if (wt_rel_gitdir && chdir(gitdirenv))
-		die("Cannot change directory to $%s '%s'",
-			GIT_DIR_ENVIRONMENT, gitdirenv);
-	if (gitworktree && chdir(gitworktree)) {
-		if (nongit_ok) {
-			if (wt_rel_gitdir && chdir(cwd))
-				die("Cannot come back to cwd");
-			*nongit_ok = 1;
+	offset = len = strlen(cwd);
+	for (;;) {
+		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
+			break;
+		if (is_git_directory(".")) {
+			inside_git_dir = 1;
+			if (!work_tree_env)
+				inside_work_tree = 0;
+			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
 			return NULL;
 		}
-		if (wt_rel_gitdir)
-			die("Cannot change directory to working tree '%s'"
-				" from $%s", gitworktree, GIT_DIR_ENVIRONMENT);
-		else
-			die("Cannot change directory to working tree '%s'",
-				gitworktree);
-	}
-	if (!getcwd(worktree, sizeof(worktree)-1))
-		die("Unable to read current working directory");
-	strcat(worktree, "/");
-	inside_work_tree = !prefixcmp(cwd, worktree);
-
-	if (gitworktree && inside_work_tree && !prefixcmp(worktree, gitdir) &&
-	    strcmp(worktree, gitdir)) {
-		inside_git_dir = 0;
+		chdir("..");
+		do {
+			if (!offset) {
+				if (nongit_ok) {
+					if (chdir(cwd))
+						die("Cannot come back to cwd");
+					*nongit_ok = 1;
+					return NULL;
+				}
+				die("Not a git repository");
+			}
+		} while (cwd[--offset] != '/');
 	}
 
-	if (!inside_work_tree) {
-		if (chdir(cwd))
-			die("Cannot come back to cwd");
+	inside_git_dir = 0;
+	if (!work_tree_env)
+		inside_work_tree = 1;
+	git_work_tree_cfg = xstrndup(cwd, offset);
+	if (offset == len)
 		return NULL;
-	}
 
-	if (!strcmp(cwd, worktree))
-		return NULL;
-	return cwd+strlen(worktree);
+	/* Make "offset" point to past the '/', and add a '/' at the end */
+	offset++;
+	cwd[len++] = '/';
+	cwd[len] = 0;
+	return cwd + offset;
 }
 
 int git_config_perm(const char *var, const char *value)
@@ -382,11 +327,17 @@ int git_config_perm(const char *var, const char *value)
 
 int check_repository_format_version(const char *var, const char *value)
 {
-       if (strcmp(var, "core.repositoryformatversion") == 0)
-               repository_format_version = git_config_int(var, value);
+	if (strcmp(var, "core.repositoryformatversion") == 0)
+		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
-       return 0;
+	else if (strcmp(var, "core.worktree") == 0) {
+		if (git_work_tree_cfg)
+			free(git_work_tree_cfg);
+		git_work_tree_cfg = xstrdup(value);
+		inside_work_tree = -1;
+	}
+	return 0;
 }
 
 int check_repository_format(void)
@@ -402,5 +353,14 @@ const char *setup_git_directory(void)
 {
 	const char *retval = setup_git_directory_gently(NULL);
 	check_repository_format();
+
+	/* If the work tree is not the default one, recompute prefix */
+	if (inside_work_tree < 0) {
+		static char buffer[PATH_MAX + 1];
+		char *rel = get_relative_cwd(buffer, PATH_MAX,
+				get_git_work_tree());
+		return rel && *rel ? strcat(rel, "/") : NULL;
+	}
+
 	return retval;
 }
-- 
1.5.3.rc3.18.g49a1
