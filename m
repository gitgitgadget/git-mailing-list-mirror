Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6818DC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDA4206B8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDFSqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:46:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:34784 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725876AbgDFSqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:46:51 -0400
Received: (qmail 26298 invoked by uid 109); 6 Apr 2020 18:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Apr 2020 18:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15866 invoked by uid 111); 6 Apr 2020 18:57:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2020 14:57:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Apr 2020 14:46:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
Message-ID: <20200406184650.GA637746@coredump.intra.peff.net>
References: <20200403121508.GA638328@coredump.intra.peff.net>
 <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
 <20200405185951.GA1309762@coredump.intra.peff.net>
 <020726d4-5a5c-e751-2824-d05004823326@web.de>
 <20200406183542.GA23753@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406183542.GA23753@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 06, 2020 at 02:35:42PM -0400, Jeff King wrote:

> Pointing to uninitialized bits is fine according to the standard (and I
> think that's what you're asking about for chapter and verse). But we
> really do lie to container_of(). See remote.c, for example. In
> make_remote(), we call hashmap_get() with a pointer to lookup_entry,
> which is a bare "struct hashmap_entry". That should end up in
> remotes_hash_cmp(), which unconditionally computes a pointer to a
> "struct remote".
> 
> Now the hashmap_entry there is at the beginning of the struct, so the
> offset is 0 and the two pointers are the same. So while the pointer's
> type is incorrect, we didn't compute an invalid pointer value. And
> traditionally the hashmap code required that it be at the front of the
> containing struct, but that was loosened recently (and container_of
> introduced) in 5efabc7ed9 (Merge branch 'ew/hashmap', 2019-10-15).
> 
> And grepping around, I don't see any cases where it's _not_ at the
> beginning. So perhaps this is a problem waiting to bite us.

I was curious wither ASan/UBSan might complain if we did something like
this:

diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d..1abfe966f2 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -12,10 +12,10 @@
  * internal_entry field.
  */
 struct oidmap_entry {
+	struct object_id oid;
+
 	/* For internal use only */
 	struct hashmap_entry internal_entry;
-
-	struct object_id oid;
 };
 

It does, but not because of the subtle UB issue. It's just that the rest
of oidmap still assumes the hashmap-is-first logic, and we need:

diff --git a/oidmap.c b/oidmap.c
index 423aa014a3..4065ea4b79 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -35,7 +35,10 @@ void *oidmap_get(const struct oidmap *map, const struct object_id *key)
 	if (!map->map.cmpfn)
 		return NULL;
 
-	return hashmap_get_from_hash(&map->map, oidhash(key), key);
+	return container_of_or_null(
+		hashmap_get_from_hash(&map->map, oidhash(key), key),
+		struct oidmap_entry,
+		internal_entry);
 }
 
 void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 struct oidmap {
@@ -79,7 +79,10 @@ static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter
 static inline void *oidmap_iter_next(struct oidmap_iter *iter)
 {
 	/* TODO: this API could be reworked to do compile-time type checks */
-	return (void *)hashmap_iter_next(&iter->h_iter);
+	return container_of_or_null(
+		hashmap_iter_next(&iter->h_iter),
+		struct oidmap_entry,
+		internal_entry);
 }
 
 static inline void *oidmap_iter_first(struct oidmap *map,

-Peff


