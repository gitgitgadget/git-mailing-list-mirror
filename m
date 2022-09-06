Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E5ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIFWwl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 6 Sep 2022 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFWwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 18:52:39 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C386063
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 15:52:38 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3452214cec6so69140757b3.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 15:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=++/14MdZtlp310BhanpxQw90unjE8fsik3sUoA3UaAU=;
        b=XAPMCJbkITZRHIgCODkz2Fj/bNOD6P5jloKXL+y86VGzrSeG3/JhUF2EkkMis7LJH+
         gwixjqdUS2DRp+lJ4NOOKSEgNfWKOIMbYqfhi1BcRes+Hz7LK22mfWpHGlfHzdT9+g8K
         626WjHUDQvwHHCqauGkrV1X1jV/5uwG5rTeHjt8KFXN4QRAe/GZcetGjwaF+GgnYU1wb
         gZ/iJS72k/CNCPQazdzx0v8tqjH+JOlP/zMs4vkSbykgX0R8SQB7+cS/x0U/KgxRd5gn
         exkBYf2aASqeFpuS3tIuJItRlAhOY2k1p8mftpni5fEcSdBdEIYPr8SzyXezHqbfWwSQ
         pj8A==
X-Gm-Message-State: ACgBeo2155NDpWb3sD/sLyXUMc/5KVPyjSB7I9zlJxpQ/CdvnLHt3zl+
        pMKtCh4HXOK7R54Kcp81ugb9evtmvk9ROpTGjY0=
X-Google-Smtp-Source: AA6agR6V5FHCnK8SGOuI/BOVu2xzZu/lJ7FOujmKuWI/8DvDZqv8GG/NLkycdRoqeqBLqrXuXOAtdNFJrNY1QkX9/Fw=
X-Received: by 2002:a0d:c307:0:b0:335:6fff:dc70 with SMTP id
 f7-20020a0dc307000000b003356fffdc70mr732226ywd.493.1662504757632; Tue, 06 Sep
 2022 15:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
In-Reply-To: <20220906223537.M956576@dcvr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Sep 2022 18:52:26 -0400
Message-ID: <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     Eric Wong <e@80x24.org>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2022 at 6:35 PM Eric Wong <e@80x24.org> wrote:
> Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > +unless ($Config{useithreads} && eval {
> > +     require threads; threads->import();
>
> Fwiw, the threads(3perl) manpage has this since 2014:
>
>        The use of interpreter-based threads in perl is officially discouraged.

Thanks for pointing this out. I did see that, but as no better
alternative was offered, and since I did want this to work on Windows,
I went with it.

> I was bummed, too :<  but I've decided it wasn't worth the
> effort to deal with the problems threads could cause down the
> line in future Perl versions.  For example, common libraries
> like File::Temp will chdir behind-the-scenes which is
> thread-unsafe.
>
> (of course I only care about *BSD and Linux on MMU hardware,
> so I use SOCK_SEQPACKET and fork() freely :>)

I'm not overly worried about the deprecation at the moment since (1)
chainlint.pl isn't a widely used script -- it's audience is very
narrow; (2) the `$Config{useithreads}` conditional can be seen as an
automatic escape-hatch, and (if need be) I can even make `--jobs=1` be
an explicit escape hatch, and there's already --no-chain-lint for an
extreme escape-hatch; (3) the script is pretty much standalone -- it
doesn't rely upon any libraries like File::Temp or others; (4) Ævar
has ideas for using the Makefile for parallelism instead; (5) we can
cross the deprecation-bridge when/if it actually does become a
problem, either by dropping parallelism from chainlint.pl or by
dropping chainlint.pl itself.
