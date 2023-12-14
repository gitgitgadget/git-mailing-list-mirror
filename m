Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF367215
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xHq9gnOZ"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fb9a22b4a7so30673fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592635; x=1703197435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5jT4KWLJtxvtElWXJZV/gpmSKNZ9enQEjfI8AweJxI=;
        b=xHq9gnOZIvGPvjaFGnCROb+rFY4WDFqv8bw7wVVCu446oln36HAzuGfF/fPxV0oDTR
         bwW4ybyNk7XcXgkmlGlGaGFnkxFUR34uroO53vSYsUqPR9uGQcK/behrtMX4ntnfBLS4
         LqTN2FjhLer1doOrZYsTc4Ok8egBozUrS1nWeyn4YCytMdQmwcAgN3SBN8TowlTCM2j7
         blJkJ4pKSnNC/LESB7v6OThUiyYF2Bs1wOBMzk1646tAxGnR+ogvImvtHMSiaR7vKxPx
         NfpbMpJMrYAwU3SasaJRcSBvftkmC4NtxXorU05tpDbdsMgMqw3kc6hQwYPRQ8Wh1olC
         D16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592635; x=1703197435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5jT4KWLJtxvtElWXJZV/gpmSKNZ9enQEjfI8AweJxI=;
        b=AFOF7e5Li3nIkhFFE+sFDN4GwouQiUFVrNOxbo0ynKYX9+OHi0UBOA+w54DDheHWTw
         oces/OIxhUrrMxPi8EUCdilNZxvIhQrgXPqYlzVYf3tfi72POtABttvwqDGSowxzLkuK
         NjhHdFRtOEzPpCXo3fr+sgK9rhvbFx7nPtZ59gjwcES/U3AC2G2c+NQlMVJHR4AW4vl6
         QPByljNaKSuWpdl2XDghVAldXcLNMB5YGoqBw/ifeUT/ZTeFpOv0jzA63McEVa0anSrY
         GR5PpXQ6QO7bLN9iym0Hmwsy/muhuC0dn5GmvWCB7y6C+Xt196BwycdNLCj52YtV5vgK
         lT6A==
X-Gm-Message-State: AOJu0YxGYu+lu5Z6QwX1ByI3GPTQ8zLzMHTSq1NEkkAmjSffVDjQdxq7
	h6tpBfTReRUDPV69y4InV/3rAR1Z8KirnkeqG7qDBw==
X-Google-Smtp-Source: AGHT+IHNHHXvVyg3qqZL0Xq1fi+mexRNZAyIyjrWgmbVc6nR2ztQUnPuwhwaaPWjeVg+N2oODYkkjQ==
X-Received: by 2002:a05:6871:824:b0:203:fde:f894 with SMTP id q36-20020a056871082400b002030fdef894mr4590362oap.57.1702592635161;
        Thu, 14 Dec 2023 14:23:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id gu11-20020a056870ab0b00b001fb3143cc0bsm4760250oab.44.2023.12.14.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:54 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/26] midx: implement `midx_locate_pack()`
Message-ID: <96f397a2b2a48db87975cee4789a91e45bd3bc39.1702592604.git.me@ttaylorr.com>
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

The multi-pack index API exposes a `midx_contains_pack()` function that
takes in a string ending in either ".idx" or ".pack" and returns whether
or not the MIDX contains a given pack corresponding to that string.

There is no corresponding function to locate the position of a pack
within the MIDX's pack order (sorted lexically by pack filename).

We could add an optional out parameter to `midx_contains_pack()` that is
filled out with the pack's position when the parameter is non-NULL. To
minimize the amount of fallout from this change, instead introduce a new
function by renaming `midx_contains_pack()` to `midx_locate_pack()`,
adding that output parameter, and then reimplementing
`midx_contains_pack()` in terms of it.

Future patches will make use of this new function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 13 +++++++++++--
 midx.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index de25612b0c..beaf0c0de4 100644
--- a/midx.c
+++ b/midx.c
@@ -428,7 +428,8 @@ static int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
+		     uint32_t *pos)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -439,8 +440,11 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 
 		current = m->pack_names[mid];
 		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
-		if (!cmp)
+		if (!cmp) {
+			if (pos)
+				*pos = mid;
 			return 1;
+		}
 		if (cmp > 0) {
 			first = mid + 1;
 			continue;
@@ -451,6 +455,11 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 	return 0;
 }
 
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+{
+	return midx_locate_pack(m, idx_or_pack_name, NULL);
+}
+
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
 {
 	struct multi_pack_index *m;
diff --git a/midx.h b/midx.h
index b404235db5..89c5aa637e 100644
--- a/midx.h
+++ b/midx.h
@@ -70,7 +70,10 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
 int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
+int midx_contains_pack(struct multi_pack_index *m,
+		       const char *idx_or_pack_name);
+int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
+		     uint32_t *pos);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 /*
-- 
2.43.0.102.ga31d690331.dirty

