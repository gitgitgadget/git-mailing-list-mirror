From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 5/8] init-db.c: refactor mkdir logic
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-730821@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNohI-0005e7-GT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDSJLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDSJLE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:11:04 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:50830 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261398AbVDSJJv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 05:09:51 -0400
Received: (qmail 23336 invoked by uid 5006); 19 Apr 2005 02:09:49 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Move redundant mkdir call logic into helper function.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
        [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
 init-db.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


--- a/init-db.c	2005-04-19 01:36:58.000000000 -0700
+++ b/init-db.c	2005-04-19 01:37:03.000000000 -0700
@@ -11,6 +11,16 @@
  * be the judge.  The default case is to have a DB per managed directory.
  */
 
+static void create_dir(char *path) 
+{
+	if (mkdir(dir, 0755) < 0) {
+		if (errno != EEXIST) {
+			perror(dir);
+			exit(1);
+		}
+	}
+}
+
 static char* init_dir(char *env, char *std, char *label, int *len)
 {
 	char *dir;
@@ -26,12 +36,7 @@
 		dir = std;
 		fprintf(stderr, "defaulting to private %s area\n", label);
 	}
-	if (mkdir(dir, 0755) < 0) {
-		if (errno != EEXIST) {
-			perror(dir);
-			exit(1);
-		}
-	}
+	create_dir(dir);
 	if (len)
 		*len = strlen(dir);
 	return dir;
@@ -49,12 +54,7 @@
 	memcpy(path, sha1_dir, len);
 	for (i = 0; i < 256; i++) {
 		sprintf(path+len, "/%02x", i);
-		if (mkdir(path, 0755) < 0) {
-			if (errno != EEXIST) {
-				perror(path);
-				exit(1);
-			}
-		}
+		create_dir(path);
 	}
 	return 0;
 }
