Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A5C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 05:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiG3FWb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 30 Jul 2022 01:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiG3FWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 01:22:30 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356FDFC5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 22:22:29 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31f661b3f89so68061767b3.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 22:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2SdEbNov/3QD1OZLP5rZrdvpemnfxQR4Yaou5qM+b1k=;
        b=AEFyvTCvIWVj6D42g4IupNMEnCmPn3a/uB/alVxlhsKGaksAHzHONBizyK/wDRUTkD
         k3KKbhnSD8qm4i335uTh2+2i65rMkbN9bvdYCyy03DAGk+FJSdjoY+R8/OdH8JFZCcno
         4rJN/R4J8RX/JtaT3+NjIIx/9QNqczBwZg8Bv8viyGgjS2CMswBTJYU/ipY1i/ZWIPT4
         wnqjowHRosQRtfuFdVvmfTQH9txPWRgzJ0rmDOpINuaiM5UzFfOsFf5qQ6gg1P/e34MU
         Q+MnfP2uMTIX0YOw9t/DHFz1KnG5I+8aJrivsBFvar5JgRmugfFP+40ZOF17Rw2XG5w6
         lX/g==
X-Gm-Message-State: ACgBeo2sBhyLsVUv6qA+N0w2wMfFs/pnjhF9hrZ3sKfnNoOfKS5YcJNd
        8+3hTjybmI9SwJOpQzw54U+4jjJQrby9MUTJP3o=
X-Google-Smtp-Source: AA6agR5k8AbhH3M34tRg6ld4Q1XZVn+kBMTPFr/KTDF41C1HP0bmFXe8MdHhuXfyz5eQuEyItgTWZ66eoNa/hy7x9/k=
X-Received: by 2002:a81:84cb:0:b0:31f:5d57:c4d4 with SMTP id
 u194-20020a8184cb000000b0031f5d57c4d4mr5691088ywf.210.1659158543688; Fri, 29
 Jul 2022 22:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <patch-v2-2.6-bbd3a7e5ecc-20220729T082919Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.6-bbd3a7e5ecc-20220729T082919Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 30 Jul 2022 01:22:12 -0400
Message-ID: <CAPig+cRF23qR2TF6TpRnMkj+FYQJBoEJUfCzSbF8EGWzANgXeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] test-fast-rebase helper: use release_revisions() (again)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 4:33 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix a bug in 0139c58ab95 (revisions API users: add "goto cleanup" for
> release_revisions(), 2022-04-13), in that commit a release_revisions()
> call was added to this function, but it never did anything due to this
> TODO memset() added in fe1a21d5267 (fast-rebase: demonstrate
> merge-ort's API via new test-tool command, 2020-10-29).
>
> Simply removing the memset() will fix the "cmdline" which can be seen
> when running t5520-pull.sh.
>
> This sort of thing could be detected automatically with a rule similar
> to the unused.cocci merged in 7fa60d2a5b6 (Merge branch
> 'ab/cocci-unused' into next, 2022-07-11). The following rule on top
> would catch the case being fixed here:
>
>         @@
>         type T;
>         identifier I;
>         identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
>         identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
>         @@
>
>         - memset(\( I \| &I \), 0, ...);
>           ... when != \( I \| &I \)
>         (
>           \( REL1 \| REL2 \)( \( I \| &I \), ...);
>         |
>           \( REL1 \| REL2 \)( \( &I \| I \) );
>         )
>           ... when != \( I \| &I \)
>
> That rule should arguably use only &I, not I (as we might be passed a
> pointer). He distinction would matter if anyone cared about the

s/He/The/

> side-effects of a memset() followed by release() of a pointer to a
> variable passed into the function.
>
> As such a pattern would be at best very confusing, and most likely
> point to buggy code as in this case, the above rule is probably fine
> as-is.
>
> But as this rule only found one such bug in the entire codebase let's
> not add it to contrib/coccinelle/unused.cocci for now, we can always
> dig it up in the future if it's deemed useful.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
