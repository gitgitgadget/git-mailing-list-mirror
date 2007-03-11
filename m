From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH(amend)] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 16:56:49 +0100
Message-ID: <20070311155649.GA29663@moooo.ath.cx>
References: <20070311043250.GA21331@moooo.ath.cx> <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 16:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQPr-0005fS-L0
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 16:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933790AbXCKP4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933782AbXCKP4y
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:56:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:56671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933790AbXCKP4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:56:53 -0400
Received: (qmail invoked by alias); 11 Mar 2007 15:56:51 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp019) with SMTP; 11 Mar 2007 16:56:51 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19R3mYpvsNR1miSBbUS+9eSUywvScOBP0gGplZjfW
	++83lMboxi9yup
Mail-Followup-To: git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41934>

This environment variable can be used with GIT_DIR to
specify the toplevel working directory.  When GIT_DIR is not
set this variable is ignored.  As for GIT_DIR there is also
the option git --work-dir which overrides the environment
variable.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
New patch, this should go with the 'rev-parse --is-bare-repository
option' patch.

Documentation added, is_bare_repository check fixed, relative GIT_DIR
fix.  Becaus GIT_DIR is expanded to a full path setup_git_env should
be called after setup_git_directory_gently.  I searched for the
callers of setup_git_directory_gently and think this is fulfilled.

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I propose the following instead of the last two lines:
> 
>                if (!gitwd)
>                        return NULL;
>                if (stat(gitwd, &st_work))
>                        die("Unable to stat git working directory %s",gitwd);
It's in this new patch.

> If cwd changed and GIT_DIR is a relative path, git can no longer
> access GIT_DIR properly.
This too.
---
 Documentation/git.txt |   16 ++++++++-
 cache.h               |    2 +
 environment.c         |   11 +++++-
 git.c                 |   12 ++++++-
 setup.c               |   92 +++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 119 insertions(+), 14 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e875e83..d2f5d27 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
-    [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=GIT_DIR] [--work-dir=GIT_WORK_DIR]
+    [--help] COMMAND [ARGS]
 
 DESCRIPTION
 -----------
@@ -81,6 +82,13 @@ OPTIONS
 	Set the path to the repository. This can also be controlled by
 	setting the GIT_DIR environment variable.
 
+--work-dir=<path>::
+	Set the path to the toplevel working directory.  The value will
+	be used only in combination with $GIT_DIR or '--git-dir'.
+	Without this option git will assume that the current directory
+	is also the toplevel directory.  This can also be controlled by
+	setting the GIT_WORK_DIR environment variable.
+
 --bare::
 	Same as --git-dir=`pwd`.
 
@@ -325,6 +333,12 @@ git so take care if using Cogito etc.
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
 
+'GIT_WORK_DIR'::
+	Set the path to the toplevel working directory.  The value will
+	be used only in combination with $GIT_DIR or '--git-dir'.
+	Without this environment variable git will assume that the
+	current directory is also the toplevel directory.
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index f172d02..e3ca087 100644
--- a/cache.h
+++ b/cache.h
@@ -144,6 +144,7 @@ enum object_type {
 };
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
+#define GIT_WORKING_DIR_ENVIRONMENT "GIT_WORK_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
@@ -164,6 +165,7 @@ extern char *get_graft_file(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
+extern int has_working_directory;
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
diff --git a/environment.c b/environment.c
index 0151ad0..7bf6a87 100644
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
+	/* GIT_WORK_DIR is set, bare if cwd is outside */
+	if (has_working_directory >= 0)
+		return !has_working_directory;
+	/* configuration says it is not bare */
+	if (is_bare_repository_cfg == 0)
+		return 0;
 
 	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
diff --git a/git.c b/git.c
index fe2b74a..8a73648 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--work-dir=GIT_WORK_DIR] [--help] COMMAND [ARGS]";
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -68,6 +68,16 @@ static int handle_options(const char*** argv, int* argc)
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+		} else if (!strcmp(cmd, "--work-dir")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --work-dir.\n" );
+				usage(git_usage_string);
+			}
+			setenv(GIT_WORKING_DIR_ENVIRONMENT, (*argv)[1], 1);
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--work-dir=")) {
+			setenv(GIT_WORKING_DIR_ENVIRONMENT, cmd + 11, 1);
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
diff --git a/setup.c b/setup.c
index a45ea83..ebf628e 100644
--- a/setup.c
+++ b/setup.c
@@ -192,28 +192,100 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+int has_working_directory = -1;
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	int len, offset;
 
-	/*
-	 * If GIT_DIR is set explicitly, we're not going
-	 * to do any discovery, but we still do repository
-	 * validation.
-	 */
 	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 	if (gitdirenv) {
+		struct stat st, st_work, st_git;
+		const char *gitwd;
+		char *prefix;
+		char c;
+		int len;
+
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
-		if (is_git_directory(gitdirenv))
-			return NULL;
-		if (nongit_ok) {
-			*nongit_ok = 1;
+		if (!is_git_directory(gitdirenv)) {
+			if (nongit_ok) {
+				*nongit_ok = 1;
+				return NULL;
+			}
+			die("Not a git repository: '%s'", gitdirenv);
+		}
+
+		/* check for working directory */
+		gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+		if (!gitwd)
 			return NULL;
+		if (stat(gitwd, &st_work))
+			die("Unable to stat git working directory '%s'", gitwd);
+		if (inside_git_dir == -1 && stat(gitdirenv, &st_git))
+			die("Unable to stat git directory");
+		if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
+			die("Unable to read current working directory");
+		len = strlen(cwd);
+
+		prefix = cwd+len;
+		for (;;) {
+			c = *prefix;
+			*prefix = '\0';
+			if (stat(cwd, &st))
+				die("Unable to stat '%s'", cwd);
+			if (st_work.st_dev == st.st_dev &&
+			    st_work.st_ino == st.st_ino)
+				break;
+			if (inside_git_dir == -1 &&
+			    st_git.st_dev == st.st_dev &&
+			    st_git.st_ino == st.st_ino)
+				inside_git_dir = 1;
+			*prefix = c;
+
+			if (prefix == cwd+1) {
+				has_working_directory = 0;
+				return NULL;
+			}
+			while (*(--prefix) != '/')
+				; /* do nothing */
+			if (prefix == cwd)
+				prefix++;
+		}
+
+		/*
+		 * if GIT_DIR is no absolute path it wont work anymore after
+		 * changing the directory, therefore expand it to an absolute
+		 * path
+		 */
+		if (gitdirenv[0] != '/') {
+			char buf[PATH_MAX];
+			if (chdir(gitdirenv))
+				die("Cannot change directory to '%s'",
+				    gitdirenv);
+			if (!getcwd(buf, sizeof(buf)) || buf[0] != '/')
+				die("Unable to read current working directory");
+			setenv(GIT_DIR_ENVIRONMENT, buf, 1);
+		}
+		if (chdir(cwd))
+			die("Cannot change directory to '%s'", cwd);
+
+		if (c) {
+			*prefix = c;
+			prefix++;
+			cwd[len] = '/';
+			cwd[len+1] = '\0';
+		} else {
+			prefix = NULL;
 		}
-		die("Not a git repository: '%s'", gitdirenv);
+
+		has_working_directory = 1;
+		if (inside_git_dir == -1)
+			inside_git_dir = 0;
+
+		return prefix;
 	}
 
 	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
-- 
1.5.0.3.356.gafc9e-dirty
