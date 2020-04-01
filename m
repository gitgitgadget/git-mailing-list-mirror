Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30FC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0A52078B
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgDAKYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:58056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728242AbgDAKYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 06:24:36 -0400
Received: (qmail 1201 invoked by uid 109); 1 Apr 2020 10:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 10:24:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6716 invoked by uid 111); 1 Apr 2020 10:34:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 06:34:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 06:24:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: fast-import's hash table is slow
Message-ID: <20200401102435.GD60227@coredump.intra.peff.net>
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <c0398484-15f4-e5c2-d229-82037094417c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0398484-15f4-e5c2-d229-82037094417c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 01:21:08AM +0200, René Scharfe wrote:

> >> +	pos = kh_put_object_entry_set(&object_table, (struct object_entry *)oid, &was_empty);
> >
> > Now this looks illegal.  khash is surely reading a full object_entry from oid,
> > which only is a mere object_id, no?
> 
> No, it's a set of pointers, and khash only accesses the referenced objects
> via the hash and comparison functions.
> 
> Storing the objects directly in the set and getting rid of new_object()
> could improve performance due to reduced dereferencing overhead -- or
> make it slower because more data has to be copied when the hashmap needs
> to grow.  Worth a shot.  Later.

Yeah. I tried that, too, but it caused tons of test failures. Quite
possibly just a bug in my patch, which I did as quickly as possible. But
I think it performed about the same. Here it is for reference (though
you may be better off to start from scratch).

Note the "this is OK to cast from oid to object_entry" comment is
leftover from the earlier attempt, but it probably _isn't_ OK. Even
though we don't do anything actionable on the non-oid bytes, they do get
passed by value, which could mean reading random bytes.

---
diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..5a1b451971 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -39,18 +39,24 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	struct object_entry *next;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 };
 
-struct object_entry_pool {
-	struct object_entry_pool *next_pool;
-	struct object_entry *next_free;
-	struct object_entry *end;
-	struct object_entry entries[FLEX_ARRAY]; /* more */
-};
+static inline unsigned int object_entry_hash(struct object_entry oe)
+{
+	return oidhash(&oe.idx.oid);
+}
+
+static inline int object_entry_equal(struct object_entry a,
+				     struct object_entry b)
+{
+	return oideq(&a.idx.oid, &b.idx.oid);
+}
+
+KHASH_INIT(object_entry_set, struct object_entry, int, 0,
+	   object_entry_hash, object_entry_equal);
 
 struct mark_set {
 	union {
@@ -176,9 +182,7 @@ static struct packed_git **all_packs;
 static off_t pack_size;
 
 /* Table of objects we've written. */
-static unsigned int object_entry_alloc = 5000;
-static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static kh_object_entry_set_t object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -428,71 +432,44 @@ static void set_checkpoint_signal(void)
 
 #endif
 
-static void alloc_objects(unsigned int cnt)
-{
-	struct object_entry_pool *b;
-
-	b = xmalloc(sizeof(struct object_entry_pool)
-		+ cnt * sizeof(struct object_entry));
-	b->next_pool = blocks;
-	b->next_free = b->entries;
-	b->end = b->entries + cnt;
-	blocks = b;
-	alloc_count += cnt;
-}
-
-static struct object_entry *new_object(struct object_id *oid)
-{
-	struct object_entry *e;
-
-	if (blocks->next_free == blocks->end)
-		alloc_objects(object_entry_alloc);
-
-	e = blocks->next_free++;
-	oidcpy(&e->idx.oid, oid);
-	return e;
-}
-
 static struct object_entry *find_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e;
-	for (e = object_table[h]; e; e = e->next)
-		if (oideq(oid, &e->idx.oid))
-			return e;
+	/*
+	 * this cast works because we only look at the oid part of the entry,
+	 * and it comes first in the struct
+	 */
+	khiter_t pos = kh_get_object_entry_set(&object_table,
+					       *(struct object_entry *)oid);
+	if (pos != kh_end(&object_table))
+		return &kh_key(&object_table, pos);
 	return NULL;
 }
 
 static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e = object_table[h];
+	struct object_entry e;
+	int was_empty;
+	khiter_t pos;
 
-	while (e) {
-		if (oideq(oid, &e->idx.oid))
-			return e;
-		e = e->next;
-	}
+	oidcpy(&e.idx.oid, oid);
+	e.idx.offset = 0;
+	pos = kh_put_object_entry_set(&object_table, e, &was_empty);
 
-	e = new_object(oid);
-	e->next = object_table[h];
-	e->idx.offset = 0;
-	object_table[h] = e;
-	return e;
+	return &kh_key(&object_table, pos);
 }
 
 static void invalidate_pack_id(unsigned int id)
 {
-	unsigned int h;
 	unsigned long lu;
 	struct tag *t;
+	khiter_t iter;
 
-	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
-		struct object_entry *e;
-
-		for (e = object_table[h]; e; e = e->next)
+	for (iter = kh_begin(&object_table); iter != kh_end(&object_table); iter++) {
+		if (kh_exist(&object_table, iter)) {
+			struct object_entry *e = &kh_key(&object_table, iter);
 			if (e->pack_id == id)
 				e->pack_id = MAX_PACK_ID;
+		}
 	}
 
 	for (lu = 0; lu < branch_table_sz; lu++) {
@@ -766,15 +743,18 @@ static const char *create_index(void)
 	const char *tmpfile;
 	struct pack_idx_entry **idx, **c, **last;
 	struct object_entry *e;
-	struct object_entry_pool *o;
+	khiter_t iter;
 
 	/* Build the table of object IDs. */
 	ALLOC_ARRAY(idx, object_count);
 	c = idx;
-	for (o = blocks; o; o = o->next_pool)
-		for (e = o->next_free; e-- != o->entries;)
+	for (iter = kh_begin(&object_table); iter != kh_end(&object_table); iter++) {
+		if (kh_exist(&object_table, iter)) {
+			e = &kh_key(&object_table, iter);
 			if (pack_id == e->pack_id)
 				*c++ = &e->idx;
+		}
+	}
 	last = idx + object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
@@ -3504,7 +3484,6 @@ int cmd_main(int argc, const char **argv)
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
 
-	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
 	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
 	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
