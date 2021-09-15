Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B63C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3522E61216
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 05:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhIOFKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 01:10:50 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:43749 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhIOFKu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 01:10:50 -0400
Received: by mail-ej1-f53.google.com with SMTP id qq21so3387193ejb.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 22:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wB3MA+aO4KISqkeZsN6KYD6kDWdLCXcMescwmIh5T6s=;
        b=mIi7dH6adqReHyrsGhMsUCkqqOLh5IpGg4rguoj5ee2UL+zkDQFKZ6ERqxI0azo1bf
         dBy7R5exN7hM71dtqfonQVa/hamdE/J4TFHY7HFueSJriU7noNoH6jFdWnDsyove/JZ7
         BHmOCmwASKn99Vt6nZCWddciZSzfixlAkZuaW4Na7crsWN/Yiy+FejWJoF6RWJ4amaJj
         u/kT/c5dwPctck8UZ8MyOPZge5PrUBfOAmklcUEIvkfN/YdY+cVK+ssLXtHVfqBW8xDA
         qAImo+RzCv7TWg/ha+xRe6XEJVdUXqhNdRieA1CKKE0tfBAr1SGu08DV5WOn5crZPMBU
         Z7KA==
X-Gm-Message-State: AOAM530ePad5V6sf71LQUHlwybvG6AnVnoetMtFL+ccqR9TT9hzrGzyb
        hp74OhchUPskKN79zwCuCliG2cxQS+PY5fL9OA0=
X-Google-Smtp-Source: ABdhPJz81ytk88olhVfFgXnGRWJ9o23MvkWbhM3tjgQIjfiGfAxeWIZfKElsDzvWCO5jxyYmPXgu4xyyIygkLPYJaiA=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr22347303ejr.36.1631682570740;
 Tue, 14 Sep 2021 22:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net> <YUE1ym1dALRQLztq@coredump.intra.peff.net>
In-Reply-To: <YUE1ym1dALRQLztq@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Sep 2021 01:09:19 -0400
Message-ID: <CAPig+cQNipgVwYZw3r2nQMZ_AOOsFEp1=MgEdmZcdAPnFE7gZA@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:52 PM Jeff King <peff@peff.net> wrote:
> When we see a line from the client like "command=ls-refs", we parse
> everything after the equals sign as a capability, which we check against
> our capabilities table. If we don't recognize the command (e.g.,
> "command=foo"), we'll reject it. But we use the same parser that checks
> for regular capabilities like "object-format=sha256". And so we'll
> accept "ls-refs=foo", even though everything after the equals is bogus,
> and simply ignored.
>
> This isn't really hurting anything, but the request does violate the
> spec. Let's tighten it up to prevent any surprising behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> @@ -72,6 +72,16 @@ test_expect_success 'request invalid command' '
> +test_expect_success 'requested command is command=value' '
> +       test-tool pkt-line pack >in <<-\EOF &&
> +       command=ls-refs=whatever
> +       object-format=$(test_oid algo)
> +       0000
> +       EOF

This here-doc uses <<-\EOF yet (presumably) expects $(test_oid algo)
to be expanded. I'm guessing that you meant <<-EOF but never
noticed...

> +       test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&

... because of this test_must_fail().

> +       grep invalid.command.*ls-refs=whatever err
> +'
