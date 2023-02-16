Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB2C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 06:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBPGQx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 16 Feb 2023 01:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBPGQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 01:16:51 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516032CF7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:16:47 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id j184so786605pfg.10
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm6mWdpsFGOpxdbVsHBtKNJOAM/QvoiDRS9T7i4IZsI=;
        b=lNqw4QbkNzLoZqPaKpWkoaZHrlxircqCFT6IygNLEeygKZb1yfVUURCXjgs73ihbUm
         MWGebtbHNvdPHR5g6J3UKt9a0yQOA3K6UeBjF5wocssDC+9mnrihA5+3SRxiJCKjnIXI
         MQEefhrcgGU/BiMO4UFumVvSS29Quqv8xl1H69XL5L3B3VvBvDLd1JPhKQSARBTuQPvE
         G4dqZ0xd4b/Vr4Vkb1bDDwc1gvxFQFmF6SfOhPfuTlW86rIAXvuywC97pJ7lQA9px5Cz
         9/sqjvCtUGNUpfo+/w1hLs0xJUBoA+zSYBBwSedH51ICQzBhhqkVLtMoUNS2ZOXsNjox
         bRGw==
X-Gm-Message-State: AO0yUKWJAh0+lyiHkEgMIJYvBnzCyQReeEUotXhRMkTjrJIUBXDFAXMv
        pBkTj+FclNFNURwucebaoOQdOWaoPWObX8C1qe8=
X-Google-Smtp-Source: AK7set/5EGR5DHggbVPAEH+/OPKElfts4BECx0FCy7p7N8BMG2Eie09+JOiDBgyBIiNqkPUB12uQvT0dT7JpHaJIsTQ=
X-Received: by 2002:a63:7b12:0:b0:4fa:b17b:e72e with SMTP id
 w18-20020a637b12000000b004fab17be72emr735430pgc.10.1676528207076; Wed, 15 Feb
 2023 22:16:47 -0800 (PST)
MIME-Version: 1.0
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net> <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
 <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
In-Reply-To: <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Feb 2023 01:16:35 -0500
Message-ID: <CAPig+cR3fNVnLcfR0K85YgVo3go2p9cbC9ekdmm=orh0WQ+HwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 12:56 AM Torsten Bögershausen <tboegi@web.de> wrote:
> On Wed, Feb 15, 2023 at 10:16:21AM -0500, Jeff King wrote:
> > +test_expect_success 'symbolic-ref --short handles complex utf8 case' '
> > +     name="测试-加-增加-加-增加" &&
> > +     git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
> > +     # In the real world, we saw problems with this case only
> > +     # when the locale includes UTF-8. Set it here to try to make things as
> > +     # hard as possible for us to pass, but in practice we should do the
> > +     # right thing regardless (and of course some platforms may not even
> > +     # have this locale).
> > +     LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
> > +     echo "$name" >expect &&
> > +     test_cmp expect actual
> > +'
>
> The other thing seems to be that there is a bug even with
> LANG=C, see the response from Eric here:
>
> $ git symbolic-ref --short HEAD | xxd
> 00000000: e6b5 8be8 af95 2de5 8a0a                 ......-...
> $ LANG=C git symbolic-ref --short HEAD | xxd
> 00000000: e6b5 8be8 af95 2de5 8aa0 2de5 a29e e58a  ......-...-.....
> 00000010: a02d e58a a02d e5a2 9ee5 8aa0 0a         .-...-.......

I'm confused. To what bug do you refer? In my tests, LANG=C seemed to
sidestep the problem.

> Does it make sense to
> a) Use the local locale, what ever that is
> b) Re-run with LC_ALL=en_US.UTF-8
> c) Re-run with LANG=C (that is where I had suspected problems when using UTF-8)

In my tests, LANG=C is the only case which seemed to work correctly
when the implementation used fscanf().

> d) Mention MacOs here ?

Certainly, a good idea.

> Somewhat in that style:
>
> test_expect_success 'symbolic-ref --short handles complex utf8 case' '
>         name="测试-加-增加-加-增加" &&
>         git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
>         # In the real world, we saw problems with this case only under MacOs Ventura

I'm on ancient High Sierra (10.13) using HFS+, so the problem is not
Ventura-specific. The original bug report did mention Ventura (which
presumably is using APFS).

>         # when the locale includes UTF-8. Try it here to try to make things as
>         # hard as possible for us to pass, but in practice we should do the
>         # right thing regardless (and of course some platforms may not even
>         # have this locale).
>         # Use try even the default and LANG=C
>         git symbolic-ref --short TEST_SYMREF >actual &&
>         echo "$name" >expect &&
>         test_cmp expect actual &&
>         LC_ALL=en_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
>         echo "$name" >expect &&
>         test_cmp expect actual &&
>         LANG=C git symbolic-ref --short TEST_SYMREF >actual &&
>         echo "$name" >expect &&
>         test_cmp expect actual
> '
