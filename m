From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 3/8] init-db.c: refactor directory creation
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-726360@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:07:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNogf-0005Z3-C8
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDSJK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDSJK1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:10:27 -0400
Received: from spoon.guft.org ([63.224.205.130]:50318 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261304AbVDSJJr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:09:47 -0400
Received: (qmail 23330 invoked by uid 5006); 19 Apr 2005 02:09:45 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch factors the init-db directory creation into a new function,
which is then reused in the next patch.  

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
 init-db.c |   61 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 34 insertions(+), 27 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


--- a/init-db.c
+++ b/init-db.c
@@ -4,43 +4,50 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+/*
+ * If you want to, you can share the DB area with any number of branches.
+ * That has advantages: you can save space by sharing all the SHA1 objects.
+ * On the other hand, it might just make lookup slower and messier. You
+ * be the judge.  The default case is to have a DB per managed directory.
+ */
+
+static char* init_dir(char *env, char *std, char *label, int *len)
+{
+	char *dir;
+	dir = getenv(env);
+	if (dir) {
+		struct stat st;
+		if (stat(dir, &st) < 0 || !S_ISDIR(st.st_mode)) {
+			fprintf(stderr, "%s set to bad directory %s: ", env, dir);
+			exit(1);
+		}
+	} 
+	else {
+		dir = std;
+		fprintf(stderr, "defaulting to private %s area\n", label);
+	}
+	if (mkdir(dir, 0755) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+	if (len)
+		*len = strlen(dir);
+	return dir;
+}
 
 int main(int argc, char **argv)
 {
	char *sha1_dir, *path;
 	int len, i;
 
 	if (mkdir(".git", 0755) < 0) {
 		perror("unable to create .git directory");
 		exit(1);
 	}
-
-	/*
-	 * If you want to, you can share the DB area with any number of branches.
-	 * That has advantages: you can save space by sharing all the SHA1 objects.
-	 * On the other hand, it might just make lookup slower and messier. You
-	 * be the judge.
-	 */
-	sha1_dir = getenv(DB_ENVIRONMENT);
-	if (sha1_dir) {
-		struct stat st;
-		if (!stat(sha1_dir, &st) && S_ISDIR(st.st_mode))
-			return 0;
-		fprintf(stderr, "DB_ENVIRONMENT set to bad directory %s: ", sha1_dir);
-	}
-
-	/*
-	 * The default case is to have a DB per managed directory.
-	 */
-	sha1_dir = DEFAULT_DB_ENVIRONMENT;
-	fprintf(stderr, "defaulting to private storage area\n");
-	len = strlen(sha1_dir);
-	if (mkdir(sha1_dir, 0755) < 0) {
-		if (errno != EEXIST) {
-			perror(sha1_dir);
-			exit(1);
-		}
-	}
+	sha1_dir = init_dir(DB_ENVIRONMENT, DEFAULT_DB_ENVIRONMENT, "storage", &len);
+	
 	path = malloc(len + 40);
 	memcpy(path, sha1_dir, len);
 	for (i = 0; i < 256; i++) {
