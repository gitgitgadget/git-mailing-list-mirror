Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDCC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064E6206E9
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbgDALQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:16:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732258AbgDALQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:16:22 -0400
Received: (qmail 1402 invoked by uid 109); 1 Apr 2020 11:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 11:16:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7252 invoked by uid 111); 1 Apr 2020 11:26:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 07:26:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 07:16:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200401111621.GA1265072@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <20200401103522.GE60227@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401103522.GE60227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 06:35:23AM -0400, Jeff King wrote:

> > > +	/*
> > > +	 * this cast works because we only look at the oid part of the entry,
> > > +	 * and it comes first in the struct
> > > +	 */
> > > +	khiter_t pos = kh_get_object_entry_set(&object_table,
> > > +					       (struct object_entry *)oid);
> > 
> > Dirty, but I can believe the comment.
> 
> Our hashmap.c implementation gets around this by letting the equality
> function take an extra parameter. It's annoying when you're writing
> those functions, but it should allow this case without any casting (or
> preemptively allocating a struct).

And here's a patch trying that. Much to my surprise, it outperforms
khash, which has generally been faster in previous tests.

Here are the numbers I get:

nr_objects   master       khash      hashmap
2^20         0m4.317s     0m5.109s   0m3.890s
2^21         0m10.204s    0m9.702s   0m7.933s
2^22         0m27.159s    0m17.911s  0m16.751s
2^23         1m19.038s    0m35.080s  0m31.963s
2^24         4m18.766s    1m10.233s  1m6.793s

And I didn't even have to pre-size the table. This really makes me
wonder if there's some silly inefficiency in khash which we could be
addressing. Or maybe open-addressing really does lose to chaining here,
but I think we keep the load factor low enough that it should be a win.

---
diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..0ef6defc10 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -39,12 +39,28 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	struct object_entry *next;
+	struct hashmap_entry ent;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 };
 
+static int object_entry_hashcmp(const void *map_data,
+				const struct hashmap_entry *eptr,
+				const struct hashmap_entry *entry_or_key,
+				const void *keydata)
+{
+	const struct object_id *oid = keydata;
+	const struct object_entry *e1, *e2;
+
+	e1 = container_of(eptr, const struct object_entry, ent);
+	if (oid)
+		return oidcmp(&e1->idx.oid, oid);
+
+	e2 = container_of(entry_or_key, const struct object_entry, ent);
+	return oidcmp(&e1->idx.oid, &e2->idx.oid);
+}
+
 struct object_entry_pool {
 	struct object_entry_pool *next_pool;
 	struct object_entry *next_free;
@@ -178,7 +194,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static struct hashmap object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -455,44 +471,42 @@ static struct object_entry *new_object(struct object_id *oid)
 
 static struct object_entry *find_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
-		if (oideq(oid, &e->idx.oid))
-			return e;
+	struct hashmap_entry lookup_entry, *e;
+
+	hashmap_entry_init(&lookup_entry, oidhash(oid));
+	e = hashmap_get(&object_table, &lookup_entry, oid);
+	if (e)
+		return container_of(e, struct object_entry, ent);
 	return NULL;
 }
 
 static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e = object_table[h];
+	struct object_entry *e;
+	struct hashmap_entry lookup_entry, *hashent;
 
-	while (e) {
-		if (oideq(oid, &e->idx.oid))
-			return e;
-		e = e->next;
-	}
+	hashmap_entry_init(&lookup_entry, oidhash(oid));
+	hashent = hashmap_get(&object_table, &lookup_entry, oid);
+	if (hashent)
+		return container_of(hashent, struct object_entry, ent);
 
 	e = new_object(oid);
-	e->next = object_table[h];
 	e->idx.offset = 0;
-	object_table[h] = e;
+	e->ent.hash = lookup_entry.hash;
+	hashmap_add(&object_table, &e->ent);
 	return e;
 }
 
 static void invalidate_pack_id(unsigned int id)
 {
-	unsigned int h;
 	unsigned long lu;
 	struct tag *t;
+	struct hashmap_iter iter;
+	struct object_entry *e;
 
-	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
-		struct object_entry *e;
-
-		for (e = object_table[h]; e; e = e->next)
-			if (e->pack_id == id)
-				e->pack_id = MAX_PACK_ID;
+	hashmap_for_each_entry(&object_table, &iter, e, ent) {
+		if (e->pack_id == id)
+			e->pack_id = MAX_PACK_ID;
 	}
 
 	for (lu = 0; lu < branch_table_sz; lu++) {
@@ -3511,6 +3525,8 @@ int cmd_main(int argc, const char **argv)
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
 
+	hashmap_init(&object_table, object_entry_hashcmp, NULL, 0);
+
 	/*
 	 * We don't parse most options until after we've seen the set of
 	 * "feature" lines at the start of the stream (which allows the command
