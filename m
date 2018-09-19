Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4757A1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 03:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeISJZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 05:25:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725875AbeISJZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 05:25:04 -0400
Received: (qmail 5448 invoked by uid 109); 19 Sep 2018 03:49:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Sep 2018 03:49:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14113 invoked by uid 111); 19 Sep 2018 03:49:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 23:49:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 23:49:07 -0400
Date:   Tue, 18 Sep 2018 23:49:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] pack-objects: handle island check for "external" delta base
Message-ID: <20180919034907.GA7626@sigill.intra.peff.net>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 02:56:36PM -0700, Junio C Hamano wrote:

> * cc/delta-islands (2018-08-16) 7 commits
>   (merged to 'next' on 2018-08-27 at cf3d7bd93f)
>  + pack-objects: move 'layer' into 'struct packing_data'
>  + pack-objects: move tree_depth into 'struct packing_data'
>  + t5320: tests for delta islands
>  + repack: add delta-islands support
>  + pack-objects: add delta-islands support
>  + pack-objects: refactor code into compute_layer_order()
>  + Add delta-islands.{c,h}
> 
>  Lift code from GitHub to restrict delta computation so that an
>  object that exists in one fork is not made into a delta against
>  another object that does not appear in the same forked repository.
> 
>  Will merge to 'master'.

This needed some conflict resolution with my pack-bitmap-reuse-delta
topic, but there's a subtle bug in the result that went to 'master'.
Details and a fix below.

As a side note, I did this same resolution myself at least twice (for my
personal build and for porting the refreshed delta-reuse series to our
GitHub build), and I wrote the exact same resolution you did both times.
So I think it was an easy mistake to make. :)

-Peff

-- >8 --
Subject: pack-objects: handle island check for "external" delta base

Two recent topics, jk/pack-delta-reuse-with-bitmap and
cc/delta-islands, can have a funny interaction. When
checking if we can reuse an on-disk delta, the first topic
allows base_entry to be NULL when we find an object that's
not in the packing list. But the latter topic introduces a
call to in_same_island(), which needs to look at
base_entry->idx.oid. When these two features are used
together, we might try to dereference a NULL base_entry.

In practice, this doesn't really happen. We'd generally only
use delta islands when packing to disk, since the whole
point is to optimize the pack for serving fetches later. And
the new delta-reuse code relies on having used reachability
bitmaps to determine the set of objects, which we would
typically only do when serving an actual fetch.

However, it is technically possible to combine these
features. And even without doing so, building with
"SANITIZE=address,undefined" will cause t5310.46 to
complain.  Even though that test does not have delta islands
enabled, we still take the address of the NULL entry to pass
to in_same_island(). That function then promptly returns
without dereferencing the value when it sees that islands
are not enabled, but it's enough to trigger a sanitizer
error.

The solution is straight-forward: when both features are
used together, we should pass the oid of the found base to
in_same_island().

This is tricky to do inside a single "if" statement. And
after the merge in f3504ea3dd (Merge branch
'cc/delta-islands', 2018-09-17), that "if" condition is
already getting pretty unwieldy. So this patch moves the
logic into a helper function, where we can easily use
multiple return paths. The result is a bit longer, but the
logic should be much easier to follow.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 68 ++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5041818ddf..27cb674124 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1470,6 +1470,57 @@ static void cleanup_preferred_base(void)
 	done_pbase_paths_num = done_pbase_paths_alloc = 0;
 }
 
+/*
+ * Return 1 iff the object specified by "delta" can be sent
+ * literally as a delta against the base in "base_sha1". If
+ * so, then *base_out will point to the entry in our packing
+ * list, or NULL if we must use the external-base list.
+ *
+ * Depth value does not matter - find_deltas() will
+ * never consider reused delta as the base object to
+ * deltify other objects against, in order to avoid
+ * circular deltas.
+ */
+static int can_reuse_delta(const unsigned char *base_sha1,
+			   struct object_entry *delta,
+			   struct object_entry **base_out)
+{
+	struct object_entry *base;
+
+	if (!base_sha1)
+		return 0;
+
+	/*
+	 * First see if we're already sending the base (or it's explicitly in
+	 * our "excluded" list.
+	 */
+	base = packlist_find(&to_pack, base_sha1, NULL);
+	if (base) {
+		if (!in_same_island(&delta->idx.oid, &base->idx.oid))
+			return 0;
+		*base_out = base;
+		return 1;
+	}
+
+	/*
+	 * Otherwise, reachability bitmaps may tell us if the receiver has it,
+	 * even if it was buried too deep in history to make it into the
+	 * packing list.
+	 */
+	if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, base_sha1)) {
+		if (use_delta_islands) {
+			struct object_id base_oid;
+			hashcpy(base_oid.hash, base_sha1);
+			if (!in_same_island(&delta->idx.oid, &base_oid))
+				return 0;
+		}
+		*base_out = NULL;
+		return 1;
+	}
+
+	return 0;
+}
+
 static void check_object(struct object_entry *entry)
 {
 	unsigned long canonical_size;
@@ -1556,22 +1607,7 @@ static void check_object(struct object_entry *entry)
 			break;
 		}
 
-		if (base_ref && (
-		    (base_entry = packlist_find(&to_pack, base_ref, NULL)) ||
-		    (thin &&
-		     bitmap_has_sha1_in_uninteresting(bitmap_git, base_ref))) &&
-		    in_same_island(&entry->idx.oid, &base_entry->idx.oid)) {
-			/*
-			 * If base_ref was set above that means we wish to
-			 * reuse delta data, and either we found that object in
-			 * the list of objects we want to pack, or it's one we
-			 * know the receiver has.
-			 *
-			 * Depth value does not matter - find_deltas() will
-			 * never consider reused delta as the base object to
-			 * deltify other objects against, in order to avoid
-			 * circular deltas.
-			 */
+		if (can_reuse_delta(base_ref, entry, &base_entry)) {
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA_SIZE(entry, in_pack_size);
-- 
2.19.0.745.g75ede3edf3

