Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B27E1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 22:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbcHVWAF (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:00:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:59297 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756447AbcHVWAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:00:04 -0400
Received: (qmail 29644 invoked by uid 109); 22 Aug 2016 21:59:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:59:45 +0000
Received: (qmail 17577 invoked by uid 111); 22 Aug 2016 21:59:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 17:59:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:59:42 -0400
Date:   Mon, 22 Aug 2016 17:59:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/7] delta_base_cache: use list.h for LRU
Message-ID: <20160822215942.nm2jcrkyib7acr4u@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We keep an LRU list of entries for when we need to drop
something from an over-full cache. The list is implemented
as a circular doubly-linked list, which is exactly what
list.h provides. We can save a few lines by using the list.h
macros and functions. More importantly, this makes the code
easier to follow, as the reader sees explicit concepts like
"list_add_tail()" instead of pointer manipulation.

As a bonus, the list_entry() macro lets us place the lru
pointers anywhere inside the delta_base_cache_entry struct
(as opposed to just casting the pointer, which requires it
at the front of the struct). This will be useful in later
patches when we need to place other items at the front of
the struct (e.g., our hashmap implementation requires this).

Signed-off-by: Jeff King <peff@peff.net>
---
I think the result is much nicer, but I found list_entry() a little
disappointing, because we lack typeof(). So you are stuck writing:

  struct delta_base_cache_entry *f =
    list_entry(p, struct delta_base_cache_entry, lru);

I waffled on adding something like:

  LIST_ITEM(struct delta_bas_cache_entry, f, p, lru);

to declare "f" as above. But it's getting rather magical and un-C-like.

 sha1_file.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8264b39..c02e785 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -24,6 +24,7 @@
 #include "streaming.h"
 #include "dir.h"
 #include "mru.h"
+#include "list.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -2077,13 +2078,10 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 static size_t delta_base_cached;
 
-static struct delta_base_cache_lru_list {
-	struct delta_base_cache_lru_list *prev;
-	struct delta_base_cache_lru_list *next;
-} delta_base_cache_lru = { &delta_base_cache_lru, &delta_base_cache_lru };
+static LIST_HEAD(delta_base_cache_lru);
 
 static struct delta_base_cache_entry {
-	struct delta_base_cache_lru_list lru;
+	struct list_head lru;
 	void *data;
 	struct packed_git *p;
 	off_t base_offset;
@@ -2128,8 +2126,7 @@ static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
 static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 {
 	ent->data = NULL;
-	ent->lru.next->prev = ent->lru.prev;
-	ent->lru.prev->next = ent->lru.next;
+	list_del(&ent->lru);
 	delta_base_cached -= ent->size;
 }
 
@@ -2168,24 +2165,24 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 {
 	unsigned long hash = pack_entry_hash(p, base_offset);
 	struct delta_base_cache_entry *ent = delta_base_cache + hash;
-	struct delta_base_cache_lru_list *lru;
+	struct list_head *lru;
 
 	release_delta_base_cache(ent);
 	delta_base_cached += base_size;
 
-	for (lru = delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru != &delta_base_cache_lru;
-	     lru = lru->next) {
-		struct delta_base_cache_entry *f = (void *)lru;
+	list_for_each(lru, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *f =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		if (delta_base_cached <= delta_base_cache_limit)
+			break;
 		if (f->type == OBJ_BLOB)
 			release_delta_base_cache(f);
 	}
-	for (lru = delta_base_cache_lru.next;
-	     delta_base_cached > delta_base_cache_limit
-	     && lru != &delta_base_cache_lru;
-	     lru = lru->next) {
-		struct delta_base_cache_entry *f = (void *)lru;
+	list_for_each(lru, &delta_base_cache_lru) {
+		struct delta_base_cache_entry *f =
+			list_entry(lru, struct delta_base_cache_entry, lru);
+		if (delta_base_cached <= delta_base_cache_limit)
+			break;
 		release_delta_base_cache(f);
 	}
 
@@ -2194,10 +2191,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	ent->type = type;
 	ent->data = base;
 	ent->size = base_size;
-	ent->lru.next = &delta_base_cache_lru;
-	ent->lru.prev = delta_base_cache_lru.prev;
-	delta_base_cache_lru.prev->next = &ent->lru;
-	delta_base_cache_lru.prev = &ent->lru;
+	list_add_tail(&ent->lru, &delta_base_cache_lru);
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,
-- 
2.10.0.rc1.118.ge2299eb

