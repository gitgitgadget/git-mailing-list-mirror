From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 05:32:50 +0100
Message-ID: <20070311043250.GA21331@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:34:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFl9-00009r-6r
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbXCKEc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933100AbXCKEc4
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:32:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933101AbXCKEcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:32:54 -0500
Received: (qmail invoked by alias); 11 Mar 2007 04:32:52 -0000
Received: from pD9EB9C1C.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.156.28]
  by mail.gmx.net (mp009) with SMTP; 11 Mar 2007 05:32:52 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+TIfRV42eTmf2ztOky79CmDEt2w3aw8v1OSF01po
	bnZb6BRQAh2Gzv
Mail-Followup-To: git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41902>

This environment variable can be used with GIT_DIR to
specify the toplevel working directory.  When GIT_DIR is not
set this variable is ignored.  As for GIT_DIR there is also
the option git --work-dir which overrides the environment
variable.
---
Missing:
Documentation update but if this feature should not get accepted..
therefore I'll wait for feedback first.

Idea:
Add some way to configure tho working directory for one repository
and set GIT_WORK_DIR automatically when GIT_DIR is used.  I think of:
 * a subdirectory in the repository directory
   e.g. .git/work_dir which is supposed to be a symlink (or a textfile
   containing the path for windows compatibility?)
or
 * a configuration variable

Considerations:
Without running setup_git_directory_gently is_bare_repository and
is_inside_git_dir may return wrong values.  Except for cmd_init_db I
found no place calling on of the functions without calling
setup_git_directory_gently before.

To do:
git init should probably set bare = false when GIT_WORK_DIR is
exported.  And if the idea about configurable working directories gets
implemented it could also set this option accordingly.

---
 cache.h       |    2 +
 environment.c |    2 +
 git.c         |   12 +++++++++-
 setup.c       |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index ae25759..042734c 100644
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
index 0151ad0..5c30c9b 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,8 @@ int is_bare_repository(void)
 	const char *dir, *s;
 	if (0 <= is_bare_repository_cfg)
 		return is_bare_repository_cfg;
+	if (0 <= has_working_directory)
+		return !has_working_directory;
 
 	dir = get_git_dir();
 	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
diff --git a/git.c b/git.c
index 04fc99a..3cf7ce2 100644
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
index dda67d2..7f5d73b 100644
--- a/setup.c
+++ b/setup.c
@@ -192,6 +192,8 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
+int has_working_directory = -1;
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static char cwd[PATH_MAX+1];
@@ -205,15 +207,73 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
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
+		gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
+		if (!gitwd || stat(gitwd, &st_work))
 			return NULL;
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
 
 	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
-- 
1.5.0.3
