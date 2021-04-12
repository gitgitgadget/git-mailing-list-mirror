Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB06C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E4F61249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhDLStP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Apr 2021 14:49:15 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:36827 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbhDLStO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:49:14 -0400
Received: by mail-ej1-f49.google.com with SMTP id r9so21976028ejj.3
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 11:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJEZhUtY2D0XDeF2ZIjiMbXMaUkcJ9/cN7rceyZdfMQ=;
        b=MPA+WEx0yd7874wH29UtQdNWsxljMLVoK0XmIfSco1btKriz0N8X+pWAuL9/zPfR7c
         8ZhDMD187o6FfYtViKC1QNjBsD/YJ1RRCdTV/i6xuOWMiiFQArg/Z41rve71+m16XbA+
         /hbiE7XVsP52/cZ9eDsUd2NppB2IWmSR0AxpyEmnvDPTaCd6b7zQS1qx5fGQF4goTtVE
         rBwv/MS5I+uYTZjRz8b325+onjG9WVtEWPoiFizIY6+3FNoLBvYCs85Zi01Byv0zPpoT
         NVLX4sX+EPrbOZsuazwterIF3OigG86HGA0jVh3b4w9uM4unTYnJD8p0RcTIKU2qt76t
         5TrQ==
X-Gm-Message-State: AOAM531LeqUnDFTAE8eWqvk9xUwuU/dwC/bJ2C4wZmCKLOemIvaQ7VZZ
        yaR+4Vfg6Ox0lPUGtlyz3JFWr55oOCGHneWJj6Q=
X-Google-Smtp-Source: ABdhPJwLtC/vH/j1OIBVjGs4mMd22ctBVkb2H7WOWUPkS5x8RYvhjvjNVn1MDBkn5q4uup2T7BEX/zlUMgrw+HUFJqk=
X-Received: by 2002:a17:906:85cb:: with SMTP id i11mr8178186ejy.311.1618253333903;
 Mon, 12 Apr 2021 11:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
 <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com> <xmqqsg3vcpqv.fsf@gitster.g>
In-Reply-To: <xmqqsg3vcpqv.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Apr 2021 14:48:43 -0400
Message-ID: <CAPig+cSiwq3KwSLyfNezx77FvLMu0gDjLq2jCKVnLQ-uVXP3Yw@mail.gmail.com>
Subject: Re: [PATCH 01/16] check-non-portable-shell: complain about "test"
 a/-o instead of &&/||
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 2:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +       /\btest\s+-[a-z]\s+.*?\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
> >> +       /\btest\s+-[a-z]\s+.*?\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
> >
> > These will only match the simplistic forms of `test -X blah` (where
> > "-X" is some single letter option), but will miss expressions such as
> > `test "$foo" = bar`. Crafting a regex to match more generally would be
> > non-trivial, so this simpler match is a reasonable start. Okay.
>
> Would it be a trivial improvement to do
>
>     'test', followed by anything other than '&' or '|', and then
>     followed by '-a' or '-o'
>
> instead?

That seems plausible and trivial enough. In fact, I think it
eliminates a source of false-positives that Ævar's pattern can report,
such as:

    test whatever && ls -a foo

and

    test whatever && foo -o outfile

among others.
