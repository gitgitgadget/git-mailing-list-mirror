From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 7/8] read-tree.c: add INDEX_FILE_DIRECTORY support
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-735349@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:11:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNokR-00063c-Ls
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDSJNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVDSJLu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:11:50 -0400
Received: from spoon.guft.org ([63.224.205.130]:51342 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261413AbVDSJJz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:09:55 -0400
Received: (qmail 23342 invoked by uid 5006); 19 Apr 2005 02:09:53 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch give read-tree the ability for the index directory to be 
overridden by the INDEX_FILE_DIRECTORY environment variable.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
        [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
        [PATCH 5/8] init-db.c: refactor mkdir logic
        [PATCH 6/8] read-cache.c: add INDEX_FILE_DIRECTORY support
 read-tree.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


read-tree.c: 42556c82def1d23f21116a2c1b3e7ae27c0605c5
--- a/read-tree.c
+++ b/read-tree.c
@@ -65,12 +65,12 @@ static int read_tree(unsigned char *sha1
 	return 0;
 }
 
-static int remove_lock = 0;
+static char *index_lock = NULL;
 
 static void remove_lock_file(void)
 {
-	if (remove_lock)
-		unlink(".git/index.lock");
+	if (index_lock)
+		unlink(index_lock);
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -154,14 +154,27 @@ static void trivially_merge_cache(struct
 
 int main(int argc, char **argv)
 {
-	int i, newfd;
+	int i, newfd, len;
 	unsigned char sha1[20];
+	char *index_file, *index_path;
 
-	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
+	index_path = getenv(INDEX_ENVIRONMENT);
+	if (!index_path)
+		index_path = DEFAULT_INDEX_ENVIRONMENT;
+
+	len = strlen(index_path);
+	index_file = malloc(len + 7);
+	if (!index_file) error("out of memory");
+	sprintf(index_file, "%s/index", index_path);
+
+	index_lock = malloc(len + 12);
+	if (!index_lock) error("out of memory");
+	sprintf(index_lock, "%s/index.lock", index_path);
+
+	newfd = open(index_lock, O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
 		die("unable to create new cachefile");
 	atexit(remove_lock_file);
-	remove_lock = 1;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -182,8 +195,12 @@ int main(int argc, char **argv)
 	if (stage == 4)
 		trivially_merge_cache(active_cache, active_nr);
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    rename(".git/index.lock", ".git/index"))
+	    rename(index_lock, index_file))
 		die("unable to write new index file");
-	remove_lock = 0;
+
+	free(index_file);
+	free(index_lock);
+	index_lock = NULL;
+
 	return 0;
 }
