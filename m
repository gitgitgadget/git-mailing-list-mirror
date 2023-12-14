Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F36720C
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MbJqBnBa"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9f069e9b0so63447a34.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592656; x=1703197456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4XNhNNhFFLFDKKlC4eR3SMBA65aA/jbaNCQOeCQ6bI=;
        b=MbJqBnBap7jVQLodTgtN3gETHcybHbJtrT1Rurh78JrlvRvEGGZxsyPZbQuH614zTE
         nF/K1/jVd1CvyRrMxztP1oFRSnC51Yv71QiKVqRX0csMCnJ2DYXWv75+2aXxDY20OazB
         1k/wzF1N1797+ubIeOkQNZGxe1O3pV652fuuFGJmLNh9u2TN65cLWhys/AHWtWxal4ib
         I3UWXjaXtaq3ufiLR+809Yu5yeFxUnFD0rd412TqtLDEuoZkPLM1GjK3Huz1LOfF3njn
         IgJQX2vJ8RKkGZcaUB9Fm+YqoghsItBiY/w6ZXH206zWqGti1A6IKU7ctQ91OAKxnNNT
         1FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592656; x=1703197456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4XNhNNhFFLFDKKlC4eR3SMBA65aA/jbaNCQOeCQ6bI=;
        b=wc3NZnTTr+wg79NScjAIWUixpjP61bJz+yrQtNvlioR0yCBRNRW7rVrXNaRlLllvyP
         fK0h4O4FNIKECsMCO58blpxXQc81V9kf3cMqnBevijljBH8THnbZ/1dEIm6+z5ZFXH3j
         GHmzYSf0+sLVds58brKgTmxKrEmzqAlnAyv2GVtTeTmn8ovZeMXiGXQ76mE/kEv/APKK
         Uv4Ua0fPgv/zgyjx9GCTAg6wYxne4LWATAWKuDzj5o1yEznxXi+MPkXJ6DroEARzMaYF
         KPMCPZ481teNfqkSk/3PrISF6uIXxfZeHHkQNk37g0MduOfDbumZk09zKTEWkF3WJ80V
         SjFg==
X-Gm-Message-State: AOJu0YxExFEVsLbDjgiIG3HSHXaKJIt/GPwqYn1dRxE9rTT8zKm8KTm3
	2LtuSa3Wr8eFx6IoUuMnQ6cCq+bNJ10qDnz/WLrmgg==
X-Google-Smtp-Source: AGHT+IHJE6l0iY/onrivYq9/wiK9+XcjoaAcKU9AnnAeWGmya+cmpcNgO4x9Lds7vqjO/zu6g1rIYQ==
X-Received: by 2002:a9d:7f11:0:b0:6d9:a1f8:6b9a with SMTP id j17-20020a9d7f11000000b006d9a1f86b9amr9816362otq.47.1702592655878;
        Thu, 14 Dec 2023 14:24:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cq8-20020a056830668800b006d7f6638afesm1108494otb.0.2023.12.14.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:15 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/26] pack-objects: prepare `write_reused_pack()` for
 multi-pack reuse
Message-ID: <b32742ebcb0632aabcc82427cae7823e75cf6b9c.1702592604.git.me@ttaylorr.com>
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

The function `write_reused_pack()` within `builtin/pack-objects.c` is
responsible for performing pack-reuse on a single pack, and has two main
functions:

  - it dispatches a call to `write_reused_pack_verbatim()` to see if we
    can reuse portions of the packfile in whole-word chunks

  - for any remaining objects (that is, any objects that appear after
    the first "gap" in the bitmap), call write_reused_pack_one() on that
    object to record it for reuse.

Prepare this function for multi-pack reuse by removing the assumption
that the bit position corresponding to the first object being reused
from a given pack must be at bit position zero.

The changes in this function are mostly straightforward. Initialize `i`
to the position of the first word to contain bits corresponding to that
reuse pack. In most situations, we throw the initialized value away,
since we end up replacing it with the return value from
write_reused_pack_verbatim(), moving us past the section of whole words
that we reused.

Likewise, modify the per-object loop to ignore any bits at the beginning
of the first word that do not belong to the pack currently being reused,
as well as skip to the "done" section once we have processed the last
bit corresponding to this pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 07c849b5d4..6ce52d88a9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1127,7 +1127,7 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			      struct hashfile *f)
 {
-	size_t i = 0;
+	size_t i = reuse_packfile->bitmap_pos / BITS_IN_EWORD;
 	uint32_t offset;
 	off_t pack_start = hashfile_total(f) - sizeof(struct pack_header);
 	struct pack_window *w_curs = NULL;
@@ -1145,17 +1145,23 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
+			if (pos + offset < reuse_packfile->bitmap_pos)
+				continue;
+			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
+				goto done;
 			/*
 			 * Can use bit positions directly, even for MIDX
 			 * bitmaps. See comment in try_partial_reuse()
 			 * for why.
 			 */
-			write_reused_pack_one(reuse_packfile->p, pos + offset,
+			write_reused_pack_one(reuse_packfile->p,
+					      pos + offset - reuse_packfile->bitmap_pos,
 					      f, pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
 
+done:
 	unuse_pack(&w_curs);
 }
 
-- 
2.43.0.102.ga31d690331.dirty

