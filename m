Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7441BC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9460EFD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhI2B4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhI2B4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:43 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BEC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n71so1196902iod.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fTmKYl0jFkOhMPvYVM4JfTdMaXHOAwfHND5bviBg7s=;
        b=HhKMPNukMSYj444BW+IIcW7FOdTdByhAinJlgxGD6pwZSrOy4ofh6gKrOjtokEitqu
         cSSoeEvdMhdTLksLqFl02AuO9mfiNIrs/Je6teUY/+0NGtRVtJO+K2m6+zeahU9C/4gw
         1M8lPLayLcAptrTr+cbEfbG8HVq55Py4SnOgcwR9pMukXmNiYr7L5fd7sYeuYuKXemVg
         lSQ5pcgSZ6FqhPD7OqlSACNJiDoZilOyx0Ta13P4cok9YkEXWwXEGRbKDTB8hp/OAf/y
         8HUlfxqo56eqRWTqyxDG2qX3MF1WGfoC80dXbXSbA6zq1Q8HwICvcvfsSfgtXEgvthj0
         u7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fTmKYl0jFkOhMPvYVM4JfTdMaXHOAwfHND5bviBg7s=;
        b=d71+puP7sFUyM//V/HFqeh887nbkCSNPYzSKzJYpY69/14C9dBxeRvqkZrGTWuqv/S
         P3Y2HSx06LdQrQz4sA6utd+2aVGucCbVuodnXUJHXHhQYSPHbFNfw58ORTC69tRowih/
         0wQOv1gJs/nWUU8rmbeGI60hOdl8bnG98//2SS+9vRysJ2axYB4zs54cDfemgVEbyeiA
         bSgYT9ombbJi82h7HfjGShWjExCZQVaeSb+QKJovyuWyMBcO1IXq3+Z3wvTeJ1gzv7iz
         5Nm/Mvtve39DW0for/zFo/ZXpymBHG66Fin0OKaU725bwqast6cUV3TZIcTS8IPAenir
         vcxw==
X-Gm-Message-State: AOAM532Wfmmo/+m5tqxHJzw0FYntANrBQv4XZHVMwdJV/RAiqhzM0+5I
        L52hoXcHfSh/ylbqNt1bFt5S3mxkoeakGQ==
X-Google-Smtp-Source: ABdhPJznKNMkTNpH7wLf/JKgLwzkIXbI/gQfqHOF5qSX8S1logauKnWnzybrWIxc5KTgGau64G2YQg==
X-Received: by 2002:a05:6638:16d4:: with SMTP id g20mr7213729jat.22.1632880502942;
        Tue, 28 Sep 2021 18:55:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z4sm474811ilp.64.2021.09.28.18.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:02 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 1/9] midx: expose `write_midx_file_only()` publicly
Message-ID: <b7c72d0bf5b9bbe2d4f082ddcbf65f33c10d584b.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expose a variant of the write_midx_file() function which ignores packs
that aren't included in an explicit "allow" list.

This will be used in an upcoming patch to power a new `--stdin-packs`
mode of `git multi-pack-index write` for callers that only want to
include certain packs in a MIDX (and ignore any packs which may have
happened to enter the repository independently, e.g., from pushes).

Those patches will provide test coverage for this new function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 midx.h |  9 +++++++++
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index f96fb2efee..7ac97e66e0 100644
--- a/midx.c
+++ b/midx.c
@@ -460,6 +460,8 @@ struct write_midx_context {
 	uint32_t num_large_offsets;
 
 	int preferred_pack_idx;
+
+	struct string_list *to_include;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -469,8 +471,26 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
+		/*
+		 * Note that at most one of ctx->m and ctx->to_include are set,
+		 * so we are testing midx_contains_pack() and
+		 * string_list_has_string() independently (guarded by the
+		 * appropriate NULL checks).
+		 *
+		 * We could support passing to_include while reusing an existing
+		 * MIDX, but don't currently since the reuse process drags
+		 * forward all packs from an existing MIDX (without checking
+		 * whether or not they appear in the to_include list).
+		 *
+		 * If we added support for that, these next two conditional
+		 * should be performed independently (likely checking
+		 * to_include before the existing MIDX).
+		 */
 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
 			return;
+		else if (ctx->to_include &&
+			 !string_list_has_string(ctx->to_include, file_name))
+			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
@@ -1043,6 +1063,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 }
 
 static int write_midx_internal(const char *object_dir,
+			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
 			       unsigned flags)
@@ -1067,10 +1088,17 @@ static int write_midx_internal(const char *object_dir,
 		die_errno(_("unable to create leading directories of %s"),
 			  midx_name);
 
-	for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
-		if (!strcmp(object_dir, cur->object_dir)) {
-			ctx.m = cur;
-			break;
+	if (!packs_to_include) {
+		/*
+		 * Only reference an existing MIDX when not filtering which
+		 * packs to include, since all packs and objects are copied
+		 * blindly from an existing MIDX if one is present.
+		 */
+		for (cur = get_multi_pack_index(the_repository); cur; cur = cur->next) {
+			if (!strcmp(object_dir, cur->object_dir)) {
+				ctx.m = cur;
+				break;
+			}
 		}
 	}
 
@@ -1121,10 +1149,13 @@ static int write_midx_internal(const char *object_dir,
 	else
 		ctx.progress = NULL;
 
+	ctx.to_include = packs_to_include;
+
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
+	if ((ctx.m && ctx.nr == ctx.m->num_packs) &&
+	    !(packs_to_include || packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
 		int want_bitmap = flags & MIDX_WRITE_BITMAP;
@@ -1365,7 +1396,17 @@ int write_midx_file(const char *object_dir,
 		    const char *preferred_pack_name,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, preferred_pack_name, flags);
+	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
+				   flags);
+}
+
+int write_midx_file_only(const char *object_dir,
+			 struct string_list *packs_to_include,
+			 const char *preferred_pack_name,
+			 unsigned flags)
+{
+	return write_midx_internal(object_dir, packs_to_include, NULL,
+				   preferred_pack_name, flags);
 }
 
 struct clear_midx_data {
@@ -1645,7 +1686,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr) {
-		result = write_midx_internal(object_dir, &packs_to_drop, NULL, flags);
+		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, flags);
 		m = NULL;
 	}
 
@@ -1836,7 +1877,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, flags);
+	result = write_midx_internal(object_dir, NULL, NULL, NULL, flags);
 	m = NULL;
 
 cleanup:
diff --git a/midx.h b/midx.h
index aa3da557bb..3545e327ea 100644
--- a/midx.h
+++ b/midx.h
@@ -2,6 +2,7 @@
 #define MIDX_H
 
 #include "repository.h"
+#include "string-list.h"
 
 struct object_id;
 struct pack_entry;
@@ -62,6 +63,14 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
+/*
+ * Variant of write_midx_file which writes a MIDX containing only the packs
+ * specified in packs_to_include.
+ */
+int write_midx_file_only(const char *object_dir,
+			 struct string_list *packs_to_include,
+			 const char *preferred_pack_name,
+			 unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
-- 
2.33.0.96.g73915697e6

