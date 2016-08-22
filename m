Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0D21F859
	for <e@80x24.org>; Mon, 22 Aug 2016 21:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756380AbcHVV6C (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 17:58:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:59290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756363AbcHVV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 17:58:02 -0400
Received: (qmail 29516 invoked by uid 109); 22 Aug 2016 21:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:58:01 +0000
Received: (qmail 17512 invoked by uid 111); 22 Aug 2016 21:58:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 17:58:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:57:58 -0400
Date:   Mon, 22 Aug 2016 17:57:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] release_delta_base_cache: reuse existing detach function
Message-ID: <20160822215758.uamavr7koin3ze6c@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function drops an entry entirely from the cache,
meaning that aside from the freeing of the buffer, it is
exactly equivalent to detach_delta_base_cache_entry(). Let's
build on top of the detach function, which shortens the code
and will make it simpler when we change out the underlying
storage in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1d0810c..8264b39 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2152,10 +2152,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 {
 	if (ent->data) {
 		free(ent->data);
-		ent->data = NULL;
-		ent->lru.next->prev = ent->lru.prev;
-		ent->lru.prev->next = ent->lru.next;
-		delta_base_cached -= ent->size;
+		detach_delta_base_cache_entry(ent);
 	}
 }
 
-- 
2.10.0.rc1.118.ge2299eb

