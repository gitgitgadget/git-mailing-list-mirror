From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] Move remove_path() into libgit.a
Date: Wed, 24 Jan 2007 02:13:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 24 02:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Whk-00068f-QB
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456AbXAXBNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965471AbXAXBNe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:13:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:34255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965456AbXAXBNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:13:33 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:13:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 24 Jan 2007 02:13:32 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37584>


Rename the function remove_path()  to remove_path_recursively(),
and move it to path.c.

This also fixes a bug in merge-recursive, where a now-empty
directory was not removed.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 cache.h           |    1 +
 merge-recursive.c |   24 +-----------------------
 path.c            |   25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index a435781..64ea1dc 100644
--- a/cache.h
+++ b/cache.h
@@ -240,6 +240,7 @@ static inline void hashclr(unsigned char *hash)
 }
 
 int git_mkstemp(char *path, size_t n, const char *template);
+int remove_path_recursively(const char *name);
 
 enum sharedrepo {
 	PERM_UMASK = 0,
diff --git a/merge-recursive.c b/merge-recursive.c
index fa320eb..091177d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -463,28 +463,6 @@ static int update_stages(const char *path, struct diff_filespec *o,
 	return 0;
 }
 
-static int remove_path(const char *name)
-{
-	int ret, len;
-	char *slash, *dirs;
-
-	ret = unlink(name);
-	if (ret)
-		return ret;
-	len = strlen(name);
-	dirs = xmalloc(len+1);
-	memcpy(dirs, name, len);
-	dirs[len] = '\0';
-	while ((slash = strrchr(name, '/'))) {
-		*slash = '\0';
-		len = slash - name;
-		if (rmdir(name) != 0)
-			break;
-	}
-	free(dirs);
-	return ret;
-}
-
 static int remove_file(int clean, const char *path, int no_wd)
 {
 	int update_cache = index_only || clean;
@@ -498,7 +476,7 @@ static int remove_file(int clean, const char *path, int no_wd)
 		unlink(path);
 		if (errno != ENOENT || errno != EISDIR)
 			return -1;
-		remove_path(path);
+		remove_path_recursively(path);
 	}
 	return 0;
 }
diff --git a/path.c b/path.c
index c5d25a4..b1f64e6 100644
--- a/path.c
+++ b/path.c
@@ -292,3 +292,28 @@ int adjust_shared_perm(const char *path)
 		return -2;
 	return 0;
 }
+
+/* this also removes the directories which became empty */
+int remove_path_recursively(const char *name)
+{
+	int ret, len;
+	char *slash, *dirs;
+
+	ret = unlink(name);
+	if (ret == ENOENT || ret == EISDIR)
+		ret = 0;
+	if (ret)
+		return ret;
+	len = strlen(name);
+	dirs = xmalloc(len+1);
+	memcpy(dirs, name, len);
+	dirs[len] = '\0';
+	while ((slash = strrchr(name, '/'))) {
+		*slash = '\0';
+		len = slash - name;
+		if (rmdir(name) != 0)
+			break;
+	}
+	free(dirs);
+	return ret;
+}
-- 
1.5.0.rc2.gc5868-dirty
