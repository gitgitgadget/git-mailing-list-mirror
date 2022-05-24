Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F73C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241966AbiEXVip (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiEXVio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:38:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A107CB16
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:38:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 256D812BD9E;
        Tue, 24 May 2022 17:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jBsG6sJmZb0FO+lIqyoi+zrtXv096kLLts5vcz
        VhtuA=; b=Ahfs8AURO2jDps37UTQ/ZmpJmJgqczddzxwEPYwgLeAth8zmzpoYUR
        GcceDFrRFxG+HzgnAyDXhhpfHZPdTHVJXd/fvd7tsiMe0ezUz2j/NejB2YT/wBMx
        pCJS1q6vyQk+IdB68e7gItgCt9mXBxM6UeTJX8ZdtfVDgpfxmYrI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B04F12BD9D;
        Tue, 24 May 2022 17:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89D0412BD9C;
        Tue, 24 May 2022 17:38:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 0/4] pack-objects: fix a pair of MIDX bitmap-related
 races
References: <cover.1652458395.git.me@ttaylorr.com>
        <cover.1653418457.git.me@ttaylorr.com>
Date:   Tue, 24 May 2022 14:38:39 -0700
In-Reply-To: <cover.1653418457.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 24 May 2022 14:54:18 -0400")
Message-ID: <xmqqfskyfw68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E09B22CA-DBA9-11EC-B257-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>          verbatim reuse (c.f., `write_reused_pack_verbatim()`).

Unlike "e.g." and "i.e.", I think these should all be "cf." (there
are many others).

>     +    This patch handles the "preferred" pack (c.f., the section
>     +    "multi-pack-index reverse indexes" in
>     +    Documentation/technical/pack-format.txt) specially, since pack-objects
>     +    depends on reusing exact chunks of that pack verbatim in
>     +    reuse_partial_packfile_from_bitmap(). So if that pack cannot be loaded,
>     +    the utility of a bitmap is significantly diminished.

It explains why we care about the "preferred" pack, which is a nice
clarification.  It hints that the other packs do not matter as much,
and it is clearly stated that how they are handled is ...

>     +    Similar to dc1daacdcc, we could technically just add this check in
>     +    reuse_partial_packfile_from_bitmap(), since it's possible to use a MIDX
>     +    .bitmap without needing to open any of its packs. But it's simpler to do
>     +    the check as early as possible, covering all direct uses of the
>     +    preferred pack. Note that doing this check early requires us to call
>     +    prepare_midx_pack() early, too, so move the relevant part of that loop
>     +    from load_reverse_index() into open_midx_bitmap_1().
>     +
>     +    Subsequent patches handle the non-preferred packs in a slightly
>     +    different fashion.

... left for later steps.

Excellent write-up.

>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>      
>     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>      +
>      +	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
>      +	if (!is_pack_valid(preferred)) {
>     -+		close(fd);
>      +		warning(_("preferred pack (%s) is invalid"),
>      +			preferred->pack_name);
>      +		goto cleanup;
> 2:  9adf6e1341 < -:  ---------- builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
> -:  ---------- > 2:  2719d33f32 builtin/pack-objects.c: avoid redundant NULL check
> -:  ---------- > 3:  cdc3265ec2 builtin/pack-objects.c: ensure included `--stdin-packs` exist
> -:  ---------- > 4:  3fc3a95517 builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
