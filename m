Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72241F954
	for <e@80x24.org>; Tue, 21 Aug 2018 19:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHUW2b (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:28:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:50774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727233AbeHUW2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:28:31 -0400
Received: (qmail 6982 invoked by uid 109); 21 Aug 2018 19:07:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 19:07:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26110 invoked by uid 111); 21 Aug 2018 19:07:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 15:07:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 15:07:05 -0400
Date:   Tue, 21 Aug 2018 15:07:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180821190705.GF30764@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821184140.GA24165@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we serve a fetch, we pass the "wants" and "haves" from
the fetch negotiation to pack-objects. That tells us not
only which objects we need to send, but we also use the
boundary commits as "preferred bases": their trees and blobs
are candidates for delta bases, both for reusing on-disk
deltas and for finding new ones.

However, this misses some opportunities. Modulo some special
cases like shallow or partial clones, we know that every
object reachable from the "haves" could be a preferred base.
We don't use all of them for two reasons:

  1. It's expensive to traverse the whole history and
     enumerate all of the objects the other side has.

  2. The delta search is expensive, so we want to keep the
     number of candidate bases sane. The boundary commits
     are the most likely to work.

When we have reachability bitmaps, though, reason 1 no
longer applies. We can efficiently compute the set of
reachable objects on the other side (and in fact already did
so as part of the bitmap set-difference to get the list of
interesting objects). And using this set conveniently
covers the shallow and partial cases, since we have to
disable the use of bitmaps for those anyway.

The second reason argues against using these bases in the
search for new deltas. But there's one case where we can use
this information for free: when we have an existing on-disk
delta that we're considering reusing, we can do so if we
know the other side has the base object. This in fact saves
time during the delta search, because it's one less delta we
have to compute.

And that's exactly what this patch does: when we're
considering whether to reuse an on-disk delta, if bitmaps
tell us the other side has the object (and we're making a
thin-pack), then we reuse it.

Here are the results on p5311 using linux.git, which
simulates a client fetching after `N` days since their last
fetch:

Test                         origin              HEAD
--------------------------------------------------------------------------
5311.3: server   (1 days)    0.27(0.27+0.04)     0.12(0.09+0.03) -55.6%
5311.4: size     (1 days)               0.9M              237.0K -73.7%
5311.5: client   (1 days)    0.04(0.05+0.00)     0.10(0.10+0.00) +150.0%
5311.7: server   (2 days)    0.34(0.42+0.04)     0.13(0.10+0.03) -61.8%
5311.8: size     (2 days)               1.5M              347.7K -76.5%
5311.9: client   (2 days)    0.07(0.08+0.00)     0.16(0.15+0.01) +128.6%
5311.11: server   (4 days)   0.56(0.77+0.08)     0.13(0.10+0.02) -76.8%
5311.12: size     (4 days)              2.8M              566.6K -79.8%
5311.13: client   (4 days)   0.13(0.15+0.00)     0.34(0.31+0.02) +161.5%
5311.15: server   (8 days)   0.97(1.39+0.11)     0.30(0.25+0.05) -69.1%
5311.16: size     (8 days)              4.3M                1.0M -76.0%
5311.17: client   (8 days)   0.20(0.22+0.01)     0.53(0.52+0.01) +165.0%
5311.19: server  (16 days)   1.52(2.51+0.12)     0.30(0.26+0.03) -80.3%
5311.20: size    (16 days)              8.0M                2.0M -74.5%
5311.21: client  (16 days)   0.40(0.47+0.03)     1.01(0.98+0.04) +152.5%
5311.23: server  (32 days)   2.40(4.44+0.20)     0.31(0.26+0.04) -87.1%
5311.24: size    (32 days)             14.1M                4.1M -70.9%
5311.25: client  (32 days)   0.70(0.90+0.03)     1.81(1.75+0.06) +158.6%
5311.27: server  (64 days)   11.76(26.57+0.29)   0.55(0.50+0.08) -95.3%
5311.28: size    (64 days)             89.4M               47.4M -47.0%
5311.29: client  (64 days)   5.71(9.31+0.27)     15.20(15.20+0.32) +166.2%
5311.31: server (128 days)   16.15(36.87+0.40)   0.91(0.82+0.14) -94.4%
5311.32: size   (128 days)            134.8M              100.4M -25.5%
5311.33: client (128 days)   9.42(16.86+0.49)    25.34(25.80+0.46) +169.0%

In all cases we save CPU time on the server (sometimes
significant) and the resulting pack is smaller. We do spend
more CPU time on the client side, because it has to
reconstruct more deltas. But that's the right tradeoff to
make, since clients tend to outnumber servers. It just means
the thin pack mechanism is doing its job.

From the user's perspective, the end-to-end time of the
operation will generally be faster. E.g., in the 128-day
case, we saved 15s on the server at a cost of 16s on the
client. Since the resulting pack is 34MB smaller, this is a
net win if the network speed is less than 270Mbit/s. And
that's actually the worst case. The 64-day case saves just
over 11s at a cost of just under 11s. So it's a slight win
at any network speed, and the 40MB saved is pure bonus. That
trend continues for the smaller fetches.

The implementation itself is mostly straightforward, with
the new logic going into check_object(). But there are two
tricky bits.

The first is that check_object() needs access to the
relevant information (the thin flag and bitmap result). We
can do this by pushing these into program-lifetime globals.

The second is that the rest of the code assumes that any
reused delta will point to another "struct object_entry" as
its base. But of course the case we are interested in here
is the one where don't have such an entry!

I looked at a number of options that didn't quite work:

 - we could use a flag to signal a reused delta, but it's
   not a single bit. We have to actually store the oid of
   the base, which is normally done by pointing to the
   existing object_entry. And we'd have to modify all the
   code which looks at deltas.

 - we could add the reused bases to the end of the existing
   object_entry array. While this does create some extra
   work as later stages consider the extra entries, it's
   actually not too bad (we're not sending them, so they
   don't cost much in the delta search, and at most we'd
   have 2*N of them).

   But there's a more subtle problem. Adding to the existing
   array means we might need to grow it with realloc, which
   could move the earlier entries around. While many of the
   references to other entries are done by integer index,
   some (including ones on the stack) use pointers, which
   would become invalidated.

   This isn't insurmountable, but it would require quite a
   bit of refactoring (and it's hard to know that you've got
   it all, since it may work _most_ of the time and then
   fail subtly based on memory allocation patterns).

 - we could allocate a new one-off entry for the base. In
   fact, this is what an earlier version of this patch did.
   However, since the refactoring brought in by ad635e82d6
   (Merge branch 'nd/pack-objects-pack-struct', 2018-05-23),
   the delta_idx code requires that both entries be in the
   main packing list.

So taking all of those options into account, what I ended up
with is a separate list of "external bases" that are not
part of the main packing list. Each delta entry that points
to an external base has a single-bit flag to do so; we have a
little breathing room in the bitfield section of
object_entry.

This lets us limit the change primarily to the oe_delta()
and oe_set_delta_ext() functions. And as a bonus, most of
the rest of the code does not consider these dummy entries
at all, saving both runtime CPU and code complexity.

Signed-off-by: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 28 +++++++++++++++++++---------
 pack-objects.c         | 19 +++++++++++++++++++
 pack-objects.h         | 20 ++++++++++++++++++--
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0d80dee2ba..1bd43432f7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -40,6 +40,7 @@
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
 #define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_EXT(obj, oid) oe_set_delta_ext(&to_pack, obj, oid)
 #define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
@@ -59,6 +60,7 @@ static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
 static uint32_t nr_result, nr_written, nr_seen;
+static struct bitmap_index *bitmap_git;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -79,6 +81,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -1510,11 +1513,15 @@ static void check_object(struct object_entry *entry)
 			break;
 		}
 
-		if (base_ref && (base_entry = packlist_find(&to_pack, base_ref, NULL))) {
+		if (base_ref && (
+		    (base_entry = packlist_find(&to_pack, base_ref, NULL)) ||
+		    (thin &&
+		     bitmap_has_sha1_in_uninteresting(bitmap_git, base_ref)))) {
 			/*
 			 * If base_ref was set above that means we wish to
-			 * reuse delta data, and we even found that base
-			 * in the list of objects we want to pack. Goodie!
+			 * reuse delta data, and either we found that object in
+			 * the list of objects we want to pack, or it's one we
+			 * know the receiver has.
 			 *
 			 * Depth value does not matter - find_deltas() will
 			 * never consider reused delta as the base object to
@@ -1523,10 +1530,16 @@ static void check_object(struct object_entry *entry)
 			 */
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
-			SET_DELTA(entry, base_entry);
 			SET_DELTA_SIZE(entry, in_pack_size);
-			entry->delta_sibling_idx = base_entry->delta_child_idx;
-			SET_DELTA_CHILD(base_entry, entry);
+
+			if (base_entry) {
+				SET_DELTA(entry, base_entry);
+				entry->delta_sibling_idx = base_entry->delta_child_idx;
+				SET_DELTA_CHILD(base_entry, entry);
+			} else {
+				SET_DELTA_EXT(entry, base_ref);
+			}
+
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -2954,7 +2967,6 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	struct bitmap_index *bitmap_git;
 	if (!(bitmap_git = prepare_bitmap_walk(revs)))
 		return -1;
 
@@ -2970,7 +2982,6 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	}
 
 	traverse_bitmap_commit_list(bitmap_git, &add_object_entry_from_bitmap);
-	free_bitmap_index(bitmap_git);
 	return 0;
 }
 
@@ -3118,7 +3129,6 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
-	int thin = 0;
 	int shallow = 0;
 	int all_progress_implied = 0;
 	struct argv_array rp = ARGV_ARRAY_INIT;
diff --git a/pack-objects.c b/pack-objects.c
index 92708522e7..9ae0cecd81 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -177,3 +177,22 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 	return new_entry;
 }
+
+void oe_set_delta_ext(struct packing_data *pdata,
+		      struct object_entry *delta,
+		      const unsigned char *sha1)
+{
+	struct object_entry *base;
+
+	ALLOC_GROW(pdata->ext_bases, pdata->nr_ext + 1, pdata->alloc_ext);
+	base = &pdata->ext_bases[pdata->nr_ext++];
+	memset(base, 0, sizeof(*base));
+	hashcpy(base->idx.oid.hash, sha1);
+
+	/* These flags mark that we are not part of the actual pack output. */
+	base->preferred_base = 1;
+	base->filled = 1;
+
+	delta->ext_base = 1;
+	delta->delta_idx = base - pdata->ext_bases + 1;
+}
diff --git a/pack-objects.h b/pack-objects.h
index 08c6b57d49..3fd10b15c9 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -111,6 +111,7 @@ struct object_entry {
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned char in_pack_header_size;
 	unsigned depth:OE_DEPTH_BITS;
+	unsigned ext_base:1; /* delta_idx points outside packlist */
 
 	/*
 	 * pahole results on 64-bit linux (gcc and clang)
@@ -141,6 +142,14 @@ struct packing_data {
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
 
+	/*
+	 * This list contains entries for bases which we know the other side
+	 * has (e.g., via reachability bitmaps), but which aren't in our
+	 * "objects" list.
+	 */
+	struct object_entry *ext_bases;
+	uint32_t nr_ext, alloc_ext;
+
 	uintmax_t oe_size_limit;
 };
 
@@ -228,9 +237,12 @@ static inline struct object_entry *oe_delta(
 		const struct packing_data *pack,
 		const struct object_entry *e)
 {
-	if (e->delta_idx)
+	if (!e->delta_idx)
+		return NULL;
+	if (e->ext_base)
+		return &pack->ext_bases[e->delta_idx - 1];
+	else
 		return &pack->objects[e->delta_idx - 1];
-	return NULL;
 }
 
 static inline void oe_set_delta(struct packing_data *pack,
@@ -243,6 +255,10 @@ static inline void oe_set_delta(struct packing_data *pack,
 		e->delta_idx = 0;
 }
 
+void oe_set_delta_ext(struct packing_data *pack,
+		      struct object_entry *e,
+		      const unsigned char *sha1);
+
 static inline struct object_entry *oe_delta_child(
 		const struct packing_data *pack,
 		const struct object_entry *e)
-- 
2.19.0.rc0.398.g138a08f6f6
