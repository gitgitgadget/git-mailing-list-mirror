Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67E31F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdA0WC7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:02:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:46094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdA0WCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:02:54 -0500
Received: (qmail 32741 invoked by uid 109); 27 Jan 2017 22:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 22:02:35 +0000
Received: (qmail 11888 invoked by uid 111); 27 Jan 2017 22:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:02:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 17:02:33 -0500
Date:   Fri, 27 Jan 2017 17:02:33 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] pack-objects: enforce --depth limit in reused deltas
Message-ID: <20170127220233.mwg36mgxdklwz7lr@sigill.intra.peff.net>
References: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 898b14c (pack-objects: rework check_delta_limit usage,
2007-04-16), we check the delta depth limit only when
figuring out whether we should make a new delta. We don't
consider it at all when reusing deltas, which means that
packing once with --depth=250, and then again with
--depth=50, the second pack my still contain chains larger
than 50.

This is generally considered a feature, as the results of
earlier high-depth repacks are carried forward, used for
serving fetches, etc. However, since we started using
cross-pack deltas in c9af708b1 (pack-objects: use mru list
when iterating over packs, 2016-08-11), we are no longer
bounded by the length of an existing delta chain in a single
pack.

Here's one particular pathological case: a sequence of N
packs, each with 2 objects, the base of which is stored as a
delta in a previous pack. If we chain all the deltas
together, we have a cycle of length N. We break the cycle,
but the tip delta is still at depth N-1.

This is less unlikely than it might sound. See the included
test for a reconstruction based on real-world actions.  I
ran into such a case in the wild, where a client was rapidly
sending packs, and we had accumulated 10,000 before doing a
server-side repack.  The pack that "git repack" tried to
generate had a very deep chain, which caused pack-objects to
run out of stack space in the recursive write_one().

This patch bounds the length of delta chains in the output
pack based on --depth, regardless of whether they are caused
by cross-pack deltas or existed in the input packs. This
fixes the problem, but does have two possible downsides:

  1. High-depth aggressive repacks followed by "normal"
     repacks will throw away the high-depth chains.

     In the long run this is probably OK; investigation
     showed that high-depth repacks aren't actually
     beneficial, and we dropped the aggressive depth default
     to match the normal case in 07e7dbf0d (gc: default
     aggressive depth to 50, 2016-08-11).

  2. If you really do want to store high-depth deltas on
     disk, they may be discarded and new delta computed when
     serving a fetch, unless you set pack.depth to match
     your high-depth size.

The implementation uses the existing search for delta
cycles.  That lets us compute the depth of any node based on
the depth of its base, because we know the base is DFS_DONE
by the time we look at it (modulo any cycles in the graph,
but we know there cannot be any because we break them as we
see them).

There is some subtlety worth mentioning, though. We record
the depth of each object as we compute it. It might seem
like we could save the per-object storage space by just
keeping track of the depth of our traversal (i.e., have
break_delta_chains() report how deep it went). But we may
visit an object through multiple delta paths, and on
subsequent paths we want to know its depth immediately,
without having to walk back down to its final base (doing so
would make our graph walk quadratic rather than linear).

Likewise, one could try to record the depth not from the
base, but from our starting point (i.e., start
recursion_depth at 0, and pass "recursion_depth + 1" to each
invocation of break_delta_chains()). And then when
recursion_depth gets too big, we know that we must cut the
delta chain.  But that technique is wrong if we do not visit
the nodes in topological order. In a chain A->B->C, it
if we visit "C", then "B", then "A", we will never recurse
deeper than 1 link (because we see at each node that we have
already visited it).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c      | 18 +++++++++
 pack-objects.h              |  4 ++
 t/t5316-pack-delta-depth.sh | 93 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100755 t/t5316-pack-delta-depth.sh

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8841f8b36..2b08c8121 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1539,6 +1539,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
  *   2. Updating our size/type to the non-delta representation. These were
  *      either not recorded initially (size) or overwritten with the delta type
  *      (type) when check_object() decided to reuse the delta.
+ *
+ *   3. Resetting our delta depth, as we are now a base object.
  */
 static void drop_reused_delta(struct object_entry *entry)
 {
@@ -1552,6 +1554,7 @@ static void drop_reused_delta(struct object_entry *entry)
 			p = &(*p)->delta_sibling;
 	}
 	entry->delta = NULL;
+	entry->depth = 0;
 
 	oi.sizep = &entry->size;
 	oi.typep = &entry->type;
@@ -1570,6 +1573,9 @@ static void drop_reused_delta(struct object_entry *entry)
  * Follow the chain of deltas from this entry onward, throwing away any links
  * that cause us to hit a cycle (as determined by the DFS state flags in
  * the entries).
+ *
+ * We also detect too-long reused chains that would violate our --depth
+ * limit.
  */
 static void break_delta_chains(struct object_entry *entry)
 {
@@ -1587,6 +1593,18 @@ static void break_delta_chains(struct object_entry *entry)
 		 */
 		entry->dfs_state = DFS_ACTIVE;
 		break_delta_chains(entry->delta);
+
+		/*
+		 * Once we've recursed, our base (if we still have one) knows
+		 * its depth, so we can compute ours (and check it against
+		 * the limit).
+		 */
+		if (entry->delta) {
+			entry->depth = entry->delta->depth + 1;
+			if (entry->depth > depth)
+				drop_reused_delta(entry);
+		}
+
 		entry->dfs_state = DFS_DONE;
 		break;
 
diff --git a/pack-objects.h b/pack-objects.h
index cc9b9a9b9..03f119165 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -30,12 +30,16 @@ struct object_entry {
 
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
+	 *
+	 * The depth is measured in delta-links to the base (so if A is a delta
+	 * against B, then A has a depth of 1, and B a depth of 0).
 	 */
 	enum {
 		DFS_NONE = 0,
 		DFS_ACTIVE,
 		DFS_DONE
 	} dfs_state;
+	int depth;
 };
 
 struct packing_data {
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
new file mode 100755
index 000000000..236d60fe6
--- /dev/null
+++ b/t/t5316-pack-delta-depth.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+
+test_description='pack-objects breaks long cross-pack delta chains'
+. ./test-lib.sh
+
+# This mirrors a repeated push setup:
+#
+# 1. A client repeatedly modifies some files, makes a
+#      commit, and pushes the result. It does this N times
+#      before we get around to repacking.
+#
+# 2. Each push generates a thin pack with the new version of
+#    various objects. Let's consider some file in the root tree
+#    which is updated in each commit.
+#
+#    When generating push number X, we feed commit X-1 (and
+#    thus blob X-1) as a preferred base. The resulting pack has
+#    blob X as a thin delta against blob X-1.
+#
+#    On the receiving end, "index-pack --fix-thin" will
+#    complete the pack with a base copy of tree X-1.
+#
+# 3. In older versions of git, if we used the delta from
+#    pack X, then we'd always find blob X-1 as a base in the
+#    same pack (and generate a fresh delta).
+#
+#    But with the pack mru, we jump from delta to delta
+#    following the traversal order:
+#
+#      a. We grab blob X from pack X as a delta, putting it at
+#         the tip of our mru list.
+#
+#      b. Eventually we move onto commit X-1. We need other
+#         objects which are only in pack X-1 (in the test code
+#         below, it's the containing tree). That puts pack X-1
+#         at the tip of our mru list.
+#
+#      c. Eventually we look for blob X-1, and we find the
+#         version in pack X-1 (because it's the mru tip).
+#
+# Now we have blob X as a delta against X-1, which is a delta
+# against X-2, and so forth.
+#
+# In the real world, these small pushes would get exploded by
+# unpack-objects rather than "index-pack --fix-thin", but the
+# same principle applies to larger pushes (they only need one
+# repeatedly-modified file to generate the delta chain).
+
+test_expect_success 'create series of packs' '
+	test-genrandom foo 4096 >content &&
+	prev= &&
+	for i in $(test_seq 1 10)
+	do
+		cat content >file &&
+		echo $i >>file &&
+		git add file &&
+		git commit -m $i &&
+		cur=$(git rev-parse HEAD^{tree}) &&
+		{
+			test -n "$prev" && echo "-$prev"
+			echo $cur
+			echo "$(git rev-parse :file) file"
+		} | git pack-objects --stdout >tmp &&
+		git index-pack --stdin --fix-thin <tmp || return 1
+		prev=$cur
+	done
+'
+
+max_chain() {
+	git index-pack --verify-stat-only "$1" >output &&
+	perl -lne '
+	  /chain length = (\d+)/ and $len = $1;
+	  END { print $len }
+	' output
+}
+
+# Note that this whole setup is pretty reliant on the current
+# packing heuristics. We double-check that our test case
+# actually produces a long chain. If it doesn't, it should be
+# adjusted (or scrapped if the heuristics have become too unreliable)
+test_expect_success 'packing produces a long delta' '
+	# Use --window=0 to make sure we are seeing reused deltas,
+	# not computing a new long chain.
+	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
+	test 9 = "$(max_chain pack-$pack.pack)"
+'
+
+test_expect_success '--depth limits depth' '
+	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
+	test 5 = "$(max_chain pack-$pack.pack)"
+'
+
+test_done
-- 
2.11.0.914.gb3b960f50

