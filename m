Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C560AC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 06:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiFVGmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFVGmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 02:42:04 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C83464E
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 23:42:03 -0700 (PDT)
Date:   Wed, 22 Jun 2022 06:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1655880119; x=1656139319;
        bh=7anMuSCzcDYJfwbD4sigq67egisfhEKwLJkTQkRww84=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=x1bUp+VYy0FhTXl/R+03e4+g7ulkohHInx/jjdgsCRRBsfhYb5C5zDZXT433D/EnA
         65XUDKmTL/WM8bRamNDk7NIoMEQLFOGwc2my1wxNAOoxWK7O+RMC3xavt5Ejo4oJcY
         /68mseLYV1imBlgKVS85l3ykCgPop5yJ9/oOkoAZQ1968Hd+NpPnE3CzuR2S2dv1bf
         O17b1dTVO+BCSVycWApIwDinGM9hkdNS3k5EuNyE8Fuuq2imjVHl1HO3Z+F9AEGzJB
         xGKhuGiHaheQVPeFANXOtTlTiJrNvlWBy1TEcKgHtAQCbAEEM5PD4X38KvEXfZalip
         h6u05hkO+tUag==
To:     Junio C Hamano <gitster@pobox.com>
From:   "Carlos L." <00xc@protonmail.com>
Cc:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren_=5B_=5D?= <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>
Reply-To: "Carlos L." <00xc@protonmail.com>
Subject: Re: [PATCH v2] grep: add --max-count command line option
Message-ID: <XWF-gaPGsSObqE_fNBKYQ-577E-oM5mMtmnDeGE-oCRmjjTSnByfmgGwesPecoAAVN9B2Gk1mA-Hu-KVyGyPiwzUxgC4Yc1HUetOvYoC2YU=@protonmail.com>
In-Reply-To: <xmqq5ykuhthp.fsf@gitster.g>
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com> <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com> <xmqq5ykuhthp.fsf@gitster.g>
Feedback-ID: 24333956:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just a couple of questions.

On Tuesday, June 21st, 2022 at 18:27, Junio C Hamano <gitster@pobox.com> wr=
ote:

> "Carlos L. via GitGitGadget" gitgitgadget@gmail.com writes:
>
> > From: =3D?UTF-8?q?Carlos=3D20L=3DC3=3DB3pez?=3D 00xc@protonmail.com
> >
> > This patch adds a command line option analogous to that of GNU
> > grep(1)'s -m / --max-count, which users might already be used to.
> > This makes it possible to limit the amount of matches shown in the
> > output while keeping the functionality of other options such as -C
> > (show code context) or -p (show containing function), which would be
> > difficult to do with a shell pipeline (e.g. head(1)).
> >
> > Signed-off-by: Carlos L=C3=B3pez 00xc@protonmail.com
> > ---
> > ...
> > Documentation/git-grep.txt | 8 ++++++++
> > builtin/grep.c | 9 +++++++++
> > grep.c | 2 ++
> > grep.h | 2 ++
> > 4 files changed, 21 insertions(+)
>
>
> Tests?

Right. Is it OK if I include my test(s) in t/t7810-grep.sh, or should it be=
 a different/new file?

> > diff --git a/grep.c b/grep.c
> > index 82eb7da1022..b32ab75cb6b 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -1686,6 +1686,8 @@ static int grep_source_1(struct grep_opt *opt, st=
ruct grep_source *gs, int colle
> > bol =3D eol + 1;
> > if (!left)
> > break;
> > + if (opt->max_count !=3D -1 && count =3D=3D opt->max_count)
> > + break;
>
>
> I would have written it "if (0 <=3D opt->max_count && ...)". What
>
> happens when a trickster asks you to do "git grep -m -2"?

Fair enough. Since it's already optimized out above, is there any reason we=
 need to include zero (<=3D)?

> I guess what I am getting at is if we are better off saying that
> negative means unlimited, instead of special casing -1 like this. I
> didn't think it through so it may be perfectly possible that what
> you wrote makes more sense than "anything negative is unlimited".
>
> I dunno.

I think you're right, I'll adjust my patch.

Best,
Carlos
