From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 14/22] move read_cache_unmerged into read-cache.c
Date: Mon, 12 Sep 2005 10:56:14 -0400
Message-ID: <20050912145613.28120.32935.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 16:59:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjn-0000SG-CC
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVILO42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVILO41
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:27 -0400
Received: from citi.umich.edu ([141.211.133.111]:60064 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751302AbVILO4O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:14 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 142AB1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:14 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8386>

Clean-up: put read_cache_unmerged() right next to read_cache().
read_cache_unmerged() will likely need to be reconstructed if
the active cache data type changes.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 cache.h      |    1 +
 read-cache.c |   31 +++++++++++++++++++++++++++++++
 read-tree.c  |   28 ----------------------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -157,6 +157,7 @@ extern char *prefix_path(const char *pre
 
 /* Initialize and use the cache information */
 extern int read_cache(void);
+extern int read_cache_unmerged(void);
 extern int write_cache(int newfd);
 extern int cache_name_pos(const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -453,6 +453,37 @@ unmap:
 	return error("verify header failed");
 }
 
+static int deleted = 0;
+static struct cache_cursor dst;
+
+static int read_one_unmerged(struct cache_cursor *cc, struct cache_entry *ce)
+{
+	if (ce_stage(ce)) {
+		deleted++;
+		goto out;
+	}
+	if (deleted)
+		set_ce_at_cursor(&dst, ce);
+	next_cc(&dst);
+out:
+	next_cc(cc);
+	return 0;
+}
+
+/*
+ * Read in the cache, then throw away the unmerged entries
+ */
+int read_cache_unmerged(void)
+{
+	if (read_cache() > 0) {
+		init_cc(&dst);
+		walk_cache(read_one_unmerged);
+	}
+
+	active_nr -= deleted;
+	return deleted;
+}
+
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -555,34 +555,6 @@ static int oneway_merge(struct cache_ent
 	return merged_entry(a, NULL);
 }
 
-static int deleted = 0;
-static struct cache_cursor dst;
-
-static int read_one_unmerged(struct cache_cursor *cc, struct cache_entry *ce)
-{
-	if (ce_stage(ce)) {
-		deleted++;
-		goto out;
-	}
-	if (deleted)
-		set_ce_at_cursor(&dst, ce);
-	next_cc(&dst);
-out:
-	next_cc(cc);
-	return 0;
-}
-
-static int read_cache_unmerged(void)
-{
-	if (read_cache() > 0) {
-		init_cc(&dst);
-		walk_cache(read_one_unmerged);
-	}
-
-	active_nr -= deleted;
-	return deleted;
-}
-
 static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])";
 
 static struct cache_file cache_file;
