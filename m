Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AED21F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfFTHl1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:45376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:27 -0400
Received: (qmail 16628 invoked by uid 109); 20 Jun 2019 07:41:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12878 invoked by uid 111); 20 Jun 2019 07:42:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:25 -0400
Date:   Thu, 20 Jun 2019 03:41:25 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/17] khash: drop broken oid_map typedef
Message-ID: <20190620074124.GJ3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5a8643eff1 (khash: move oid hash table definition, 2019-02-19)
added a khash "oid_map" type to match the existing "oid" type, which is
a simple set (i.e., just keys, no values). But in setting up the
khash_oid_map typedef, it accidentally referred to "kh_oid_t", which is
the set type.

Nobody noticed the breakage because there are not yet any callers; the
type was added just as a match to the existing sha1 types (whose map
type confusingly _is_ called khash_sha1, and it has no matching set
type).

We could easily fix this with s/oid/oid_map/ in the typedef. But let's
take this a step further, and just drop the typedef entirely.  These
typedefs were added by 5a8643eff1 to match the khash_sha1 typedefs. But
the actual khash-derived type names are descriptive enough; this is just
adding an extra layer of indirection. The khash names do not quite
follow our usual style (e.g., they end in "_t"), but since we end up
using other khash names (e.g., khiter_t, kh_get_oid()) anyway, just
typedef-ing the struct name is not really helping much.

And there are already many cases where we use the raw khash type names
anyway (e.g., the "set" variant defined just above us does not have such
a typedef!).

So let's drop this typedef, and the matching oid_pos one (which actually
_does_ have a user, but we can easily convert it).

We'll leave the khash_sha1 typedef around. The ultimate fate of its
callers should be conversion to kh_oid_map_t, so there's no point in
going through the noise of changing the names now.

Signed-off-by: Jeff King <peff@peff.net>
---
 khash.h       | 2 --
 pack-bitmap.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/khash.h b/khash.h
index af747a683f..64d4eeb2bd 100644
--- a/khash.h
+++ b/khash.h
@@ -345,9 +345,7 @@ static inline int oid_equal(struct object_id a, struct object_id b)
 KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
 
 KHASH_INIT(oid_map, struct object_id, void *, 1, oid_hash, oid_equal)
-typedef kh_oid_t khash_oid_map;
 
 KHASH_INIT(oid_pos, struct object_id, int, 1, oid_hash, oid_equal)
-typedef kh_oid_pos_t khash_oid_pos;
 
 #endif /* __AC_KHASH_H */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ff1f07e249..998133588f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -365,7 +365,7 @@ struct include_data {
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
-	khash_oid_pos *positions = bitmap_git->ext_index.positions;
+	kh_oid_pos_t *positions = bitmap_git->ext_index.positions;
 	khiter_t pos = kh_get_oid_pos(positions, *oid);
 
 	if (pos < kh_end(positions)) {
-- 
2.22.0.732.g5402924b4b

