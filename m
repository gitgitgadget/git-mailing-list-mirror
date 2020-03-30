Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2DC2D0EE
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F320409
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgC3OJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:09:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:55662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725268AbgC3OJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:09:31 -0400
Received: (qmail 15228 invoked by uid 109); 30 Mar 2020 14:09:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:09:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18866 invoked by uid 111); 30 Mar 2020 14:19:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:19:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:09:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] oid_array: use size_t for count and allocation
Message-ID: <20200330140930.GA2456104@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
 <20200330140309.GA2456038@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140309.GA2456038@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 10:03:10AM -0400, Jeff King wrote:

> The oid_array object uses an "int" to store the number of items and the
> allocated size. It's rather unlikely for somebody to have more than 2^31
> objects in a repository (the sha1's alone would be 40GB!), but if they
> do, we'd overflow our alloc variable.
> 
> You can reproduce this case with something like:
> 
>   git init repo
>   cd repo
> 
>   # make a pack with 2^24 objects
>   perl -e '
>     my $nr = 2**24;
> 
>     for (my $i = 0; $i < $nr; $i++) {
> 	    print "blob\n";
> 	    print "data 4\n";
> 	    print pack("N", $i);
>     }
>   ' | git fast-import

I briefly tried to create a packfile manually that had a ton of objects
in it, thinking it would be faster. Conceptually it's pretty simple to
write a pack header, and then a series of pack-object headers (which are
the same single-byte each time) and then a 4-byte body. But you have to
zlib compress the body, which created a bunch of headaches.

So I arrived at this fast-import solution, which was...not super fast.
Profiling showed that we were spending 80% of the time inserting into
our custom hashtable, which is fixed at 2^16 entries and then chains
beyond that. Swapping it out for a khash proved much faster, but I'm not
sure if the memory games are too gross (see the comment in find_object
below).

I also didn't look into whether we could get rid of the extra allocating
pool (and store the structs right in the hash), or if it's necessary for
their pointers to be stable.

---
diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..427dd73d26 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -39,12 +39,25 @@
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	struct object_entry *next;
 	uint32_t type : TYPE_BITS,
 		pack_id : PACK_ID_BITS,
 		depth : DEPTH_BITS;
 };
 
+static inline unsigned int object_entry_hash(struct object_entry *oe)
+{
+	return oidhash(&oe->idx.oid);
+}
+
+static inline int object_entry_equal(struct object_entry *a,
+				     struct object_entry *b)
+{
+	return oideq(&a->idx.oid, &b->idx.oid);
+}
+
+KHASH_INIT(object_entry_set, struct object_entry *, int, 0,
+	   object_entry_hash, object_entry_equal);
+
 struct object_entry_pool {
 	struct object_entry_pool *next_pool;
 	struct object_entry *next_free;
@@ -178,7 +191,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
-static struct object_entry *object_table[1 << 16];
+static kh_object_entry_set_t object_table;
 static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
@@ -455,44 +468,40 @@ static struct object_entry *new_object(struct object_id *oid)
 
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
+					       (struct object_entry *)oid);
+	if (pos != kh_end(&object_table))
+		return kh_key(&object_table, pos);
 	return NULL;
 }
 
 static struct object_entry *insert_object(struct object_id *oid)
 {
-	unsigned int h = oid->hash[0] << 8 | oid->hash[1];
-	struct object_entry *e = object_table[h];
-
-	while (e) {
-		if (oideq(oid, &e->idx.oid))
-			return e;
-		e = e->next;
-	}
+	struct object_entry *e;
+	int redundant;
 
 	e = new_object(oid);
-	e->next = object_table[h];
 	e->idx.offset = 0;
-	object_table[h] = e;
+	kh_put_object_entry_set(&object_table, e, &redundant);
 	return e;
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
+			struct object_entry *e = kh_key(&object_table, iter);
 			if (e->pack_id == id)
 				e->pack_id = MAX_PACK_ID;
+		}
 	}
 
 	for (lu = 0; lu < branch_table_sz; lu++) {
