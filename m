Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0BDC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiITUk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITUkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:40:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380D3F1C0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z9so2933819qvn.9
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lsTJkX4xv4RDSeIy7n3hLhEXxCZ3raUqhCLQJc5ZFaw=;
        b=26xGgyFcXOWNg/UaYf5rKSAk/yRe8ZE/KB5OufQqNUPdjAvCgwJYEkuDht0lPZbYtX
         2kiQSlmqGyhbHN47MZeE+E71tSyR8Kdy2D/jh+yavtzFd/gxCPpL6dLPkF8TLkvcypWn
         bhmuV8XVJR/N5uJVy5SODCwxAjE/oGrItT0iRFmSb5o38GEfu9q6PnO+Rem7MTryza9T
         mLXcWJfpVi3zTivn7SpuqTzXGUOt3gnF+vjilmA8QPhxqt2676RSfMIBWq0QdE+QQA0h
         t0yEyVlxlVytUNgqfdTEtZKxNEnlFcv4kjDCsbHBRS9/XhNQ32ZK45h04IuJwidJEeZU
         DCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lsTJkX4xv4RDSeIy7n3hLhEXxCZ3raUqhCLQJc5ZFaw=;
        b=KwhzwHqno+2eZQxcKhPK6NERnr2MuIhlb60mxRXgNfMcorcwbwXf3hNPcZBsiBfyVh
         vzXAAX9WTEebXjfNyr4GRFhhv2Z7Q57xY8hYmv1dkR1C+E82UWI1FYh+6qc6iMDQ0xha
         DeCE02MQO0QSWPqXwEH84gJnLhwCB7jSmkUKLInoteWbjTOJkld6x2lS7OZ06GyDKDjw
         SfTodWuszWwAcJSLnGbMY/ngKcQrr+aXXm+hrqfZclgSE2eArIkoKkzWRIL1K2NPR2zH
         nDVKbBru5aEglLFRQKb2zM0/GKWBigLw+Hl2P/w+wcJk8A3LiOwFPj759kU7Yqq+9Tg+
         4DzQ==
X-Gm-Message-State: ACrzQf2ichoIh6JAwtMbqRmBrMSOnt1OXS1gqJrJ4ehLMC/Dzb8MJ+dW
        HUXL4I/2MfxPTgMx/KJqlsvXZGMGQctCDw==
X-Google-Smtp-Source: AMsMyM7YIQ+U9JGx19I1ZM0nJUD8hwuIxQHOdiVB+SDXZUTHiiD2vjSE//RkwraFE6qXv0ARUgUL1A==
X-Received: by 2002:a05:6214:2522:b0:4ad:6956:fc83 with SMTP id gg2-20020a056214252200b004ad6956fc83mr1385174qvb.37.1663706418268;
        Tue, 20 Sep 2022 13:40:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006b942f4ffe3sm540406qkp.18.2022.09.20.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:40:18 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:40:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: [PATCH v2 1/3] midx.c: compute pack_info array outside of
 fill_included_packs_batch()
Message-ID: <a501776f6eaeef6fcddf2cf9a349f8888fabcb0f.1663706401.git.me@ttaylorr.com>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663706401.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fill_included_packs_batch() function needs to compute a list of
packs which are included in the MIDX, and then sort that list according
to the pack mtimes.

Since packs are listed in the `m->pack_names` array in SHA-1 order, we
have to reconstruct their mtimes by reading the `pack_mtime` member of
the struct `packed_git` in order to determine the value by which to
sort.

This list is only needed by the fill_included_packs_batch(), but the
subsequent commit will want to have this list accessible in this
function's caller, `midx_repack()`.

Prepare for that by teaching `midx_repack()` to compute, pass in, and
then free that list so it is available throughout the body of
`midx_repack()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/midx.c b/midx.c
index c27d0e5f15..db0a70c5af 100644
--- a/midx.c
+++ b/midx.c
@@ -1905,32 +1905,16 @@ static int fill_included_packs_all(struct repository *r,
 
 static int fill_included_packs_batch(struct repository *r,
 				     struct multi_pack_index *m,
+				     struct repack_info *pack_info,
 				     unsigned char *include_pack,
 				     size_t batch_size)
 {
 	uint32_t i, packs_to_repack;
 	size_t total_size;
-	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
 	int pack_kept_objects = 0;
 
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
-	for (i = 0; i < m->num_packs; i++) {
-		pack_info[i].pack_int_id = i;
-
-		if (prepare_midx_pack(r, m, i))
-			continue;
-
-		pack_info[i].mtime = m->packs[i]->mtime;
-	}
-
-	for (i = 0; batch_size && i < m->num_objects; i++) {
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
-		pack_info[pack_int_id].referenced_objects++;
-	}
-
-	QSORT(pack_info, m->num_packs, compare_by_mtime);
-
 	total_size = 0;
 	packs_to_repack = 0;
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
@@ -1957,8 +1941,6 @@ static int fill_included_packs_batch(struct repository *r,
 		include_pack[pack_int_id] = 1;
 	}
 
-	free(pack_info);
-
 	if (packs_to_repack < 2)
 		return 1;
 
@@ -1974,6 +1956,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	FILE *cmd_in;
 	struct strbuf base_name = STRBUF_INIT;
 	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
+	struct repack_info *pack_info = NULL;
 
 	/*
 	 * When updating the default for these configuration
@@ -1987,9 +1970,25 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		return 0;
 
 	CALLOC_ARRAY(include_pack, m->num_packs);
+	CALLOC_ARRAY(pack_info, m->num_packs);
+
+	for (i = 0; i < m->num_packs; i++) {
+		pack_info[i].pack_int_id = i;
+
+		if (prepare_midx_pack(r, m, i))
+			continue;
+
+		pack_info[i].mtime = m->packs[i]->mtime;
+	}
+
+	for (i = 0; batch_size && i < m->num_objects; i++)
+		pack_info[nth_midxed_pack_int_id(m, i)].referenced_objects++;
+
+	QSORT(pack_info, m->num_packs, compare_by_mtime);
 
 	if (batch_size) {
-		if (fill_included_packs_batch(r, m, include_pack, batch_size))
+		if (fill_included_packs_batch(r, m, pack_info, include_pack,
+					      batch_size))
 			goto cleanup;
 	} else if (fill_included_packs_all(r, m, include_pack))
 		goto cleanup;
@@ -2047,6 +2046,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
 
 cleanup:
+	free(pack_info);
 	free(include_pack);
 	return result;
 }
-- 
2.37.0.1.g1379af2e9d

