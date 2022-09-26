Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7CC6FA8E
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 19:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiIZTIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIZTIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 15:08:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC8018372
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 12:08:29 -0700 (PDT)
Received: (qmail 27749 invoked by uid 109); 26 Sep 2022 19:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Sep 2022 19:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10892 invoked by uid 111); 26 Sep 2022 19:08:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Sep 2022 15:08:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Sep 2022 15:08:28 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
Message-ID: <YzH4rDpHXdeLURSN@coredump.intra.peff.net>
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
 <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 05:39:28PM -0400, Jeff King wrote:

> Another strategy is to just parse left-to-right, advancing the byte
> pointer. Like:
> 
>   ce->ce_state_data.sd_ctime.sec = get_be32(ondisk);
>   ondisk += sizeof(uint32_t);
>   ce->ce_state_data.sd_mtime.sec = get_be32(ondisk);
>   ondisk += sizeof(uint32_t);
>   ...etc...
> 
> You can even stick that in a helper function that does the get_b32() and
> advances, so you know they're always done in sync. See pack-bitmap.c's
> read_be32(), etc. IMHO this produces a nice result because the reading
> code itself becomes the source of truth for the format.
> 
> But one tricky thing there is if you want to parse out of order. And it
> does seem that we read the struct out of order in this case. But I don't
> think there's any reason we need to do so. Of course reordering the
> function would make the change much more invasive.

By the way, this last paragraph turns out not to be true. We do rely on
the order because we need to know the length of the name (retrieved from
the flags field) in order to allocate the internal ce_entry, which has a
FLEX_ARRAY. And we must allocate the struct before populating its fields
from the earlier bytes of the ondisk entry.

So we either need to go out of order, or parse into a dummy ce_entry and
then memcpy the results into the heap-allocated one.

You can still do a partial conversion as below, which I do think
improves readability, but without getting rid of the match for the
flagsp pointer, it feels like it may not be accomplishing enough to be
worth it.

Note also that there is some confusion with signed vs unsigned pointers.
It doesn't really matter in practice because get_be* is casting under
the hood, but the compiler is picky here. Arguably read_be32() should
take a void (just like get_be32() does). But I do find it a bit odd that
all of the index code uses a signed pointer for the mmap. Most of our
other code uses "const unsigned char *" to indicate that we expect
binary data. We could switch over, but it's a rather invasive patch. And
while we get rid of some casts (e.g., when we call oidread()), we'd gain
some new ones (some code uses strtol() to parse ascii numbers).

In the patch below I hacked around it by passing through a local void
pointer. ;)

diff --git a/read-cache.c b/read-cache.c
index d16eb97906..8668ded8f5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1875,17 +1875,20 @@ static int read_index_extension(struct index_state *istate,
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
-					    const char *ondisk,
+					    const void *ondisk_map,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
+	const unsigned char *ondisk = ondisk_map;
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
+	const unsigned char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
 	unsigned int flags;
 	size_t copy_len = 0;
+	size_t pos;
+
 	/*
 	 * Adjacent cache entries tend to share the leading paths, so it makes
 	 * sense to only store the differences in later entries.  In the v4
@@ -1935,24 +1938,21 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	ce = mem_pool__ce_alloc(ce_mem_pool, len);
 
-	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
-							+ offsetof(struct cache_time, sec));
-	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
-							+ offsetof(struct cache_time, sec));
-	ce->ce_stat_data.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
-							 + offsetof(struct cache_time, nsec));
-	ce->ce_stat_data.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
-							 + offsetof(struct cache_time, nsec));
-	ce->ce_stat_data.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
-	ce->ce_stat_data.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
-	ce->ce_mode  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
-	ce->ce_stat_data.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
-	ce->ce_stat_data.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
-	ce->ce_stat_data.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
+	pos = 0;
+	ce->ce_stat_data.sd_ctime.sec = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_ctime.nsec = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_mtime.sec = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_mtime.nsec = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_dev   = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_ino   = read_be32(ondisk, &pos);
+	ce->ce_mode  = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_uid   = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_gid   = read_be32(ondisk, &pos);
+	ce->ce_stat_data.sd_size  = read_be32(ondisk, &pos);
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
+	oidread(&ce->oid, ondisk + pos);
 
 	if (expand_name_field) {
 		if (copy_len)
