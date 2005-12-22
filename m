From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-init-db: initialize shared repositories with --shared
Date: Thu, 22 Dec 2005 23:19:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222318570.12217@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 23:19:50 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpYmj-00033x-NX
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVLVWTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbVLVWTj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:19:39 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:6588 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030347AbVLVWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:19:38 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AB80CDFA12; Thu, 22 Dec 2005 23:19:37 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8BA879E3E3; Thu, 22 Dec 2005 23:19:37 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C22A9E3A1; Thu, 22 Dec 2005 23:19:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54E75DFA12; Thu, 22 Dec 2005 23:19:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13974>


Now you can say

	git-init-db --shared

if you want other users to be able to push into that repository.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	So, I lied in my last message. This patch actually changes the
	modes of the $GIT_DIR/{objects,objects/pack,refs,refs/heads,
	refs/tags} directories.

	I just forgot to commit this before sending the patch :-(

 cache.h     |    1 +
 init-db.c   |   36 ++++++++++++++++++++++++++----------
 sha1_file.c |    2 +-
 3 files changed, 28 insertions(+), 11 deletions(-)

e60956946509622bda221cea567f841568f4cd20
diff --git a/cache.h b/cache.h
index 0f875dd..63acc72 100644
--- a/cache.h
+++ b/cache.h
@@ -184,6 +184,7 @@ extern const unsigned char null_sha1[20]
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
+int make_group_writable(const char *path);
 int safe_create_leading_directories(char *path);
 char *safe_strncpy(char *, const char *, size_t);
 char *enter_repo(char *path, int strict);
diff --git a/init-db.c b/init-db.c
index c58b92d..b66b5cd 100644
--- a/init-db.c
+++ b/init-db.c
@@ -9,7 +9,7 @@
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
 #endif
 
-static void safe_create_dir(const char *dir)
+static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
 		if (errno != EEXIST) {
@@ -17,6 +17,11 @@ static void safe_create_dir(const char *
 			exit(1);
 		}
 	}
+
+	if (shared_repository && share && make_group_writable(dir)) {
+		fprintf(stderr, "Could not make %s writable by group\n", dir);
+		exit(2);
+	}
 }
 
 static int copy_file(const char *dst, const char *src, int mode)
@@ -32,6 +37,11 @@ static int copy_file(const char *dst, co
 	}
 	status = copy_fd(fdi, fdo);
 	close(fdo);
+
+	if (shared_repository && !status && (mode & 0200) &&
+			make_group_writable(dst))
+		return -1;
+
 	return status;
 }
 
@@ -48,7 +58,7 @@ static void copy_templates_1(char *path,
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
 	 */
-	safe_create_dir(path);
+	safe_create_dir(path, 0);
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st_git, st_template;
 		int namelen;
@@ -176,11 +186,11 @@ static void create_default_files(const c
 	 * Create .git/refs/{heads,tags}
 	 */
 	strcpy(path + len, "refs");
-	safe_create_dir(path);
+	safe_create_dir(path, 1);
 	strcpy(path + len, "refs/heads");
-	safe_create_dir(path);
+	safe_create_dir(path, 1);
 	strcpy(path + len, "refs/tags");
-	safe_create_dir(path);
+	safe_create_dir(path, 1);
 
 	/* First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
@@ -220,7 +230,7 @@ static void create_default_files(const c
 }
 
 static const char init_db_usage[] =
-"git-init-db [--template=<template-directory>]";
+"git-init-db [--template=<template-directory>] [--shared]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -239,6 +249,8 @@ int main(int argc, char **argv)
 		char *arg = argv[1];
 		if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
+		else if (!strcmp(arg, "--shared"))
+			shared_repository = 1;
 		else
 			die(init_db_usage);
 	}
@@ -251,7 +263,7 @@ int main(int argc, char **argv)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
-	safe_create_dir(git_dir);
+	safe_create_dir(git_dir, 0);
 
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
@@ -270,10 +282,14 @@ int main(int argc, char **argv)
 	path = xmalloc(len + 40);
 	memcpy(path, sha1_dir, len);
 
-	safe_create_dir(sha1_dir);
+	safe_create_dir(sha1_dir, 1);
 	strcpy(path+len, "/pack");
-	safe_create_dir(path);
+	safe_create_dir(path, 1);
 	strcpy(path+len, "/info");
-	safe_create_dir(path);
+	safe_create_dir(path, 0);
+
+	if (shared_repository)
+		git_config_set("core.sharedRepository", "true");
+
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index e109a07..10d63f1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -48,7 +48,7 @@ int get_sha1_hex(const char *hex, unsign
 	return 0;
 }
 
-static int make_group_writable(const char *path)
+int make_group_writable(const char *path)
 {
 	struct stat st;
 
-- 
1.0.GIT
