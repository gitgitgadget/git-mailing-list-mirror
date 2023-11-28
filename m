Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ApWRMuPQ"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1AED66
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:07 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4239f2c1209so23772181cf.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198486; x=1701803286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NT0SmoFD7rUuFip4tMJQaG/hpI4OvIVp7m3Ixsk9Xg4=;
        b=ApWRMuPQAyer/5bbnjaoJypJdwP4rZVCEYNfYOSihjZ0C41yFMAE8kG11DCMQIQ9cz
         xDYkhj7Mpo7rheZix9LzkZpgbZliQbFHaysytXQDRmuUV5694u5vwBg99Jf2PY0gd0ml
         zHxnK7NxairA18Yrn2GWYwORvFE3CWntmDwfqjnGG4pGU9xxjTzCOIFQGqPj2XymjWup
         rpY7e912vFxG+PVweD+W4P/8/IIpH8oBkQ+mg5R2K7mklVeNypMQsLdtLqk2KmEpU5v3
         UHWHiLUkplngIO9xsmotIgCzDOcypPPKTB/XEuztmZ5bZovIYT8Qwwd15jN8XKQ/UVIi
         AFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198486; x=1701803286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT0SmoFD7rUuFip4tMJQaG/hpI4OvIVp7m3Ixsk9Xg4=;
        b=OJ7RqCAdKVBLyTQuvAVm39gelzugsxeVIydc6fas4fwaRV1xrVf/GZ0V29sLoatCUP
         ptcaaSzH5ceKu1hKcMPrcVOYpMi2E21bpH6NFQVOlkyIMPfLqKDsZpqsqJxo2RglyjWW
         IQx3pahvyqmOgwYqCD4DzqD73akvz4kx9Bcp67nCP+KDpjoEhVSkNztg1lJrO+/Y3WDk
         td5KfKzoKzBI1WShLZW4YABmzdKreVNrQ2mOMUqI6y3of6SbuXMpg9p4LGQRNsV9b2Mk
         gX2dWLOvRCxxQD0u9JGjyM1PO8YQK/7YkD0Cxs4IO3JuqX8/uVX4AV3Qy9C0+UdvsD87
         PGCw==
X-Gm-Message-State: AOJu0YzKcOnXHmpqNs1qRwvZrHbCNTp4og0HNOeBMuENLCaIZtpopukn
	Y/Z0u9NyPGbiDiq4GiDPS/Jv5hdNLTKjiM3AnPs=
X-Google-Smtp-Source: AGHT+IHy3qRYO6uvmkojf0Z5ZlkmyoCy5dAya4XPLOLF1R6+1cNkIydlUUfyt/DVF/ZHdtS34MRSUw==
X-Received: by 2002:ac8:7dcf:0:b0:41e:1b18:f4a2 with SMTP id c15-20020ac87dcf000000b0041e1b18f4a2mr21781682qte.36.1701198486343;
        Tue, 28 Nov 2023 11:08:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o1-20020ac84281000000b0041cb8947ed2sm4810354qtl.26.2023.11.28.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:06 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/24] midx: factor out `fill_pack_info()`
Message-ID: <ccf1337305db60f1c8174e9b309e2a9e04ce1487.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

When selecting which packfiles will be written while generating a MIDX,
the MIDX internals fill out a 'struct pack_info' with various pieces of
book-keeping.

Instead of filling out each field of the `pack_info` structure
individually in each of the two spots that modify the array of such
structures (`ctx->info`), extract a common routine that does this for
us.

This reduces the code duplication by a modest amount. But more
importantly, it zero-initializes the structure before assigning values
into it. This hardens us for a future change which will add additional
fields to this structure which (until this patch) was not
zero-initialized.

As a result, any new fields added to the `pack_info` structure need only
be updated in a single location, instead of at each spot within midx.c.

There are no functional changes in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/midx.c b/midx.c
index 3b727dc633..591b3c636e 100644
--- a/midx.c
+++ b/midx.c
@@ -464,6 +464,17 @@ struct pack_info {
 	unsigned expired : 1;
 };
 
+static void fill_pack_info(struct pack_info *info,
+			   struct packed_git *p, char *pack_name,
+			   uint32_t orig_pack_int_id)
+{
+	memset(info, 0, sizeof(struct pack_info));
+
+	info->orig_pack_int_id = orig_pack_int_id;
+	info->pack_name = pack_name;
+	info->p = p;
+}
+
 static int pack_info_compare(const void *_a, const void *_b)
 {
 	struct pack_info *a = (struct pack_info *)_a;
@@ -504,6 +515,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			     const char *file_name, void *data)
 {
 	struct write_midx_context *ctx = data;
+	struct packed_git *p;
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
@@ -530,17 +542,14 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
 
-		ctx->info[ctx->nr].p = add_packed_git(full_path,
-						      full_path_len,
-						      0);
-
-		if (!ctx->info[ctx->nr].p) {
+		p = add_packed_git(full_path, full_path_len, 0);
+		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
-		if (open_pack_index(ctx->info[ctx->nr].p)) {
+		if (open_pack_index(p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
 			close_pack(ctx->info[ctx->nr].p);
@@ -548,9 +557,8 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}
 
-		ctx->info[ctx->nr].pack_name = xstrdup(file_name);
-		ctx->info[ctx->nr].orig_pack_int_id = ctx->nr;
-		ctx->info[ctx->nr].expired = 0;
+		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
+			       ctx->nr);
 		ctx->nr++;
 	}
 }
@@ -1310,11 +1318,6 @@ static int write_midx_internal(const char *object_dir,
 		for (i = 0; i < ctx.m->num_packs; i++) {
 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
 
-			ctx.info[ctx.nr].orig_pack_int_id = i;
-			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
-			ctx.info[ctx.nr].p = ctx.m->packs[i];
-			ctx.info[ctx.nr].expired = 0;
-
 			if (flags & MIDX_WRITE_REV_INDEX) {
 				/*
 				 * If generating a reverse index, need to have
@@ -1330,10 +1333,10 @@ static int write_midx_internal(const char *object_dir,
 				if (open_pack_index(ctx.m->packs[i]))
 					die(_("could not open index for %s"),
 					    ctx.m->packs[i]->pack_name);
-				ctx.info[ctx.nr].p = ctx.m->packs[i];
 			}
 
-			ctx.nr++;
+			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
+				       xstrdup(ctx.m->pack_names[i]), i);
 		}
 	}
 
-- 
2.43.0.24.g980b318f98

