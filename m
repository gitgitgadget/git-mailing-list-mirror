From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] init-db: check template and repository format.
Date: Fri, 25 Nov 2005 17:15:13 -0800
Message-ID: <7v7jawgqfy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 26 02:16:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efof1-0004aa-J1
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 02:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVKZBPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 20:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbVKZBPS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 20:15:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25527 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932418AbVKZBPP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 20:15:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126011411.VYK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 25 Nov 2005 20:14:11 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12760>

This makes init-db repository version aware.

It checks if an existing config file says the repository being
reinitialized is of a wrong version and aborts before doing
further harm.

When copying the templates, it makes sure the they are of the
right repository format version.  Otherwise the templates are
ignored with an warning message.

It copies the templates before creating the HEAD, and if the
config file is copied from the template directory, reads it,
primarily to pick up the value of core.symrefsonly.

It changes the way the result of the filemode reliability test
is written to the configuration file using git_config_set().
The test is done even if the config file was copied from the
templates.

And finally, our own repository format version is written to the
config file.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 cache.h   |    1 +
 config.c  |   16 ++++++++---
 init-db.c |   89 +++++++++++++++++++++++++++++++++++--------------------------
 3 files changed, 64 insertions(+), 42 deletions(-)

applies-to: 3478f0c15277931430f7db669a8004da52c1a887
654494dfddb135db6187a3f00917e24c1dbcd569
diff --git a/cache.h b/cache.h
index de53f41..61bf884 100644
--- a/cache.h
+++ b/cache.h
@@ -387,6 +387,7 @@ extern int gitfakemunmap(void *start, si
 
 typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
+extern int git_config_from_file(config_fn_t fn, const char *);
 extern int git_config(config_fn_t fn);
 extern int git_config_int(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
diff --git a/config.c b/config.c
index 5cc8535..0c43d76 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #define MAXNAME (256)
 
 static FILE *config_file;
+static char *config_file_name;
 static int config_linenr;
 static int get_next_char(void)
 {
@@ -186,7 +187,7 @@ static int git_parse_file(config_fn_t fn
 		if (get_value(fn, var, baselen+1) < 0)
 			break;
 	}
-	die("bad config file line %d", config_linenr);
+	die("bad config file line %d in %s", config_linenr, config_file_name);
 }
 
 int git_config_int(const char *name, const char *value)
@@ -197,7 +198,7 @@ int git_config_int(const char *name, con
 		if (!*end)
 			return val;
 	}
-	die("bad config value for '%s'", name);
+	die("bad config value for '%s' in %s", name, config_file_name);
 }
 
 int git_config_bool(const char *name, const char *value)
@@ -240,21 +241,28 @@ int git_default_config(const char *var, 
 	return 0;
 }
 
-int git_config(config_fn_t fn)
+int git_config_from_file(config_fn_t fn, const char *filename)
 {
 	int ret;
-	FILE *f = fopen(git_path("config"), "r");
+	FILE *f = fopen(filename, "r");
 
 	ret = -1;
 	if (f) {
 		config_file = f;
+		config_file_name = filename;
 		config_linenr = 1;
 		ret = git_parse_file(fn);
 		fclose(f);
+		config_file_name = NULL;
 	}
 	return ret;
 }
 
+int git_config(config_fn_t fn)
+{
+	return git_config_from_file(fn, git_path("config"));
+}
+
 /*
  * Find all the stuff for git_config_set() below.
  */
diff --git a/init-db.c b/init-db.c
index bd88291..8195b68 100644
--- a/init-db.c
+++ b/init-db.c
@@ -132,6 +132,23 @@ static void copy_templates(const char *g
 		return;
 	}
 
+	/* Make sure that template is from the correct vintage */
+	strcpy(template_path + template_len, "config");
+	repository_format_version = 0;
+	git_config_from_file(check_repository_format_version,
+			     template_path);
+	template_path[template_len] = 0;
+
+	if (repository_format_version &&
+	    repository_format_version != GIT_REPO_VERSION) {
+		fprintf(stderr, "warning: not copying templates of "
+			"a wrong format version %d from '%s'\n",
+			repository_format_version,
+			template_dir);
+		closedir(dir);
+		return;
+	}
+
 	memcpy(path, git_dir, len);
 	path[len] = 0;
 	copy_templates_1(path, len,
@@ -140,12 +157,13 @@ static void copy_templates(const char *g
 	closedir(dir);
 }
 
-static void create_default_files(const char *git_dir,
-				 char *template_path)
+static void create_default_files(const char *git_dir, char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
 	unsigned char sha1[20];
+	struct stat st1;
+	char repo_version_string[10];
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -164,6 +182,15 @@ static void create_default_files(const c
 	strcpy(path + len, "refs/tags");
 	safe_create_dir(path);
 
+	/* First copy the templates -- we might have the default
+	 * config file there, in which case we would want to read
+	 * from it after installing.
+	 */
+	path[len] = 0;
+	copy_templates(path, len, template_path);
+
+	git_config(git_default_config);
+
 	/*
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
@@ -173,44 +200,22 @@ static void create_default_files(const c
 		if (create_symref(path, "refs/heads/master") < 0)
 			exit(1);
 	}
-	path[len] = 0;
-	copy_templates(path, len, template_path);
 
-	/*
-	 * Find out if we can trust the executable bit.
-	 */
-	safe_create_dir(path);
+	/* This forces creation of new config file */
+	sprintf(repo_version_string, "%d", GIT_REPO_VERSION);
+	git_config_set("core.repositoryformatversion", repo_version_string);
+
+	path[len] = 0;
 	strcpy(path + len, "config");
-	if (access(path, R_OK) < 0) {
-		static const char contents[] =
-			"#\n"
-			"# This is the config file\n"
-			"#\n"
-			"\n"
-			"; core variables\n"
-			"[core]\n"
-			"	; Don't trust file modes\n"
-			"	filemode = false\n"
-			"\n";
-		FILE *config = fopen(path, "w");
-		struct stat st;
-
-		if (!config)
-			die("Can not write to %s?", path);
-
-		fwrite(contents, sizeof(contents)-1, 1, config);
-
-		fclose(config);
-
-		if (!lstat(path, &st)) {
-			struct stat st2;
-			if (!chmod(path, st.st_mode ^ S_IXUSR) &&
-					!lstat(path, &st2) &&
-					st.st_mode != st2.st_mode)
-				unlink(path);
-			else
-				fprintf(stderr, "Ignoring file modes\n");
-		}
+
+	/* Check filemode trustability */
+	if (!lstat(path, &st1)) {
+		struct stat st2;
+		int filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+				!lstat(path, &st2) &&
+				st1.st_mode != st2.st_mode);
+		git_config_set("core.filemode",
+			       filemode ? "true" : "false");
 	}
 }
 
@@ -249,6 +254,14 @@ int main(int argc, char **argv)
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	safe_create_dir(git_dir);
+
+	/* Check to see if the repository version is right.
+	 * Note that a newly created repository does not have
+	 * config file, so this will not fail.  What we are catching
+	 * is an attempt to reinitialize new repository with an old tool.
+	 */
+	check_repository_format();
+
 	create_default_files(git_dir, template_dir);
 
 	/*
---
0.99.9.GIT
