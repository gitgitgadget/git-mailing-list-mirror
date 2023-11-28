Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AZGr/vwr"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC0C3
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:34 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d67000b69so333897285a.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198513; x=1701803313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gJXQz2t/K9qukTZoVFmWxkjVYWThf7iWKhcma2Kg/4=;
        b=AZGr/vwr5WrFuXrzGwruXHJNO5Jer5LvhU3jpAsjHqDq5lSI6y6IaZ7Aa7b93yZJFe
         ukZJkzyMK0JOvcda5Y1Ui/qclsqp1QsaeInlMJewJDUpapM5ZAOyQLdXm1V049HkyEec
         4egis6hyTPy0N+tNyVD9vFdFfDOEomi9r9491IriVo6IZ00L+f/uy1mwgQZtUg4SvBeo
         M7mfFU+eL5FLokT9uVvseA4HFdNAtnURpyvJmUY9UKDeipjPadwWGwu0UFLpefW+ITkA
         GCb3KZevBkAKk42YQ72g0cJ8cjSOyCoIco4ZitdC+aMpowVvmyQn4XCn6sdA6OoyaQ06
         Ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198513; x=1701803313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gJXQz2t/K9qukTZoVFmWxkjVYWThf7iWKhcma2Kg/4=;
        b=sXI7kaX4w5jFKUZeFQ/51ZXccv6kq8jtftljad0OvvzEMZtDQHkEdm9emVJ7Ty5PF7
         MVoEhoS+TlyZCzKxAe1kWsmCdfCvq6HOt3t0P0nZblp22KjsBm76vNOQ0MokwTUOpmSw
         rBxGRBKSmlX+lzkEjfxHjPYY0lYe0fT+8TIYHITVEGsWfreQ8qssHMMIwTjp2sS8yDan
         FP12JdmT3hqkcG+aCj1eo3wmn/Ja9niz6k3BJI+Umrs5rexy6l99vjYPY8z/zUxjSloE
         pfSKuAiC8p/VAUJf/ybM3T0ZsjAMSUoboh8bCwPdsOr37eFodRA7T+o1So9OwMDUb9SV
         Ky9g==
X-Gm-Message-State: AOJu0YyM2xATp2Gpc8piqKMTxoL4QPOUDy9QjVA6wh0ebEWD5TKGkIgD
	fLtypfzAWsmOkmJM4e7psgSRrrztBtlt+YbLvhw=
X-Google-Smtp-Source: AGHT+IGjrVhyrG/ZO8n+pl234gxDQQfpm3DDL1xXheVTIz68Cs/XdRYfqAMEe12p2lMJnrFTdgjUmw==
X-Received: by 2002:a05:620a:8087:b0:774:1ac2:79be with SMTP id ef7-20020a05620a808700b007741ac279bemr18423634qkb.53.1701198513084;
        Tue, 28 Nov 2023 11:08:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id vq2-20020a05620a558200b0077da7a46b0fsm2016966qkn.69.2023.11.28.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:32 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/24] pack-objects: keep track of `pack_start` for each
 reuse pack
Message-ID: <6f4fba861b59f909148775ee64c3ba89afc872b5.1701198172.git.me@ttaylorr.com>
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

When reusing objects from a pack, we keep track of a set of one or more
`reused_chunk`s, corresponding to sections of one or more object(s) from
a source pack that we are reusing. Each chunk contains two pieces of
information:

  - the offset of the first object in the source pack (relative to the
    beginning of the source pack)
  - the difference between that offset, and the corresponding offset in
    the pack we're generating

The purpose of keeping track of these is so that we can patch an
OFS_DELTAs that cross over a section of the reuse pack that we didn't
take.

For instance, consider a hypothetical pack as shown below:

                                                (chunk #2)
                                                __________...
                                               /
                                              /
      +--------+---------+-------------------+---------+
  ... | <base> | <other> |      (unused)     | <delta> | ...
      +--------+---------+-------------------+---------+
       \                /
        \______________/
           (chunk #1)

Suppose that we are sending objects "base", "other", and "delta", and
that the "delta" object is stored as an OFS_DELTA, and that its base is
"base". If we don't send any objects in the "(unused)" range, we can't
copy the delta'd object directly, since its delta offset includes a
range of the pack that we didn't copy, so we have to account for that
difference when patching and reassembling the delta.

In order to compute this value correctly, we need to know not only where
we are in the packfile we're assembling (with `hashfile_total(f)`) but
also the position of the first byte of the packfile that we are
currently reusing.

Together, these two allow us to compute the reused chunk's offset
difference relative to the start of the reused pack, as desired.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7682bd65bb..eb8be514d1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1016,6 +1016,7 @@ static off_t find_reused_offset(off_t where)
 
 static void write_reused_pack_one(struct packed_git *reuse_packfile,
 				  size_t pos, struct hashfile *out,
+				  off_t pack_start,
 				  struct pack_window **w_curs)
 {
 	off_t offset, next, cur;
@@ -1025,7 +1026,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 	offset = pack_pos_to_offset(reuse_packfile, pos);
 	next = pack_pos_to_offset(reuse_packfile, pos + 1);
 
-	record_reused_object(offset, offset - hashfile_total(out));
+	record_reused_object(offset,
+			     offset - (hashfile_total(out) - pack_start));
 
 	cur = offset;
 	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
@@ -1095,6 +1097,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
 					 struct hashfile *out,
+					 off_t pack_start UNUSED,
 					 struct pack_window **w_curs)
 {
 	size_t pos = 0;
@@ -1126,10 +1129,12 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
 {
 	size_t i = 0;
 	uint32_t offset;
+	off_t pack_start = hashfile_total(f) - sizeof(struct pack_header);
 	struct pack_window *w_curs = NULL;
 
 	if (allow_ofs_delta)
-		i = write_reused_pack_verbatim(reuse_packfile, f, &w_curs);
+		i = write_reused_pack_verbatim(reuse_packfile, f, pack_start,
+					       &w_curs);
 
 	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
 		eword_t word = reuse_packfile_bitmap->words[i];
@@ -1146,7 +1151,7 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
 			 * for why.
 			 */
 			write_reused_pack_one(reuse_packfile, pos + offset, f,
-					      &w_curs);
+					      pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
-- 
2.43.0.24.g980b318f98

