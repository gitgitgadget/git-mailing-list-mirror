Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C685C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiITUkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiITUkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:40:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8AC52099
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:24 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ml1so2966795qvb.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zRop9O85ah/dqxRX2/6MueHbzVV9VlC2nSA7s8WXVts=;
        b=7mJGXnTe8Kgj/cOOQbBkT09FCAV3lENnkxCyV2YZKHItm/dqjChZbIcD4SDTFDx8Rq
         5Uk4vqy1SBh3GFx0jhpe8GX99c2X6dgZdcYk70pwSXERWsDrYoCG80icW0WXjzd3FzG3
         se8+jgszRuo3yQ+/CiCA0LzmC0omQXnTCNvMh57KcRlNUOXFW2AAHQZhel0SDpzSjnOT
         2H/Wfc0AophaUq1GN8zNZQ2Y8tGhjfYzqvfUUwBIg1pWZbptUPXupLbtAwILvK31ECQb
         Yv1LLJtBB2E42+irS2kkEaDiG2VsdLdbWjOZSp7uvKANb4ov7XxAO2m+dkuuZv65ghPz
         BOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zRop9O85ah/dqxRX2/6MueHbzVV9VlC2nSA7s8WXVts=;
        b=NQyM9gP73AE0kl1K0ZdPhS8Y5QkfWuIaSdixugykH8u4ji8QZF4GJgGvhBD4ge87fj
         54MspnU/u7nGHSDnd1yzxXBOS/GEW/+oqv9+LxzSFG3e81DEwZTfcSV+0KLib7QVQwtQ
         i9BQNBxURfh718DfWKQRs4vwCDJCUdmwFP4P6mJ0zwRnLWot/DHCn0SWfwqL+VobgZ5w
         8UlOvKt9UMaA8lBoAI0NEDEH/siIIz3WiVSq3y7IorTlZeJDMxNdZwR9QzOJp7EyxFYl
         A8gyakAkoDdNTXiItGU2zjswvGcdWItbF5xkYG4/xo2Qi0URYp/I/9nsxnZ6Kyuh9JoN
         JyIQ==
X-Gm-Message-State: ACrzQf16k77wG+Ru5wAoneLno1uWatJztK+HxhVWSls6rjgCKpyNNR87
        pTg8WOTMr2hfcDw/ePIgzhMHMfdrUHtSUA==
X-Google-Smtp-Source: AMsMyM4x9sCLjBXQ4nJnSNUa49wOnCTY86jUlaAwMpFkeov/EO8+jFMRSzKzYWWXlM0FaBDlhuzEjw==
X-Received: by 2002:ad4:4eee:0:b0:4ad:2663:a117 with SMTP id dv14-20020ad44eee000000b004ad2663a117mr14425503qvb.113.1663706423341;
        Tue, 20 Sep 2022 13:40:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h22-20020a05622a171600b0035ba366cc90sm490605qtk.15.2022.09.20.13.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:40:23 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:40:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH v2 3/3] midx.c: unify `include_pack` array into `pack_info`
 struct
Message-ID: <81e9ccc3232f1a372adc9b06e2a93e9d9b26c80d.1663706401.git.me@ttaylorr.com>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663706401.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MIDX repack code uses a separate byte-array to track which packs are
"included" in the rollup. Now that an array of `repack_info` structs is
available for the lifetime of the `midx_repack()` function, we can
instead use a new bit in that struct's record instead of maintaining a
separate array.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/midx.c b/midx.c
index 5fbf964bba..59db9162ea 100644
--- a/midx.c
+++ b/midx.c
@@ -1865,6 +1865,7 @@ struct repack_info {
 	timestamp_t mtime;
 	uint32_t referenced_objects;
 	uint32_t pack_int_id;
+	unsigned include : 1;
 };
 
 static int compare_by_mtime(const void *a_, const void *b_)
@@ -1883,7 +1884,7 @@ static int compare_by_mtime(const void *a_, const void *b_)
 
 static int fill_included_packs_all(struct repository *r,
 				   struct multi_pack_index *m,
-				   unsigned char *include_pack)
+				   struct repack_info *pack_info)
 {
 	uint32_t i, count = 0;
 	int pack_kept_objects = 0;
@@ -1896,7 +1897,7 @@ static int fill_included_packs_all(struct repository *r,
 		if (!pack_kept_objects && m->packs[i]->pack_keep)
 			continue;
 
-		include_pack[i] = 1;
+		pack_info[i].include = 1;
 		count++;
 	}
 
@@ -1906,7 +1907,6 @@ static int fill_included_packs_all(struct repository *r,
 static int fill_included_packs_batch(struct repository *r,
 				     struct multi_pack_index *m,
 				     struct repack_info *pack_info,
-				     unsigned char *include_pack,
 				     size_t batch_size)
 {
 	uint32_t i, packs_to_repack;
@@ -1918,8 +1918,8 @@ static int fill_included_packs_batch(struct repository *r,
 	total_size = 0;
 	packs_to_repack = 0;
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
-		int pack_int_id = pack_info[i].pack_int_id;
-		struct packed_git *p = m->packs[pack_int_id];
+		struct repack_info *info = &pack_info[i];
+		struct packed_git *p = m->packs[info->pack_int_id];
 		size_t expected_size;
 
 		if (!p)
@@ -1938,7 +1938,8 @@ static int fill_included_packs_batch(struct repository *r,
 
 		packs_to_repack++;
 		total_size += expected_size;
-		include_pack[pack_int_id] = 1;
+
+		info->include = 1;
 	}
 
 	if (packs_to_repack < 2)
@@ -1951,7 +1952,6 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 {
 	int result = 0;
 	uint32_t i;
-	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
 	struct strbuf base_name = STRBUF_INIT;
@@ -1970,7 +1970,6 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	if (!m)
 		return 0;
 
-	CALLOC_ARRAY(include_pack, m->num_packs);
 	CALLOC_ARRAY(pack_info, m->num_packs);
 
 	for (i = 0; i < m->num_packs; i++) {
@@ -1988,10 +1987,9 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	QSORT(pack_info, m->num_packs, compare_by_mtime);
 
 	if (batch_size) {
-		if (fill_included_packs_batch(r, m, pack_info, include_pack,
-					      batch_size))
+		if (fill_included_packs_batch(r, m, pack_info, batch_size))
 			goto cleanup;
-	} else if (fill_included_packs_all(r, m, include_pack))
+	} else if (fill_included_packs_all(r, m, pack_info))
 		goto cleanup;
 
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
@@ -2035,7 +2033,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		strbuf_strip_suffix(&scratch, ".idx");
 		strbuf_addstr(&scratch, ".pack");
 
-		fprintf(cmd_in, "%s%s\n", include_pack[info->pack_int_id] ? "" : "^", scratch.buf);
+		fprintf(cmd_in, "%s%s\n", info->include ? "" : "^", scratch.buf);
 	}
 	fclose(cmd_in);
 	strbuf_release(&scratch);
@@ -2050,6 +2048,5 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 cleanup:
 	free(pack_info);
-	free(include_pack);
 	return result;
 }
-- 
2.37.0.1.g1379af2e9d
