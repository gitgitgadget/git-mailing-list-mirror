From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] Clean up work-tree handling
Date: Wed, 1 Aug 2007 01:30:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010129530.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Wed Aug 01 02:30:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG26t-0005Nn-7m
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbXHAAak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbXHAAak
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:30:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:56591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755590AbXHAAai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:30:38 -0400
Received: (qmail invoked by alias); 01 Aug 2007 00:30:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 01 Aug 2007 02:30:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+h0q0Y+3qhWmuIMHb0LUPiknCZOMc80qDPmr5CMX
	4BcjcjVQbD1KOC
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708010058130.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54388>


The old version of work-tree support was an unholy mess, barely readable,
and not to the point.

For example, why do you have to provide a worktree, when it is not used?
As in "git status".  Now it works.

Another riddle was: if you can have work trees inside the git dir, why
are some programs complaining that they need a work tree?

IOW it is allowed to call

	$ git --git-dir=../ --work-tree=. bla

when you really want to.  In this case, you are both in the git directory
and in the working tree.  So, programs have to actually test for the right
thing, namely if they are inside a working tree, and not if they are
inside a git directory.

Also, GIT_DIR=../.git should behave the same as if no GIT_DIR was
specified, unless there is a repository in the current working directory.
It does now.

The logic to determine if a repository is bare, or has a work tree
(tertium non datur), is this:

--work-tree=bla overrides GIT_WORK_TREE, which overrides core.bare = true,
which overrides core.worktree, which overrides GIT_DIR/.. when GIT_DIR
ends in /.git, which overrides the directory in which .git/ was found.

In related news, a long standing bug was fixed: when in .git/bla/x.git/,
which is a bare repository, git formerly assumed ../.. to be the
appropriate git dir.  This problem was reported by Shawn Pearce to have
caused much pain, where a colleague mistakenly ran "git init" in "/" a
long time ago, and bare repositories just would not work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-init-db.c    |   48 ++-------
 builtin-ls-files.c   |    8 +-
 builtin-rev-parse.c  |    7 ++
 cache.h              |    2 +
 environment.c        |   35 +++++--
 git-sh-setup.sh      |    3 +-
 git.c                |   11 ++-
 setup.c              |  279 +++++++++++++++++++++++---------------------------
 t/t1500-rev-parse.sh |   20 ++--
 t/t1501-worktree.sh  |   24 ++++-
 10 files changed, 216 insertions(+), 221 deletions(-)

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
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 61577ea..d36181a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -469,9 +469,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (require_work_tree &&
-			(!is_inside_work_tree() || is_inside_git_dir()))
-		die("This operation must be run in a work tree");
+	if (require_work_tree && !is_inside_work_tree()) {
+		const char *work_tree = get_git_work_tree();
+		if (!work_tree || chdir(work_tree))
+			die("This operation must be run in a work tree");
+	}
 
 	pathspec = get_pathspec(prefix, argv + i);
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 497903a..15bdb72 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -320,6 +320,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-cdup")) {
+				if (!is_inside_work_tree()) {
+					const char *work_tree =
+						get_git_work_tree();
+					if (work_tree)
+						printf("%s\n", work_tree);
+					continue;
+				}
 				const char *pfx = prefix;
 				while (pfx) {
 					pfx = strchr(pfx, '/');
diff --git a/cache.h b/cache.h
index e1f94cb..e97af18 100644
--- a/cache.h
+++ b/cache.h
@@ -208,6 +208,7 @@ enum object_type {
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
+extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
@@ -215,6 +216,7 @@ extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern const char *get_git_work_tree(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index a571fae..2af12fd 100644
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
@@ -80,6 +77,26 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
+const char *get_git_work_tree(void)
+{
+	static int initialized = 0;
+	if (!initialized) {
+		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
+		/* core.bare = true overrides implicit and config work tree */
+		if (!work_tree && is_bare_repository_cfg < 1) {
+			work_tree = git_work_tree_cfg;
+			/* make_absolute_path also normalizes the path */
+			if (work_tree && !is_absolute_path(work_tree))
+				work_tree = xstrdup(make_absolute_path(git_path(work_tree)));
+		} else if (work_tree)
+			work_tree = xstrdup(make_absolute_path(work_tree));
+		initialized = 1;
+		if (work_tree)
+			is_bare_repository_cfg = 0;
+	}
+	return work_tree;
+}
+
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c51985e..7bef43f 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -59,8 +59,7 @@ cd_to_toplevel () {
 }
 
 require_work_tree () {
-	test $(git rev-parse --is-inside-work-tree) = true &&
-	test $(git rev-parse --is-inside-git-dir) = false ||
+	test $(git rev-parse --is-inside-work-tree) = true ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 
diff --git a/git.c b/git.c
index a647f9c..2433355 100644
--- a/git.c
+++ b/git.c
@@ -272,9 +272,14 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 		prefix = setup_git_directory();
 	if (p->option & USE_PAGER)
 		setup_pager();
-	if ((p->option & NEED_WORK_TREE) &&
-	    (!is_inside_work_tree() || is_inside_git_dir()))
-		die("%s must be run in a work tree", p->cmd);
+	if (p->option & NEED_WORK_TREE) {
+		const char *work_tree = get_git_work_tree();
+		const char *git_dir = get_git_dir();
+		if (!is_absolute_path(git_dir))
+			set_git_dir(make_absolute_path(git_dir));
+		if (!work_tree || chdir(work_tree))
+			die("%s must be run in a work tree", p->cmd);
+	}
 	trace_argv_printf(argv, argc, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
diff --git a/setup.c b/setup.c
index b54d65f..8237fe3 100644
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
@@ -170,100 +174,89 @@ static int is_git_directory(const char *suspect)
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
+ *	git --git-dir=/some/where/else/.git bla
+ *
+ * default to /some/where/else as working directory; if the specified
+ * git-dir does not end in "/.git", the cwd is used as working directory.
+ */
+const char* set_work_tree(const char *dir)
 {
-	if (!strcmp(var, "core.worktree")) {
-		if (gitworktree_config)
-			strlcpy(gitworktree_config, value, PATH_MAX);
-		return 0;
+	char dir_buffer[PATH_MAX];
+	static char buffer[PATH_MAX + 1], *rel = NULL;
+	int len, postfix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
+
+	/* strip the variable 'dir' of the postfix "/.git" if it has it */
+	len = strlen(dir);
+	if (len > postfix_len && !strcmp(dir + len - postfix_len,
+				"/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
+			strncpy(dir_buffer, dir, len - postfix_len);
+
+		/* are we inside the default work tree? */
+		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
+	}
+	/* if rel is set, the cwd is _not_ the current working tree */
+	if (rel && *rel) {
+		if (!is_absolute_path(dir))
+			set_git_dir(make_absolute_path(dir));
+		dir = dir_buffer;
+		chdir(dir);
+		strcat(rel, "/");
+		inside_git_dir = 0;
+	} else {
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
@@ -273,92 +266,53 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
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
@@ -386,6 +340,16 @@ int check_repository_format_version(const char *var, const char *value)
 		repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
+	else if (strcmp(var, "core.bare") == 0) {
+		is_bare_repository_cfg = git_config_bool(var, value);
+		if (is_bare_repository_cfg == 1)
+			inside_work_tree = -1;
+	} else if (strcmp(var, "core.worktree") == 0) {
+		if (git_work_tree_cfg)
+			free(git_work_tree_cfg);
+		git_work_tree_cfg = xstrdup(value);
+		inside_work_tree = -1;
+	}
 	return 0;
 }
 
@@ -402,5 +366,16 @@ const char *setup_git_directory(void)
 {
 	const char *retval = setup_git_directory_gently(NULL);
 	check_repository_format();
+
+	/* If the work tree is not the default one, recompute prefix */
+	if (inside_work_tree < 0) {
+		static char buffer[PATH_MAX + 1];
+		if (retval && chdir(retval))
+			die ("Could not jump back into original cwd");
+		char *rel = get_relative_cwd(buffer, PATH_MAX,
+				get_git_work_tree());
+		return rel && *rel ? strcat(rel, "/") : NULL;
+	}
+
 	return retval;
 }
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index ec49966..bea40cb 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -31,9 +31,9 @@ test_rev_parse() {
 test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
-test_rev_parse .git/ false true true .git/
+test_rev_parse .git/ true true false ''
 cd objects || exit 1
-test_rev_parse .git/objects/ false true true .git/objects/
+test_rev_parse .git/objects/ true true false ''
 cd ../.. || exit 1
 
 mkdir -p sub/dir || exit 1
@@ -42,7 +42,7 @@ test_rev_parse subdirectory false false true sub/dir/
 cd ../.. || exit 1
 
 git config core.bare true
-test_rev_parse 'core.bare = true' true false true
+test_rev_parse 'core.bare = true' true false false
 
 git config --unset core.bare
 test_rev_parse 'core.bare undefined' false false true
@@ -50,28 +50,28 @@ test_rev_parse 'core.bare undefined' false false true
 mkdir work || exit 1
 cd work || exit 1
 export GIT_DIR=../.git
-export GIT_CONFIG="$GIT_DIR"/config
+export GIT_CONFIG="$(pwd)"/../.git/config
 
 git config core.bare false
-test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = false' false false true work/
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
+test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true work/
 
 mv ../.git ../repo.git || exit 1
 export GIT_DIR=../repo.git
-export GIT_CONFIG="$GIT_DIR"/config
+export GIT_CONFIG="$(pwd)"/../repo.git/config
 
 git config core.bare false
 test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
 git config core.bare true
-test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 
 git config --unset core.bare
-test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' true false true ''
+test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
 test_done
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index aadeeab..7322161 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -33,17 +33,17 @@ mv .git repo.git || exit 1
 
 say "core.worktree = relative path"
 export GIT_DIR=repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 unset GIT_WORK_TREE
 git config core.worktree ../work
 test_rev_parse 'outside'      false false false
 cd work || exit 1
 export GIT_DIR=../repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
 export GIT_DIR=../../../repo.git
-export GIT_CONFIG=$GIT_DIR/config
+export GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
@@ -84,9 +84,23 @@ test_rev_parse 'in repo.git'              false true  false
 cd objects || exit 1
 test_rev_parse 'in repo.git/objects'      false true  false
 cd ../work || exit 1
-test_rev_parse 'in repo.git/work'         false false true ''
+test_rev_parse 'in repo.git/work'         false true true ''
 cd sub/dir || exit 1
-test_rev_parse 'in repo.git/sub/dir' false false true sub/dir/
+test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
 cd ../../../.. || exit 1
 
+test_expect_success 'repo finds its work tree' '
+	(cd repo.git &&
+	 : > work/sub/dir/untracked &&
+	 test sub/dir/untracked = "$(git ls-files --others)")
+'
+
+test_expect_success 'repo finds its work tree from work tree, too' '
+	(cd repo.git/work/sub/dir &&
+	 : > tracked &&
+	 git --git-dir=../../.. add tracked &&
+	 cd ../../.. &&
+	 test sub/dir/tracked = "$(git ls-files)")
+'
+
 test_done
-- 
1.5.3.rc3.94.g3024
