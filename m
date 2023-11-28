Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Tl5dz+v6"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0985410EC
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:12 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778ac9c898dso276704385a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198492; x=1701803292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEDtWcgKkKFMfj4d8K6Y4PlGFqXS3yAeCGaW38EJJH8=;
        b=Tl5dz+v6fpKCwd1IHrvwBkP9bGNQHH9lKBnlUWK2zQ7WlGaVzsWMrkejoEXlPU4lZA
         tL7Y5o23O4vij/707OyScX4afkvZnvjhvl6R6PVrFOiIqq9UknyQOtNzHEqShZGc90dV
         MtfqhHU3nlA5wmklVP5Vk+lAxqEkQUS6uuYaCU4QHFo4i9WBxSSiWd1DWwqyPfk/iib3
         Uc1L3VGaLgPSNeiitduuvrh8AGC1XDVxUADy3URP/DHGSn2LpcDVdDko3oDuPgimgG/b
         2ubKuHQ8Na2pIWeyDl1xWYGxuyHeuOEG/lteoBGOtIBxU5Vr1vY/dJdei3stOFyMXmpz
         hqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198492; x=1701803292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEDtWcgKkKFMfj4d8K6Y4PlGFqXS3yAeCGaW38EJJH8=;
        b=PVlNvXA5JUyTcxfCTCLzkzU5gFODUFBwzsB54SKdXOQkfQXMAFWSw8E9ykejRrjI/U
         jz3PGu6p/dwyW1cn6HEAneFNt2GJCBiek1lJsJaO/aRNT6GYavRmgKcxG8ZR6XSzT9Gt
         nKsjPeDcWsbri1x03QLD9Lsyx48Un3LRD/1/C1NtcicdFMWWcJ1/+pbw7hx1iTUdD2O8
         JBdvjmnMFfassBBOxkl5VLSCHACVeHXi0BcN9XQ/xn4piFtmK/T+pme5lXM0CSpl94Mu
         dn1qu5EzgOXem1xhqYBV2DAkap5M2mTrQp4XDsGa7Cuv/QCpnlUsN1+OV7PxLuKXdo+q
         fpKA==
X-Gm-Message-State: AOJu0YwMNB+9p7daGONd88lFofeA3DU4oSfm3EaQPDfzvpKi9TYF10TX
	GxJvDbtCatwLfmNANrHuoEbxyepnQHo4s8L/0T4=
X-Google-Smtp-Source: AGHT+IH6H6DgOw5Y7jLzNCRRfxul3ern0EAsO3FLTSo/OfWTr1neQ05GtUEUSReRHcUz6ohtIn+Isw==
X-Received: by 2002:a05:620a:1992:b0:77d:bbb7:4690 with SMTP id bm18-20020a05620a199200b0077dbbb74690mr4263950qkb.12.1701198491804;
        Tue, 28 Nov 2023 11:08:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dt32-20020a05620a47a000b0077d71d46887sm4702414qkb.112.2023.11.28.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:11 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/24] midx: implement `midx_locate_pack()`
Message-ID: <541fbb442b78942dd6319821a340b2298c836138.1701198172.git.me@ttaylorr.com>
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
index f55020072f..65ba0c70fe 100644
--- a/midx.c
+++ b/midx.c
@@ -413,7 +413,8 @@ static int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
+		     uint32_t *pos)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -424,8 +425,11 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 
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
@@ -436,6 +440,11 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
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
index cdd16a8378..a6e969c2ea 100644
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
2.43.0.24.g980b318f98

