Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DB6E2BB
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kBszcGR7"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5906df1d2adso44348eaf.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592623; x=1703197423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpb97+wmWvddLNa6TbWiGBUlqgUoWA+hzhvJsz6L1dI=;
        b=kBszcGR77vEoZBg3Pp272zW7qKV+ajcKiDMcK4pR5t3Fnd4m5kXln/4bc2MaMd2xlE
         nrJTScMwppAdR4LRq4DVUEC/jMrMK3xFQgs+d6g9E8No1IkxLWecjxm//H9ZFy9vVlRN
         yf5m0Gmln9EglK9fIFmk1ZI5/S7XigGhEQw0zVgXxGLQ9kdKCytLFO6ugBTMQr9bhz9o
         t6PTxppYP6X3cIquqwKdLQXdO3OgFx0XgSb7eghVU7y0ieH0qcf0GgvWnoISiIwC1JKh
         5xVMJmRLSx+vugaYwUtH1zn6wJIFwtBwnbpW2fvRKok5NlxL994KA0+1t+Lcm5Fbp0so
         CvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592623; x=1703197423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpb97+wmWvddLNa6TbWiGBUlqgUoWA+hzhvJsz6L1dI=;
        b=uXIz/c97XyQ2RsvGi8+640l+vaK/wjnieHgy5BFrBga9wsEGWoPGRIIpIG88uxZko5
         ozy+a2Gc1Ywn8rxRnb8Mq7k1/7fwhknZjtSrC0yF8FORl/+fheNttDMCk4OD8eBE97LL
         BHMlAALIVCVxXetbYodCuUjX88GuXc4QmkZyT7b1RWaMHX6o21bfD//By6WT4ObH22LB
         rPfXCOmIRtGW/tyMfckyXWexCMdYbG6bHQEl+sgAqDATvGBnBwBp0NeYWM05HFQ1V46W
         w2QkCHhYa3PvBGPz9jJX/9fPZRzqFDiO94scjIpS/Y5KClu83pFbWWX4mZhMP0MSZUxo
         1TjQ==
X-Gm-Message-State: AOJu0YwbtylvuVtl6slSEYIacpbFhEuDsvQbxiDmQxbPZKKED+k4zt/u
	Z2ATaMl7g4RX4vijSUaQNXSUw9ZvTmAdPxXLMwyvvg==
X-Google-Smtp-Source: AGHT+IEMN5vMlodgeVWhTWhAn/54up8yip+Z4r54OJR/MR6TiA1wrbZCcm1wPmR4a5V5zNh1cwG4UQ==
X-Received: by 2002:a4a:dfb6:0:b0:590:6fd5:68f2 with SMTP id k22-20020a4adfb6000000b005906fd568f2mr5140508ook.18.1702592623687;
        Thu, 14 Dec 2023 14:23:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568301e0e00b006d87dc31cddsm3361038otr.37.2023.12.14.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:43 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/26] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <19cdaf59c5e8c2aa58b757f7013ccb4ba1cc7f98.1702592604.git.me@ttaylorr.com>
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

The `bb_commit` commit slab is used by the pack-bitmap-write machinery
to track various pieces of bookkeeping used to generate reachability
bitmaps.

Even though we clear the slab when freeing the bitmap_builder struct
(with `bitmap_builder_clear()`), there are still pointers which point to
locations in memory that have not yet been freed, resulting in a leak.

Plug the leak by introducing a suitable `free_fn` for the `struct
bb_commit` type, and make sure it is called on each member of the slab
via the `deep_clear_bb_data()` function.

Note that it is possible for both of the arguments to `bitmap_free()` to
be NULL, but `bitmap_free()` is a noop for NULL arguments, so it is OK
to pass them unconditionally.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f4ecdf8b0e..ae37fb6976 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -198,6 +198,13 @@ struct bb_commit {
 	unsigned idx; /* within selected array */
 };
 
+static void clear_bb_commit(struct bb_commit *commit)
+{
+	free_commit_list(commit->reverse_edges);
+	bitmap_free(commit->commit_mask);
+	bitmap_free(commit->bitmap);
+}
+
 define_commit_slab(bb_data, struct bb_commit);
 
 struct bitmap_builder {
@@ -339,7 +346,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 static void bitmap_builder_clear(struct bitmap_builder *bb)
 {
-	clear_bb_data(&bb->data);
+	deep_clear_bb_data(&bb->data, clear_bb_commit);
 	free(bb->commits);
 	bb->commits_nr = bb->commits_alloc = 0;
 }
-- 
2.43.0.102.ga31d690331.dirty

