Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEE3FB12
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2qFzci2b"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303F3580
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d0169cf43so45160856d6.3
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697648881; x=1698253681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdOewODb38aAPzbzHPP7AVJkAW1Xajuiv60PskYm8LA=;
        b=2qFzci2bb1MnqIX39f9Eay08CiXn7KueCkeXnTfhDkU7aMH4oLmiebj+qS7XpC9GAJ
         Yj6A3anUpiJH7Bar6CApKjraGzTzmWbTYtQRyWEk/o2QIrWwlQdcw8LCnULBAgmLEYku
         d7Ze4kxsAPv/4rbTbg07t0BOnigjrlVxN6pXKWhdxz6cGVWDb+Na7kIKVzcJhkwd06bX
         cvaq268fB23LKXr7JwipFbC13dpgGi+DHtUZz8wE2BO6a9nbeawZzeShveSNoS/cl1N3
         nD46OS6h8C4gVOphLGE2340/GTpptjPlTuCsHEs6IlzDwQ7tI6ZzEjPY0yfDsPwUbbEU
         KMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648881; x=1698253681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdOewODb38aAPzbzHPP7AVJkAW1Xajuiv60PskYm8LA=;
        b=s99T+cRt0N4+XEKeG99vqbhR3gbvUyUtiazwx1NXga9ox2nHQYzwaEVqNM7RYF/Aje
         CYif8qLiLzCXF/yvqihapstGOrLMEleUPgdPgavSvYdMZhwI0vg7pL7n+54lOFQ1dCql
         bWPE+8+dfW+3K0T4wD30s1/0hEIIxEL8naNe+5sgKl3Sy02jIzbyLIjG8cC/INFNtMt5
         yhrmEUD5iGK4yTkAnGEsfb5udx9shbf9Jf6svXLd/cfaPrJLahd+/vHrI4Uur9TkFZ9B
         vKA4u2+DL8Gk0w/+TlG3qEUMj8r/w2jGPU96A/e84qqYD93LMas5E8T+sB0OKcH1veut
         PQ2A==
X-Gm-Message-State: AOJu0YxUetb2DiVQ9zhwMcvTHMccZI0EZaI+48TKOtXd+DB0mhkyhkof
	l3MDiFYhgsV0u1+QNbvizsbzYw9xn3ZnCStHw6/VmA==
X-Google-Smtp-Source: AGHT+IE0WF+KLVefTIqTLGMbKjQYZp7lFSQSYPi0MRTBNMgni0pxsfInBX55cyhVlxpb8ErLrNtmVA==
X-Received: by 2002:a05:6214:2262:b0:66d:253c:9a80 with SMTP id gs2-20020a056214226200b0066d253c9a80mr7978835qvb.54.1697648880871;
        Wed, 18 Oct 2023 10:08:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w16-20020a0cef90000000b006577e289d37sm101494qvr.2.2023.10.18.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:08:00 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:07:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 04/10] bulk-checkin: factor out `finalize_checkpoint()`
Message-ID: <893051d0b7aa162396778cd696e98ae507d7f3d6.1697648864.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697648864.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697648864.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a similar spirit as previous commits, factor out the routine to
finalize the just-written object from the bulk-checkin mechanism.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b92d7a6f5a..f4914fb6d1 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -292,6 +292,30 @@ static void truncate_checkpoint(struct bulk_checkin_packfile *state,
 	flush_bulk_checkin_packfile(state);
 }
 
+static void finalize_checkpoint(struct bulk_checkin_packfile *state,
+				git_hash_ctx *ctx,
+				struct hashfile_checkpoint *checkpoint,
+				struct pack_idx_entry *idx,
+				struct object_id *result_oid)
+{
+	the_hash_algo->final_oid_fn(result_oid, ctx);
+	if (!idx)
+		return;
+
+	idx->crc32 = crc32_end(state->f);
+	if (already_written(state, result_oid)) {
+		hashfile_truncate(state->f, checkpoint);
+		state->offset = checkpoint->offset;
+		free(idx);
+	} else {
+		oidcpy(&idx->oid, result_oid);
+		ALLOC_GROW(state->written,
+			   state->nr_written + 1,
+			   state->alloc_written);
+		state->written[state->nr_written++] = idx;
+	}
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -324,22 +348,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 		if (lseek(fd, seekback, SEEK_SET) == (off_t) -1)
 			return error("cannot seek back");
 	}
-	the_hash_algo->final_oid_fn(result_oid, &ctx);
-	if (!idx)
-		return 0;
-
-	idx->crc32 = crc32_end(state->f);
-	if (already_written(state, result_oid)) {
-		hashfile_truncate(state->f, &checkpoint);
-		state->offset = checkpoint.offset;
-		free(idx);
-	} else {
-		oidcpy(&idx->oid, result_oid);
-		ALLOC_GROW(state->written,
-			   state->nr_written + 1,
-			   state->alloc_written);
-		state->written[state->nr_written++] = idx;
-	}
+	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
 	return 0;
 }
 
-- 
2.42.0.408.g97fac66ae4

