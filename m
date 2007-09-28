From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] Introduce remove_dir_recursively()
Date: Fri, 28 Sep 2007 16:28:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281628410.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 17:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbHnA-0007di-Kt
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 17:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbXI1PaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXI1PaF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 11:30:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:51787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753438AbXI1PaD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 11:30:03 -0400
Received: (qmail invoked by alias); 28 Sep 2007 15:30:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 28 Sep 2007 17:30:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SHN0H7DSS3NmOQuMwFf7WVzASOlnfuEvgHAu9EW
	euzsCTHM0HeeL5
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709280602580.28395@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59403>


There was a function called remove_empty_dir_recursive() buried
in refs.c.  Expose a slightly enhanced version in dir.h: it can now
optionally remove a non-empty directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 dir.h  |    2 ++
 refs.c |   57 ++++++++++++---------------------------------------------
 3 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/dir.c b/dir.c
index eb6c3ab..b18257e 100644
--- a/dir.c
+++ b/dir.c
@@ -685,3 +685,44 @@ int is_inside_dir(const char *dir)
 	char buffer[PATH_MAX];
 	return get_relative_cwd(buffer, sizeof(buffer), dir) != NULL;
 }
+
+int remove_dir_recursively(struct strbuf *path, int only_empty)
+{
+	DIR *dir = opendir(path->buf);
+	struct dirent *e;
+	int ret = 0, original_len = path->len, len;
+
+	if (!dir)
+		return -1;
+	if (path->buf[original_len - 1] != '/')
+		strbuf_addch(path, '/');
+
+	len = path->len;
+	while ((e = readdir(dir)) != NULL) {
+		struct stat st;
+		if ((e->d_name[0] == '.') &&
+		    ((e->d_name[1] == 0) ||
+		     ((e->d_name[1] == '.') && e->d_name[2] == 0)))
+			continue; /* "." and ".." */
+
+		strbuf_setlen(path, len);
+		strbuf_addstr(path, e->d_name);
+		if (lstat(path->buf, &st))
+			; /* fall thru */
+		else if (S_ISDIR(st.st_mode)) {
+			if (!remove_dir_recursively(path, only_empty))
+				continue; /* happy */
+		} else if (!only_empty && !unlink(path->buf))
+			continue; /* happy, too */
+
+		/* path too long, stat fails, or non-directory still exists */
+		ret = -1;
+		break;
+	}
+	closedir(dir);
+
+	strbuf_setlen(path, original_len);
+	if (!ret)
+		ret = rmdir(path->buf);
+	return ret;
+}
diff --git a/dir.h b/dir.h
index f55a87b..a248a23 100644
--- a/dir.h
+++ b/dir.h
@@ -64,4 +64,6 @@ extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 extern char *get_relative_cwd(char *buffer, int size, const char *dir);
 extern int is_inside_dir(const char *dir);
 
+extern int remove_dir_recursively(struct strbuf *path, int only_empty);
+
 #endif
diff --git a/refs.c b/refs.c
index 07e260c..aff02cd 100644
--- a/refs.c
+++ b/refs.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
+#include "dir.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
@@ -671,57 +672,23 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 	return lock;
 }
 
-static int remove_empty_dir_recursive(char *path, int len)
-{
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
-}
-
-static int remove_empty_directories(char *file)
+static int remove_empty_directories(const char *file)
 {
 	/* we want to create a file but there is a directory there;
 	 * if that is an empty directory (or a directory that contains
 	 * only empty directories), remove them.
 	 */
-	char path[PATH_MAX];
-	int len = strlen(file);
+	struct strbuf path;
+	int result;
 
-	if (len >= PATH_MAX) /* path too long ;-) */
-		return -1;
-	strcpy(path, file);
-	return remove_empty_dir_recursive(path, len);
+	strbuf_init(&path, 20);
+	strbuf_addstr(&path, file);
+
+	result = remove_dir_recursively(&path, 1);
+
+	strbuf_release(&path);
+
+	return result;
 }
 
 static int is_refname_available(const char *ref, const char *oldref,
-- 
1.5.3.2.1102.g9487
