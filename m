Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF72C696
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iKBW55nu"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f055438492so30902fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592653; x=1703197453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwZrOkhPjBG+WXIE3BSRWg+0jUXkdoVE/GCNZunL+Ao=;
        b=iKBW55nueRrlOKzdpuczCs5EjU1IgT9ibzCd+hkjdcDiV/4xnUpmC0djPI3fX57xHh
         lRZQ934LZjh71v4GuE7jh6e3nNFtjmwlwmLF1h2edTPsEVaqhyfZxh0JDApjljt0NMHv
         Cffpk6Ir4uuMxiyodSa+/FB8DfZIEUNmD71kW/Xu+VywB69OorIef9jnjChVl0TDfpoW
         ERGFulzqCXKaMtsliNSwdqfsOKDuTbnkwvdpPRkIRnqkvMbzRr9lv7TMndfCOYsVQ9qP
         DI3IW6gVYDnJioHyvBFxpqtguvVgSamczaZFR+jRza5LRfb7i6Suc1KZxAVz1LGSTX7N
         qTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592653; x=1703197453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwZrOkhPjBG+WXIE3BSRWg+0jUXkdoVE/GCNZunL+Ao=;
        b=eQErEHLXl/x3oQJh8dW7P1OsKh8wlZygO0HCJSI8OCbadnk9cnEIniej5im83jIHRU
         CvLLbPTAn1f0HAv580AKnCeor+1HrKLjVMdfaxQqa+c2j4w6Q14kK3qmqsV5ekFUyqpV
         m3PG127SfyqB4fIce2XN37jGRrnuZhT17yXh8+ahRlbRnFUY5fvXYHivmnw7BaqHuy4q
         ki7Ajt0Ecw/72JkBz7uHTxe79sF7QRC5JvgmIK92Q8qPgpzdEn6++xl71DLjYpZ++OrJ
         4P8dGLwj43AyTyJ9t1nrApgektkTKJfU8g0yDTmtWNZLV2WsrXkpXsLoNF+4kNRjDv/L
         /lXw==
X-Gm-Message-State: AOJu0YwMvOL0ZP33ZEMg5oWpc5orgv6xGNr0QnBFO6rT92q+IAO9VOUF
	qTBg/O+ej4KMJxXlLgDONxAGBQgJx+EapFWwV3mLpA==
X-Google-Smtp-Source: AGHT+IEdyCR7JZMl1zY9/OpBk04tul+0I1P5ebKE2fh75HhvE6RWcQs08teGqoE11wPSSVVj1ZACNg==
X-Received: by 2002:a05:6870:d91b:b0:1fa:f6e2:6fc7 with SMTP id gq27-20020a056870d91b00b001faf6e26fc7mr13328963oab.29.1702592653372;
        Thu, 14 Dec 2023 14:24:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pp23-20020a0568709d1700b001fa3c734bc5sm4733200oab.46.2023.12.14.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:13 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:12 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/26] pack-objects: pass `bitmapped_pack`'s to pack-reuse
 functions
Message-ID: <5492d11f25ec54c8eff59e3fa266abd766a1f40c.1702592604.git.me@ttaylorr.com>
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
index f51b86d99f..07c849b5d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -221,7 +221,8 @@ static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
 
-static struct packed_git *reuse_packfile;
+static struct bitmapped_pack *reuse_packfiles;
+static size_t reuse_packfiles_nr;
 static uint32_t reuse_packfile_objects;
 static struct bitmap *reuse_packfile_bitmap;
 
@@ -1094,7 +1095,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 	copy_pack_data(out, reuse_packfile, w_curs, offset, next - offset);
 }
 
-static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
+static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
 					 off_t pack_start UNUSED,
 					 struct pack_window **w_curs)
@@ -1109,13 +1110,13 @@ static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
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
@@ -1123,7 +1124,7 @@ static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
 	return pos;
 }
 
-static void write_reused_pack(struct packed_git *reuse_packfile,
+static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			      struct hashfile *f)
 {
 	size_t i = 0;
@@ -1149,8 +1150,8 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
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
@@ -1206,9 +1207,12 @@ static void write_pack_file(void)
 
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
 
@@ -3949,19 +3953,16 @@ static int pack_options_allow_reuse(void)
 
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
2.43.0.102.ga31d690331.dirty

