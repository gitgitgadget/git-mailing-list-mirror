Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C32C697
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ca1j7Pv2"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-20335dcec64so31881fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592648; x=1703197448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmySEqTNnPQFnlPQzIl5fkFaXq8X0shgNEuk2aLPPK8=;
        b=Ca1j7Pv2IMoFQuN3vQAQkCJi6kU3JRN4HQJMTocWtnSri8ovmc2BJjzjFnAqWfGsoZ
         0lhRDCty6bGG6iL4vStgkzYG4fPalkMdsL4yx4597KRmwaDTz0cSmKqSmw1xUwdAUh/U
         qh/xAcBqd9obawviLyEB5/L3mPTQASbTybXIilOmZuFUgtQ1b5X7w/wJWOljhmj4xz3k
         GtZ0jvnMcAH5uTs91y3OghZmOGFw8A2iQ1yw54dRJvdMAoXdPxwVsr5skjxHUh79F41Y
         lg/03dmjFMrqRLYP6ZsVrywBu7mHyZ6A1tuqq1MU5gMjlyBSeAL9fqqDMh4gMUFavmPe
         dIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592648; x=1703197448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmySEqTNnPQFnlPQzIl5fkFaXq8X0shgNEuk2aLPPK8=;
        b=wBG3TRX9VBYU2l6cl0vhDSuPWgyhM01krr/EBvHi/INM1F66pM0OlBEzGIXu6WnHID
         vSaVMbEmAFezf/1cKMkgtTFCb9/4SiLFqcT9qksykiD17crt+BcbM/Nkq9FqKDHGTs0I
         PNe8/uwraMqv8X/8aM/w1+w6M6kxXIZY9tGIFRVeFuzxwybVzsXZNE1wA31TVByyTnQg
         x7BkjcTv+uR18LogYYuHJ298cj0BhVhD7tNKP4UbAKF9rEd803bs3nKJ0frT9LV6YBT5
         5ann9da1lFVCcflCmMy5B1L+xrg+bAwJMWKLcAFQLIesmkAqLikIlZLT+Fagv1w2s5fi
         PVpw==
X-Gm-Message-State: AOJu0Yy/B7CYWBo4LG8GXHiKALqna6eaFrqnykDmXAJh1thSC2P6lU5n
	ttlhosBgT7JY/ePtFAd5X2myeuO/bzJ/3nHcAYhnZg==
X-Google-Smtp-Source: AGHT+IEGg8n6tyr6h/j1LGosNe7opT0uBwgC6oQp/rLuS6/Q/NdsSAGswpxupivCJmGDlGq1cDQB3Q==
X-Received: by 2002:a05:6871:e407:b0:203:1696:1dd1 with SMTP id py7-20020a056871e40700b0020316961dd1mr4569726oac.100.1702592648191;
        Thu, 14 Dec 2023 14:24:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m18-20020a9d6ad2000000b006d7e23c58b6sm3344242otq.38.2023.12.14.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:08 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/26] pack-objects: parameterize pack-reuse routines over
 a single pack
Message-ID: <67e4fd8a061fdc008031f6d3746fd65664965ff2.1702592604.git.me@ttaylorr.com>
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

The routines pack-objects uses to perform verbatim pack-reuse are:

  - write_reused_pack_one()
  - write_reused_pack_verbatim()
  - write_reused_pack()

, all of which assume that there is exactly one packfile being reused:
the global constant `reuse_packfile`.

Prepare for reusing objects from multiple packs by making reuse packfile
a parameter of each of the above functions in preparation for calling
these functions in a loop with multiple packfiles.

Note that we still have the global "reuse_packfile", but pass it through
each of the above function's parameter lists, eliminating all but one
direct access (the top-level caller in `write_pack_file()`). Even after
this series, we will still have a global, but it will hold the array of
reusable packfiles, and we'll pass them one at a time to these functions
in a loop.

Note also that we will eventually need to pass a `bitmapped_pack`
instead of a `packed_git` in order to hold onto additional information
required for reuse (such as the bit position of the first object
belonging to that pack). But that change will be made in a future commit
so as to minimize the noise below as much as possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87e16636a8..102fe9a4f8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1013,7 +1013,8 @@ static off_t find_reused_offset(off_t where)
 	return reused_chunks[lo-1].difference;
 }
 
-static void write_reused_pack_one(size_t pos, struct hashfile *out,
+static void write_reused_pack_one(struct packed_git *reuse_packfile,
+				  size_t pos, struct hashfile *out,
 				  struct pack_window **w_curs)
 {
 	off_t offset, next, cur;
@@ -1091,7 +1092,8 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
 }
 
-static size_t write_reused_pack_verbatim(struct hashfile *out,
+static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
+					 struct hashfile *out,
 					 struct pack_window **w_curs)
 {
 	size_t pos = 0;
@@ -1118,14 +1120,15 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
 	return pos;
 }
 
-static void write_reused_pack(struct hashfile *f)
+static void write_reused_pack(struct packed_git *reuse_packfile,
+			      struct hashfile *f)
 {
 	size_t i = 0;
 	uint32_t offset;
 	struct pack_window *w_curs = NULL;
 
 	if (allow_ofs_delta)
-		i = write_reused_pack_verbatim(f, &w_curs);
+		i = write_reused_pack_verbatim(reuse_packfile, f, &w_curs);
 
 	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
 		eword_t word = reuse_packfile_bitmap->words[i];
@@ -1141,7 +1144,8 @@ static void write_reused_pack(struct hashfile *f)
 			 * bitmaps. See comment in try_partial_reuse()
 			 * for why.
 			 */
-			write_reused_pack_one(pos + offset, f, &w_curs);
+			write_reused_pack_one(reuse_packfile, pos + offset, f,
+					      &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
@@ -1199,7 +1203,7 @@ static void write_pack_file(void)
 
 		if (reuse_packfile) {
 			assert(pack_to_stdout);
-			write_reused_pack(f);
+			write_reused_pack(reuse_packfile, f);
 			offset = hashfile_total(f);
 		}
 
-- 
2.43.0.102.ga31d690331.dirty

