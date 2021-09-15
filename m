Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A247C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B87361155
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhIOFBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 01:01:32 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39590 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOFBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 01:01:31 -0400
Received: by mail-ed1-f44.google.com with SMTP id h17so2369483edj.6
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 22:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=una/JzfpuKgwyG5j6ZCOV6R5YrVJYrjjp2YHF6YipQk=;
        b=DTyQOQssslIPRLKTnF7N5y9cVx1yLIPji5NP4LDFxdi99sVu3g8pU9Ej8gY3CMcvB1
         QOxoYQRhHAp8A9QxMGdEgQDveQHWCb9XXy0UyiTHyX5vnQ2ItQnrTLVpmR2NkqfLtfhJ
         a25Syqe8EcfNEjCEBzKYCEtGDuf4Eitp2P9S3zggkpPM85DW8ddRDW88ufd26djZ9N8y
         Wd/pzzi0kYRqGYOF8O57W4TrDPhjzKD3K5oaimmdO3HQMwlzvaQaqKFe2tKl4/f6UU/P
         vU4H5e1Wo4prXLfAjd6T1ADyD4DzuNhKH0gdVCKuqubZRez6nkl3OF65xraGq1dYZ39V
         WF5g==
X-Gm-Message-State: AOAM5302S1xZEfXTCqE1QlcA8qBgj0b+oUAv0RH05W7QFVHrO4dADit0
        PbwJrls+H1hzcdIz4lU4UCO+EkYXzbU5R0CJpG8=
X-Google-Smtp-Source: ABdhPJxemkIPqf9o695WLktZaR3uiczEMjouKgkUM8jGTAqxbX0qemSYt82n3DHZalQjprgh044IFvWKvENxX/dxVqQ=
X-Received: by 2002:aa7:df92:: with SMTP id b18mr22901771edy.47.1631682012214;
 Tue, 14 Sep 2021 22:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net> <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
In-Reply-To: <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Sep 2021 01:00:01 -0400
Message-ID: <CAPig+cQxSTzo0tCUEb3uMhyRLS0hyuOM5ksZyH+h2StFupQ9Yw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] ls-refs: ignore very long ref-prefix counts
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:51 PM Jeff King <peff@peff.net> wrote:
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> @@ -158,6 +158,37 @@ test_expect_success 'refs/heads prefix' '
> +test_expect_success 'ignore very large set of prefixes' '
> +       # generate a large number of ref-prefixes that we expect
> +       # to match nothing; the value here exceeds TOO_MANY_PREFIXES
> +       # from ls-refs.c.
> +       {
> +               echo command=ls-refs &&
> +               echo object-format=$(test_oid algo)
> +               echo 0001 &&
> +               perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
> +               echo 0000
> +       } |
> +       test-tool pkt-line pack >in &&

Broken &&-chain in {...}.

(Granted, it doesn't matter in this case since the exit code gets lost
down the pipe, but better to be consistent about it.)
