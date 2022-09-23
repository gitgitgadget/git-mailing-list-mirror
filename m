Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCFCC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiIWToC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiIWToA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 15:44:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4711CB3E
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:43:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso3390788wmk.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=YnVfJ37e/4N6pbV+QVbIPlul7FB25GngEtnN/8CSvt8=;
        b=MWI0HoPUyFIP6udMtSztas4o1u6JgNuB74ZSkuW4jWO/B3mhVvWSwBuvoR+FJdcXt0
         orN9vNOUG2H3K3VGHC6Be3A7lp8Hy/IU5V7xfbm4abuGqjN0PrLTFvmkHcPutafZD5YI
         6WRSn2Slae2AHauEBjq5fGApjzaJaKs+2M4zyrUVLcJaAsutXWWq6tRdKyS2C+QZi845
         22+Ucsj30J0nElnA3YpcnCk5mWly9sUEVF4h3fQfKlYS6AL/aDLRNBWcZNX4y3xIBae9
         iR82d7IaU4E96AIi85mej5U2hh+F/8tNbuWBZsWR00bfrfdQozNCy3NDriuFiZxZOjnS
         9S2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=YnVfJ37e/4N6pbV+QVbIPlul7FB25GngEtnN/8CSvt8=;
        b=uY/tZ+pOyQh2yQkvP0I6sWVHZBqs7Mc1hdeQ2PRHGwgVWYqnWSA2AXdoIIHK9YGiCc
         jqVs/3C+HxG+fwnewnkW+yUCGve8/FLpoe0W232H9km0TDRcG9XQ0rpqn60gIXC//R0G
         y92TGqxh1xpD7H4L8V4+bXGdKLW2TBrBTinIQaC7cuRosNSx/GREyuL5O6mH6Krrw1Xq
         laXh63hmvHHeSFI4yTlnynjPkO6gcya1023rEGCQzNfrAnjMmm+Cs8GVdt2ytmU42h9N
         WeRcK2cuCEmRF+gv2lF/OR7TN4LDr3dF6k1BqvKLkFbyL1lf/PkN5QZ3QXixXpY+iV/Y
         vTqg==
X-Gm-Message-State: ACrzQf2yeWsRfwWzOLnR1w8SvyVCR5Vw6ll/8wlb01OvlmtvGLvBB+pi
        bk6RPnX08xDxAhv+v402HQxkxStriIQ=
X-Google-Smtp-Source: AMsMyM5o0EhBKDw/BHkQPRyj5YwGk1K7dJLD1Zf3BdqrTF+KGC8E0fq3YfdGCSsBeHhmTJnOuV0I4w==
X-Received: by 2002:a1c:4b0d:0:b0:3b4:76ae:f7a5 with SMTP id y13-20020a1c4b0d000000b003b476aef7a5mr7360060wma.23.1663962237764;
        Fri, 23 Sep 2022 12:43:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d5701000000b00228de58ae2bsm8320987wrv.12.2022.09.23.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:43:57 -0700 (PDT)
Message-Id: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 19:43:55 +0000
Subject: [PATCH] read-cache: avoid misaligned reads in index v4
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The process for reading the index into memory from disk is to first read its
contents into a single memory-mapped file buffer (type 'char *'), then
sequentially convert each on-disk index entry into a corresponding incore
'cache_entry'. To access the contents of the on-disk entry for processing, a
moving pointer within the memory-mapped file is cast to type 'struct
ondisk_cache_entry *'.

In index v4, the entries in the on-disk index file are written *without*
aligning their first byte to a 4-byte boundary; entries are a variable
length (depending on the entry name and whether or not extended flags are
used). As a result, casting the 'char *' buffer pointer to 'struct
ondisk_cache_entry *' then accessing its contents in a 'SANITIZE=undefined'
build can trigger the following error:

  read-cache.c:1886:46: runtime error: member access within misaligned
  address <address> for type 'struct ondisk_cache_entry', which requires 4
  byte alignment

Avoid this error by reading fields directly from the 'char *' buffer, using
the 'offsetof' individual fields in 'struct ondisk_cache_entry'.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    read-cache: avoid misaligned reads in index v4
    
    This fixes the bug reported in [1], where unaligned index entries in the
    memory-mapped index file triggered a 'SANITIZE=undefined' error due to
    casting to & accessing unaligned data a 4 byte-aligned 'struct
    ondisk_cache_entry *' type.
    
    In addition to the originally-reported 't9210-scalar.sh' now passing in
    a 'SANITIZE=undefined' build, I did some light testing by first writing
    a v4 index with a released version of Git (v2.37), then running some
    index-modifying operations ('git status', 'git add') with this patch's
    changes, then again running 'git status' with the stable version. I
    didn't see anything out of the ordinary but, considering how critical
    "reading the index" is, I'd very much appreciate some extra-thorough
    reviews on this patch. :)
    
    Thanks!
    
     * Victoria
    
    [1]
    https://lore.kernel.org/git/YywzNTzd72tox8Z+@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1366%2Fvdye%2Fbugfix%2Findex-v4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1366/vdye/bugfix/index-v4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1366

 read-cache.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index b09128b1884..d16eb979060 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1875,7 +1875,7 @@ static int read_index_extension(struct index_state *istate,
 
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
-					    struct ondisk_cache_entry *ondisk,
+					    const char *ondisk,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
 {
@@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	size_t len;
 	const char *name;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
+	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
 	unsigned int flags;
 	size_t copy_len = 0;
 	/*
@@ -1901,15 +1901,15 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	if (flags & CE_EXTENDED) {
 		int extended_flags;
-		extended_flags = get_be16(flagsp + 1) << 16;
+		extended_flags = get_be16(flagsp + sizeof(uint16_t)) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die(_("unknown index entry format 0x%08x"), extended_flags);
 		flags |= extended_flags;
-		name = (const char *)(flagsp + 2);
+		name = (const char *)(flagsp + 2 * sizeof(uint16_t));
 	}
 	else
-		name = (const char *)(flagsp + 1);
+		name = (const char *)(flagsp + sizeof(uint16_t));
 
 	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
@@ -1935,20 +1935,24 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 
 	ce = mem_pool__ce_alloc(ce_mem_pool, len);
 
-	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
-	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
-	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
-	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
-	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
-	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
-	ce->ce_mode  = get_be32(&ondisk->mode);
-	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
-	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
-	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
+	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							+ offsetof(struct cache_time, sec));
+	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							+ offsetof(struct cache_time, sec));
+	ce->ce_stat_data.sd_ctime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
+							 + offsetof(struct cache_time, nsec));
+	ce->ce_stat_data.sd_mtime.nsec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
+							 + offsetof(struct cache_time, nsec));
+	ce->ce_stat_data.sd_dev   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, dev));
+	ce->ce_stat_data.sd_ino   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ino));
+	ce->ce_mode  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mode));
+	ce->ce_stat_data.sd_uid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, uid));
+	ce->ce_stat_data.sd_gid   = get_be32(ondisk + offsetof(struct ondisk_cache_entry, gid));
+	ce->ce_stat_data.sd_size  = get_be32(ondisk + offsetof(struct ondisk_cache_entry, size));
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	ce->index = 0;
-	oidread(&ce->oid, ondisk->data);
+	oidread(&ce->oid, (const unsigned char *)ondisk + offsetof(struct ondisk_cache_entry, data));
 
 	if (expand_name_field) {
 		if (copy_len)
@@ -2117,12 +2121,12 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 	unsigned long src_offset = start_offset;
 
 	for (i = offset; i < offset + nr; i++) {
-		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
-		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
+		ce = create_from_disk(ce_mem_pool, istate->version,
+				      mmap + src_offset,
+				      &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;

base-commit: 1b3d6e17fe83eb6f79ffbac2f2c61bbf1eaef5f8
-- 
gitgitgadget
