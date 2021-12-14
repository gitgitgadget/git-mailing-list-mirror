Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F47C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhLNBz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhLNBz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:28 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A805C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:28 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p65so21522626iof.3
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTdhB2yfpxVqp3JXkXWy7ZS2r7BKgYsmjcie5Vef6wI=;
        b=k6DvSJ3FEL4qbbGwDEY7EGpXvteDu6px/0HqqhDPTqe34YtsP3vj9auhboPboiX1Mh
         NBhKngkVwEoZED568Kp6AExSpfq67bVMoMbguyuvIt/I7cSa6f7OWMHHzKUW6jw0gM4x
         BNc9wYx841ohZ++GxpHhn7BkwNA1I4mWGOc8DhZhbDIW9xvZvzDMbV0iuaKZnDIWC3NZ
         4+JUODjT93uecbyihbsBpND/rYYFMyUiiM+HtGZ4MHPQnregyWq1q98iOAbzuFZGJTzj
         4QBDPIAMV06iblyFfGuY7ZLLOAL11CKA+RsDUbX1SVP8XZD9no8mPad0+a7hEbDg75pS
         feYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTdhB2yfpxVqp3JXkXWy7ZS2r7BKgYsmjcie5Vef6wI=;
        b=WzMcz4RnXIDjd9LFwuPni1i66T2stIAvFmp99NlJvvmiymUFR9Ep9NlwVvNRaouCUw
         bVVmgCnszxh2/w2uKbccLCl/4ggj2+pQp1Mcy3+YM5XpOlOog5Oq3vREgBqZv2AgDXn4
         mYHvmYwWZqifuPE5gIDnKrz8mSyy0LvPiney4r1CKD29HWkBDUA5ObNn/+R0uY+YbZ8v
         UrsaU3jdL+1RrRYMpUJAwcHI5bwtTL32v4r0WV6TfWys9W250aC/EZjcdCbqq4Rhw1l7
         ZYTXV7lnY7A0eA31P4BLeyihYaW4mLdwQfW4wZOQsdskE7AmIOn0IC6aS01szbeeuhOx
         r9cw==
X-Gm-Message-State: AOAM5322UCI7jClmtM3DtBp1x/Y04Djs6VrFINyfHbFRTkEKggJyICjv
        GWh7RtxxLb2PH2fy43MH9HixvzINbGfK5/L2
X-Google-Smtp-Source: ABdhPJyASqbNzJIbzjngf+9KVKdjRE8/gTW+j7172N4cTGGTfuifRgoXqTNFvfzhm0ExSE7Z6ueLUA==
X-Received: by 2002:a5d:9053:: with SMTP id v19mr1651327ioq.39.1639446926985;
        Mon, 13 Dec 2021 17:55:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4da6bsm185858173.119.2021.12.13.17.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:26 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting pack
 order
Message-ID: <cover.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638991570.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
which they can become corrupt when permuting their pack order.

The problem is described in detail in the second patch. But this version goes
further and stops writing the MIDX .rev file altogether, instead reading the
same data out of a new optional 'RIDX' chunk (falling back to the .rev file when
necessary).

Applying just the first two patches is sufficient to fix this problem, but the
remaining six go further to deprecate the MIDX .rev file altogether. I'm not
crazy about the testing strategy, though I think it was the best that I came up
with.

The idea is to essentially copy the core of t5326 into a new t5327. The former
uses the RIDX chunk, and the latter uses .rev files. I would have like to just
run the same tests in t5326 twice, but they munge the state of their test
repository enough to make it sufficiently awkward to do in practice.

So I'm definitely open to suggestions there, but otherwise this series should go
a long ways towards fixing my design mistake of having the MIDX .rev file be
separate from the MIDX itself.

Taylor Blau (8):
  t5326: demonstrate bitmap corruption after permutation
  midx.c: make changing the preferred pack safe
  pack-revindex.c: instrument loading on-disk reverse index
  t5326: drop unnecessary setup
  t5326: extract `test_rev_exists`
  t5326: move tests to t/lib-bitmap.sh
  t/lib-bitmap.sh: parameterize tests over reverse index source
  midx: read `RIDX` chunk when present

 Documentation/technical/multi-pack-index.txt |   1 +
 Documentation/technical/pack-format.txt      |  13 +-
 midx.c                                       |  31 +++-
 midx.h                                       |   1 +
 pack-revindex.c                              |  20 ++
 t/lib-bitmap.sh                              | 186 +++++++++++++++++++
 t/t5326-multi-pack-bitmaps.sh                | 144 +-------------
 t/t5327-multi-pack-bitmaps-rev.sh            |  23 +++
 t/t7700-repack.sh                            |   4 -
 9 files changed, 271 insertions(+), 152 deletions(-)
 create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh

Range-diff against v1:
1:  ea91cebb6b = 1:  dfbac4bc60 t5326: demonstrate bitmap corruption after permutation
2:  fa42d816f4 ! 2:  4ea52e66dd midx.c: make changing the preferred pack safe
    @@ Commit message
         or MIDX, but writing that data into the MIDX itself makes that a
         circular dependency).
     
    -    Instead, make the pack order used during bitmap generation part of the
    +    Instead, make the object order used during bitmap generation part of the
         MIDX itself. That means that the new test in t5326 will cause the MIDX's
         checksum to update, preventing the stale read problem.
     
    -    There is no need to store the complete pack order here, since the only
    -    way a fixed set of packs can result in a change in the object ordering
    -    is by changing the preferred pack. That's because packs are sorted
    -    according to their pack name only, so it would be impossible to induce a
    -    different order by, say, touching a pack's mtime.
    -
    -    But storing the complete pack order gives us some flexibility in the
    -    future, and it only costs 4 bytes per pack to do. In the future, we
    -    could also optimize .rev reads looking for the identity of the preferred
    -    pack by consulting this list if it exists.
    +    In theory, it is possible to store a "fingerprint" of the full object
    +    order here, so long as that fingerprint changes at least as often as the
    +    full object order does. Some possibilities here include storing the
    +    identity of the preferred pack, along with the mtimes of the
    +    non-preferred packs in a consistent order. But storing a limited part of
    +    the information makes it difficult to reason about whether or not there
    +    are gaps between the two that would cause us to get bitten by this bug
    +    again.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ Documentation/technical/multi-pack-index.txt: and their offsets into multiple pa
        - An offset within the jth packfile for the object.
      - If large offsets are required, we use another list of large
        offsets similar to version 2 pack-indexes.
    -+- An optional list of pack IDs in bitmap-sorted order.
    ++- An optional list of objects in pseudo-pack order (used with MIDX bitmaps).
      
      Thus, we can provide O(log N) lookup time for any number
      of packfiles.
    @@ Documentation/technical/pack-format.txt: CHUNK DATA:
      	[Optional] Object Large Offsets (ID: {'L', 'O', 'F', 'F'})
      	    8-byte offsets into large packfiles.
      
    -+	[Optional] Bitmap pack order (ID: {'P', 'O', 'R', 'D'})
    -+	    A list of 4-byte pack identifiers in sorted order according to
    -+	    their relative bitmap positions.
    ++	[Optional] Bitmap pack order (ID: {'R', 'I', 'D', 'X'})
    ++	    A list of MIDX positions (one per object in the MIDX, num_objects in
    ++	    total, each a 4-byte unsigned integer in network byte order), sorted
    ++	    according to their relative bitmap/pseudo-pack positions.
     +
      TRAILER:
      
      	Index checksum of the above contents.
    +@@ Documentation/technical/pack-format.txt: In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
    + objects in packs stored by the MIDX, laid out in pack order, and the
    + packs arranged in MIDX order (with the preferred pack coming first).
    + 
    +-Finally, note that the MIDX's reverse index is not stored as a chunk in
    +-the multi-pack-index itself. This is done because the reverse index
    +-includes the checksum of the pack or MIDX to which it belongs, which
    +-makes it impossible to write in the MIDX. To avoid races when rewriting
    +-the MIDX, a MIDX reverse index includes the MIDX's checksum in its
    +-filename (e.g., `multi-pack-index-xyz.rev`).
    ++The MIDX's reverse index is stored in the optional 'RIDX' chunk within
    ++the MIDX itself.
     
      ## midx.c ##
     @@
      #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
      #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
      #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
    -+#define MIDX_CHUNKID_PACKORDER 0x504f5244 /* "PORD" */
    ++#define MIDX_CHUNKID_REVINDEX 0x52494458 /* "RIDX" */
      #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
      #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
      #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
    @@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
      	return 0;
      }
      
    -+static int write_midx_pack_order(struct hashfile *f,
    -+				 void *data)
    ++static int write_midx_revindex(struct hashfile *f,
    ++			       void *data)
     +{
     +	struct write_midx_context *ctx = data;
     +	uint32_t i;
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      
     +	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP)) {
     +		ctx.pack_order = midx_pack_order(&ctx);
    -+		add_chunk(cf, MIDX_CHUNKID_PACKORDER,
    ++		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
     +			  ctx.entries_nr * sizeof(uint32_t),
    -+			  write_midx_pack_order);
    ++			  write_midx_revindex);
     +	}
     +
      	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
-:  ---------- > 3:  b630fea149 pack-revindex.c: instrument loading on-disk reverse index
-:  ---------- > 4:  f430b6f2e9 t5326: drop unnecessary setup
-:  ---------- > 5:  73faab9f42 t5326: extract `test_rev_exists`
-:  ---------- > 6:  bf42b116e1 t5326: move tests to t/lib-bitmap.sh
-:  ---------- > 7:  fa91631024 t/lib-bitmap.sh: parameterize tests over reverse index source
-:  ---------- > 8:  993bfa8dd8 midx: read `RIDX` chunk when present
-- 
2.34.1.25.gb3157a20e6
