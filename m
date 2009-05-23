From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] Optimize "diff-index --cached" using cache-tree
Date: Sat, 23 May 2009 12:24:37 -0700
Message-ID: <1243106678-6343-5-git-send-email-gitster@pobox.com>
References: <1243106678-6343-1-git-send-email-gitster@pobox.com>
 <1243106678-6343-2-git-send-email-gitster@pobox.com>
 <1243106678-6343-3-git-send-email-gitster@pobox.com>
 <1243106678-6343-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wql-0002Cd-8n
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbZEWTYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbZEWTYu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:24:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbZEWTYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:24:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E6505B56B9
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:24:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09BDCB56B8 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:24:47 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106678-6343-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 619BE7E2-47CF-11DE-A7D2-F6BA321C86B1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119791>

When running "diff-index --cached" after making a change to only a small
portion of the index, there is no point unpacking unchanged subtrees into
the index recursively, only to find that all entries match anyway.  Tweak
unpack_trees() logic that is used to read in the tree object to catch the
case where the tree entry we are looking at matches the index as a whole
by looking at the cache-tree.

As an exercise, after modifying a few paths in the kernel tree, here are
a few numbers on my Athlon 64X2 3800+:

    (without patch, hot cache)
    $ /usr/bin/time git diff --cached --raw
    :100644 100644 b57e1f5... e69de29... M  Makefile
    :100644 000000 8c86b72... 0000000... D  arch/x86/Makefile
    :000000 100644 0000000... e69de29... A  arche
    0.07user 0.02system 0:00.09elapsed 102%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+9407minor)pagefaults 0swaps

    (with patch, hot cache)
    $ /usr/bin/time ../git.git/git-diff --cached --raw
    :100644 100644 b57e1f5... e69de29... M  Makefile
    :100644 000000 8c86b72... 0000000... D  arch/x86/Makefile
    :000000 100644 0000000... e69de29... A  arche
    0.02user 0.00system 0:00.02elapsed 103%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+2446minor)pagefaults 0swaps

Cold cache numbers are very impressive, but it does not matter very much
in practice:

    (without patch, cold cache)
    $ su root sh -c 'echo 3 >/proc/sys/vm/drop_caches'
    $ /usr/bin/time git diff --cached --raw
    :100644 100644 b57e1f5... e69de29... M  Makefile
    :100644 000000 8c86b72... 0000000... D  arch/x86/Makefile
    :000000 100644 0000000... e69de29... A  arche
    0.06user 0.17system 0:10.26elapsed 2%CPU (0avgtext+0avgdata 0maxresident)k
    247032inputs+0outputs (1172major+8237minor)pagefaults 0swaps

    (with patch, cold cache)
    $ su root sh -c 'echo 3 >/proc/sys/vm/drop_caches'
    $ /usr/bin/time ../git.git/git-diff --cached --raw
    :100644 100644 b57e1f5... e69de29... M  Makefile
    :100644 000000 8c86b72... 0000000... D  arch/x86/Makefile
    :000000 100644 0000000... e69de29... A  arche
    0.02user 0.01system 0:01.01elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
    18440inputs+0outputs (79major+2369minor)pagefaults 0swaps

This of course helps "git status" as well.

    (without patch, hot cache)
    $ /usr/bin/time ../git.git/git-status >/dev/null
    0.17user 0.18system 0:00.35elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+5336outputs (0major+10970minor)pagefaults 0swaps

    (with patch, hot cache)
    $ /usr/bin/time ../git.git/git-status >/dev/null
    0.10user 0.16system 0:00.27elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+5336outputs (0major+3921minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c   |   32 ++++++++++++++++++++++++++++++++
 cache-tree.h   |    3 +++
 diff-lib.c     |    2 ++
 unpack-trees.c |   17 +++++++++++++++++
 unpack-trees.h |    1 +
 5 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 5481e43..16a65df 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -631,3 +631,35 @@ void prime_cache_tree(struct cache_tree **it, struct tree *tree)
 	*it = cache_tree();
 	prime_cache_tree_rec(*it, tree);
 }
+
+/*
+ * find the cache_tree that corresponds to the current level without
+ * exploding the full path into textual form.  The root of the
+ * cache tree is given as "root", and our current level is "info".
+ * (1) When at root level, info->prev is NULL, so it is "root" itself.
+ * (2) Otherwise, find the cache_tree that corresponds to one level
+ *     above us, and find ourselves in there.
+ */
+static struct cache_tree *find_cache_tree_from_traversal(struct cache_tree *root,
+							 struct traverse_info *info)
+{
+	struct cache_tree *our_parent;
+
+	if (!info->prev)
+		return root;
+	our_parent = find_cache_tree_from_traversal(root, info->prev);
+	return cache_tree_find(our_parent, info->name.path);
+}
+
+int cache_tree_matches_traversal(struct cache_tree *root,
+				 struct name_entry *ent,
+				 struct traverse_info *info)
+{
+	struct cache_tree *it;
+
+	it = find_cache_tree_from_traversal(root, info);
+	it = cache_tree_find(it, ent->path);
+	if (it && it->entry_count > 0 && !hashcmp(ent->sha1, it->sha1))
+		return it->entry_count;
+	return 0;
+}
diff --git a/cache-tree.h b/cache-tree.h
index eadcad8..3df641f 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -2,6 +2,7 @@
 #define CACHE_TREE_H
 
 #include "tree.h"
+#include "tree-walk.h"
 
 struct cache_tree;
 struct cache_tree_sub {
@@ -42,4 +43,6 @@ int cache_tree_update(struct cache_tree *, struct cache_entry **, int, int, int)
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
 void prime_cache_tree(struct cache_tree **, struct tree *);
 
+extern int cache_tree_matches_traversal(struct cache_tree *, struct name_entry *ent, struct traverse_info *info);
+
 #endif
diff --git a/diff-lib.c b/diff-lib.c
index a310fb2..1cb97af 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -446,6 +446,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
+	opts.diff_index_cached = cached;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
@@ -502,6 +503,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
+	opts.diff_index_cached = 1;
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = &revs;
diff --git a/unpack-trees.c b/unpack-trees.c
index aaacaf1..8eb3ddb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -326,6 +326,23 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 			if (src[0])
 				conflicts |= 1;
 		}
+
+		/* special case: "diff-index --cached" looking at a tree */
+		if (o->diff_index_cached &&
+		    n == 1 && dirmask == 1 && S_ISDIR(names->mode)) {
+			int matches;
+			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
+							       names, info);
+			/*
+			 * Everything under the name matches.  Adjust o->pos to
+			 * skip the entire hierarchy.
+			 */
+			if (matches) {
+				o->pos += matches;
+				return mask;
+			}
+		}
+
 		if (traverse_trees_recursive(n, dirmask, conflicts,
 					     names, info) < 0)
 			return -1;
diff --git a/unpack-trees.h b/unpack-trees.h
index 0d26f3d..1e0e232 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,6 +27,7 @@ struct unpack_trees_options {
 		     aggressive:1,
 		     skip_unmerged:1,
 		     initial_checkout:1,
+		     diff_index_cached:1,
 		     gently:1;
 	const char *prefix;
 	int pos;
-- 
1.6.3.1.145.gb74d77
