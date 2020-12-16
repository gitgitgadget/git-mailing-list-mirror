Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08124C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956C72063A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbgLPTaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:30:20 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43]:39033 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388596AbgLPTaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:30:19 -0500
Received: by mail-ej1-f43.google.com with SMTP id n26so34391010eju.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 11:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0cP2OxI9RPKP/WXdk7Sjk78Gfgof5iwll5VspzlddQ=;
        b=lkA7kHw7fJekpyQ2gXPFkZRpjJdZOX5qWXrpP7igfQWXor51R8s5yoaHm09nKRHXMi
         hl8o41iEyyGIgOFb6agb+W0RTen2ROti5rKlwQenWReS75osMWq56X09q3XM5qrIK3Hm
         AOBeeJlJvZ+Al7U2+cHeNbpWhRN7lFQ24c/G5bha/VataPDUTK7ERknydCqfjmsLFsxF
         Z1+joaFugY5AVcG6BqcxMxwCbMdMs9EFvJ0RiZyF0g7ZH6JvEAZeCllXzM+FKoJ5SiUw
         /9QWOV/Wm3PaAroQf8PCnbGjGm0xsbyzMaLKupGDTOQtJyzxCse2cpeXHU8tphlX4FiJ
         YvLQ==
X-Gm-Message-State: AOAM530yBF3fXwC9xEkq9CNavo2qRPiWyKZ5sa3t0jbPzraKwoh22RyH
        9WNhDl8vNfR8+GZJ/PVMtjqy+5Np1sSpVf8Qng8=
X-Google-Smtp-Source: ABdhPJy+fwInwrw/pAV4lgxga0CvRNo6eCQBj+6xA1z6T18t8yXsHEaZTGljMYbaGmY8J6/efyRGClBEjU4/LmeefCw=
X-Received: by 2002:a17:906:c289:: with SMTP id r9mr31075140ejz.311.1608146977828;
 Wed, 16 Dec 2020 11:29:37 -0800 (PST)
MIME-Version: 1.0
References: <20201216073907.62591-1-sunshine@sunshineco.com> <xmqq5z514lj5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z514lj5.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Dec 2020 14:29:26 -0500
Message-ID: <CAPig+cR+4Wh4Sgk6UhUML4SHqaQsvYmw_77ih+oec2YmqQJCCg@mail.gmail.com>
Subject: Re: [PATCH] t/perf: fix test_export() failure with BSD `sed`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Sangeeta <sangunb09@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >  test_export () {
> >       [ $# != 0 ] || return 0
> > -     test_export_="$test_export_\\|$1"
> > +     test_export_="$test_export_ $1"
> >       shift
> >       test_export "$@"
> >  }
>
> This "recursion to consume $@ one by one, instead of looping" caught
> my eyes a bit, but the bug being fixed is not caused by it, so it is
> fine to let it pass.

The unusual recursion caught my eye as well.

> Given that the arguments to test_export are
> supposed to be all variable names (i.e. no funny characters anywhere
> in it), I think it could just be
>
>         test_export () {
>                 test_export_="$*"
>         }
>
> though.

That's almost good enough, but test_export() needs to accumulate the
to-be-exported variables across multiple calls, so the non-recursive
definition would likely be:

    test_export () {
        test_export_="$test_export_ $*"
    }

which would make a nice cleanup atop this portability-fix patch.

> Oh, does anybody need to clear test_export_ to an empty string (or
> unset it), by the way?

Perhaps a test_unexport() might be handy in the distant future, but
presently there is only a single call to test_export() in the entire
suite, so it's probably not worth worrying about now.
