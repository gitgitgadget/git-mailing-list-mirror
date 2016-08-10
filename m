Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770501FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940970AbcHJTJr (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:09:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932754AbcHJTJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:09:45 -0400
Received: (qmail 21482 invoked by uid 109); 10 Aug 2016 12:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 12:03:03 +0000
Received: (qmail 31188 invoked by uid 111); 10 Aug 2016 12:03:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 08:03:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 08:03:01 -0400
Date:	Wed, 10 Aug 2016 08:03:01 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/2] pack-objects: use mru list when iterating over packs
Message-ID: <20160810120301.cof3pd3mseb2cb4r@sigill.intra.peff.net>
References: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810115206.l57qpehpabthnl6c@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the original implementation of want_object_in_pack(), we
always looked for the object in every pack, so the order did
not matter for performance.

As of the last few patches, however, we can now often break
out of the loop early after finding the first instance, and
avoid looking in the other packs at all. In this case, pack
order can make a big difference, because we'd like to find
the objects by looking at as few packs as possible.

This patch switches us to the same packed_git_mru list that
is now used by normal object lookups.

Here are timings for p5303 on linux.git:

Test                      HEAD^                HEAD
------------------------------------------------------------------------
5303.3: rev-list (1)      31.31(31.07+0.23)    31.28(31.00+0.27) -0.1%
5303.4: repack (1)        40.35(38.84+2.60)    40.53(39.31+2.32) +0.4%
5303.6: rev-list (50)     31.37(31.15+0.21)    31.41(31.16+0.24) +0.1%
5303.7: repack (50)       58.25(68.54+2.03)    47.28(57.66+1.89) -18.8%
5303.9: rev-list (1000)   31.91(31.57+0.33)    31.93(31.64+0.28) +0.1%
5303.10: repack (1000)    304.80(376.00+3.92)  87.21(159.54+2.84) -71.4%

The rev-list numbers are unchanged, which makes sense (they
are not exercising this code at all). The 50- and 1000-pack
repack cases show considerable improvement.

The single-pack repack case doesn't, of course; there's
nothing to improve. In fact, it gives us a baseline for how
fast we could possibly go. You can see that though rev-list
can approach the single-pack case even with 1000 packs,
repack doesn't. The reason is simple: the loop we are
optimizing is only part of what the repack is doing. After
the "counting" phase, we do delta compression, which is much
more expensive when there are multiple packs, because we
have fewer deltas we can reuse (you can also see that these
numbers come from a multicore machine; the CPU times are
much higher than the wall-clock times due to the delta
phase).

So the good news is that in cases with many packs, we used
to be dominated by the "counting" phase, and now we are
dominated by the delta compression (which is faster, and
which we have already parallelized).

Here are similar numbers for git.git:

Test                      HEAD^               HEAD
---------------------------------------------------------------------
5303.3: rev-list (1)      1.55(1.51+0.02)     1.54(1.53+0.00) -0.6%
5303.4: repack (1)        1.82(1.80+0.08)     1.82(1.78+0.09) +0.0%
5303.6: rev-list (50)     1.58(1.57+0.00)     1.58(1.56+0.01) +0.0%
5303.7: repack (50)       2.50(3.12+0.07)     2.31(2.95+0.06) -7.6%
5303.9: rev-list (1000)   2.22(2.20+0.02)     2.23(2.19+0.03) +0.5%
5303.10: repack (1000)    10.47(16.78+0.22)   7.50(13.76+0.22) -28.4%

Not as impressive in terms of percentage, but still
measurable wins.  If you look at the wall-clock time
improvements in the 1000-pack case, you can see that linux
improved by roughly 10x as many seconds as git. That's
because it has roughly 10x as many objects, and we'd expect
this improvement to scale linearly with the number of
objects (since the number of packs is kept constant). It's
just that the "counting" phase is a smaller percentage of
the total time spent for a git.git repack, and hence the
percentage win is smaller.

The implementation itself is a straightforward use of the
MRU code. We only bother marking a pack as used when we know
that we are able to break early out of the loop, for two
reasons:

  1. If we can't break out early, it does no good; we have
     to visit each pack anyway, so we might as well avoid
     even the minor overhead of managing the cache order.

  2. The mru_mark() function reorders the list, which would
     screw up our traversal. So it is only safe to mark when
     we are about to break out of the loop. We could record
     the found pack and mark it after the loop finishes, of
     course, but that's more complicated and it doesn't buy
     us anything due to (1).

Note that this reordering does have a potential impact on
the final pack, as we store only a single "found" pack for
each object, even if it is present in multiple packs. In
principle, any copy is acceptable, as they all refer to the
same content. But in practice, they may differ in whether
they are stored as deltas, against which base, etc. This may
have an impact on delta reuse, and even the delta search
(since we skip pairs that were already in the same pack).

It's not clear whether this change of order would hurt or
even help average cases, though. The most likely reason to
have duplicate objects is from the completion of thin packs
(e.g., you have some objects in a "base" pack, then receive
several pushes; the packs you receive may be thin on the
wire, with deltas that refer to bases outside the pack, but
we complete them with duplicate base objects when indexing
them).

In such a case the current code would always find the thin
duplicates (because we currently walk the packs in reverse
chronological order). Whereas with this patch, some of those
duplicates would be found in the base pack instead.

In my tests repacking a real-world case of linux.git with
3600 thin-pack pushes (on top of a large "base" pack), the
resulting pack was about 0.04% larger with this patch. On
the other hand, because we were more likely to hit the base
pack, there were more opportunities for delta reuse, and we
had 50,000 fewer objects to examine in the delta search.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3e30eae..f89a206 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -23,6 +23,7 @@
 #include "reachable.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "mru.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -958,7 +959,7 @@ static int want_object_in_pack(const unsigned char *sha1,
 			       struct packed_git **found_pack,
 			       off_t *found_offset)
 {
-	struct packed_git *p;
+	struct mru_entry *entry;
 
 	if (!exclude && local && has_loose_object_nonlocal(sha1))
 		return 0;
@@ -966,7 +967,8 @@ static int want_object_in_pack(const unsigned char *sha1,
 	*found_pack = NULL;
 	*found_offset = 0;
 
-	for (p = packed_git; p; p = p->next) {
+	for (entry = packed_git_mru->head; entry; entry = entry->next) {
+		struct packed_git *p = entry->item;
 		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			if (!*found_pack) {
@@ -993,8 +995,10 @@ static int want_object_in_pack(const unsigned char *sha1,
 			 * out of the loop to return 1 now.
 			 */
 			if (!ignore_packed_keep &&
-			    (!local || !have_non_local_packs))
+			    (!local || !have_non_local_packs)) {
+				mru_mark(packed_git_mru, entry);
 				break;
+			}
 
 			if (local && !p->pack_local)
 				return 0;
-- 
2.9.2.790.gaa5bc72
