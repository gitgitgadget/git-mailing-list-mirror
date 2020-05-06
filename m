Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29920C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F7C206DB
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgEFQSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:18:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgEFQSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:18:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id g12so3403193wmh.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Bie4dBfQNxv9R2bJfx3/QlfSWY7z2HqZKTkrivgnrk=;
        b=FnwVGjYElMnFEjL/1uA1+FODtSVfRQS6opjvnvsEKlHYKaXfY1hv8ilVGuKiaiNckT
         n+axQQstWSSQQqT3HYp1y8CWUF2MeHNN6w9fgXErcrS31AOH3Tst56BVhiX9CKWAIBvT
         sj4QvcpzctYo1S9zn5T8YSfpxUYL3K5Dmx76Ot57jhDVog7PoQrwk46G1pXsKtjCPWT6
         5USR3aEH2XCnhFAGa2tXntkfD/aOTxR9HGAUtCyPvrRkW9De/tiMdA9CiMrO87km10Uw
         EzBXX1XKZqOnlTWk0Mj5WxWQB/nMghjHm3RuQlX4Wxi0DkTgpF1hMWcLftMOP9k7yDvL
         vO7w==
X-Gm-Message-State: AGi0PuYYL7/xUcvOV2aFygEn9k2fntq611uc7RyRW/O9IM0zuUjDyP52
        FloP6mI2Svt/v4q6Y/VPqB0pTLcgzmn7jZBrAMA=
X-Google-Smtp-Source: APiQypLSziRK3jXG/WWpTTUpqsHJ3AZwj/Gqsaokl30jwK94Q+5NpyxOED6szUMJuoRavEThsUYxKtX1r4LMZqzGrtM=
X-Received: by 2002:a1c:678a:: with SMTP id b132mr5447937wmc.107.1588781920799;
 Wed, 06 May 2020 09:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <pull.626.v2.git.1588758194.gitgitgadget@gmail.com> <3d7b334f5c6a89f438bba34cf91259cb67aebcd0.1588758194.git.gitgitgadget@gmail.com>
In-Reply-To: <3d7b334f5c6a89f438bba34cf91259cb67aebcd0.1588758194.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 May 2020 12:18:29 -0400
Message-ID: <CAPig+cSBBVjBs6ypcpk=s+j2Vu4OXbhUnrJPq8tyoCDr+hX4rw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] multi-pack-index: respect repack.packKeptObjects=false
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 6, 2020 at 5:44 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -538,6 +538,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
> +test_expect_success 'repack respects repack.packKeptObjects=false' '
> +       test_when_finished rm -f dup/.git/objects/pack/*keep &&
> +       (
> +               [...]
> +               THIRD_SMALLEST_SIZE=$(test-tool path-utils file-size .git/objects/pack/*pack | sort -n | head -n 3 | tail -n 1) &&
> +               BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&

Taking jk/arith-expansion-coding-guidelines[1] into consideration,
perhaps write this as:

    BATCH_SIZE=$((THIRD_SMALLEST_SIZE + 1)) &&

[1]: https://lore.kernel.org/git/20200504160709.GB12842@coredump.intra.peff.net/
