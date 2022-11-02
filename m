Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE460C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKBItw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKBItu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:49:50 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84D24F09
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:49:48 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id l127so14456525iof.12
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 01:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu5YRyeLixyo8IZqrb9E1q3PJwgCFmfRmaw3KoLprxU=;
        b=MOnrzFHZ5FmFFB5+bKU2AaNNnz1NFz0ooQ78Y2WnQXLA8XBvq9Ik73Hc2ZXO+lu0E2
         mI4NRPFdf+ACuwx9s/lCXatrW/36CuIzxyFCqcVVJJNXsMGo8icBW4eDp/JlWtjcawIv
         lmyEexUrk6w7dBOOlqtb25yl79nvXpo0EWPwLRdVvKZJ9gl+zSxRF/0gIGnbLBmBtCwp
         8NEXm/v58qE/GthamB3P7L7eclJS77EwPGI2CTXmKJ1hJGz+Ve+s8JvkCf4Fgry5lAxH
         YU/+Wq2yhp6J0ZLzRKZk2sJs/q8ZKJ1GylbeqszqBpRBRZGJb5avWwjDpgqssSvDZmN9
         QpdA==
X-Gm-Message-State: ACrzQf2vI0/eANQCpLadK3gaNxeu/JcG3PXwoMPc3ME8xv/wwKxrwkQu
        xNSpBq3PwMypYJkEdT4d/t876oKVZRt4VWAO7YEJHW1m
X-Google-Smtp-Source: AMsMyM7V7ZTeyL9e6JQ28KxE6uKpUaU1JF3PZWEcK6FWeew4AOaCzWW71U/BAIG215ZChGTG/C+lJlbrimpdd7xHAL4=
X-Received: by 2002:a05:6638:2602:b0:35a:66ec:8d99 with SMTP id
 m2-20020a056638260200b0035a66ec8d99mr16063527jat.170.1667378988183; Wed, 02
 Nov 2022 01:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net> <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local> <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
In-Reply-To: <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Nov 2022 04:49:37 -0400
Message-ID: <CAPig+cSj78Mh8v6mN3BtyHJ+NxOvT2H_NW6SPFSAce0op2DfjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t5551: be less strict about the number of
 credential warnings
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2022 at 4:46 AM Jeff King <peff@peff.net> wrote:
> Subject: t5551: be less strict about the number of credential warnings
>
> It is unclear as to _why_, but under certain circumstances the warning
> about credentials being passed as part of the URL seems to be swallowed
> by the `git remote-https` helper in the Windows jobs of Git's CI builds.
>
> This causes the tests to fail, because they assert that in a few cases
> we should print the warning 2 or even 3 times. The reason for that is
> given in 6dcbdc0d66 (remote: create fetch.credentialsInUrl config,
> 2022-06-06), which is that multiple processes are involved, and each
> warns.
>
> In an ideal world, the user would just see the message once per logical
> operation; they don't care how many underlying processes are involved.
> And we may fix that eventually. But in the meantime, let's loosen the
> tests to just assert that the user sees the message _at least_ once.
>
> This won't catch a case where we accidentally start producing it 500
> times, but that's not a likely regression. A more likely thing is that
> we'd start producing it four times because the underlying code changes
> to use a new process. But that's exactly the kind of thing we'd prefer
> to be ignoring in the tests.
>
> Note that the tests for the "die" mode don't need adjusted. They die

s/adjusted/adjustment --or -- s/need/& to be/

> immediately in the first process that sees the problem, so they
> consistently show the error once. It's only the "warn" mode which must
> be loose. If we eventually fix it, then we can tighten its assertion. In
> the meantime, this works around the CI issues.
>
> Based on a patch by Johannes Schindelin.
>
> Signed-off-by: Jeff King <peff@peff.net>
