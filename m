Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UlScft13"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278BD63
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:02 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77d5cf15280so318222485a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198481; x=1701803281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNHSdvJxUhh1bobqc9K0tlmjnWuuFEhSc/suqvGlddM=;
        b=UlScft13hCYz15dOdHDtvEV3hB+aMAh6Ifm0Twbip3LZKvSwg/ej+S62kv33vJU0Qv
         1KDiWFMEfLgQBMBFVWrDBB9cpYATk170PzCx91TBIiuPeGamnwVCefgPcW8xDSRYLwck
         8KQYc56SGGeXTGtAYSh2VF403/5f+jwUXmYSjBc83gTz85/uiHZlEv2BcDDjnyqyb/Fq
         BVrguR6fzxpozan9T1uHLDqXmu52ZTDiq9rd9K6kBP8lMYoD8iu922lVmsm4PVN7wLeu
         MQDm3zltKQ2rRps+X3CLtdTaw893VL9kU1g8bG0/jDAcYbMZ6mKPnbpnL3NsK8KWxhfq
         sQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198481; x=1701803281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNHSdvJxUhh1bobqc9K0tlmjnWuuFEhSc/suqvGlddM=;
        b=JI+hKg2LFyXt1OnrQ8q+CQpG7LeIbVtttMVBDaavAfndXsecnNoZlW45yOPam/EBrz
         4Fx9gBYDIQUR2ObSERodHnSjPesxX7/cl7N8d4wTPamT0IVsG2pO/Kwz0qSREh+NHtJO
         Aa/tRA4cGr8SQ2zwI68itSEdrQ3McUpdPd0fVVGqgLrsFUSkOqjRZC5jlo0QJ+3DrI3S
         uR3J/u2EogYtkx38aNKRDRf2m++IyePaRGSwwRs/nZo4hzOAipUGFopuQXfJY/S4kVKX
         ljm3zF909mbJyKUx3wXaucxi8TGUzD4dbP+8cgfEo3jTgbR4Q6t7uBVK8y9KVAIzlq4Y
         HAiA==
X-Gm-Message-State: AOJu0Yx7IA7f1G/XDF9r6RP1NQpOi83u4ECM5lBwQH54+pTcf2IO84OZ
	jo44b6VexpRCyFEDRT3KQU6Pdc2Ng+Da2bccMx4=
X-Google-Smtp-Source: AGHT+IHILdUxJ8W9ai8usxuAQMoR469YyRnyJBFksl5Zz28nyE2zNr2uuztipeKcOFFZUVZo/fMbCQ==
X-Received: by 2002:a05:620a:6409:b0:77d:6804:aeda with SMTP id pz9-20020a05620a640900b0077d6804aedamr20712114qkn.19.1701198480965;
        Tue, 28 Nov 2023 11:08:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a11b300b0077dc7cb232asm289063qkk.103.2023.11.28.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:00 -0800 (PST)
Date: Tue, 28 Nov 2023 14:07:59 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/24] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>
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

The `bb_commit` commit slab is used by the pack-bitmap-write machinery
to track various pieces of bookkeeping used to generate reachability
bitmaps.

Even though we clear the slab when freeing the bitmap_builder struct
(with `bitmap_builder_clear()`), there are still pointers which point to
locations in memory that have not yet been freed, resulting in a leak.

Plug the leak by introducing a suitable `free_fn` for the `struct
bb_commit` type, and make sure it is called on each member of the slab
via the `deep_clear_bb_data()` function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f4ecdf8b0e..dd3a415b9d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -198,6 +198,13 @@ struct bb_commit {
 	unsigned idx; /* within selected array */
 };
 
+static void clear_bb_commit(struct bb_commit *commit)
+{
+	free(commit->reverse_edges);
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
2.43.0.24.g980b318f98

