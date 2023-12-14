Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF06D1DE
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ff0sMCkX"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5906988ab8dso58211eaf.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592629; x=1703197429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJn5qRs6lqTbZ3HymPXKMtcJ4ZUxdDzTr5RaipMgT4A=;
        b=ff0sMCkX9fwugW1uzkA5qmhl20t9GRaLzkQ/2oKeCWJWeyD0NHe8EvYpP8cEiRYbzX
         7I7nKS1DyE0GUrOy6s+oqsKDmIbaCAr5yQUjYPkTzuAdFL6TEZHU7Fr4kqnD5FWQu/EN
         NW1RWXMf7scA8vqGHtkLJRBlbremjujtP9fMwk1iZqet8mGdZygBbxH8BId27GIR1XrC
         GW97ZtTw308wmDexV60qSes2XNkWC+Fh90Xoo838/zMKVymaKRWN2S9Kk6NOpoaPgYgK
         fizdrTfZNr+SCLxCh0l4vhsAhT/Vpyt+ZVXNmLs14jWx7d30QDGaCMRUg4XMfWwCEB7o
         7j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592629; x=1703197429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJn5qRs6lqTbZ3HymPXKMtcJ4ZUxdDzTr5RaipMgT4A=;
        b=INxvKYF5gPm8lAP5jzcBnp46w2uaBa3T3ZbIp4XR1RiYVPvKwkW0/AJZN+XmR68O8N
         id11h9ZkftmM0Gyt/2Or5RXb3mCOhr2294i3FiyJMJ7fEchUux6Gdtm7OTBeEB9ZEWZT
         Is5ZW0eThEBxMpsyTadMAoBfr2rtxqNLuq1TpACr+nOCym/1Wd23wVKrGlPX8YTLz/eQ
         psqnHW/jb3+V5zw1kdWw+IIKlcWHT/2UaSpV1Zjzux59zRrDPR9dK61IKN2WFPZ32wVK
         z5b6DPkxpNpjOzHhsHx+erm38eRx62bq7v2EDl5QZjdy8MJnOMtSGKqhHCTK/vnvaauf
         luMg==
X-Gm-Message-State: AOJu0Yzu6kPUz17UwpL/ZFyYAz+yUertB1Hr1+RmOYZo397Yduvg9kS+
	aVsoEK4aL9oX5bKu3KwSJK9Bq4SMjXgKVlz7rlcOvQ==
X-Google-Smtp-Source: AGHT+IEyAyxIEqv5kskArvqU0iw5bGtY+Ru6qLVDG3Ku4806wwKSc48Ik9cxrJrRsx/C3YoEEKkq8w==
X-Received: by 2002:a05:6870:6190:b0:1fa:1ebb:8e86 with SMTP id a16-20020a056870619000b001fa1ebb8e86mr7019478oah.52.1702592629548;
        Thu, 14 Dec 2023 14:23:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id xm7-20020a0568709f8700b001fb2acf9a66sm1735958oab.51.2023.12.14.14.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:49 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/26] midx: factor out `fill_pack_info()`
Message-ID: <a06ed75af1276d9467ca2e5a414407c353412ddf.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

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
 midx.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/midx.c b/midx.c
index 778dd536c8..8dba67ddbe 100644
--- a/midx.c
+++ b/midx.c
@@ -475,6 +475,17 @@ struct pack_info {
 	unsigned expired : 1;
 };
 
+static void fill_pack_info(struct pack_info *info,
+			   struct packed_git *p, const char *pack_name,
+			   uint32_t orig_pack_int_id)
+{
+	memset(info, 0, sizeof(struct pack_info));
+
+	info->orig_pack_int_id = orig_pack_int_id;
+	info->pack_name = xstrdup(pack_name);
+	info->p = p;
+}
+
 static int pack_info_compare(const void *_a, const void *_b)
 {
 	struct pack_info *a = (struct pack_info *)_a;
@@ -515,6 +526,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			     const char *file_name, void *data)
 {
 	struct write_midx_context *ctx = data;
+	struct packed_git *p;
 
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
@@ -541,27 +553,22 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
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
-			close_pack(ctx->info[ctx->nr].p);
-			FREE_AND_NULL(ctx->info[ctx->nr].p);
+			close_pack(p);
+			free(p);
 			return;
 		}
 
-		ctx->info[ctx->nr].pack_name = xstrdup(file_name);
-		ctx->info[ctx->nr].orig_pack_int_id = ctx->nr;
-		ctx->info[ctx->nr].expired = 0;
+		fill_pack_info(&ctx->info[ctx->nr], p, file_name, ctx->nr);
 		ctx->nr++;
 	}
 }
@@ -1321,11 +1328,6 @@ static int write_midx_internal(const char *object_dir,
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
@@ -1341,10 +1343,10 @@ static int write_midx_internal(const char *object_dir,
 				if (open_pack_index(ctx.m->packs[i]))
 					die(_("could not open index for %s"),
 					    ctx.m->packs[i]->pack_name);
-				ctx.info[ctx.nr].p = ctx.m->packs[i];
 			}
 
-			ctx.nr++;
+			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
+				       ctx.m->pack_names[i], i);
 		}
 	}
 
-- 
2.43.0.102.ga31d690331.dirty

