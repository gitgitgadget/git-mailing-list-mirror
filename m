From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Sat, 24 Dec 2005 04:20:16 -0800
Message-ID: <20051224122016.GD3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:20:31 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8Nz-0001cJ-DG
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVLXMUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVLXMUS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:20:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:28035 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932515AbVLXMUR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:20:17 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 80C367DC005; Sat, 24 Dec 2005 04:20:16 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14023>

strcpy_user_path(dest,src) acts just like strcpy() except tildes
in src are expanded appropriately to point to a user's home
directory.

The following expansions are supported:

~user/path	reads home directory from getpwnam()
~/path	 	reads home directory from $HOME env,
		or getpwuid() if $HOME is not set

This patch makes it easier for an ordinary user to share compiled
binaries across different machines, especially if they have different
account names and home directories on those machines.

Hint: build git with: make 'prefix=~'

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 cache.h   |    1 +
 git.c     |    6 ++++++
 init-db.c |    3 ++-
 path.c    |   41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletions(-)

c46a17b746572e6d16aa026de50d7911eddf8664
diff --git a/cache.h b/cache.h
index c5ff4b7..041bf94 100644
--- a/cache.h
+++ b/cache.h
@@ -184,6 +184,7 @@ extern const unsigned char null_sha1[20]
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+char * strcpy_user_path(char *dest, const char *path);
 int safe_create_leading_directories(char *path);
 char *safe_strncpy(char *, const char *, size_t);
 char *enter_repo(char *path, int strict);
diff --git a/git.c b/git.c
index 434a3d9..15f4c69 100644
--- a/git.c
+++ b/git.c
@@ -12,6 +12,8 @@
 #include <termios.h>
 #include "git-compat-util.h"
 
+extern char * strcpy_user_path(char *dest, const char *path);
+
 #ifndef PATH_MAX
 # define PATH_MAX 4096
 #endif
@@ -234,6 +236,7 @@ int main(int argc, char **argv, char **e
 {
 	char git_command[PATH_MAX + 1];
 	char wd[PATH_MAX + 1];
+	char tmp[PATH_MAX + 1];
 	int i, len, show_help = 0;
 	char *exec_path = getenv("GIT_EXEC_PATH");
 
@@ -269,6 +272,9 @@ int main(int argc, char **argv, char **e
 			cmd_usage(NULL, NULL);
 	}
 
+	strcpy_user_path(tmp, exec_path);
+	exec_path = tmp;
+
 	if (i >= argc || show_help) {
 		if (i >= argc)
 			cmd_usage(exec_path, NULL);
diff --git a/init-db.c b/init-db.c
index ead37b5..468c93a 100644
--- a/init-db.c
+++ b/init-db.c
@@ -119,7 +119,8 @@ static void copy_templates(const char *g
 
 	if (!template_dir)
 		template_dir = DEFAULT_GIT_TEMPLATE_DIR;
-	strcpy(template_path, template_dir);
+	strcpy_user_path(template_path, template_dir);
+	
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
 		template_path[template_len++] = '/';
diff --git a/path.c b/path.c
index 334b2bd..3caa188 100644
--- a/path.c
+++ b/path.c
@@ -131,6 +131,47 @@ int validate_symref(const char *path)
 	return -1;
 }
 
+char * strcpy_user_path(char *dest, const char *path)
+{
+	if (path[0] == '~') {
+		struct passwd *pw;
+
+		if (path[1] == '/' || path[1] == '\0') {
+			char *home;
+			
+			if (!(home = getenv("HOME"))) {
+				pw = getpwuid(getuid());
+				if (pw && pw->pw_dir)
+					home = pw->pw_dir;
+			}
+				
+			strcpy(dest, home);
+			
+			if (path[1] == '/')
+				strcat(dest, path + 1);
+		} else {
+			char *slash;
+			
+			if ((slash = strchr(path,'/'))) {
+				memcpy(pathname, path + 1, slash - path - 1);
+				pathname[slash - path] = '\0';
+				pw = getpwnam(pathname);
+			} else
+				pw = getpwnam(path + 1);
+
+			if (pw && pw->pw_dir) {
+				strcpy(dest, pw->pw_dir);
+				if (slash)
+					strcat(dest,slash);
+			} else
+				strcpy(dest, path);
+		}
+	} else
+		strcpy(dest, path);
+
+	return dest;
+}
+
 static char *user_path(char *buf, char *path, int sz)
 {
 	struct passwd *pw;
-- 
1.0.GIT
