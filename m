From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Optimize "diff-index --cached" using cache-tree
Date: Wed, 20 May 2009 17:44:24 -0700
Message-ID: <7v4ovfwahj.fsf_-_@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<7vfxezzms0.fsf@alter.siamese.dyndns.org>
	<7vws8by6iz.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 02:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6wOf-0007yh-0H
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 02:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbZEUAoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 20:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbZEUAoY
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 20:44:24 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57326 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbZEUAoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 20:44:23 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521004425.BTFI18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Wed, 20 May 2009 20:44:25 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id u0kQ1b00L4aMwMQ040kQbT; Wed, 20 May 2009 20:44:24 -0400
X-Authority-Analysis: v=1.0 c=1 a=urYtXk3hq8YA:10 a=fZZQJNvJNwkA:10
 a=ybZZDoGAAAAA:8 a=X6cAocOkftCVMfxtRkYA:9 a=f5ivddewP1hmFQP6LHYA:7
 a=XNu4UX77dNrnxmor3QE6RprlWccA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vws8by6iz.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 20 May 2009 11\:27\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119643>

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

 * This is what I've been wanting to do for a loooooooong time, ever since
   I introduced the cache-tree extension to the index data structure.
   Even though "diff --cached HEAD" is probably one of the least often
   used form of the diff from end users' point of view (you would run at
   most once before making an actual commit to give it a final review), it
   is more often used than a casual observer realizes, because it is the
   way Porcelains check what changes, if any, are staged.

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
1.6.3.1.56.gd00e3.dirty
