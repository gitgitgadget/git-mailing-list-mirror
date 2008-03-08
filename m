From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 09/11] Provide API access to init_db()
Date: Sat, 8 Mar 2008 18:04:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081804200.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY86x-0008Dx-Vm
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYCHXEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYCHXEZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:04:25 -0500
Received: from iabervon.org ([66.92.72.58]:42235 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbYCHXEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:04:23 -0500
Received: (qmail 18607 invoked by uid 1000); 8 Mar 2008 23:04:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:04:21 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76605>

The caller first calls set_git_dir() to specify the GIT_DIR, and then
calls init_db() to initialize it. This also cleans up various parts of
the code to account for the fact that everything is done with GIT_DIR
set, so it's unnecessary to pass the specified directory around.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-init-db.c |  183 +++++++++++++++++++++++++++--------------------------
 cache.h           |    4 +
 2 files changed, 98 insertions(+), 89 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 79eaf8d..4f93d03 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -104,12 +104,14 @@ static void copy_templates_1(char *path, int baselen,
 	}
 }
 
-static void copy_templates(const char *git_dir, int len, const char *template_dir)
+static void copy_templates(const char *template_dir)
 {
 	char path[PATH_MAX];
 	char template_path[PATH_MAX];
 	int template_len;
 	DIR *dir;
+	const char *git_dir = get_git_dir();
+	int len = strlen(git_dir);
 
 	if (!template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
@@ -156,6 +158,8 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	}
 
 	memcpy(path, git_dir, len);
+	if (len && path[len - 1] != '/')
+		path[len++] = '/';
 	path[len] = 0;
 	copy_templates_1(path, len,
 			 template_path, template_len,
@@ -163,8 +167,9 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	closedir(dir);
 }
 
-static int create_default_files(const char *git_dir, const char *template_path)
+static int create_default_files(const char *template_path)
 {
+	const char *git_dir = get_git_dir();
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
 	unsigned char sha1[20];
@@ -183,19 +188,15 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strcpy(path + len, "refs");
-	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/heads");
-	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/tags");
-	safe_create_dir(path, 1);
+	safe_create_dir(git_path("refs"), 1);
+	safe_create_dir(git_path("refs/heads"), 1);
+	safe_create_dir(git_path("refs/tags"), 1);
 
 	/* First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
 	 */
-	path[len] = 0;
-	copy_templates(path, len, template_path);
+	copy_templates(template_path);
 
 	git_config(git_default_config);
 
@@ -204,21 +205,16 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	 * shared-repository settings, we would need to fix them up.
 	 */
 	if (shared_repository) {
-		path[len] = 0;
-		adjust_shared_perm(path);
-		strcpy(path + len, "refs");
-		adjust_shared_perm(path);
-		strcpy(path + len, "refs/heads");
-		adjust_shared_perm(path);
-		strcpy(path + len, "refs/tags");
-		adjust_shared_perm(path);
+		adjust_shared_perm(get_git_dir());
+		adjust_shared_perm(git_path("refs"));
+		adjust_shared_perm(git_path("refs/heads"));
+		adjust_shared_perm(git_path("refs/tags"));
 	}
-
+ 
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	strcpy(path + len, "HEAD");
 	reinit = !read_ref("HEAD", sha1);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
@@ -250,8 +246,10 @@ static int create_default_files(const char *git_dir, const char *template_path)
 		/* allow template config file to override the default */
 		if (log_all_ref_updates == -1)
 		    git_config_set("core.logallrefupdates", "true");
-		if (work_tree != git_work_tree_cfg)
+		if (prefixcmp(git_dir, work_tree) ||
+		    strcmp(git_dir + strlen(work_tree), "/.git")) {
 			git_config_set("core.worktree", work_tree);
+		}
 	}
 
 	/* Check if symlink is supported in the work tree */
@@ -271,42 +269,83 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	return reinit;
 }
 
-static void guess_repository_type(const char *git_dir)
+int init_db(const char *template_dir, unsigned int flags)
+{
+	const char *sha1_dir;
+	char *path;
+	int len, reinit;
+
+	safe_create_dir(get_git_dir(), 0);
+
+	/* Check to see if the repository version is right.
+	 * Note that a newly created repository does not have
+	 * config file, so this will not fail.  What we are catching
+	 * is an attempt to reinitialize new repository with an old tool.
+	 */
+	check_repository_format();
+
+	reinit = create_default_files(template_dir);
+
+	sha1_dir = get_object_directory();
+	len = strlen(sha1_dir);
+	path = xmalloc(len + 40);
+	memcpy(path, sha1_dir, len);
+
+	safe_create_dir(sha1_dir, 1);
+	strcpy(path+len, "/pack");
+	safe_create_dir(path, 1);
+	strcpy(path+len, "/info");
+	safe_create_dir(path, 1);
+
+	if (shared_repository) {
+		char buf[10];
+		/* We do not spell "group" and such, so that
+		 * the configuration can be read by older version
+		 * of git.
+		 */
+		sprintf(buf, "%d", shared_repository);
+		git_config_set("core.sharedrepository", buf);
+		git_config_set("receive.denyNonFastforwards", "true");
+	}
+
+	if (!(flags & INIT_DB_QUIET))
+		printf("%s%s Git repository in %s/\n",
+		       reinit ? "Reinitialized existing" : "Initialized empty",
+		       shared_repository ? " shared" : "",
+		       get_git_dir());
+
+	return 0;
+}
+
+static int guess_repository_type(const char *git_dir)
 {
 	char cwd[PATH_MAX];
 	const char *slash;
 
-	if (0 <= is_bare_repository_cfg)
-		return;
-	if (!git_dir)
-		return;
-
 	/*
 	 * "GIT_DIR=. git init" is always bare.
 	 * "GIT_DIR=`pwd` git init" too.
 	 */
 	if (!strcmp(".", git_dir))
-		goto force_bare;
+		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
 		die("cannot tell cwd");
 	if (!strcmp(git_dir, cwd))
-		goto force_bare;
+		return 1;
 	/*
 	 * "GIT_DIR=.git or GIT_DIR=something/.git is usually not.
 	 */
 	if (!strcmp(git_dir, ".git"))
-		return;
+		return 0;
 	slash = strrchr(git_dir, '/');
 	if (slash && !strcmp(slash, "/.git"))
-		return;
+		return 0;
 
 	/*
 	 * Otherwise it is often bare.  At this point
 	 * we are just guessing.
 	 */
- force_bare:
-	is_bare_repository_cfg = 1;
-	return;
+	return 1;
 }
 
 static const char init_db_usage[] =
@@ -321,11 +360,9 @@ static const char init_db_usage[] =
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
-	const char *sha1_dir;
 	const char *template_dir = NULL;
-	char *path;
-	int len, i, reinit;
-	int quiet = 0;
+	unsigned int flags = 0;
+	int i;
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
@@ -336,7 +373,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		else if (!prefixcmp(arg, "--shared="))
 			shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-		        quiet = 1;
+			flags |= INIT_DB_QUIET;
 		else
 			usage(init_db_usage);
 	}
@@ -353,64 +390,32 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		    GIT_WORK_TREE_ENVIRONMENT,
 		    GIT_DIR_ENVIRONMENT);
 
-	guess_repository_type(git_dir);
-
-	if (is_bare_repository_cfg <= 0) {
-		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
-		if (!getcwd(git_work_tree_cfg, PATH_MAX))
-			die ("Cannot access current working directory.");
-		if (access(get_git_work_tree(), X_OK))
-			die ("Cannot access work tree '%s'",
-			     get_git_work_tree());
-	}
-
 	/*
 	 * Set up the default .git directory contents
 	 */
-	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-	safe_create_dir(git_dir, 0);
 
-	/* Check to see if the repository version is right.
-	 * Note that a newly created repository does not have
-	 * config file, so this will not fail.  What we are catching
-	 * is an attempt to reinitialize new repository with an old tool.
-	 */
-	check_repository_format();
-
-	reinit = create_default_files(git_dir, template_dir);
+	if (is_bare_repository_cfg < 0)
+		is_bare_repository_cfg = guess_repository_type(git_dir);
 
-	/*
-	 * And set up the object store.
-	 */
-	sha1_dir = get_object_directory();
-	len = strlen(sha1_dir);
-	path = xmalloc(len + 40);
-	memcpy(path, sha1_dir, len);
-
-	safe_create_dir(sha1_dir, 1);
-	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
-	strcpy(path+len, "/info");
-	safe_create_dir(path, 1);
-
-	if (shared_repository) {
-		char buf[10];
-		/* We do not spell "group" and such, so that
-		 * the configuration can be read by older version
-		 * of git.
-		 */
-		sprintf(buf, "%d", shared_repository);
-		git_config_set("core.sharedrepository", buf);
-		git_config_set("receive.denyNonFastforwards", "true");
+	if (!is_bare_repository_cfg) {
+		if (git_dir) {
+			const char *git_dir_parent = strrchr(git_dir, '/');
+			if (git_dir_parent)
+				git_work_tree_cfg = strdup(make_absolute_path(xstrndup(git_dir, git_dir_parent - git_dir)));
+		}
+		if (!git_work_tree_cfg) {
+			git_work_tree_cfg = xcalloc(PATH_MAX, 1);
+			if (!getcwd(git_work_tree_cfg, PATH_MAX))
+				die ("Cannot access current working directory.");
+		}
+		if (access(get_git_work_tree(), X_OK))
+			die ("Cannot access work tree '%s'",
+			     get_git_work_tree());
 	}
 
-	if (!quiet)
-		printf("%s%s Git repository in %s/\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
-		       git_dir);
+	set_git_dir(make_absolute_path(git_dir));
 
-	return 0;
+	return init_db(template_dir, flags);
 }
diff --git a/cache.h b/cache.h
index 32e8746..59805b8 100644
--- a/cache.h
+++ b/cache.h
@@ -324,6 +324,10 @@ extern const char *prefix_filename(const char *prefix, int len, const char *path
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
 
+#define INIT_DB_QUIET 0x0001
+
+extern int init_db(const char *template_dir, unsigned int flags);
+
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /*
-- 
1.5.4.3.327.g614d7.dirty

