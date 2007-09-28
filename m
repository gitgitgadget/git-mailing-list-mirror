From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Introduce remove_dir_recursively()
Date: Fri, 28 Sep 2007 06:06:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709280606350.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 07:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib853-0003Yp-3G
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 07:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323AbXI1FHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 01:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbXI1FHy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 01:07:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:33507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754992AbXI1FHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 01:07:53 -0400
Received: (qmail invoked by alias); 28 Sep 2007 05:07:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp007) with SMTP; 28 Sep 2007 07:07:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KvVEWcuOKPWYGsdrq/BO7/uMm9R1Xy+6KO3k+S6
	c3dNETf7fV+k/A
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709280602580.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59363>


There was a function called remove_empty_dir_recursive() buried
in refs.c.  Expose a slightly enhanced version in dir.h: it can now
optionally remove a non-empty directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c  |   45 +++++++++++++++++++++++++++++++++++++++++++++
 dir.h  |    2 ++
 refs.c |   36 ++----------------------------------
 3 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/dir.c b/dir.c
index eb6c3ab..0fae400 100644
--- a/dir.c
+++ b/dir.c
@@ -685,3 +685,48 @@ int is_inside_dir(const char *dir)
 	char buffer[PATH_MAX];
 	return get_relative_cwd(buffer, sizeof(buffer), dir) != NULL;
 }
+
+int remove_dir_recursively(char *path, int len, int only_empty)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int ret = 0;
+
+	if (!dir)
+		return -1;
+	if (path[len-1] != '/')
+		path[len++] = '/';
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		int namlen;
+		if ((e->d_name[0] == '.') &&
+		    ((e->d_name[1] == 0) ||
+		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
+			continue; /* "." and ".." */
+
+		namlen = strlen(e->d_name);
+		if (len + namlen > PATH_MAX ||
+				!memcpy(path + len, e->d_name, namlen) ||
+				(path[len + namlen] = '\0') ||
+				lstat(path, &st))
+			; /* fall thru */
+		else if (S_ISDIR(st.st_mode)) {
+			if (!remove_dir_recursively(path, len + namlen,
+						only_empty))
+				continue; /* happy */
+		} else if (!only_empty &&
+				len + namlen + 1 < PATH_MAX &&
+				!unlink(path))
+			continue; /* happy, too */
+
+		/* path too long, stat fails, or non-directory still exists */
+		ret = -1;
+		break;
+	}
+	closedir(dir);
+	if (!ret) {
+		path[len] = 0;
+		ret = rmdir(path);
+	}
+	return ret;
+}
diff --git a/dir.h b/dir.h
index f55a87b..f52eea8 100644
--- a/dir.h
+++ b/dir.h
@@ -64,4 +64,6 @@ extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
 
+extern int remove_dir_recursively(char *dir, int len, int only_empty);
+
 #endif
diff --git a/refs.c b/refs.c
index 07e260c..f0336ee 100644
--- a/refs.c
+++ b/refs.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
+#include "dir.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
@@ -673,40 +674,7 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 
 static int remove_empty_dir_recursive(char *path, int len)
 {
-	DIR *dir = opendir(path);
-	struct dirent *e;
-	int ret = 0;
-
-	if (!dir)
-		return -1;
-	if (path[len-1] != '/')
-		path[len++] = '/';
-	while ((e = readdir(dir)) != NULL) {
-		struct stat st;
-		int namlen;
-		if ((e->d_name[0] == '.') &&
-		    ((e->d_name[1] == 0) ||
-		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
-			continue; /* "." and ".." */
-
-		namlen = strlen(e->d_name);
-		if ((len + namlen < PATH_MAX) &&
-		    strcpy(path + len, e->d_name) &&
-		    !lstat(path, &st) &&
-		    S_ISDIR(st.st_mode) &&
-		    !remove_empty_dir_recursive(path, len + namlen))
-			continue; /* happy */
-
-		/* path too long, stat fails, or non-directory still exists */
-		ret = -1;
-		break;
-	}
-	closedir(dir);
-	if (!ret) {
-		path[len] = 0;
-		ret = rmdir(path);
-	}
-	return ret;
+	return remove_dir_recursively(path, len, 1);
 }
 
 static int remove_empty_directories(char *file)
-- 
1.5.3.2.1102.g9487
