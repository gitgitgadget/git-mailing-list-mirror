From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 1/5] Library code for user-relative paths, take three.
Date: Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Message-ID: <20051117193714.2B8995BF93@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZk-0000lW-Rr
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVKQThV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKQThV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:37:21 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36314 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964782AbVKQThP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:15 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 52B636BD02
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 2B8995BF93; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12144>


See the threads "User-relative paths", "[RFC] GIT paths" and
"[PATCH 0/4] User-relative paths, take two" for previous discussions
on this topic.

This patch provides the work-horse of the user-relative paths feature,
using Linus' idea of a blind chdir() and getcwd() which makes it
remarkably simple.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 cache.h |    1 +
 path.c  |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)

applies-to: 8ff699dffc817e92fb2101f538f84c38d5ed0a0f
416ee0a4f47244471b52b9dc8aca3e984b20445f
diff --git a/cache.h b/cache.h
index 99afa2c..d8be06b 100644
--- a/cache.h
+++ b/cache.h
@@ -192,6 +192,7 @@ extern int diff_rename_limit_default;
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+extern char *enter_repo(char *path, int strict);
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
diff --git a/path.c b/path.c
index 495d17c..5b61709 100644
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
+static char *current_dir()
+{
+	return getcwd(pathname, sizeof(pathname));
+}
+
+/* Take a raw path from is_git_repo() and canonicalize it using Linus'
+ * idea of a blind chdir() and getcwd(). */
+static const char *canonical_path(char *path, int strict)
+{
+	char *dir = path;
+
+	if(strict && *dir != '/')
+		return NULL;
+
+	if(*dir == '~') {		/* user-relative path */
+		struct passwd *pw;
+		char *slash = strchr(dir, '/');
+
+		dir++;
+		/* '~/' and '~' (no slash) means users own home-dir */
+		if(!*dir || *dir == '/')
+			pw = getpwuid(getuid());
+		else {
+			if (slash) {
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
+		if(!slash || !slash[1]) /* no path following username */
+			return current_dir();
+
+		dir = slash + 1;
+	}
+
+	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
+	if(chdir(dir) < 0)
+		return NULL;
+
+	return current_dir();
+}
+
+char *enter_repo(char *path, int strict)
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
