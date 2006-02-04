From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Use sha1_file.c's mkdir-like routine in apply.c.
Date: Fri, 03 Feb 2006 22:50:57 -0800
Message-ID: <17347.1139035857@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5HGK-0000eh-5B
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 07:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946304AbWBDGu6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946315AbWBDGu6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 01:50:58 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:59547 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1946304AbWBDGu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 01:50:58 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k146ovxV017349
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 22:50:57 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k146ovVL017348
	for <git@vger.kernel.org>; Fri, 3 Feb 2006 22:50:57 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15574>

As far as I can see, create_subdirectories() in apply.c just
duplicates the functionality of safe_create_leading_directories() from
sha1_file.c.  The former has a warm, fuzzy const parameter, but that's
not important.

The potential problem with EEXIST and creating directories should
never occur here, but will be removed by future
safe_create_leading_directories() changes.  Other uses of EEXIST in
apply.c should be fine barring intentionally malicious behavior.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 apply.c |   25 ++++---------------------
 1 files changed, 4 insertions(+), 21 deletions(-)

9f6bc2c90544688c2aad0ad0da4b2674f5aa6fab
diff --git a/apply.c b/apply.c
index 79e23a7..2ad47fb 100644
--- a/apply.c
+++ b/apply.c
@@ -1564,24 +1564,6 @@ static void add_index_file(const char *p
 		die("unable to add cache entry for %s", path);
 }
 
-static void create_subdirectories(const char *path)
-{
-	int len = strlen(path);
-	char *buf = xmalloc(len + 1);
-	const char *slash = path;
-
-	while ((slash = strchr(slash+1, '/')) != NULL) {
-		len = slash - path;
-		memcpy(buf, path, len);
-		buf[len] = 0;
-		if (mkdir(buf, 0777) < 0) {
-			if (errno != EEXIST)
-				break;
-		}
-	}
-	free(buf);
-}
-
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
 	int fd;
@@ -1610,13 +1592,14 @@ static int try_create_file(const char *p
  * which is true 99% of the time anyway. If they don't,
  * we create them and try again.
  */
-static void create_one_file(const char *path, unsigned mode, const char *buf, unsigned long size)
+static void create_one_file(char *path, unsigned mode, const char *buf, unsigned long size)
 {
 	if (!try_create_file(path, mode, buf, size))
 		return;
 
 	if (errno == ENOENT) {
-		create_subdirectories(path);
+		if (safe_create_leading_directories(path))
+			return;
 		if (!try_create_file(path, mode, buf, size))
 			return;
 	}
@@ -1643,7 +1626,7 @@ static void create_one_file(const char *
 
 static void create_file(struct patch *patch)
 {
-	const char *path = patch->new_name;
+	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
 	unsigned long size = patch->resultsize;
 	char *buf = patch->result;
-- 
1.1.5
