Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581BC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbiEXSy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiEXSyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:54:23 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450358E79
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:22 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f189b07f57so23426540fac.1
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaV1Qq4UnqG0nO66RA0BjIpUfq5YuzW2V1WmI/pa3dw=;
        b=aR+KgJmB9U/vFApgfZhH3EVshxkCOrMi4JzBVjcKspGJSd/cnBjDWXMMacVD4vPrdi
         qf/Szkatb4SHOPcNfbnmy1ReZa9SMfiputJ1LJaAzXkRPIPKHui5CVCV/HV7em57lKl2
         QIg+bHzOyOLRz/1dkWuISNFlzi/BhTlmi5U2wtr7zJBnEdQeQhKKPXvhMpcoPwUmgS4M
         BrSm7Sjip6gsQdhxfmS1zF+g6Wky9soSA/LAduJrNTvNMqDuynJC/OQuDVA210BgC/+U
         uwAYu6RD82I0P7KA08ANPlfVyE3nxGjgAZgSnIELqr7oRa/qiYxXafieSusXE2qHEfF+
         zE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaV1Qq4UnqG0nO66RA0BjIpUfq5YuzW2V1WmI/pa3dw=;
        b=fcxpLfH/JClvm09p1RXMRmwUqOYV+zXh2xml4lTPauhHbCsxexeoODp9hc56NO3ew3
         JMmFKvPU9NNHnhjwvUo6VGQ+mMDugEfohN7/dws/jI+RU+vj/7Zg/lcvDccWRm9U8/I3
         KgEiQFxH5PyQBH8aJpKRDwX8A3U0xdLeIvMsD8qQDZ8z1ZgpVFz0/r+QjbbQqDlub2eB
         tCVHYxtSKCXZNjGyVJZqVVGLGEcoPKJL9BjDq1AKX8aio155xRFY6cXa96gInq0MOsJg
         3nRxr2hl052W9fQud9fPNRjNbVNQWgseeZ+jcGd6bJr1AwVh9056ypE8VklGVdFsqvbD
         Yu8A==
X-Gm-Message-State: AOAM531naEXpiwPU6TFKF9gubgBI59jHZMO+8XW8+YJuOIb/wzdfZayN
        flL0DJ/9sPiUz/ZhWJaQHJhnbDv5eJB7hQ==
X-Google-Smtp-Source: ABdhPJwuU25Owcg9oTjs+Sef2v+ZDRWkGZe0p+omACBCP8zhQphdyj/81fMTq3sYRt1J3iFUbzBs9Q==
X-Received: by 2002:a05:6870:32d6:b0:e3:6e1a:e56b with SMTP id r22-20020a05687032d600b000e36e1ae56bmr3275589oac.206.1653418461207;
        Tue, 24 May 2022 11:54:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x29-20020a056830409d00b0060603221260sm762630ott.48.2022.05.24.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:54:20 -0700 (PDT)
Date:   Tue, 24 May 2022 14:54:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v2 0/4] pack-objects: fix a pair of MIDX bitmap-related races
Message-ID: <cover.1653418457.git.me@ttaylorr.com>
References: <cover.1652458395.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652458395.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small-ish reroll of mine and Victoria's series to fix a couple of
races related to using multi-pack bitmaps in pack-objects.

The crux of both is that we call `is_pack_valid()` far too late, leaving us in a
situation where `pack-objects` committed to using objects from a specific pack
in the MIDX bitmap, without having actually opened those packs. So if those
packs are removed in the background (e.g., due to a simultaneous repack),
any ongoing clones or fetches will see this error message:

    remote: Enumerating objects: 1498802, done.
    remote: fatal: packfile ./objects/pack/pack-$HASH.pack cannot be accessed
    remote: aborting due to possible repository corruption on the remote side.

The first patch is mostly unchanged (except for removing an accidental
double-close()), but the second patch has itself turned into three new patches
in order to resolve the issue described in [1].

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/Yn+v8mEHm2sfo4sn@nand.local/

Taylor Blau (4):
  pack-bitmap.c: check preferred pack validity when opening MIDX bitmap
  builtin/pack-objects.c: avoid redundant NULL check
  builtin/pack-objects.c: ensure included `--stdin-packs` exist
  builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects

 builtin/pack-objects.c | 43 +++++++++++++++++++++++++-----------------
 pack-bitmap.c          | 18 ++++++++++++++++--
 2 files changed, 42 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  83e2ad3962 ! 1:  618e8a6166 pack-bitmap: check preferred pack validity when opening MIDX bitmap
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    pack-bitmap: check preferred pack validity when opening MIDX bitmap
    +    pack-bitmap.c: check preferred pack validity when opening MIDX bitmap
     
         When pack-objects adds an entry to its packing list, it marks the
         packfile and offset containing the object, which we may later use during
         verbatim reuse (c.f., `write_reused_pack_verbatim()`).
     
         If the packfile in question is deleted in the background (e.g., due to a
    -    concurrent `git repack`), we'll die() as a result of calling use_pack().
    -    4c08018204 (pack-objects: protect against disappearing packs,
    -    2011-10-14) worked around this by opening the pack ahead of time before
    -    recording it as a valid source for reuse.
    +    concurrent `git repack`), we'll die() as a result of calling use_pack(),
    +    unless we have an open file descriptor on the pack itself. 4c08018204
    +    (pack-objects: protect against disappearing packs, 2011-10-14) worked
    +    around this by opening the pack ahead of time before recording it as a
    +    valid source for reuse.
     
         4c08018204's treatment meant that we could tolerate disappearing packs,
    -    since it ensures we always have an open file descriptor any pack that we
    -    mark as a valid source for reuse. This tightens the race to only happen
    -    when we need to close an open pack's file descriptor (c.f., the caller
    -    of `packfile.c::get_max_fd_limit()`) _and_ that pack was deleted, in
    -    which case we'll complain that a pack could not be accessed and die().
    +    since it ensures we always have an open file descriptor on any pack that
    +    we mark as a valid source for reuse. This tightens the race to only
    +    happen when we need to close an open pack's file descriptor (c.f., the
    +    caller of `packfile.c::get_max_fd_limit()`) _and_ that pack was deleted,
    +    in which case we'll complain that a pack could not be accessed and
    +    die().
     
    -    The pack bitmap code does this, too, since prior to bab919bd44
    -    (pack-bitmap: check pack validity when opening bitmap, 2015-03-26) it
    +    The pack bitmap code does this, too, since prior to dc1daacdcc
    +    (pack-bitmap: check pack validity when opening bitmap, 2021-07-23) it
         was vulnerable to the same race.
     
         The MIDX bitmap code does not do this, and is vulnerable to the same
    -    race. Apply the same treatment as bab919bd44 to the routine responsible
    -    for opening multi-pack bitmaps to close this race.
    +    race. Apply the same treatment as dc1daacdcc to the routine responsible
    +    for opening the multi-pack bitmap's preferred pack to close this race.
     
    -    Similar to bab919bd44, we could technically just add this check in
    -    reuse_partial_packfile_from_bitmap(), since it's technically possible to
    -    use a MIDX .bitmap without needing to open any of its packs. But it's
    -    simpler to do the check as early as possible, covering all direct uses
    -    of the preferred pack. Note that doing this check early requires us to
    -    call prepare_midx_pack() early, too, so move the relevant part of that
    -    loop from load_reverse_index() into open_midx_bitmap_1().
    +    This patch handles the "preferred" pack (c.f., the section
    +    "multi-pack-index reverse indexes" in
    +    Documentation/technical/pack-format.txt) specially, since pack-objects
    +    depends on reusing exact chunks of that pack verbatim in
    +    reuse_partial_packfile_from_bitmap(). So if that pack cannot be loaded,
    +    the utility of a bitmap is significantly diminished.
    +
    +    Similar to dc1daacdcc, we could technically just add this check in
    +    reuse_partial_packfile_from_bitmap(), since it's possible to use a MIDX
    +    .bitmap without needing to open any of its packs. But it's simpler to do
    +    the check as early as possible, covering all direct uses of the
    +    preferred pack. Note that doing this check early requires us to call
    +    prepare_midx_pack() early, too, so move the relevant part of that loop
    +    from load_reverse_index() into open_midx_bitmap_1().
    +
    +    Subsequent patches handle the non-preferred packs in a slightly
    +    different fashion.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
     +
     +	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
     +	if (!is_pack_valid(preferred)) {
    -+		close(fd);
     +		warning(_("preferred pack (%s) is invalid"),
     +			preferred->pack_name);
     +		goto cleanup;
2:  9adf6e1341 < -:  ---------- builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
-:  ---------- > 2:  2719d33f32 builtin/pack-objects.c: avoid redundant NULL check
-:  ---------- > 3:  cdc3265ec2 builtin/pack-objects.c: ensure included `--stdin-packs` exist
-:  ---------- > 4:  3fc3a95517 builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
-- 
2.36.1.94.gb0d54bedca
