Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A4E1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 21:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756295AbcHVV5t (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 17:57:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:59286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756274AbcHVV5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 17:57:48 -0400
Received: (qmail 29502 invoked by uid 109); 22 Aug 2016 21:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:57:48 +0000
Received: (qmail 17482 invoked by uid 111); 22 Aug 2016 21:57:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 17:57:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:57:45 -0400
Date:   Mon, 22 Aug 2016 17:57:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] cache_or_unpack_entry: drop keep_cache parameter
Message-ID: <20160822215744.nc3yqv64gf3hwcv4@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is only one caller of cache_or_unpack_entry() and it
always passes 1 for the keep_cache parameter. We can
simplify it by dropping the "!keep_cache" case.

Another call, which did pass 0, was dropped in abe601b
(sha1_file: remove recursion in unpack_entry, 2013-03-27),
as unpack_entry() now does more complicated things than a
simple unpack when there is a cache miss.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3045aea..2333911 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2129,25 +2129,18 @@ static void clear_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type, int keep_cache)
+	unsigned long *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
-	void *ret;
 
 	ent = get_delta_base_cache_entry(p, base_offset);
 
 	if (!eq_delta_base_cache_entry(ent, p, base_offset))
 		return unpack_entry(p, base_offset, type, base_size);
 
-	ret = ent->data;
-
-	if (!keep_cache)
-		clear_delta_base_cache_entry(ent);
-	else
-		ret = xmemdupz(ent->data, ent->size);
 	*type = ent->type;
 	*base_size = ent->size;
-	return ret;
+	return xmemdupz(ent->data, ent->size);
 }
 
 static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
@@ -2755,7 +2748,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 
 	if (!find_pack_entry(sha1, &e))
 		return NULL;
-	data = cache_or_unpack_entry(e.p, e.offset, size, type, 1);
+	data = cache_or_unpack_entry(e.p, e.offset, size, type);
 	if (!data) {
 		/*
 		 * We're probably in deep shit, but let's try to fetch
-- 
2.10.0.rc1.118.ge2299eb

