Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C87A1F97E
	for <e@80x24.org>; Tue, 20 Nov 2018 09:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeKTURN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:17:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:45476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726250AbeKTURM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:17:12 -0500
Received: (qmail 21432 invoked by uid 109); 20 Nov 2018 09:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 09:48:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27039 invoked by uid 111); 20 Nov 2018 09:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 04:48:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 04:48:57 -0500
Date:   Tue, 20 Nov 2018 04:48:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/3] pack-objects: zero-initialize tree_depth/layer arrays
Message-ID: <20181120094856.GB22742@sigill.intra.peff.net>
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
packing_data', 2018-08-16) started maintaining a tree_depth array that
matches the "objects" array. We extend the array when:

  1. The objects array is extended, in which case we use realloc to
     extend the tree_depth array.

  2. A caller asks to store a tree_depth for object N, and this is the
     first such request; we create the array from scratch and store the
     value for N.

In the latter case, though, we use regular xmalloc(), and the depth
values for any objects besides N is undefined. This happens to not
trigger a bug with the current code, but the reasons are quite subtle:

 - we never ask about the depth for any object with index i < N. This is
   because we store the depth immediately for all trees and blobs. So
   any such "i" must be a non-tree, and therefore we will never need to
   care about its depth (in fact, we really only care about the depth of
   trees).

 - there are no objects at this point with index i > N, because we
   always fill in the depth for a tree immediately after its object
   entry is created (we may still allocate uninitialized depth entries,
   but they'll be initialized by packlist_alloc() when it initializes
   the entry in the "objects" array).

So it works, but only by chance. To be defensive, let's zero the array,
which matches the "unset" values which would be handed out by
oe_tree_depth() already.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 1 +
 pack-objects.h    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f16058182f..09b0102cae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -861,6 +861,7 @@ extern FILE *fopen_or_warn(const char *path, const char *mode);
 #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
 
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
+#define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)));
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
 
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
diff --git a/pack-objects.h b/pack-objects.h
index f31ac1c81c..dc869f26c2 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -412,7 +412,7 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 				     unsigned int tree_depth)
 {
 	if (!pack->tree_depth)
-		ALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
+		CALLOC_ARRAY(pack->tree_depth, pack->nr_alloc);
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
@@ -429,7 +429,7 @@ static inline void oe_set_layer(struct packing_data *pack,
 				unsigned char layer)
 {
 	if (!pack->layer)
-		ALLOC_ARRAY(pack->layer, pack->nr_alloc);
+		CALLOC_ARRAY(pack->layer, pack->nr_alloc);
 	pack->layer[e - pack->objects] = layer;
 }
 
-- 
2.20.0.rc0.715.gf6b01ab3e1

