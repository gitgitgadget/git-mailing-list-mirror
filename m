Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0420C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiADSPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiADSPq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:46 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF1C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id fo11so35102975qvb.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGyKq6LLyxjkfV7RG7MCJYo/FORq6V0w0bGAQBSmZXA=;
        b=ganIP8NJ2p7sQitQG9DSDn/t8Jtx48Ede7WuxcSE0pENdpZFcDWCG6XpDuiwJBWpiX
         jaE6F7CW0eWiWl3zvtjsDaitmrORq7vIQuSpQsoMD3G4jHduBjRb5B7QB/Rg7hz5rwkV
         HnaA/2o9be2YWEtZWzc7r5WWcrQ0n7BK51onTGadUCvxVTlUckS45Z9cUkYrVhBNHSwG
         V2WHYD1dRn6EeJq5QvQM7yDj3rkFripJbhoc2QrYsrDOVTp1jR1qMJGFNrTrSS8BqirS
         Y4whwxxe7QY2H8M9br9c3zNVfPg6HPe9592w6VI/q2HZjFlp6LM06sG8ZlEYN9Ob0VUo
         2K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGyKq6LLyxjkfV7RG7MCJYo/FORq6V0w0bGAQBSmZXA=;
        b=pGDVw73eG5SpR9cberMyx7fvHFhUZDz+bP8KGtzrCDCEDAQpCpgGnuC3GSafGJD7kG
         E/zLqKwhcJf/Pdx+q8MUuHXZttCAscUAenFK1PYloDtcllRXhuuJe31tl7RazoZzBaTm
         eJve9wjIjscPO0SHl+5XpE9U0QStfdvDlukPkn9xLSRRaMG+0wkfzsBY9dQjkAKhoif6
         bAhz/ay2kQYdKk18aoD48ngaLwyrubXpPJhoTPEug/pWR71VMKP7TLDQP/00bhQUT7t+
         cApVdDkfObOfam/CfwZHeURTwKQiTEE87bf6GCZ/NCqk9HTN+44B4bXCkJ8sOhMPwL5/
         V1gQ==
X-Gm-Message-State: AOAM532pXOPaz9vdPOJmHj/dudPNjrVJE11+AQZ14sSUB1BA2d6fV21m
        07+0IfHE3q8e7JwE+a3OkRCzihgCKzGeZsmS
X-Google-Smtp-Source: ABdhPJwGlWRFNygAY4ddYUg7bKdjcKO6/JHuGnuPeGvuk7wGcBsuS+XG2TrFenn7PeKYHtFRH+Lz6A==
X-Received: by 2002:a05:6214:2a88:: with SMTP id jr8mr47240013qvb.79.1641320144993;
        Tue, 04 Jan 2022 10:15:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q21sm30346521qkl.52.2022.01.04.10.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:44 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
Message-ID: <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
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

Instead, make the object order used during bitmap generation part of the
MIDX itself. That means that the new test in t5326 will cause the MIDX's
checksum to update, preventing the stale read problem.

In theory, it is possible to store a "fingerprint" of the full object
order here, so long as that fingerprint changes at least as often as the
full object order does. Some possibilities here include storing the
identity of the preferred pack, along with the mtimes of the
non-preferred packs in a consistent order. But storing a limited part of
the information makes it difficult to reason about whether or not there
are gaps between the two that would cause us to get bitten by this bug
again.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/multi-pack-index.txt |  1 +
 Documentation/technical/pack-format.txt      | 13 +++++-----
 midx.c                                       | 25 ++++++++++++++++----
 t/t5326-multi-pack-bitmaps.sh                |  2 +-
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index b39c69da8c..f2221d2b44 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -24,6 +24,7 @@ and their offsets into multiple packfiles. It contains:
 ** An offset within the jth packfile for the object.
 * If large offsets are required, we use another list of large
   offsets similar to version 2 pack-indexes.
+- An optional list of objects in pseudo-pack order (used with MIDX bitmaps).
 
 Thus, we can provide O(log N) lookup time for any number
 of packfiles.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8d2f42f29e..6d3efb7d16 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -376,6 +376,11 @@ CHUNK DATA:
 	[Optional] Object Large Offsets (ID: {'L', 'O', 'F', 'F'})
 	    8-byte offsets into large packfiles.
 
+	[Optional] Bitmap pack order (ID: {'R', 'I', 'D', 'X'})
+	    A list of MIDX positions (one per object in the MIDX, num_objects in
+	    total, each a 4-byte unsigned integer in network byte order), sorted
+	    according to their relative bitmap/pseudo-pack positions.
+
 TRAILER:
 
 	Index checksum of the above contents.
@@ -456,9 +461,5 @@ In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
 objects in packs stored by the MIDX, laid out in pack order, and the
 packs arranged in MIDX order (with the preferred pack coming first).
 
-Finally, note that the MIDX's reverse index is not stored as a chunk in
-the multi-pack-index itself. This is done because the reverse index
-includes the checksum of the pack or MIDX to which it belongs, which
-makes it impossible to write in the MIDX. To avoid races when rewriting
-the MIDX, a MIDX reverse index includes the MIDX's checksum in its
-filename (e.g., `multi-pack-index-xyz.rev`).
+The MIDX's reverse index is stored in the optional 'RIDX' chunk within
+the MIDX itself.
diff --git a/midx.c b/midx.c
index 837b46b2af..d3179e9c02 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,7 @@
 #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
 #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
+#define MIDX_CHUNKID_REVINDEX 0x52494458 /* "RIDX" */
 #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
 #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
@@ -833,6 +834,18 @@ static int write_midx_large_offsets(struct hashfile *f,
 	return 0;
 }
 
+static int write_midx_revindex(struct hashfile *f,
+			       void *data)
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
+		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
+			  ctx.entries_nr * sizeof(uint32_t),
+			  write_midx_revindex);
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

