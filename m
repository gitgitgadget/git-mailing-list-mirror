Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51179203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 09:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbcHKJ5R (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 05:57:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:53540 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbcHKJ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 05:57:13 -0400
Received: (qmail 2190 invoked by uid 109); 11 Aug 2016 09:57:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 09:57:12 +0000
Received: (qmail 8522 invoked by uid 111); 11 Aug 2016 09:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 05:57:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 05:57:10 -0400
Date:	Thu, 11 Aug 2016 05:57:10 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5] pack-objects mru
Message-ID: <20160811095710.p2bffympjlwmv3gc@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
 <20160810120248.i2hvm2q6ag3rvsk4@sigill.intra.peff.net>
 <xmqqr39w4bvx.fsf@gitster.mtv.corp.google.com>
 <20160811050252.g3iusy7bp3j6tzte@sigill.intra.peff.net>
 <20160811065751.p64bi3sngbeotwc3@sigill.intra.peff.net>
 <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 05:20:30AM -0400, Jeff King wrote:

> Here it is. It ended up needing a few preparatory patches.
> 
>   [1/4]: provide an initializer for "struct object_info"
>   [2/4]: sha1_file: make packed_object_info public
>   [3/4]: pack-objects: break delta cycles before delta-search phase
>   [4/4]: pack-objects: use mru list when iterating over packs
> 
> I had originally intended to include an extra patch to handle the
> --depth limits better. But after writing it, I'm not sure it's actually
> a good idea. I'll post it as an addendum with more discussion.

And here's the depth patch. It does work, as you can see by running the
snippet at the bottom of the commit message.

But I began to wonder if it's actually a desirable thing. For instance,
if you do:

  git gc --aggressive
  ... time passes ...
  git gc

the first gc may generate chains up to 250 objects. When the second gc
runs (and you may not even run it yourself; it might be "gc --auto"!),
it will generally reuse most of your existing deltas, even though the
default depth is only 50.

But with the patch below, it will drop deltas from the middle of those
long chains, undoing the prior --aggressive results. Worse, we don't
find new deltas for those objects, because it falls afoul of the "they
are in the same pack, so don't bother looking for a delta" rule.

An --aggressive repack of my git.git is 52MB. Repacking that with the
patch below and "--depth=50" bumps it to 55MB. Dumping the "do not
bother" condition in try_delta() drops that to 54MB.

So it _is_ worse for the space to drop those high-depth deltas. Even if
we fixed the "do not bother" (e.g., by recording a bit that says "even
though these are in the same pack, try anyway, because we had to break
the delta for other reasons"), it's still a loss.

OTOH, I am not altogether convinced that the tradeoff of a giant --depth
is worth. I'm looking only at the space here, but deeper delta chains
cost more CPU to access (especially if they start to exceed the delta
cache size). And the space savings aren't that amazing. Doing a "git
repack -adf --depth=50 --window=250" (i.e., if aggressive had just
tweaked the window size and not the depth in the first place), the
result is only 53MB.

So considering "--depth" as a space-saving measure for --aggressive does
not seem that effective. But it feels weird to quietly drop actions
people might have done with previous aggressive runs.

-- >8 --
Subject: [PATCH] pack-objects: enforce --depth limit in reused deltas

Since 898b14c (pack-objects: rework check_delta_limit usage,
2007-04-16), we check the delta depth limit only when
figuring out whether we should make a new delta. We don't
consider it at all when reusing deltas, which means that
packing once with --depth=50, and then against with
--depth=10, the second pack my still contain chains larger
than 10.

This is probably not a huge deal, as it is limited to
whatever chains you happened to create in a previous run.
But as we start allowing cross-pack delta reuse in a future
commit, this maximum will rise to the number of packs times
the per-pack depth (in the worst case; on average, it will
likely be much smaller).

We can easily detect this as part of the existing search for
cycles, since we visit every node in a depth-first way. That
lets us compute the depth of any node based on the depth of
its base, because we know the base is DFS_DONE by the time
we look at it (modulo any cycles in the graph, but we know
there cannot be any because we break them as we see them).

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

Unfortunately there is no automated test, because it's hard
to convince pack-objects to reliably produce delta chains.
Naively, it would seem that a sequence of ever-increasing
blobs would work. E.g., something like:

  for i in 1 2 3 4 5; do
          test-genrandom $i 4096 >>file
          git add file
          git commit -m $i
  done

where a reasonable set of deltas would use "1:file" as the
base, then "2:file" as a delta against that, "3:file" as a
delta against "2:file", and so on, until we have a chain
with length 5.

But the delta search is much more fickle than that. It tends
to prefer deletions to additions (because they are smaller
than additions), so it prefers "5:file" as the base, and
then the deltas just say "remove N bytes from the end".
Moreover, the delta search has heuristics that penalize
increasing depth. So packing the script above actually ends
up with 2 chains of length 2.

So I've punted on adding an automated test. One can see the
effect on a real-world repository by repacking it with a
small --depth value, like:

  max_depth() {
    for i in .git/objects/pack/*.pack; do
      git verify-pack -v $i
    done |
    perl -lne '
      /chain length = (\d+)/ or next;
      $max = $1 if $1 > $max;
      END { print $max }
    '
  }

  echo "before: $(max_depth)"
  git repack -ad --depth=5
  echo "after: $(max_depth)"

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 15 +++++++++++++++
 pack-objects.h         |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 32c1dba..d8132a4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1505,6 +1505,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
  *   2. Updating our size/type to the non-delta representation. These were
  *      either not recorded initially (size) or overwritten with the delta type
  *      (type) when check_object() decided to reuse the delta.
+ *
+ *   3. Resetting our delta depth, as we are now a base object.
  */
 static void drop_reused_delta(struct object_entry *entry)
 {
@@ -1518,6 +1520,7 @@ static void drop_reused_delta(struct object_entry *entry)
 			p = &(*p)->delta_sibling;
 	}
 	entry->delta = NULL;
+	entry->depth = 0;
 
 	oi.sizep = &entry->size;
 	oi.typep = &entry->type;
@@ -1536,6 +1539,9 @@ static void drop_reused_delta(struct object_entry *entry)
  * Follow the chain of deltas from this entry onward, throwing away any links
  * that cause us to hit a cycle (as determined by the DFS state flags in
  * the entries).
+ *
+ * We also detect too-long reused chains that would violate our --depth
+ * limit.
  */
 static void break_delta_chains(struct object_entry *entry)
 {
@@ -1553,6 +1559,15 @@ static void break_delta_chains(struct object_entry *entry)
 		 */
 		entry->dfs_state = DFS_ACTIVE;
 		break_delta_chains(entry->delta);
+
+		/*
+		 * Once we've recursed, our base knows its depth, so we can
+		 * compute ours (and check it against the limit).
+		 */
+		entry->depth = entry->delta->depth + 1;
+		if (entry->depth > depth)
+			drop_reused_delta(entry);
+
 		entry->dfs_state = DFS_DONE;
 		break;
 
diff --git a/pack-objects.h b/pack-objects.h
index cc9b9a9..03f1191 100644
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
-- 
2.9.2.790.gaa5bc72

