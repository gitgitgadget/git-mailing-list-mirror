Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZijxkSRC"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3592
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:28 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-42033328ad0so32729931cf.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198508; x=1701803308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ilkXkGh4UQ+/aeFm6DMB3/MRHBoihpCdwNtE5FkgYiA=;
        b=ZijxkSRCa+MVoufQw8pX1zEPDmbJQHMIc7ryEPNYdxRW7uE1elAtPSEoO6TO2fdL3C
         YYQJaFPp7+XmVgUuPBLsbh8kUw7SKdejWYyghinEmlcDe0ULhtA4MtIqR+jEN2WlinHT
         rQR4rmtfQIe+M14yTYYVAo/CiHl6BtQ7g8BeE9AjKV0icbDZr85XZipLoE5eQ/zLcrOA
         qq6Tj17eJ8pSn1YjOQTW9YbR6/34H1KTm3kmb+xrriLIfhgDr5sWZExCw/RkRJt6cLvF
         qUjuUgvkfcuJD0BY8W1g6soQTICypHyEZWBA0EEUACro/YqszjDcPamlITZYdOO88J3I
         N9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198508; x=1701803308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilkXkGh4UQ+/aeFm6DMB3/MRHBoihpCdwNtE5FkgYiA=;
        b=NE6fw6dyDPggY6zRVv/CLXMPR1R+e6gvEFLNFbp2pOh9xG4RA2kXKRZN8OuEXchcRO
         A2WDrinb8GgvJnY1lZyT05ru36H1G3qYt2iNoWzaDYU2eYk5EEMYEBZRob7Tij8eiIbq
         J8mIgR8OBEpYuW7yZTy1eZA/NEIf3Y+rIB+jDhoY1cttvRkVdLsxjbc5OYIEHDB/bKVc
         uiKtoRrlhiOiq0r0OKjJEKELKihgdDog4qBh1EGriVNQ/MEan+q4doOrpdwqEOZLMdXV
         OKPH1feufGbFuwnt/4JIwDeSofdllGO41B1/QRuWg0hWBcBhLXen0hy7GnEec6dMv0fd
         ZJSA==
X-Gm-Message-State: AOJu0Yyjk4yTKABNoGhCZrL0SktZgZkI8Uv8btj2J9q8n2UrpT0WiPJ4
	IpRGO0nraH+IQS8T30RRVmH/mecsovGXWMryuEw=
X-Google-Smtp-Source: AGHT+IEGpHLFMvQAcGb5Zz6cRwfBxzkgLcTjbWXuREtroKUjuMbHF8V8wVZ0zR6J4StKXf6JL7HAoA==
X-Received: by 2002:a05:622a:7188:b0:423:a3c9:8e70 with SMTP id jd8-20020a05622a718800b00423a3c98e70mr15553662qtb.17.1701198507813;
        Tue, 28 Nov 2023 11:08:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w26-20020ac86b1a000000b0041e383d527esm4754403qts.66.2023.11.28.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:27 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/24] pack-bitmap: return multiple packs via
 `reuse_partial_packfile_from_bitmap()`
Message-ID: <36b794d9e1eaa413b3b87eb7e5a0d82098d05dca.1701198172.git.me@ttaylorr.com>
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

Further prepare for enabling verbatim pack-reuse over multiple packfiles
by changing the signature of reuse_partial_packfile_from_bitmap() to
populate an array of `struct bitmapped_pack *`'s instead of a pointer to
a single packfile.

Since the array we're filling out is sized dynamically[^1], add an
additional `size_t *` parameter which will hold the number of reusable
packs (equal to the number of elements in the array).

Note that since we still have not implemented true multi-pack reuse,
these changes aren't propagated out to the rest of the caller in
builtin/pack-objects.c.

In the interim state, we expect that the array has a single element, and
we use that element to fill out the static `reuse_packfile` variable
(which is a bog-standard `struct packed_git *`). Future commits will
continue to push this change further out through the pack-objects code.

[^1]: That is, even though we know the number of packs which are
  candidates for pack-reuse, we do not know how many of those
  candidates we can actually reuse.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 9 +++++++--
 pack-bitmap.c          | 6 ++++--
 pack-bitmap.h          | 5 +++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2bb1b64e8f..89de23f39a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3943,14 +3943,19 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
+	struct bitmapped_pack *packs = NULL;
+	size_t packs_nr = 0;
+
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse())
-		reuse_partial_packfile_from_bitmap(bitmap_git, &reuse_packfile,
+		reuse_partial_packfile_from_bitmap(bitmap_git, &packs,
+						   &packs_nr,
 						   &reuse_packfile_bitmap);
 
-	if (reuse_packfile) {
+	if (packs) {
+		reuse_packfile = packs[0].p;
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
 		if (!reuse_packfile_objects)
 			BUG("expected non-empty reuse bitmap");
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 614fc09a4e..670deec909 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1989,7 +1989,8 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 }
 
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
-					struct packed_git **packfile_out,
+					struct bitmapped_pack **packs_out,
+					size_t *packs_nr_out,
 					struct bitmap **reuse_out)
 {
 	struct repository *r = the_repository;
@@ -2056,7 +2057,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = packs[0].p;
+	*packs_out = packs;
+	*packs_nr_out = packs_nr;
 	*reuse_out = reuse;
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 5bc1ca5b65..901a3b86ed 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -78,8 +78,9 @@ int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
-void reuse_partial_packfile_from_bitmap(struct bitmap_index *,
-					struct packed_git **packfile,
+void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+					struct bitmapped_pack **packs_out,
+					size_t *packs_nr_out,
 					struct bitmap **reuse_out);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
-- 
2.43.0.24.g980b318f98

