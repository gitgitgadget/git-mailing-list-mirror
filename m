From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] merge-recur: use the unpack_trees() interface instead
 of exec()ing read-tree
Date: Sun, 30 Jul 2006 20:27:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607302026380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 20:27:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7G0U-0002ei-6e
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWG3S1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWG3S1N
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:27:13 -0400
Received: from mail.gmx.net ([213.165.64.21]:55015 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932413AbWG3S1M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 14:27:12 -0400
Received: (qmail invoked by alias); 30 Jul 2006 18:27:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 30 Jul 2006 20:27:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24467>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   77 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5375a1b..3cdea81 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -19,7 +19,7 @@ #include "diff.h"
 #include "diffcore.h"
 #include "run-command.h"
 #include "tag.h"
-
+#include "unpack-trees.h"
 #include "path-list.h"
 
 /*
@@ -124,7 +124,7 @@ static int flush_cache(void)
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int fd = hold_lock_file_for_update(lock, getenv("GIT_INDEX_FILE"));
 	if (fd < 0)
-		die("could not lock %s", temporary_index_file);
+		die("could not lock %s", lock->filename);
 	if (write_cache(fd, active_cache, active_nr) ||
 			close(fd) || commit_lock_file(lock))
 		die ("unable to write %s", getenv("GIT_INDEX_FILE"));
@@ -191,41 +191,60 @@ static int add_cacheinfo(unsigned int mo
  */
 static int index_only = 0;
 
-/*
- * TODO: this can be streamlined by refactoring builtin-read-tree.c
- */
-static int git_read_tree(const struct tree *tree)
+static int git_read_tree(struct tree *tree)
 {
 	int rc;
-	const char *argv[] = { "git-read-tree", NULL, NULL, };
+	struct object_list *trees = NULL;
+	struct unpack_trees_options opts;
+
 	if (cache_dirty)
 		die("read-tree with dirty cache");
-	argv[1] = sha1_to_hex(tree->object.sha1);
-	rc = run_command_v(2, argv);
-	return rc < 0 ? -1: rc;
+
+	memset(&opts, 0, sizeof(opts));
+	object_list_append(&tree->object, &trees);
+	rc = unpack_trees(trees, &opts);
+	cache_tree_free(&active_cache_tree);
+
+	if (rc == 0)
+		cache_dirty = 1;
+
+	return rc;
 }
 
-/*
- * TODO: this can be streamlined by refactoring builtin-read-tree.c
- */
-static int git_merge_trees(const char *update_arg,
+static int git_merge_trees(int index_only,
 			   struct tree *common,
 			   struct tree *head,
 			   struct tree *merge)
 {
 	int rc;
-	const char *argv[] = {
-		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
-		NULL,
-	};
+	struct object_list *trees = NULL;
+	struct unpack_trees_options opts;
+
+	/* TODO: if (!cache_dirty) read */
 	if (cache_dirty)
 		flush_cache();
-	argv[1] = update_arg;
-	argv[3] = sha1_to_hex(common->object.sha1);
-	argv[4] = sha1_to_hex(head->object.sha1);
-	argv[5] = sha1_to_hex(merge->object.sha1);
-	rc = run_command_v(6, argv);
-	return rc < 0 ? -1: rc;
+
+	read_cache_from(getenv("GIT_INDEX_FILE"));
+
+	memset(&opts, 0, sizeof(opts));
+	if (index_only)
+		opts.index_only = 1;
+	else
+		opts.update = 1;
+	opts.merge = 1;
+	opts.head_idx = 2;
+	opts.fn = threeway_merge;
+
+	object_list_append(&common->object, &trees);
+	object_list_append(&head->object, &trees);
+	object_list_append(&merge->object, &trees);
+
+	rc = unpack_trees(trees, &opts);
+	cache_tree_free(&active_cache_tree);
+
+	cache_dirty = 1;
+
+	return rc;
 }
 
 /*
@@ -239,8 +258,14 @@ static struct tree *git_write_tree(void)
 	unsigned char sha1[20];
 	int ch;
 	unsigned i = 0;
-	if (cache_dirty)
+	if (cache_dirty) {
+		for (i = 0; i < active_nr; i++) {
+			struct cache_entry *ce = active_cache[i];
+			if (ce_stage(ce))
+				return NULL;
+		}
 		flush_cache();
+	}
 	fp = popen("git-write-tree 2>/dev/null", "r");
 	while ((ch = fgetc(fp)) != EOF)
 		if (i < sizeof(buf)-1 && ch >= '0' && ch <= 'f')
@@ -1121,7 +1146,7 @@ static int merge_trees(struct tree *head
 		return 1;
 	}
 
-	code = git_merge_trees(index_only ? "-i": "-u", common, head, merge);
+	code = git_merge_trees(index_only, common, head, merge);
 
 	if (code != 0)
 		die("merging of trees %s and %s failed",
-- 
1.4.2.rc2.g76b2-dirty
