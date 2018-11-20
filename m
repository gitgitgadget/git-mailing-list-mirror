Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8B91F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeKTUOy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:14:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:45466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726250AbeKTUOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:14:53 -0500
Received: (qmail 21328 invoked by uid 109); 20 Nov 2018 09:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 09:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27020 invoked by uid 111); 20 Nov 2018 09:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 04:46:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 04:46:38 -0500
Date:   Tue, 20 Nov 2018 04:46:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/3] pack-objects: fix tree_depth and layer invariants
Message-ID: <20181120094638.GA22742@sigill.intra.peff.net>
References: <20181120094451.GA21725@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120094451.GA21725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 108f530385 (pack-objects: move tree_depth into 'struct
packing_data', 2018-08-16) dynamically manages a tree_depth array in
packing_data that maintains one of these invariants:

  1. tree_depth is NULL (i.e., the requested options don't require us to
     track tree depths)

  2. tree_depth is non-NULL and has as many entries as the "objects"
     array

We maintain (2) by:

  a. When the objects array grows, grow tree_depth to the same size
     (unless it's NULL, in which case we can leave it).

  b. When a caller asks to set a depth via oe_set_tree_depth(), if
     tree_depth is NULL we allocate it.

But in (b), we use the number of stored objects, _not_ the allocated
size of the objects array. So we can run into a situation like this:

  1. packlist_alloc() needs to store the Nth object, so it grows the
     objects array to M, where M > N.

  2. oe_set_tree_depth() wants to store a depth, so it allocates an
     array of length N. Now we've violated our invariant.

  3. packlist_alloc() needs to store the N+1th object. But it _doesn't_
     grow the objects array, since N <= M still holds. We try to assign
     to tree_depth[N+1], which is out of bounds.

That doesn't happen in our test scripts, because the repositories they
use are so small, but it's easy to trigger by running:

  echo HEAD | git pack-objects --revs --delta-islands --stdout >/dev/null

in any reasonably-sized repo (like git.git).

We can fix it by always growing the array to match pack->nr_alloc, not
pack->nr_objects. Likewise for the "layer" array from fe0ac2fb7f
(pack-objects: move 'layer' into 'struct packing_data', 2018-08-16),
which has the same bug.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-objects.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index feb6a6a05e..f31ac1c81c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -412,7 +412,7 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 				     unsigned int tree_depth)
 {
 	if (!pack->tree_depth)
-		ALLOC_ARRAY(pack->tree_depth, pack->nr_objects);
+		ALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
@@ -429,7 +429,7 @@ static inline void oe_set_layer(struct packing_data *pack,
 				unsigned char layer)
 {
 	if (!pack->layer)
-		ALLOC_ARRAY(pack->layer, pack->nr_objects);
+		ALLOC_ARRAY(pack->layer, pack->nr_alloc);
 	pack->layer[e - pack->objects] = layer;
 }
 
-- 
2.20.0.rc0.715.gf6b01ab3e1

