From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 8/8] update-cache.c: add INDEX_FILE_DIRECTORY support
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-737677@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:10:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNojm-0005xl-FK
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDSJNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDSJMR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:12:17 -0400
Received: from spoon.guft.org ([63.224.205.130]:51598 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261415AbVDSJJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:09:57 -0400
Received: (qmail 23345 invoked by uid 5006); 19 Apr 2005 02:09:55 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch give update-cache the ability for the index directory to be 
overridden by the INDEX_FILE_DIRECTORY environment variable.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
        [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
        [PATCH 5/8] init-db.c: refactor mkdir logic
        [PATCH 6/8] read-cache.c: add INDEX_FILE_DIRECTORY support
        [PATCH 7/8] read-tree.c: add INDEX_FILE_DIRECTORY support
 update-cache.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


update-cache.c: 0d16b36d7d074e9f0a2811a40e16e9823a628ec9
--- a/update-cache.c
+++ b/update-cache.c
@@ -270,25 +270,37 @@ static int add_cacheinfo(char *arg1, cha
 	return add_cache_entry(ce, allow_add);
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
 
 int main(int argc, char **argv)
 {
-	int i, newfd, entries;
+	int i, newfd, entries, len;
 	int allow_options = 1;
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
-
 	atexit(remove_lock_file);
-	remove_lock = 1;
 
 	entries = read_cache();
 	if (entries < 0)
@@ -330,9 +342,12 @@ int main(int argc, char **argv)
 			die("Unable to add %s to database", path);
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    rename(".git/index.lock", ".git/index"))
+	    rename(index_lock, index_file))
 		die("Unable to write new cachefile");
 
-	remove_lock = 0;
+	free(index_file);
+	free(index_lock);
+	index_lock = NULL;
+
 	return 0;
 }
