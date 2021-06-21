Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02AFC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A458B611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFUUFE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Jun 2021 16:05:04 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:33628 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhFUUFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:05:03 -0400
Received: by mail-ej1-f54.google.com with SMTP id g20so30837392ejt.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OJD3HjI11TxXXcRqGBxh56xXEbOCzPw/6V+IxgUZNzA=;
        b=dPVUVpz7YgzhVFHiq7XGG0MGZdVJkHDLW5SXyPTTiOb1ihbiP5HmqHqvDeHtNugY7i
         UWjFUHkfnQ19/F7fnP5uXjnDYktoBxdGA4XLGUfLUgNpceeU2S+Rq33+DrdY7KMQD63U
         R5yWXnUz03DBuaeuFH5MoC+zTx2v440/0ABEETfn3iURMASCVXM0rDq0hX0cEeC2gwMA
         8Fjq29GbppsYFBcMrpYGofLQU6MO/OnV7o9RdNKy5UOSpu5RCTfOi3jLtNhNz07t91HY
         f/Rh1GtmxGLeCRkyQgkxkVzLc3LLk7Um+mVd2xmrlGxJuOeZdLuRR6Nx6B6OLKsZZyFH
         svpA==
X-Gm-Message-State: AOAM530CBiLAsJ6oH3ZBpO1FYnvPiisRYzp/b2ztmWQ/mmfHUDQbZ0Ua
        rLKQ98Olmv6SIaGaNwKptr8d8y3lGa6Xvw+CIMs=
X-Google-Smtp-Source: ABdhPJyUngkqNfK6zp8RbIVY7hqycRvbdBBIFU4JCUR5+vZE09OnnwCVWxleo7Lc/gQ2XTOP13ojF2Q7oaiHmDeIeBo=
X-Received: by 2002:a17:906:64d1:: with SMTP id p17mr9019445ejn.138.1624305768023;
 Mon, 21 Jun 2021 13:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210620213836.10771-1-rhi@pengutronix.de> <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net> <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
 <20210621093310.eqt3ajic64pgag44@pengutronix.de> <87sg1b2xhl.fsf@evledraar.gmail.com>
In-Reply-To: <87sg1b2xhl.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Jun 2021 16:02:37 -0400
Message-ID: <CAPig+cT9kcuNrwTTRRbZDNWPTb8PVyDVWaUSQvFr0pKj3R2YGQ@mail.gmail.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Roland Hieber <rhi@pengutronix.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 8:50 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Jun 21 2021, Roland Hieber wrote:
> > On Sun, Jun 20, 2021 at 10:10:10PM -0400, Eric Sunshine wrote:
> >> There have been multiple patches sent to the project over the years
> >> with the same purpose. One problem, I believe, which has never been
> >> fully addressed is what happens when the subdirectory from which
> >> git-bisect is run gets deleted as part of the bisection.
> >
> > Ah, thanks for explaining the problem. Would a patch that adds a short
> > explanatory comment in git-bisect.sh on the matter help to prevent
> > people sending such patches?
>
> Having skimmed the linked discussions I don't think the consensus is
> that this shouldn't exist, but that someone who wants it should do some
> research on the relevant edge cases, come up with test cases for them,
> discuss the trade-offs in a commit message etc.

Be that as it may, having a comment in the code explaining why it is
currently turned off and what needs to be accomplished before turning
it on might indeed be a good way to stem the flow of patches which
merely flip-the-switch without doing that extra research. Whether or
not Junio would accept such a patch documenting the current state of
affairs is a different question.
