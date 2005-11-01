From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 2/4] Library code for user-relative paths.
Date: Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Message-ID: <20051101225921.2C6035BA82@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:00:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX56E-0003RJ-Sl
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVKAW7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVKAW7W
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:59:22 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48620 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751394AbVKAW7W
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:59:22 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 557E96BD04
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 2C6035BA82; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10965>

See this discussion, "[RFC] GIT paths", on the git-list:
http://www.gelato.unsw.edu.au/archives/git/0510/10924.html

This patch provides the work-horse of the user-relative paths, using Linus'
idea of a blind chdir() and getcwd(), which makes it remarkably simple.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 cache.h |    1 +
 path.c  |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)

applies-to: bf640ae3d5bb5f5f283c62d4f5198a3c5e5086f0
1c4e7bb2383e2b67f0e877a46ea1eba4ec7e45e7
diff --git a/cache.h b/cache.h
index 677c6ac..aea2097 100644
--- a/cache.h
+++ b/cache.h
@@ -190,6 +190,7 @@ extern int trust_executable_bit;
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern const char *is_git_repo(const char *path, int strict);
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
diff --git a/path.c b/path.c
index 495d17c..4f4018d 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include <pwd.h>
 
 static char pathname[PATH_MAX];
 static char bad_path[] = "/bad-path/";
@@ -89,3 +90,74 @@ char *safe_strncpy(char *dest, const cha
 
 	return dest;
 }
+
+static const char *current_dir()
+{
+	return getcwd(pathname, sizeof(pathname));
+}
+
+/* Take a raw path from is_git_repo() and canonicalize it using Linus'
+ * idea of a blind chdir() and getcwd(). */
+static const char *canonical_path(const char *path, int strict)
+{
+	const char *dir = path;
+
+	if(strict && *dir != '/')
+		return NULL;
+
+	if(*dir == '~') {		/* user-relative path */
+		struct passwd *pw;
+		char *slash = NULL;
+
+		dir++;
+		/* '~/' and '~' (no slash) means users own home-dir */
+		if(!*dir || *dir == '/')
+			pw = getpwuid(getuid());
+		else {
+			if((slash = strchr(dir, '/'))) {
+				*slash = '\0';
+				pw = getpwnam(dir);
+				*slash = '/';
+			}
+			else
+				pw = getpwnam(dir);
+		}
+
+		/* make sure we got something back that we can chdir() to */
+		if(!pw || chdir(pw->pw_dir) < 0)
+			return NULL;
+
+		if(slash && *slash + 1)
+			dir = slash + 1;
+		else
+			dir = current_dir();
+	}
+
+	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
+	if(chdir(dir) < 0)
+		return NULL;
+
+	return current_dir();
+}
+
+const char *is_git_repo(const char *path, int strict)
+{
+	if(!path)
+		return NULL;
+
+	if(!canonical_path(path, strict)) {
+		if(strict || !canonical_path(mkpath("%s.git", path), strict))
+			return NULL;
+	}
+
+	/* This is perfectly safe, and people tend to think of the directory
+	 * where they ran git-init-db as their repository, so humour them. */
+	(void)chdir(".git");
+
+	if(access("objects", X_OK) == 0 && access("refs", X_OK) == 0) {
+		putenv("GIT_DIR=.");
+		return current_dir();
+	}
+
+	return NULL;
+}
---
0.99.9.GIT
