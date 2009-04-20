From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] Move prime_cache_tree() to cache-tree.c
Date: Mon, 20 Apr 2009 03:58:18 -0700
Message-ID: <1240225100-29960-3-git-send-email-gitster@pobox.com>
References: <1240225100-29960-1-git-send-email-gitster@pobox.com>
 <1240225100-29960-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrEO-0001Cx-4q
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbZDTK6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZDTK6h
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:58:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZDTK6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:58:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC83D10ACD
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 55DD210ACB for
 <git@vger.kernel.org>; Mon, 20 Apr 2009 06:58:29 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.18.g66996
In-Reply-To: <1240225100-29960-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2EB5F13C-2D9A-11DE-B256-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116968>

The interface to build cache-tree belongs there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c  |    1 +
 builtin-read-tree.c |   37 +------------------------------------
 cache-tree.c        |   34 ++++++++++++++++++++++++++++++++++
 cache-tree.h        |    4 ++++
 4 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b121fe5..ffdb33a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "cache-tree.h"
 #include "unpack-trees.h"
 #include "dir.h"
 #include "run-command.h"
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index e4e0e71..9cd7d07 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -29,41 +29,6 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
-{
-	struct tree_desc desc;
-	struct name_entry entry;
-	int cnt;
-
-	hashcpy(it->sha1, tree->object.sha1);
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	cnt = 0;
-	while (tree_entry(&desc, &entry)) {
-		if (!S_ISDIR(entry.mode))
-			cnt++;
-		else {
-			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(entry.sha1);
-			if (!subtree->object.parsed)
-				parse_tree(subtree);
-			sub = cache_tree_sub(it, entry.path);
-			sub->cache_tree = cache_tree();
-			prime_cache_tree_rec(sub->cache_tree, subtree);
-			cnt += sub->cache_tree->entry_count;
-		}
-	}
-	it->entry_count = cnt;
-}
-
-static void prime_cache_tree(void)
-{
-	if (!nr_trees)
-		return;
-	active_cache_tree = cache_tree();
-	prime_cache_tree_rec(active_cache_tree, trees[0]);
-
-}
-
 static const char read_tree_usage[] = "git read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
@@ -236,7 +201,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	 * what came from the tree.
 	 */
 	if (nr_trees == 1 && !opts.prefix)
-		prime_cache_tree();
+		prime_cache_tree(&active_cache_tree, trees[0]);
 
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(&lock_file))
diff --git a/cache-tree.c b/cache-tree.c
index 3d8f218..37bf35e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "cache-tree.h"
 
 #ifndef DEBUG
@@ -591,3 +592,36 @@ int write_cache_as_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 
 	return 0;
 }
+
+static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	int cnt;
+
+	hashcpy(it->sha1, tree->object.sha1);
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	cnt = 0;
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			cnt++;
+		else {
+			struct cache_tree_sub *sub;
+			struct tree *subtree = lookup_tree(entry.sha1);
+			if (!subtree->object.parsed)
+				parse_tree(subtree);
+			sub = cache_tree_sub(it, entry.path);
+			sub->cache_tree = cache_tree();
+			prime_cache_tree_rec(sub->cache_tree, subtree);
+			cnt += sub->cache_tree->entry_count;
+		}
+	}
+	it->entry_count = cnt;
+}
+
+void prime_cache_tree(struct cache_tree **it, struct tree *tree)
+{
+	cache_tree_free(it);
+	*it = cache_tree();
+	prime_cache_tree_rec(*it, tree);
+}
diff --git a/cache-tree.h b/cache-tree.h
index cf8b790..e958835 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -1,6 +1,8 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
+#include "tree.h"
+
 struct cache_tree;
 struct cache_tree_sub {
 	struct cache_tree *cache_tree;
@@ -33,4 +35,6 @@ int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
 int write_cache_as_tree(unsigned char *sha1, int missing_ok, const char *prefix);
+void prime_cache_tree(struct cache_tree **, struct tree *);
+
 #endif
-- 
1.6.3.rc1.18.g66996
