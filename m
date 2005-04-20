From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 3/3] init-db.c: create and use safe_create_dir helper
Date: Tue, 19 Apr 2005 21:28:39 -0700
Message-ID: <mailbox-1242-1113971319-974200@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:25:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6ln-0007DU-NO
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDTE3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVDTE3K
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:29:10 -0400
Received: from spoon.guft.org ([63.224.205.130]:21903 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261353AbVDTE2q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 00:28:46 -0400
Received: (qmail 1260 invoked by uid 5006); 19 Apr 2005 21:28:46 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1242-1113971319-958842@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch applies on top of:
        [PATCH 1/3] init-db.c: cleanup comments
        [PATCH 2/3] init-db.c: normalize env var handling.

 init-db.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

Factor mkdir calls into common safe_create_dir subroutine.

--- a/init-db.c	2005-04-19 18:50:14.000000000 -0700
+++ b/init-db.c	2005-04-19 18:45:48.000000000 -0700
@@ -5,6 +5,16 @@
  */
 #include "cache.h"
 
+void safe_create_dir(char *dir)
+{
+	if (mkdir(dir, 0755) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+}
+
 /*
  * If you want to, you can share the DB area with any number of branches.
  * That has advantages: you can save space by sharing all the SHA1 objects.
@@ -16,10 +26,7 @@
 	char *sha1_dir, *path;
 	int len, i;
 
-	if (mkdir(".git", 0755) < 0) {
-		perror("unable to create .git directory");
-		exit(1);
-	}
+	safe_create_dir(".git");
 
 	sha1_dir = getenv(DB_ENVIRONMENT);
 	if (!sha1_dir) {
@@ -27,22 +34,13 @@
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	len = strlen(sha1_dir);
-	if (mkdir(sha1_dir, 0755) < 0) {
-		if (errno != EEXIST) {
-			perror(sha1_dir);
-			exit(1);
-		}
-	}
 	path = malloc(len + 40);
 	memcpy(path, sha1_dir, len);
+
+	safe_create_dir(sha1_dir);
 	for (i = 0; i < 256; i++) {
 		sprintf(path+len, "/%02x", i);
-		if (mkdir(path, 0755) < 0) {
-			if (errno != EEXIST) {
-				perror(path);
-				exit(1);
-			}
-		}
+		safe_create_dir(path);
 	}
 	return 0;
 }
