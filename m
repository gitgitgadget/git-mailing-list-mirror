Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11945C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33B12082E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgBCOk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:40:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:51340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727540AbgBCOk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 09:40:57 -0500
Received: (qmail 2932 invoked by uid 109); 3 Feb 2020 14:40:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Feb 2020 14:40:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25063 invoked by uid 111); 3 Feb 2020 14:49:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2020 09:49:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Feb 2020 09:40:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] index-pack: downgrade twice-resolved REF_DELTA to die()
Message-ID: <20200203144055.GA4170731@coredump.intra.peff.net>
References: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're resolving a REF_DELTA, we compare-and-swap its type from
REF_DELTA to whatever real type the base object has, as discussed in
ab791dd138 (index-pack: fix race condition with duplicate bases,
2014-08-29). If the old type wasn't a REF_DELTA, we consider that a
BUG(). But as discussed in that commit, we might see this case whenever
we try to resolve an object twice, which may happen because we have
multiple copies of the base object.

So this isn't a bug at all, but rather a sign that the input pack is
broken. And indeed, this case is triggered already in t5309.5 and
t5309.6, which create packs with delta cycles and duplicate bases. But
we never noticed because those tests are marked expect_failure.

Those tests were added by b2ef3d9ebb (test index-pack on packs with
recoverable delta cycles, 2013-08-23), which was leaving the door open
for cases that we theoretically _could_ handle. And when we see an
already-resolved object like this, in theory we could keep going after
confirming that the previously resolved child->real_type matches
base->obj->real_type. But:

  - enforcing the "only resolve once" rule here saves us from an
    infinite loop in other parts of the code. If we keep going, then the
    delta cycle in t5309.5 causes us to loop infinitely, as
    find_ref_delta_children() doesn't realize which objects have already
    been resolved. So there would be more changes needed to make this
    case work, and in the meantime we'd be worse off.

  - any pack that triggers this is broken anyway. It either has a
    duplicate base object, or it has a cycle which causes us to bring in
    a duplicate via --fix-thin. In either case, we'd end up rejecting
    the pack in write_idx_file(), which also detects duplicates.

So the tests have little value in documenting what we _could_ be doing
(and have been neglected for 6+ years). Let's switch them to confirming
that we handle this case cleanly (and switch out the BUG() for a more
informative die() so that we do so).

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed while running the tests in an environment that complains about
SIGABRT deaths. Arguably the test suite should be looking for these even
in test_expect_failure, but it would be a little convoluted to do so
(e.g., teaching BUG() to write to a marker file, and then checking the
file). And I think we're better off phrasing things as much as possible
as expect_success anyway.

 builtin/index-pack.c         | 4 +++-
 t/t5309-pack-delta-cycles.sh | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a5591039..41a7c11c8e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1003,7 +1003,9 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		if (!compare_and_swap_type(&child->real_type, OBJ_REF_DELTA,
 					   base->obj->real_type))
-			BUG("child->real_type != OBJ_REF_DELTA");
+			die("REF_DELTA at offset %"PRIuMAX" already resolved (duplicate base %s?)",
+			    (uintmax_t)child->idx.offset,
+			    oid_to_hex(&base->obj->idx.oid));
 
 		resolve_delta(child, base, result);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 491556dad9..6c209ad45c 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -62,13 +62,13 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 	test_must_fail git index-pack --fix-thin --stdin <cycle.pack
 '
 
-test_expect_failure 'failover to an object in another pack' '
+test_expect_success 'failover to an object in another pack' '
 	clear_packs &&
 	git index-pack --stdin <ab.pack &&
-	git index-pack --stdin --fix-thin <cycle.pack
+	test_must_fail git index-pack --stdin --fix-thin <cycle.pack
 '
 
-test_expect_failure 'failover to a duplicate object in the same pack' '
+test_expect_success 'failover to a duplicate object in the same pack' '
 	clear_packs &&
 	{
 		pack_header 3 &&
@@ -77,7 +77,7 @@ test_expect_failure 'failover to a duplicate object in the same pack' '
 		pack_obj $A
 	} >recoverable.pack &&
 	pack_trailer recoverable.pack &&
-	git index-pack --fix-thin --stdin <recoverable.pack
+	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
 '
 
 test_done
-- 
2.25.0.541.gdfd61ebb85
