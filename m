Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819B2C68E
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ENb03PvX"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59067ccb090so73009eaf.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592669; x=1703197469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CjAgzRsJDCAUE1qxgrABGgz8llngccG1BYa1wyBXg=;
        b=ENb03PvXBNIBs16sKsiOaynfMZYUcX35WHzB2S+c7Y7HqOeSnXLzcWkCPlu6fY+0Yd
         G3YH2VQp7Jwlxwk2yHNItl2XrDkvFngctIBEIToNfweaVExMcaH7LrrVsSsd3taFpBls
         5wFenTjicEj4+JkdsgbL3okSg31lVWtJOh0NjYUtT+bXyHtjbTmG9xHI8M/Whjb1HriP
         bct+Pz2abaCXrCH5RIYEVf1UEFTtbOfFac3+5Wa6UcLNCy91sbY84zOLx9FEkjO87Kv8
         Gdx3pctFyWkIeGW7FQ2TM+99KvvAQAnPl+4kJX2I9buExP/t/x9KfpSc+ZxqNrdnwMye
         cpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592669; x=1703197469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3CjAgzRsJDCAUE1qxgrABGgz8llngccG1BYa1wyBXg=;
        b=pyhIuyqsotPswJYfERfo3CEyoKTs4bLmCRJX2LrnAnKqcUvzASwOTvPfKl3D8S3yB8
         z/zcXeiMATBKD9/n8477cIwAWRq7v9jfb+Xk6da/wRwW+NIic8a/gXtXfoLZUumVHuRF
         R5eUtm35Xl14/Ze4934AbgUgng2GDw5JYk2cGgj5hee6vS2q/cYUswDHQzgWCzI2INJY
         06HHpIw1qfdIMVzzJJfFqaR6k+N4mH+uoB6kfEtKhA34ocn/VciWT1VPaWWWcftbeRtK
         SOfDK7J/UyMBFkdMLw4m/Ky2Ep6VG//x2t06VD5FhfUsW3HfIowFiDTUv+Dp+xQUMtSi
         0MWQ==
X-Gm-Message-State: AOJu0YzEngh+vV+M1a3iN0jTgYdK65+aGpIxqgYDVohgV6zrN3+LU5wG
	fDMLgWXXVQ7oEhh7V1ixvWDyXbMjaJvJ9Bn7Xa6d5g==
X-Google-Smtp-Source: AGHT+IGx9bVR9KJ1MTk9AB72mBGfPnSONQDAtEtaj2ZDI0JlFaQkUPBYdlG1xvBmuSMSZaK+hQxUMQ==
X-Received: by 2002:a4a:58cd:0:b0:590:c350:34c3 with SMTP id f196-20020a4a58cd000000b00590c35034c3mr6485132oob.5.1702592668999;
        Thu, 14 Dec 2023 14:24:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z20-20020a4a6554000000b0059089f2e461sm3621033oog.0.2023.12.14.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:28 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/26] pack-revindex: factor out `midx_key_to_pack_pos()`
 helper
Message-ID: <14b054d27283ffdda1d3f2a4078a4dae54868bfa.1702592604.git.me@ttaylorr.com>
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

The `midx_to_pack_pos()` function implements a binary search over
objects in the MIDX between lexical and pseudo-pack order. It does this
by taking in an index into the lexical order (i.e. the same argument
you'd use for `nth_midxed_object_id()` and similar) and spits out a
position in the pseudo-pack order.

This works for all callers, since they currently all are translating
from lexical order to pseudo-pack order. But future callers may want to
translate a known (offset, pack_id) tuple into an index into the
psuedo-pack order, without knowing where that (offset, pack_id) tuple
appears in lexical order.

Prepare for implementing a function that translates between a (offset,
pack_id) tuple into an index into the psuedo-pack order by extracting a
helper function which does just that, and then reimplementing
midx_to_pack_pos() in terms of it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 7dc6c776d5..baa4657ed3 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -520,19 +520,12 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
+static int midx_key_to_pack_pos(struct multi_pack_index *m,
+				struct midx_pack_key *key,
+				uint32_t *pos)
 {
-	struct midx_pack_key key;
 	uint32_t *found;
 
-	if (!m->revindex_data)
-		BUG("midx_to_pack_pos: reverse index not yet loaded");
-	if (m->num_objects <= at)
-		BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, at);
-
-	key.pack = nth_midxed_pack_int_id(m, at);
-	key.offset = nth_midxed_offset(m, at);
-	key.midx = m;
 	/*
 	 * The preferred pack sorts first, so determine its identifier by
 	 * looking at the first object in pseudo-pack order.
@@ -542,16 +535,32 @@ int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
 	 * implicitly is preferred (and includes all its objects, since ties are
 	 * broken first by pack identifier).
 	 */
-	if (midx_preferred_pack(key.midx, &key.preferred_pack) < 0)
+	if (midx_preferred_pack(key->midx, &key->preferred_pack) < 0)
 		return error(_("could not determine preferred pack"));
 
-
-	found = bsearch(&key, m->revindex_data, m->num_objects,
-			sizeof(*m->revindex_data), midx_pack_order_cmp);
+	found = bsearch(key, m->revindex_data, m->num_objects,
+			sizeof(*m->revindex_data),
+			midx_pack_order_cmp);
 
 	if (!found)
-		return error("bad offset for revindex");
+		return -1;
 
 	*pos = found - m->revindex_data;
 	return 0;
 }
+
+int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
+{
+	struct midx_pack_key key;
+
+	if (!m->revindex_data)
+		BUG("midx_to_pack_pos: reverse index not yet loaded");
+	if (m->num_objects <= at)
+		BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, at);
+
+	key.pack = nth_midxed_pack_int_id(m, at);
+	key.offset = nth_midxed_offset(m, at);
+	key.midx = m;
+
+	return midx_key_to_pack_pos(m, &key, pos);
+}
-- 
2.43.0.102.ga31d690331.dirty

