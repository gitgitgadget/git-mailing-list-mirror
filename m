Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E2C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiAYWlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiAYWlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:05 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CCC061749
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:05 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d188so11198320iof.7
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQwt+se2h/kogC4b6Pq+1NDXPoNCM3W9dAuF1cBNwUk=;
        b=C+tkHj/SI6gVzegCuhVjr/QkhuwKALI5FK3YEa4Dex2AN9kw64uUIZBcVKjfyIzaLN
         MpgTYPVMp2MO8hiBVIRsezGcA0z1qrevvyoLWYWF4zKW5ZEErx2GXvvtAf3jo9dV0xo4
         SnXVYyePCEA/C5HIb6g676UZFyUjr1A8rRILFbPpI65lSxfZaWBAppJTJo8PJCjDLQx2
         S7sv8FJ7+5s0ttt1LhvHKgJ1ScgCOaMDLisHj0xe8i38CiZuPZ372O1wF57pX61ypADK
         ZoA32qgfKsd4JKYstqPuc1z/xdV+Z0yA4BZH5C0gkkCdP6X+zlTF+VQXYYmwDRRZbiCT
         5RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQwt+se2h/kogC4b6Pq+1NDXPoNCM3W9dAuF1cBNwUk=;
        b=xX3e05ksa15VGC6cqRSEL96NlqAsvnDbBwE53D98HRu1ALTBAyF2DN4yLEEDW8nlec
         rncKrFSj6vtiYLQHf8ASeKs1IZlCbJw+Syx9Jbl+5zhiqXIHCFKX/ruqei+vPahopWMu
         eiap+QgbutSLl8qFRN7qZrBc8TykD7kU7VFd8eoSLcjVQ9WqA+jwLu80lrClMrtzC32T
         Mo+T/mr74tSbmyyitwrvhm8B3LvkGAkvkPAOig86ELEDEvGfjCN3BVaOpfBEFcrkJLSw
         TOGQX8QKvvl18HpsDY4vQsTyfaoRHRSYKlD0jBiijeWE8s4Iy8Q93hGerys2d7CMA4Hm
         5t6Q==
X-Gm-Message-State: AOAM5312fjVuGv+xNj+7zllNyv9jbbSLeDNOMr/UakRdn5/uah44th0n
        m2Cb5XtPIBbifpnX3B70utJm7rHWpf51jA==
X-Google-Smtp-Source: ABdhPJw8cd9M3WhIsmXaeMAhiBfueZGt9eUVk/QyPCLs5yT9XP7jqLHTBO6wOeTnDjAst2jWPxDECw==
X-Received: by 2002:a05:6638:11c8:: with SMTP id g8mr6976381jas.315.1643150464315;
        Tue, 25 Jan 2022 14:41:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9sm10201628ilu.43.2022.01.25.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:04 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 2/9] midx.c: make changing the preferred pack safe
Message-ID: <62d756148204bef46156c7ac7315bdfd5226949b.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
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

This fix is to force the MIDX's checksum to change when the preferred
pack changes but the set of packs contained in the MIDX does not. In
other words, when the object order changes, the MIDX's checksum needs to
change with it (regardless of whether the MIDX is tracking the same or
different packs).

This prevents a race whereby changing the object order (but not the
packs themselves) enables a reader to see the new .rev file with the old
MIDX, or similarly seeing the new bitmap with the old object order.

But why can't we just stop hardlinking the .rev into place instead
adding additional data to the MIDX? Suppose that's what we did. Then
when we go to generate the new bitmap, we'll load the old MIDX bitmap,
along with the MIDX that it references. That's fine, since the new MIDX
isn't moved into place until after the new bitmap is generated. But the
new object order *has* been moved into place. So we'll read the old
bitmaps in the new order when generating the new bitmap file, meaning
that without this secondary change, bitmap generation itself would
become a victim of the race described here.

This can all be prevented by forcing the MIDX's checksum to change when
the object order does. By embedding the entire object order into the
MIDX, we do just that. That is, the MIDX's checksum will change in
response to any perturbation of the underlying object order. In t5326,
this will cause the MIDX's checksum to update (even without changing the
set of packs in the MIDX), preventing the stale read problem.

Note that this makes it safe to continue to link(2) the MIDX .rev file
into place, since it is now impossible to have a .rev file that is
out-of-sync with the MIDX whose checksum it references. (But we will do
away with MIDX .rev files later in this series anyway, so this is
somewhat of a moot point).

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
 Documentation/technical/pack-format.txt      | 13 ++++++-----
 midx.c                                       | 23 +++++++++++++++++---
 t/t5326-multi-pack-bitmaps.sh                |  2 +-
 4 files changed, 29 insertions(+), 10 deletions(-)

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
index 837b46b2af..0248c4577c 100644
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
2.34.1.455.gd6eb6fd089

