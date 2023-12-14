Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7F2C6B8
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2WUa3Ug5"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d9e9b72ecfso59886a34.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592658; x=1703197458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m98ij0UquASMbSrqlkhGVvX4Kku1DVwI/fwUpawfsf4=;
        b=2WUa3Ug5GN/rHNXItIfiaWlMsOnfdeOKEA3DvX+Jj52MJbAM3IfPdlMqZI+uxsfFem
         Rf6AQZKzjbxjQTzSjD9xbqB6w7BQmkzmFRgHZowqY1oheQPwgoOkiRW/tN/OEUmbgXEb
         LBeLYSYnilwD1AEJ4GKKbBF+HlbgQ74DCezLFT6/Lk6PmIgyCF+hu5AP1gOvDjYXREjp
         wb79dOq9Dayx/+Q2AmihjjFQg2srlsdGnqKVCtOKl07jNimyx6OAwdraQ/djN51WtFgd
         Xsa/9b8e9fyaMen9PP0zmK9YCRfnWADRl/Cl3gk+K/BueQUj07zozbLycOrhGcFxR9Oy
         pHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592658; x=1703197458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m98ij0UquASMbSrqlkhGVvX4Kku1DVwI/fwUpawfsf4=;
        b=ZXYDg2Ov1Yy/bYufoLVHlkFisN05KuMJCtrPc3flAYf8ICe5bOE2Mp+Z3ueg5ceHKt
         P3MHNxZkXAz6MCNlIrDwB3U33khxlc2BBb0XAzaq3PgdyGaLsjkrgZ5772rTAfsVUjzZ
         Gys0eIebu8ayjphQ/DpV0K0Mjy1LTfbzxRpIumOgDJrQw21e3u9aLoXXfAPJbBFOTVUN
         bv9H1cdWm8W3vC6+gBHjkavVPSwV/iD08ucDOtx235S1uTFJRekpTAwsg77rbBWVPeFF
         Ni/vI0fvcY6Mh4C7GJ0f5XWlzduyxmHV326AFAcil5e97QQ9w9ITT2PYAJrO9B4RGXd5
         rJeQ==
X-Gm-Message-State: AOJu0Yw9eI0TsPvU1GiR/wolVTYCDbVGJjoFkFau2KcjVAgOydJPDwqV
	n0z6LcnCg7v7NVxBARK6bO6FJGgcRv50JOUVU/HzpQ==
X-Google-Smtp-Source: AGHT+IGGHBnEkGGNly6peoTpfTPCGY4SWBJ9EnKEzuXlc/3wQ3GCz0cjpPHiDnqX4JFauTPNtUTKRg==
X-Received: by 2002:a9d:744b:0:b0:6d9:d278:3f2b with SMTP id p11-20020a9d744b000000b006d9d2783f2bmr11392149otk.45.1702592658544;
        Thu, 14 Dec 2023 14:24:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi13-20020a056830378d00b006d9ccfddbdcsm3052672otb.68.2023.12.14.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:18 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/26] pack-objects: prepare
 `write_reused_pack_verbatim()` for multi-pack reuse
Message-ID: <805c42185ab92bb4303e91fb15e884940380fc87.1702592604.git.me@ttaylorr.com>
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

The function `write_reused_pack_verbatim()` within
`builtin/pack-objects.c` is responsible for writing out a continuous
set of objects beginning at the start of the reuse packfile.

In the existing implementation, we did something like:

    while (pos < reuse_packfile_bitmap->word_alloc &&
           reuse_packfile_bitmap->words[pos] == (eword_t)~0)
      pos++;

    if (pos)
      /* write first `pos * BITS_IN_WORD` objects from pack */

as an optimization to record a single chunk for the longest continuous
prefix of objects wanted out of the reuse pack, instead of having a
chunk for each individual object. For more details, see bb514de356
(pack-objects: improve partial packfile reuse, 2019-12-18).

In order to retain this optimization in a multi-pack reuse world, we can
no longer assume that the first object in a pack is on a word boundary
in the bitmap storing the set of reusable objects.

Assuming that all objects from the beginning of the reuse packfile up to
the object corresponding to the first bit on a word boundary are part of
the result, consume whole words at a time until the last whole word
belonging to the reuse packfile. Copy those objects to the resulting
packfile, and track that we reused them by recording a single chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 73 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ce52d88a9..31053128fc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1097,31 +1097,78 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
-					 off_t pack_start UNUSED,
+					 off_t pack_start,
 					 struct pack_window **w_curs)
 {
-	size_t pos = 0;
+	size_t pos = reuse_packfile->bitmap_pos;
+	size_t end;
 
-	while (pos < reuse_packfile_bitmap->word_alloc &&
-			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
-		pos++;
+	if (pos % BITS_IN_EWORD) {
+		size_t word_pos = (pos / BITS_IN_EWORD);
+		size_t offset = pos % BITS_IN_EWORD;
+		size_t last;
+		eword_t word = reuse_packfile_bitmap->words[word_pos];
 
-	if (pos) {
-		off_t to_write;
+		if (offset + reuse_packfile->bitmap_nr < BITS_IN_EWORD)
+			last = offset + reuse_packfile->bitmap_nr;
+		else
+			last = BITS_IN_EWORD;
 
-		written = (pos * BITS_IN_EWORD);
-		to_write = pack_pos_to_offset(reuse_packfile->p, written)
-			- sizeof(struct pack_header);
+		for (; offset < last; offset++) {
+			if (word >> offset == 0)
+				return word_pos;
+			if (!bitmap_get(reuse_packfile_bitmap,
+					word_pos * BITS_IN_EWORD + offset))
+				return word_pos;
+		}
+
+		pos += BITS_IN_EWORD - (pos % BITS_IN_EWORD);
+	}
+
+	/*
+	 * Now we're going to copy as many whole eword_t's as possible.
+	 * "end" is the index of the last whole eword_t we copy, but
+	 * there may be additional bits to process. Those are handled
+	 * individually by write_reused_pack().
+	 *
+	 * Begin by advancing to the first word boundary in range of the
+	 * bit positions occupied by objects in "reuse_packfile". Then
+	 * pick the last word boundary in the same range. If we have at
+	 * least one word's worth of bits to process, continue on.
+	 */
+	end = reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr;
+	if (end % BITS_IN_EWORD)
+		end -= end % BITS_IN_EWORD;
+	if (pos >= end)
+		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
+
+	while (pos < end &&
+	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
+		pos += BITS_IN_EWORD;
+
+	if (pos > end)
+		pos = end;
+
+	if (reuse_packfile->bitmap_pos < pos) {
+		off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
+		off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
+							pos - reuse_packfile->bitmap_pos);
+
+		written += pos - reuse_packfile->bitmap_pos;
 
 		/* We're recording one chunk, not one object. */
-		record_reused_object(sizeof(struct pack_header), 0);
+		record_reused_object(pack_start_off,
+				     pack_start_off - (hashfile_total(out) - pack_start));
 		hashflush(out);
 		copy_pack_data(out, reuse_packfile->p, w_curs,
-			sizeof(struct pack_header), to_write);
+			pack_start_off, pack_end_off - pack_start_off);
 
 		display_progress(progress_state, written);
 	}
-	return pos;
+	if (pos % BITS_IN_EWORD)
+		BUG("attempted to jump past a word boundary to %"PRIuMAX,
+		    (uintmax_t)pos);
+	return pos / BITS_IN_EWORD;
 }
 
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
-- 
2.43.0.102.ga31d690331.dirty

