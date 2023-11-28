Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qRnv5MC9"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459410EC
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:36 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41e3e77e675so32689671cf.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198515; x=1701803315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seMXIWlc+7KjgA00SKA47VNvcWo21GjGL3BPgYiPQ4M=;
        b=qRnv5MC9e85F/ZOGfzsNQUOZnUUJ/xIlQu8k38FfOy6GVnKt2NFV5DuTZLCOZtfjva
         IeIt6BIJu7kXQeJqOmfciSXbW5nvcgzTGboJLKftNhXV1cLXZRp9rV4Ccf/IKPJq6OKU
         EN+B+5+N62posSJvSbXOQE1SdRObmwKBFu05P3I9BRdtukXjae38RPlsXuN55lwliDHo
         Wxz71BcgSd5TOcyZVvv4PrQ10EFafaPZ07w315XJ+4Q7y5MlzjcYcMcQV+A4Z3ZI61so
         63JP4CS6TuRjD8eaqr0oDaiKyzvXTwRABGn/hoCFBIxN7qvm2FKhB8XMxTxgp2RnMK11
         2mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198515; x=1701803315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seMXIWlc+7KjgA00SKA47VNvcWo21GjGL3BPgYiPQ4M=;
        b=Xx6iBSH+n9zcjcRDJ4V0hbCE27KiFnNPhnO6I2vzqkV7WCIXeLlZzNlh+kVT9BAQfB
         iWJVODDlhXaFS0oYLjOGTboRTi6ADkR+m8+ZH2Ez672dAlcfCu19spIDNISSMGoZjSo/
         9ZULUyouLjzkiTym2zKCCSMr4iA47wktPK9HobuHp23n8Qey8l7LsjcyH9znv3RBKcmC
         3g01FsKnc2gJTItGAjFnH+qFF6NNM76aR/lPUlGy4t+tHTA9wGEu58CHLZmSrZC1Amp9
         +0BkKo/GoJfIa5eqS0hDXjDERwAMeKZBy1YDlzK7tyo/ekejLf5ZYjEy20FyIV70Ydtr
         fvPw==
X-Gm-Message-State: AOJu0YwuNRbSClK9iH7W52xxSdNVgIhFSjRvq4s5tLf3GInvul34WXfB
	bBzoZTHHO65EkySH1Rt+BoQDvi4eeGwQF3qMo2o=
X-Google-Smtp-Source: AGHT+IG1hy++/iv6rdBh06N0m7Odxno/5+8ErlwuyZi0LT5o8uBcA16MR4rKKpKNFcrexeFxoxbxeg==
X-Received: by 2002:a05:622a:578c:b0:423:a391:68ae with SMTP id eh12-20020a05622a578c00b00423a39168aemr11311387qtb.26.1701198515681;
        Tue, 28 Nov 2023 11:08:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cq9-20020a05622a424900b00423dbb19262sm660286qtb.78.2023.11.28.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:35 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/24] pack-objects: pass `bitmapped_pack`'s to pack-reuse
 functions
Message-ID: <2bb01e2370fd01d8468e69da474c24266ba851fb.1701198172.git.me@ttaylorr.com>
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

Further prepare pack-objects to perform verbatim pack-reuse over
multiple packfiles by converting functions that take in a pointer to a
`struct packed_git` to instead take in a pointer to a `struct
bitmapped_pack`.

The additional information found in the bitmapped_pack struct (such as
the bit position corresponding to the beginning of the pack) will be
necessary in order to perform verbatim pack-reuse.

Note that we don't use any of the extra pieces of information contained
in the bitmapped_pack struct, so this step is merely preparatory and
does not introduce any functional changes.

Note further that we do not change the argument type to
write_reused_pack_one(). That function is responsible for copying
sections of the packfile directly and optionally patching any OFS_DELTAs
to account for not reusing sections of the packfile in between a delta
and its base.

As such, that function is (and should remain) oblivious to multi-pack
reuse, and does not require any of the extra pieces of information
stored in the bitmapped_pack struct.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index eb8be514d1..3b7704d062 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -222,7 +222,8 @@ static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
 
-static struct packed_git *reuse_packfile;
+static struct bitmapped_pack *reuse_packfiles;
+static size_t reuse_packfiles_nr;
 static uint32_t reuse_packfile_objects;
 static struct bitmap *reuse_packfile_bitmap;
 
@@ -1095,7 +1096,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
 }
 
-static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
+static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
 					 off_t pack_start UNUSED,
 					 struct pack_window **w_curs)
@@ -1110,13 +1111,13 @@ static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
 		off_t to_write;
 
 		written = (pos * BITS_IN_EWORD);
-		to_write = pack_pos_to_offset(reuse_packfile, written)
+		to_write = pack_pos_to_offset(reuse_packfile->p, written)
 			- sizeof(struct pack_header);
 
 		/* We're recording one chunk, not one object. */
 		record_reused_object(sizeof(struct pack_header), 0);
 		hashflush(out);
-		copy_pack_data(out, reuse_packfile, w_curs,
+		copy_pack_data(out, reuse_packfile->p, w_curs,
 			sizeof(struct pack_header), to_write);
 
 		display_progress(progress_state, written);
@@ -1124,7 +1125,7 @@ static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
 	return pos;
 }
 
-static void write_reused_pack(struct packed_git *reuse_packfile,
+static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			      struct hashfile *f)
 {
 	size_t i = 0;
@@ -1150,8 +1151,8 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
 			 * bitmaps. See comment in try_partial_reuse()
 			 * for why.
 			 */
-			write_reused_pack_one(reuse_packfile, pos + offset, f,
-					      pack_start, &w_curs);
+			write_reused_pack_one(reuse_packfile->p, pos + offset,
+					      f, pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
@@ -1207,9 +1208,12 @@ static void write_pack_file(void)
 
 		offset = write_pack_header(f, nr_remaining);
 
-		if (reuse_packfile) {
+		if (reuse_packfiles_nr) {
 			assert(pack_to_stdout);
-			write_reused_pack(reuse_packfile, f);
+			for (j = 0; j < reuse_packfiles_nr; j++) {
+				reused_chunks_nr = 0;
+				write_reused_pack(&reuse_packfiles[j], f);
+			}
 			offset = hashfile_total(f);
 		}
 
@@ -3952,19 +3956,16 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	struct bitmapped_pack *packs = NULL;
-	size_t packs_nr = 0;
-
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse())
-		reuse_partial_packfile_from_bitmap(bitmap_git, &packs,
-						   &packs_nr,
+		reuse_partial_packfile_from_bitmap(bitmap_git,
+						   &reuse_packfiles,
+						   &reuse_packfiles_nr,
 						   &reuse_packfile_bitmap);
 
-	if (packs) {
-		reuse_packfile = packs[0].p;
+	if (reuse_packfiles) {
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
 		if (!reuse_packfile_objects)
 			BUG("expected non-empty reuse bitmap");
-- 
2.43.0.24.g980b318f98

