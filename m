Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C01C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364A920724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVTSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:18:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726082AbgCVTSj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 15:18:39 -0400
Received: (qmail 30476 invoked by uid 109); 22 Mar 2020 19:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 19:18:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2650 invoked by uid 111); 22 Mar 2020 19:28:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 15:28:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 15:18:38 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: looking up object types quickly, was Re: [PATCH 1/1]
 commit-graph.c: avoid unnecessary tag dereference when merging
Message-ID: <20200322191838.GA671552@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <20200321172716.GA39461@syl.local>
 <20200322053635.GA578498@coredump.intra.peff.net>
 <20200322110424.GC2224@szeder.dev>
 <20200322184519.GA654322@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322184519.GA654322@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 02:45:19PM -0400, Jeff King wrote:

> 3. To find the type of a delta object, we have to walk back to a base
>    object with a concrete type. When we access the actual object
>    contents, we cache intermediate bases to avoid digging down the same
>    chain over and over. But I don't think there's any such cache for the
>    type lookup. So if you have a 50-deep delta chain and want the type
>    of each object, you'll walk down 49 links, then 48 links, and so on.
>    It probably wouldn't be that hard to have a small type cache (or just
>    allow the existing cache to have entries for "I know the type, but
>    don't have the contents").
> 
> I suspect (1) would give the biggest speedup, but is more work and
> requires bitmaps. I think (3) is likely to give a moderate win and
> probably isn't that big a patch.

Sadly, it doesn't seem to help. Here's a hacky implementation (I tested
it only on my limited cat-file case; I wouldn't be at all surprised if
it causes problems for users of the delta cache that want the actual
object contents).

After some rudimentary profiling (which I _should_ have done in the
first place before opening my mouth), it looks like finding the types
isn't actually the most expensive thing anyway: it's just dealing with
the sheer number of objects in the pack.

That implies that teaching packed_object_info() to use bitmaps to find
the individual types wouldn't help much either (but being able to ask
"just give me the commits" and iterating over the commit-type bitmap
probably _would_).

Anyway, here's the patch for the curious.

---
diff --git a/packfile.c b/packfile.c
index f4e752996d..482733689a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1273,6 +1273,13 @@ static int retry_bad_packed_offset(struct repository *r,
 
 #define POI_STACK_PREALLOC 64
 
+/* some reordering of static functions could avoid these */
+static enum object_type get_delta_base_cache_type(struct packed_git *p,
+						  off_t curpos);
+static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
+				 void *base, unsigned long base_size,
+				 enum object_type type);
+
 static enum object_type packed_to_object_type(struct repository *r,
 					      struct packed_git *p,
 					      off_t obj_offset,
@@ -1287,6 +1294,14 @@ static enum object_type packed_to_object_type(struct repository *r,
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
 		unsigned long size;
+		enum object_type cached_type;
+
+		cached_type = get_delta_base_cache_type(p, obj_offset);
+		if (cached_type > 0) {
+			type = cached_type;
+			goto out;
+		}
+
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1326,6 +1341,11 @@ static enum object_type packed_to_object_type(struct repository *r,
 	}
 
 out:
+	if (type != OBJ_BAD) {
+		size_t i;
+		for (i = 0; i < poi_stack_nr; i++)
+			add_delta_base_cache(p, poi_stack[i], NULL, 0, type);
+	}
 	if (poi_stack != small_poi_stack)
 		free(poi_stack);
 	return type;
@@ -1385,6 +1405,13 @@ get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
 	return e ? container_of(e, struct delta_base_cache_entry, ent) : NULL;
 }
 
+static enum object_type get_delta_base_cache_type(struct packed_git *p, off_t curpos)
+{
+	struct delta_base_cache_entry *ent =
+		get_delta_base_cache_entry(p, curpos);
+	return ent ? ent->type : OBJ_BAD;
+}
+
 static int delta_base_cache_key_eq(const struct delta_base_cache_key *a,
 				   const struct delta_base_cache_key *b)
 {
@@ -1433,7 +1460,7 @@ static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
 	struct delta_base_cache_entry *ent;
 
 	ent = get_delta_base_cache_entry(p, base_offset);
-	if (!ent)
+	if (!ent || !ent->data)
 		return unpack_entry(r, p, base_offset, type, base_size);
 
 	if (type)
@@ -1677,7 +1704,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		struct delta_base_cache_entry *ent;
 
 		ent = get_delta_base_cache_entry(p, curpos);
-		if (ent) {
+		if (ent && ent->data) {
 			type = ent->type;
 			data = ent->data;
 			size = ent->size;
