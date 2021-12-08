Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5418C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhLHTaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLHT37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:29:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E26C061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:26:26 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w4so3141465ilv.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XOnajtP03zFrDIOV4PcnFQxX0dfu9DiDpeT9FS8xfFE=;
        b=Xbt5mXjOPEcBSAEtB7r1tlSB+b5z4v/tbWDvaaqSJAxtgDsHB1Y49O+Wnx2X0Z+y/t
         UEGaqjD18myVGwmhGa5ImuAkhslqMSjHzsipdWGeYyZRtbQhVu0cTRxNK5B5DmKPJlcx
         PjhTiaNzptJHC+45Lr4FQrAWYxLHZ3DL7ayeCEMv+7EsYbdD632h2SThqVbrjkFGCXdO
         /Uye1Rik9K0w8wrNcbCfDh9VMbA9rar9T6AuwF90LLSr8vfBJujEaN7BybUpJ3Vmtixm
         eHeBiKrcqQecWuTFpssnhPpCixNZ7VL7blYqiOYxNnWsa7dqOsG7Ka3cxPMIIqeuP3G/
         i0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOnajtP03zFrDIOV4PcnFQxX0dfu9DiDpeT9FS8xfFE=;
        b=CGlJo2WDuEyjAkMWQ3Jaiya9PDw66tdIahZs8l0WM6ffV+JyVw26sUeS5JoqXPq3FE
         biI3E2f9QmG2MGGeTmSuMCKzr3PeJ7vjMFoE4usAyNhIn3iR4dpKl09Bvyqr5uQLV1vm
         aJJs3WDz5s3/GI4QVx0+NyMsaWSGJgvB77V2OEoGleLRbmGN1UyfDIzoM+gT7f1Siib1
         R/ha5U6j7sSPuRTWpgwJBRPpsb+2ea/8hWbTgLWly+Q9K1OR6596H1ftxrWaAQ5+yvOv
         1qn8FLlr93EJlI3MKEM8zSnfY5hpihkD/aAOJr9+ypZfOVhKrzwMleLonB0ocnE9E1LD
         Vdag==
X-Gm-Message-State: AOAM530J9XSP/4eJ3tNXAzK1haiPSkOCIbLhgv9WkPl9Nqno5zFdbP1F
        WeQ20MFKMJEDu4oo9oWSWjnmea/0CFuUfmnW
X-Google-Smtp-Source: ABdhPJxz/RPyRmdcDfu1sypOV5epJcNIoKdJzg6OEOzSMIneWuQ+NAIcZyCLS0YbJHvUZTod5tJ3OA==
X-Received: by 2002:a05:6e02:1583:: with SMTP id m3mr9321253ilu.294.1638991586010;
        Wed, 08 Dec 2021 11:26:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d17sm2212894ilc.79.2021.12.08.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:26:25 -0800 (PST)
Date:   Wed, 8 Dec 2021 14:26:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH 2/2] midx.c: make changing the preferred pack safe
Message-ID: <fa42d816f453dfce5e1e7dedb9790213ce1379cb.1638991570.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch demonstrates a bug where a MIDX's auxiliary object
order can become out of sync with a MIDX bitmap.

This is because of two confounding factors:

  - First, the object order is stored in a file which is named according
    to the multi-pack index's checksum, and the MIDX does not store the
    object order. This means that the object order can change without
    altering the checksum.

  - But the .rev file is moved into place with finalize_object_file(),
    which link(2)'s the file into place instead of renaming it. For us,
    that means that a modified .rev file will not be moved into place if
    MIDX's checksum was unchanged.

The fix here is two-fold. First, we need to stop linking the file into
place and instead rename it. It's likely we were using
finalize_object_file() instead of a pure rename() because the former
also adjusts shared permissions. But that is unnecessary, because we
already do so in write_rev_file_order(), so rename alone is safe.

But we also need to make the MIDX's checksum change in some way when the
preferred pack changes without altering the set of packs stored in a
MIDX to prevent a race where the new .rev file is moved into place
before the MIDX is updated. Here, you'd get the opposite effect: reading
old bitmaps with the new object order.

But this race bites us even here: suppose that we didn't change the MIDX
checksum, but only renamed the auxiliary object order into place instead
of hardlinking it. Then when we go to generate the new bitmap, we'll
load the old MIDX bitmap, along with the MIDX that it references. That's
fine, since the new MIDX isn't moved into place until after the new
bitmap is generated. But the new object order *has* been moved into
place. So we'll read the old bitmaps in the new order when generating
the new bitmap file, meaning that without this secondary change, bitmap
generation itself would become a victim of the race described here.

This can all be prevented by forcing the MIDX's checksum to change when
the object order changes. We could include the entire object order in
the MIDX, but doing so is somewhat awkward. (For example, the code that
writes a .rev file expects to know the checksum of the associated pack
or MIDX, but writing that data into the MIDX itself makes that a
circular dependency).

Instead, make the pack order used during bitmap generation part of the
MIDX itself. That means that the new test in t5326 will cause the MIDX's
checksum to update, preventing the stale read problem.

There is no need to store the complete pack order here, since the only
way a fixed set of packs can result in a change in the object ordering
is by changing the preferred pack. That's because packs are sorted
according to their pack name only, so it would be impossible to induce a
different order by, say, touching a pack's mtime.

But storing the complete pack order gives us some flexibility in the
future, and it only costs 4 bytes per pack to do. In the future, we
could also optimize .rev reads looking for the identity of the preferred
pack by consulting this list if it exists.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.txt |  1 +
 Documentation/technical/pack-format.txt      |  4 ++++
 midx.c                                       | 25 ++++++++++++++++----
 t/t5326-multi-pack-bitmaps.sh                |  2 +-
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index 86f40f2490..077c893ae3 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -24,6 +24,7 @@ and their offsets into multiple packfiles. It contains:
   - An offset within the jth packfile for the object.
 - If large offsets are required, we use another list of large
   offsets similar to version 2 pack-indexes.
+- An optional list of pack IDs in bitmap-sorted order.
 
 Thus, we can provide O(log N) lookup time for any number
 of packfiles.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8d2f42f29e..edd77fb437 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -376,6 +376,10 @@ CHUNK DATA:
 	[Optional] Object Large Offsets (ID: {'L', 'O', 'F', 'F'})
 	    8-byte offsets into large packfiles.
 
+	[Optional] Bitmap pack order (ID: {'P', 'O', 'R', 'D'})
+	    A list of 4-byte pack identifiers in sorted order according to
+	    their relative bitmap positions.
+
 TRAILER:
 
 	Index checksum of the above contents.
diff --git a/midx.c b/midx.c
index 837b46b2af..abcdb92dd1 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,7 @@
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
 #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
+#define MIDX_CHUNKID_PACKORDER 0x504f5244 /* "PORD" */
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
@@ -833,6 +834,18 @@ static int write_midx_large_offsets(struct hashfile *f,
 	return 0;
 }
 
+static int write_midx_pack_order(struct hashfile *f,
+				 void *data)
+{
+	struct write_midx_context *ctx = data;
+	uint32_t i;
+
+	for (i = 0; i < ctx->entries_nr; i++)
+		hashwrite_be32(f, ctx->pack_order[i]);
+
+	return 0;
+}
+
 struct midx_pack_order_data {
 	uint32_t nr;
 	uint32_t pack;
@@ -891,7 +904,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
 					midx_hash, WRITE_REV);
 
-	if (finalize_object_file(tmp_file, buf.buf))
+	if (rename(tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
 
 	strbuf_release(&buf);
@@ -1403,15 +1416,19 @@ static int write_midx_internal(const char *object_dir,
 			(size_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
 			write_midx_large_offsets);
 
+	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
+		ctx.pack_order = midx_pack_order(&ctx);
+		add_chunk(cf, MIDX_CHUNKID_PACKORDER,
+			  ctx.entries_nr * sizeof(uint32_t),
+			  write_midx_pack_order);
+	}
+
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
-		ctx.pack_order = midx_pack_order(&ctx);
-
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
 	if (flags & MIDX_WRITE_BITMAP) {
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 0ca2868b0b..353282310d 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -395,7 +395,7 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
 	)
 '
 
-test_expect_failure 'changing the preferred pack does not corrupt bitmaps' '
+test_expect_success 'changing the preferred pack does not corrupt bitmaps' '
 	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
2.34.1.25.gb3157a20e6
