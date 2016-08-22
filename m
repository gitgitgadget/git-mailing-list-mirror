Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAC81F859
	for <e@80x24.org>; Mon, 22 Aug 2016 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756330AbcHVV56 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 17:57:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59289 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756303AbcHVV55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 17:57:57 -0400
Received: (qmail 29512 invoked by uid 109); 22 Aug 2016 21:57:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:57:56 +0000
Received: (qmail 17509 invoked by uid 111); 22 Aug 2016 21:57:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 17:57:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:57:53 -0400
Date:   Mon, 22 Aug 2016 17:57:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] clear_delta_base_cache_entry: use a more descriptive name
Message-ID: <20160822215753.xy7hlho7niex3wpm@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The delta base cache entries are stored in a fixed-length
hash table. So the way to remove an entry is to "clear" the
slot in the table, and that is what this function does.

However, the name is a leaky abstraction. If we were to
change the hash table implementation, it would no longer be
about "clearing". We should name it after _what_ it does,
not _how_ it does it. I.e., something like "remove" instead
of "clear".

But that does not tell the whole story, either. The subtle
thing about this function is that it removes the entry, but
does not free the entry data. So a more descriptive name is
"detach"; we give ownership of the data buffer to the
caller, and remove any other resources.

This patch uses the name detach_delta_base_cache_entry().
We could further model this after functions like
strbuf_detach(), which pass back all of the detached
information. However, since there are so many bits of
information in the struct (the data, the size, the type),
and so few callers (only one), it's not worth that
awkwardness. The name change and a comment can make the
intent clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2333911..1d0810c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2120,7 +2120,12 @@ static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
 	return eq_delta_base_cache_entry(ent, p, base_offset);
 }
 
-static void clear_delta_base_cache_entry(struct delta_base_cache_entry *ent)
+/*
+ * Remove the entry from the cache, but do _not_ free the associated
+ * entry data. The caller takes ownership of the "data" buffer, and
+ * should copy out any fields it wants before detaching.
+ */
+static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 {
 	ent->data = NULL;
 	ent->lru.next->prev = ent->lru.prev;
@@ -2243,7 +2248,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 			type = ent->type;
 			data = ent->data;
 			size = ent->size;
-			clear_delta_base_cache_entry(ent);
+			detach_delta_base_cache_entry(ent);
 			base_from_cache = 1;
 			break;
 		}
-- 
2.10.0.rc1.118.ge2299eb

