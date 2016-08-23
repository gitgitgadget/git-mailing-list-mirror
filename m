Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1421F859
	for <e@80x24.org>; Tue, 23 Aug 2016 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756284AbcHWAsV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 20:48:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:59399 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755468AbcHWAsU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 20:48:20 -0400
Received: (qmail 7331 invoked by uid 109); 23 Aug 2016 00:48:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Aug 2016 00:48:14 +0000
Received: (qmail 19012 invoked by uid 111); 23 Aug 2016 00:48:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 20:48:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 20:48:11 -0400
Date:   Mon, 22 Aug 2016 20:48:11 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/7] delta_base_cache: use list.h for LRU
Message-ID: <20160823004811.n3yuthgrxaheivzn@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
 <20160822215942.nm2jcrkyib7acr4u@sigill.intra.peff.net>
 <20160822231806.GA26148@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822231806.GA26148@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 11:18:06PM +0000, Eric Wong wrote:

> > As a bonus, the list_entry() macro lets us place the lru
> > pointers anywhere inside the delta_base_cache_entry struct
> > (as opposed to just casting the pointer, which requires it
> > at the front of the struct). This will be useful in later
> > patches when we need to place other items at the front of
> > the struct (e.g., our hashmap implementation requires this).
> 
> On a side note, I think we should s/list_entry/container_of/ and
> use container_of for hashmap.
> 
> Linux kernel defines list_entry to use container_of,
> but I'd rather avoid introducing the duality entirely.

That does make it slightly more annoying to use, since container_of()
requires naming the original type again (because of our lack of typeof),
whereas now you can freely cast between "struct hashmap_entry" and the
actual item. But if you are proposing to actually fix the hashmap to
eliminate the requirement to put the entry at the front, that might have
value (I'm not sure how easy it is to do, though; a lot of those casts
happen inside the hashmap code which is type-agnostic).

> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I think the result is much nicer, but I found list_entry() a little
> > disappointing, because we lack typeof(). So you are stuck writing:
> > 
> >   struct delta_base_cache_entry *f =
> >     list_entry(p, struct delta_base_cache_entry, lru);
> > 
> > I waffled on adding something like:
> > 
> >   LIST_ITEM(struct delta_bas_cache_entry, f, p, lru);
> > 
> > to declare "f" as above. But it's getting rather magical and un-C-like.
> 
> Right.  I'd rather keep the list_entry/container_of usage
> identical to what developers familiar using userspace-rcu,
> ccan/list, or the Linux kernel expect.

Makes sense. I am not familiar with those APIs myself, but I do not see
any reason to deviate from them for no good reason.

> >  sha1_file.c | 38 ++++++++++++++++----------------------
> >  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> Good to see the code reduction.

Yep. I realized the "hashmap must go at the front of the struct" thing
later. My initial reason for converting was actually to make the
"separate blob LRU" patch easier (since without this patch, it literally
doubles the amount of pointer manipulation required).

For reference, in case anybody wants to duplicate my experiments from
patch 5, that patch looks like this:

diff --git a/sha1_file.c b/sha1_file.c
index 2cd1b79..e82be30 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2076,7 +2076,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 static size_t delta_base_cached;
 
-static LIST_HEAD(delta_base_cache_lru);
+static LIST_HEAD(delta_base_cache_lru_blobs);
+static LIST_HEAD(delta_base_cache_lru_other);
 
 static struct delta_base_cache_entry {
 	struct list_head lru;
@@ -2170,15 +2171,14 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	release_delta_base_cache(ent);
 	delta_base_cached += base_size;
 
-	list_for_each(lru, &delta_base_cache_lru) {
+	list_for_each(lru, &delta_base_cache_lru_blobs) {
 		struct delta_base_cache_entry *f =
 			list_entry(lru, struct delta_base_cache_entry, lru);
 		if (delta_base_cached <= delta_base_cache_limit)
 			break;
-		if (f->type == OBJ_BLOB)
-			release_delta_base_cache(f);
+		release_delta_base_cache(f);
 	}
-	list_for_each(lru, &delta_base_cache_lru) {
+	list_for_each(lru, &delta_base_cache_lru_other) {
 		struct delta_base_cache_entry *f =
 			list_entry(lru, struct delta_base_cache_entry, lru);
 		if (delta_base_cached <= delta_base_cache_limit)
@@ -2191,7 +2191,10 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	ent->type = type;
 	ent->data = base;
 	ent->size = base_size;
-	list_add_tail(&ent->lru, &delta_base_cache_lru);
+	if (type == OBJ_BLOB)
+		list_add_tail(&ent->lru, &delta_base_cache_lru_blobs);
+	else
+		list_add_tail(&ent->lru, &delta_base_cache_lru_other);
 }
 
 static void *read_object(const unsigned char *sha1, enum object_type *type,

-Peff
