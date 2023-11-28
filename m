Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eqPFVPgm"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC210F6
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:31 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a3e0fb11aso15709856d6.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198510; x=1701803310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzd1kLFDSKSrvJElIbHY8ojcKXX1VK/68PrAguZ/47Q=;
        b=eqPFVPgmxeRQ9F1C8A3gf1iI3Mj8eXW8hOsgfxStqIawGveduCvB9Xjmstugk2jnc3
         cW8BZNoesJ11K2bO9lpyMCgFM9TESn/TQjqW6dn6aUeK8f8CQ2//OFDs/UKkmUeFJEjC
         CS23gBs+A0Z31GgddMxRu+IVYlFFnDVheu1Hn7wimbIwu9u0cecG1DSCeNcFtv74UkAF
         6pArJ59n3VIGbBvNvXb9y+WrOEfrBkdKdFHHQfxhO5ZTq7Vcfs547MQcntrsJi+prjfd
         P6zrTQ4dWc5SR21X/AzCpw1Z8d4dz+LXawNcxk3SgOYYW3mEfoMyLLpFyB+l8mHmVm0/
         0Q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198510; x=1701803310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzd1kLFDSKSrvJElIbHY8ojcKXX1VK/68PrAguZ/47Q=;
        b=OmSPAqv/Gf7PMZ7BBw9n0PIBYZWUiOkOCnnF/dlAgdSeEhK86mtfWpW4MHet7FK1m8
         QyNqy1YcAzNL+oglliVyR77IRwwEWo3bqAPlR4nKGXV7DO520v0joC6BPFHMgJdQtXHz
         ta6JB+5Q6duORTVKkuT4Ko0BdYS1RhkH8/Ftyvo/Z3UCc/S7uDa3dttem18PkBm0waRS
         QpNzftQHYBMjJSnUsXiqUqTlDnzroKtGFPDadtPHKBlJm7bweKAA7sd1KY7bI4Gv47lF
         dyyo2MBgSQ4VaA8Rn80jZveaMdUSS/yk8sqmYnsKOTAiapnr+JgkC5KI+Oogx5qVLd1M
         0Now==
X-Gm-Message-State: AOJu0YwOrebp+wW+VLBSou0z1xno5tjRZNPtJNRW5MD6jT+Rx1xeMYla
	O8XOVl+y5BiPvYOdsKgDGu5c4opB+V5RhgmfEd0=
X-Google-Smtp-Source: AGHT+IF0xib+eSb9iU/oCk7Xd5fOlUnniG7XOjyVve5Ow4JAVgtNfTnCNU7+HaSyhk3ocN/DRU9y5Q==
X-Received: by 2002:a05:6214:4a8f:b0:67a:2bf7:5275 with SMTP id pi15-20020a0562144a8f00b0067a2bf75275mr17590562qvb.46.1701198510521;
        Tue, 28 Nov 2023 11:08:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dp11-20020a05621409cb00b0067a4b72b6besm1654490qvb.105.2023.11.28.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:30 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/24] pack-objects: parameterize pack-reuse routines over a
 single pack
Message-ID: <dca1083d8ec20cc6b224abf87959af933cca59ca.1701198172.git.me@ttaylorr.com>
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
index 89de23f39a..7682bd65bb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1014,7 +1014,8 @@ static off_t find_reused_offset(off_t where)
 	return reused_chunks[lo-1].difference;
 }
 
-static void write_reused_pack_one(size_t pos, struct hashfile *out,
+static void write_reused_pack_one(struct packed_git *reuse_packfile,
+				  size_t pos, struct hashfile *out,
 				  struct pack_window **w_curs)
 {
 	off_t offset, next, cur;
@@ -1092,7 +1093,8 @@ static void write_reused_pack_one(size_t pos, struct hashfile *out,
 	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
 }
 
-static size_t write_reused_pack_verbatim(struct hashfile *out,
+static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
+					 struct hashfile *out,
 					 struct pack_window **w_curs)
 {
 	size_t pos = 0;
@@ -1119,14 +1121,15 @@ static size_t write_reused_pack_verbatim(struct hashfile *out,
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
@@ -1142,7 +1145,8 @@ static void write_reused_pack(struct hashfile *f)
 			 * bitmaps. See comment in try_partial_reuse()
 			 * for why.
 			 */
-			write_reused_pack_one(pos + offset, f, &w_curs);
+			write_reused_pack_one(reuse_packfile, pos + offset, f,
+					      &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
@@ -1200,7 +1204,7 @@ static void write_pack_file(void)
 
 		if (reuse_packfile) {
 			assert(pack_to_stdout);
-			write_reused_pack(f);
+			write_reused_pack(reuse_packfile, f);
 			offset = hashfile_total(f);
 		}
 
-- 
2.43.0.24.g980b318f98

