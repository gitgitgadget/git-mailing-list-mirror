Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D9C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 04:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiI1EVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiI1EVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 00:21:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451571D35BE
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 21:21:16 -0700 (PDT)
Received: (qmail 3209 invoked by uid 109); 28 Sep 2022 04:21:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Sep 2022 04:21:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25748 invoked by uid 111); 28 Sep 2022 04:21:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Sep 2022 00:21:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Sep 2022 00:21:14 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] read-cache: read on-disk entries in byte order
Message-ID: <YzPLuizoOlDuPu4G@coredump.intra.peff.net>
References: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An index entry starts with stat data and mode, followed by an oid,
followed by flags, followed by the entry name. We parse this out of
order:

  1. we must read the flags to know how long the name is

  2. we must know how long the name is in order to allocate the
     struct cache_entry, since it has a FLEX_ARRAY

  3. we must allocate the cache_entry in order to parse the stat_data
     and oid into it

This makes the parser a little hard to follow, because we have to access
the flags using an offset, rather than walking through it in byte order.

We can break the cyclic dependency by parsing the stat_data, etc, into
temporary variables, then allocating the cache_entry and copying the
parsed values in. This sets us up for simplifying the parsing in the
next commit.

The downside is that we're copying the data an extra time. It's not very
much data, and it's all fixed size, so the compiler should be able to do
a reasonable job of optimizing here. But I didn't time the potential
impact.

Note one subtlety in the patch: besides reordering the flags/name versus
stat data, we adjust the order within the stat data to match the on-disk
order (notably both fields of each cache_time struct are adjacent).

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d16eb97906..efb9efa5ee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1879,11 +1879,14 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
+	struct stat_data sd;
+	unsigned int mode;
+	struct object_id oid;
 	struct cache_entry *ce;
 	size_t len;
 	const char *name;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
+	const char *flagsp;
 	unsigned int flags;
 	size_t copy_len = 0;
 	/*
@@ -1895,6 +1898,24 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	 */
 	int expand_name_field = version == 4;
 
+	sd.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							+ offsetof(struct cache_time, sec));
+	sd.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							 + offsetof(struct cache_time, nsec));
+	sd.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							+ offsetof(struct cache_time, sec));
+	sd.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							 + offsetof(struct cache_time, nsec));
+	sd.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
+	sd.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
+	mode        = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
+	sd.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
+	sd.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
+	sd.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
+
+	oidread(&oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
+	flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
+
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(flagsp);
 	len = flags & CE_NAMEMASK;
@@ -1934,25 +1955,12 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	}
 
 	ce = mem_pool__ce_alloc(ce_mem_pool, len);
-
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
+	ce->ce_stat_data = sd;
+	ce->ce_mode = mode;
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
+	oidcpy(&ce->oid, &oid);
 
 	if (expand_name_field) {
 		if (copy_len)
-- 
2.38.0.rc2.615.g4fac75f9e3

