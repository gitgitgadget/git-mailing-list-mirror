Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B32C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE9B20658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBXE3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:29:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:52298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727189AbgBXE3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:29:45 -0500
Received: (qmail 5182 invoked by uid 109); 24 Feb 2020 04:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:29:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6874 invoked by uid 111); 24 Feb 2020 04:38:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:38:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:29:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 02/10] pack-objects: read delta base oid into object_id struct
Message-ID: <20200224042944.GB1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're considering reusing an on-disk delta, we get the oid of the
base as a pointer to unsigned char bytes of the hash, either into the
packfile itself (for REF_DELTA) or into the pack idx (using the revindex
to convert the offset into an index entry).

Instead, we'd prefer to use a more type-safe object_id as much as
possible. We can get the pack idx using nth_packed_object_id() instead.
For the packfile bytes, we can copy them out using oidread().

This doesn't even incur an extra copy overall, since the next thing we'd
always do with that pointer is pass it to can_reuse_delta(), which needs
an object_id anyway (and called oidread() itself). So this patch also
converts that function to take the object_id directly.

Note that we did previously use NULL as a sentinel value when the object
isn't a delta. We could probably get away with using the null oid for
this, but instead we'll use an explicit boolean flag, which should make
things more obvious for people reading the code later.

Signed-off-by: Jeff King <peff@peff.net>
---
Astute readers may notice that if we didn't do the error-conversion in
the previous patch, we could keep the sentinel value semantics with
something like:

  struct object_id *base_ref = NULL;
  struct object_id base_ref_storage;
  ...
  base_ref = nth_packed_object_oid(&base_ref_storage, p, nr);

but that's not any fewer lines, and IMHO it's much less obvious what's
going on compared to the boolean flag I used here.

 builtin/pack-objects.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de8335e2bd..8692ab3fe6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1618,23 +1618,17 @@ static void cleanup_preferred_base(void)
  * deltify other objects against, in order to avoid
  * circular deltas.
  */
-static int can_reuse_delta(const unsigned char *base_sha1,
+static int can_reuse_delta(const struct object_id *base_oid,
 			   struct object_entry *delta,
 			   struct object_entry **base_out)
 {
 	struct object_entry *base;
-	struct object_id base_oid;
-
-	if (!base_sha1)
-		return 0;
-
-	oidread(&base_oid, base_sha1);
 
 	/*
 	 * First see if we're already sending the base (or it's explicitly in
 	 * our "excluded" list).
 	 */
-	base = packlist_find(&to_pack, &base_oid);
+	base = packlist_find(&to_pack, base_oid);
 	if (base) {
 		if (!in_same_island(&delta->idx.oid, &base->idx.oid))
 			return 0;
@@ -1647,9 +1641,9 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 	 * even if it was buried too deep in history to make it into the
 	 * packing list.
 	 */
-	if (thin && bitmap_has_oid_in_uninteresting(bitmap_git, &base_oid)) {
+	if (thin && bitmap_has_oid_in_uninteresting(bitmap_git, base_oid)) {
 		if (use_delta_islands) {
-			if (!in_same_island(&delta->idx.oid, &base_oid))
+			if (!in_same_island(&delta->idx.oid, base_oid))
 				return 0;
 		}
 		*base_out = NULL;
@@ -1666,7 +1660,8 @@ static void check_object(struct object_entry *entry)
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
-		const unsigned char *base_ref = NULL;
+		int have_base = 0;
+		struct object_id base_ref;
 		struct object_entry *base_entry;
 		unsigned long used, used_0;
 		unsigned long avail;
@@ -1707,9 +1702,13 @@ static void check_object(struct object_entry *entry)
 			unuse_pack(&w_curs);
 			return;
 		case OBJ_REF_DELTA:
-			if (reuse_delta && !entry->preferred_base)
-				base_ref = use_pack(p, &w_curs,
-						entry->in_pack_offset + used, NULL);
+			if (reuse_delta && !entry->preferred_base) {
+				oidread(&base_ref,
+					use_pack(p, &w_curs,
+						 entry->in_pack_offset + used,
+						 NULL));
+				have_base = 1;
+			}
 			entry->in_pack_header_size = used + the_hash_algo->rawsz;
 			break;
 		case OBJ_OFS_DELTA:
@@ -1739,13 +1738,15 @@ static void check_object(struct object_entry *entry)
 				revidx = find_pack_revindex(p, ofs);
 				if (!revidx)
 					goto give_up;
-				base_ref = nth_packed_object_sha1(p, revidx->nr);
+				if (!nth_packed_object_id(&base_ref, p, revidx->nr))
+					have_base = 1;
 			}
 			entry->in_pack_header_size = used + used_0;
 			break;
 		}
 
-		if (can_reuse_delta(base_ref, entry, &base_entry)) {
+		if (have_base &&
+		    can_reuse_delta(&base_ref, entry, &base_entry)) {
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA_SIZE(entry, in_pack_size);
@@ -1755,7 +1756,7 @@ static void check_object(struct object_entry *entry)
 				entry->delta_sibling_idx = base_entry->delta_child_idx;
 				SET_DELTA_CHILD(base_entry, entry);
 			} else {
-				SET_DELTA_EXT(entry, base_ref);
+				SET_DELTA_EXT(entry, base_ref.hash);
 			}
 
 			unuse_pack(&w_curs);
-- 
2.25.1.823.g95c5488cf7

