Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539AC433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiAYWlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiAYWlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:00 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895CC06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:00 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id u5so18117006ilq.9
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyUA48L6zM4lj6LMFqxcyQgaKEHX7vlZ+Sfl+H2rCLY=;
        b=hJwtVC+AFFffCCcaItNezyL524RzMlwchgvNKnS/FWrjrtBVKP3jnpRw/+XSO1n5v9
         +3RAATOEuOhFO0VE54V1uwxlSwgsTnxNIdLgal3iAlVHjn+sYdgpVDqjLqvk6W2qO570
         D3jBHZpwrsNB3YmqC2jwrEyZd1IfDcZGNMk1MiNnDLLSRGpfBHmGenyJ7j+Nq378TFXd
         WSsHbDpzOuDwm1ohjbbxWe3nrT7xDeBLozlJQxBAQ51FtzDRvPhJjZ45uAysBEkLW9LD
         doZeBSChX6nj89mOdQYLRS8diKcKtmB4E8nRJDVtCN2TBJRLErjjRKdLMTq7wcx+VGB6
         kItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vyUA48L6zM4lj6LMFqxcyQgaKEHX7vlZ+Sfl+H2rCLY=;
        b=eS4EIQk+zTjJ1CX7SQYIoJEHTHLnhD8OOvx+TvBTjqnHgcD3TrLBGBnOLyFKml3INS
         02fn8dVbegdeRxOJneZ9M2YKyUkX4cScwDAOpnGkrf6qApGX//ZZokjdUaYqrYBj9r3M
         Q9O8f8vuOkVAzW4VLFgL4TU4rcM/OJe3HmofMec/HkdzpT07XTA41cPIE1pm1lQ5B5Q5
         zHoUwpRQMH3a0fN2Q48WdIj/ljVmLDKqN6HGEUntqnZcHuKiwxs6XohvWCw0NKT1I7ee
         defRP8Cg7vul580CiT40EqPWkYM3bp27mzb3RgnCOR8Hqbxsd3FUT3/liZdYJM4JXnLy
         xUpg==
X-Gm-Message-State: AOAM533T0gXWR3BOywcsC7Bgqe51yJFIOUhpM1eyjSeRaVMMDdsxeqf0
        h28owROfVPHqSZMlJzF/ZcAO78sAyb4XCg==
X-Google-Smtp-Source: ABdhPJx2y9pacwHAqHFiEqSNi2VkFurG/Md3DoM5ud2+NUqmoDO0IFXrooJyF8Qr1ZNWibekJ0c7yw==
X-Received: by 2002:a05:6e02:144d:: with SMTP id p13mr13301633ilo.66.1643150458977;
        Tue, 25 Jan 2022 14:40:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w19sm9248578iov.16.2022.01.25.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:40:58 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:40:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <cover.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a(n even) small(er) reroll of my series which fixes a serious problem
with MIDX bitmaps by which they can become corrupt when permuting their pack
order.

The only change is to revert back to using finalize_object_file(), since it
behaves consistently with other parts of the code that touch $GIT_DIR/objects.
This is safe to do given the other change described in that patch. The
description has been updated slightly to reflect.

A minor tweak to the tests is done towards the end of the series. But otherwise
this is unchanged from v3.

It is prepared on the tip of master (which is 89bece5c8c at the time of
writing).

Taylor Blau (9):
  t5326: demonstrate bitmap corruption after permutation
  midx.c: make changing the preferred pack safe
  pack-revindex.c: instrument loading on-disk reverse index
  t5326: drop unnecessary setup
  t5326: extract `test_rev_exists`
  t5326: move tests to t/lib-bitmap.sh
  t/lib-bitmap.sh: parameterize tests over reverse index source
  midx: read `RIDX` chunk when present
  pack-bitmap.c: gracefully fallback after opening pack/MIDX

 Documentation/technical/multi-pack-index.txt |   1 +
 Documentation/technical/pack-format.txt      |  13 +-
 midx.c                                       |  29 ++-
 midx.h                                       |   1 +
 pack-bitmap.c                                |   4 +
 pack-revindex.c                              |  20 ++
 t/lib-bitmap.sh                              | 185 +++++++++++++++++++
 t/t5310-pack-bitmaps.sh                      |  28 +++
 t/t5326-multi-pack-bitmaps.sh                | 164 +++-------------
 t/t5327-multi-pack-bitmaps-rev.sh            |  23 +++
 t/t7700-repack.sh                            |   4 -
 11 files changed, 321 insertions(+), 151 deletions(-)
 create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh

Range-diff against v3:
 1:  babce7d29a =  1:  7ea9cced8e t5326: demonstrate bitmap corruption after permutation
 2:  7d20c13f8b !  2:  62d7561482 midx.c: make changing the preferred pack safe
    @@ Commit message
             that means that a modified .rev file will not be moved into place if
             MIDX's checksum was unchanged.
     
    -    The fix here is two-fold. First, we need to stop linking the file into
    -    place and instead rename it. It's likely we were using
    -    finalize_object_file() instead of a pure rename() because the former
    -    also adjusts shared permissions. But that is unnecessary, because we
    -    already do so in write_rev_file_order(), so rename alone is safe.
    +    This fix is to force the MIDX's checksum to change when the preferred
    +    pack changes but the set of packs contained in the MIDX does not. In
    +    other words, when the object order changes, the MIDX's checksum needs to
    +    change with it (regardless of whether the MIDX is tracking the same or
    +    different packs).
     
    -    But we also need to make the MIDX's checksum change in some way when the
    -    preferred pack changes without altering the set of packs stored in a
    -    MIDX to prevent a race where the new .rev file is moved into place
    -    before the MIDX is updated. Here, you'd get the opposite effect: reading
    -    old bitmaps with the new object order.
    +    This prevents a race whereby changing the object order (but not the
    +    packs themselves) enables a reader to see the new .rev file with the old
    +    MIDX, or similarly seeing the new bitmap with the old object order.
     
    -    But this race bites us even here: suppose that we didn't change the MIDX
    -    checksum, but only renamed the auxiliary object order into place instead
    -    of hardlinking it. Then when we go to generate the new bitmap, we'll
    -    load the old MIDX bitmap, along with the MIDX that it references. That's
    -    fine, since the new MIDX isn't moved into place until after the new
    -    bitmap is generated. But the new object order *has* been moved into
    -    place. So we'll read the old bitmaps in the new order when generating
    -    the new bitmap file, meaning that without this secondary change, bitmap
    -    generation itself would become a victim of the race described here.
    +    But why can't we just stop hardlinking the .rev into place instead
    +    adding additional data to the MIDX? Suppose that's what we did. Then
    +    when we go to generate the new bitmap, we'll load the old MIDX bitmap,
    +    along with the MIDX that it references. That's fine, since the new MIDX
    +    isn't moved into place until after the new bitmap is generated. But the
    +    new object order *has* been moved into place. So we'll read the old
    +    bitmaps in the new order when generating the new bitmap file, meaning
    +    that without this secondary change, bitmap generation itself would
    +    become a victim of the race described here.
     
         This can all be prevented by forcing the MIDX's checksum to change when
    -    the object order changes. We could include the entire object order in
    -    the MIDX, but doing so is somewhat awkward. (For example, the code that
    -    writes a .rev file expects to know the checksum of the associated pack
    -    or MIDX, but writing that data into the MIDX itself makes that a
    -    circular dependency).
    +    the object order does. By embedding the entire object order into the
    +    MIDX, we do just that. That is, the MIDX's checksum will change in
    +    response to any perturbation of the underlying object order. In t5326,
    +    this will cause the MIDX's checksum to update (even without changing the
    +    set of packs in the MIDX), preventing the stale read problem.
     
    -    Instead, make the object order used during bitmap generation part of the
    -    MIDX itself. That means that the new test in t5326 will cause the MIDX's
    -    checksum to update, preventing the stale read problem.
    +    Note that this makes it safe to continue to link(2) the MIDX .rev file
    +    into place, since it is now impossible to have a .rev file that is
    +    out-of-sync with the MIDX whose checksum it references. (But we will do
    +    away with MIDX .rev files later in this series anyway, so this is
    +    somewhat of a moot point).
     
         In theory, it is possible to store a "fingerprint" of the full object
         order here, so long as that fingerprint changes at least as often as the
    @@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
      struct midx_pack_order_data {
      	uint32_t nr;
      	uint32_t pack;
    -@@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    - 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
    - 					midx_hash, WRITE_REV);
    - 
    --	if (finalize_object_file(tmp_file, buf.buf))
    -+	if (rename(tmp_file, buf.buf))
    - 		die(_("cannot store reverse index file"));
    - 
    - 	strbuf_release(&buf);
     @@ midx.c: static int write_midx_internal(const char *object_dir,
      			(size_t)ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
      			write_midx_large_offsets);
 3:  3279e2eb9b =  3:  abc18613e0 pack-revindex.c: instrument loading on-disk reverse index
 4:  5818621ea8 =  4:  80589d7ae6 t5326: drop unnecessary setup
 5:  33502d6a17 =  5:  b9c4ff8636 t5326: extract `test_rev_exists`
 6:  76e23cae0f =  6:  00c6e914b4 t5326: move tests to t/lib-bitmap.sh
 7:  7ce3dc60f9 !  7:  3f35ef6499 t/lib-bitmap.sh: parameterize tests over reverse index source
    @@ t/lib-bitmap.sh: midx_pack_source () {
      	commit="$1"
     +	kind="$2"
      
    - 	test_expect_success 'reverse index exists' '
    +-	test_expect_success 'reverse index exists' '
    ++	test_expect_success "reverse index exists ($kind)" '
      		GIT_TRACE2_EVENT=$(pwd)/event.trace \
      			git rev-list --test-bitmap "$commit" &&
      
 8:  55aa69de12 =  8:  94563cf038 midx: read `RIDX` chunk when present
 9:  9707d5ea44 =  9:  581b723792 pack-bitmap.c: gracefully fallback after opening pack/MIDX
-- 
2.34.1.455.gd6eb6fd089
