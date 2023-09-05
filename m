Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096ABCA0FF3
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjIEQAA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 Sep 2023 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352400AbjIEFoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 01:44:10 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B643DD
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 22:44:06 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76dbd877cd9so128899085a.0
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 22:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693892645; x=1694497445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6cEqY+IuhpkbmwqGUh+JHBn2Pme4KdmB7R9tIzrXok=;
        b=gkDB4PKEuvHN96fqGFne2lWOS79vrITCJBzR0VCObBMt9EetfrXUAV8O9dnz1B8H3N
         kPTE9VZave+TA1lYrPlJ+6AZxyCXnuJ6MUb9VOtF/EDx3XSP5dM3nIkmfsuMMyMmtzBT
         a36Fsj9Sq79J4S2txlTgYkPbv8GqVVGn6d8ob01Yg72XkaSpkZdPLgcrnKvzL1VwiG2m
         u5f/63eQujMz46JCRLsJ1A6CDcUfNYYKJYgnHXkY1DmWwu846CV849O63n2lwCtdrAY4
         3/WA2H2u3iY0tFiMPIV3Sagqj5vz2+nSAFSPE0EYK2Gexlrikecs05KyNa5V2XdQWah+
         ZoXQ==
X-Gm-Message-State: AOJu0Yy/W7mm+hH9rG8AtKfi/bcZm7jDgs1EhDALK7HflqSYYYPG8Oxl
        hsytVWK3QsN1+SKPkXPAyUUr0vw6IdXLbEoA01M=
X-Google-Smtp-Source: AGHT+IHTOJanaY/m9Gjh1lMIpWYYCR0fazOpk9KHqNrBAL/MF4JtX56Auzt5m95aA/3YjbDwTE3YQ+JxGKo1GdacbMU=
X-Received: by 2002:a05:620a:2ae2:b0:76e:eeaa:a06e with SMTP id
 bn34-20020a05620a2ae200b0076eeeaaa06emr13048278qkb.4.1693892645617; Mon, 04
 Sep 2023 22:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com> <xmqqedjdtoh5.fsf@gitster.g>
In-Reply-To: <xmqqedjdtoh5.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Sep 2023 01:43:54 -0400
Message-ID: <CAPig+cRJhrGmnBRm2dporcXiRr4SzRmpM2LTMm0S7wo0XbOU9Q@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 4, 2023 at 9:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This is not accurate. There is no default location for new worktrees;
> > git-worktree creates the new worktree at the location specified by the
> > user:
> >
> >     git worktree add [<options>] <path> [<commit>]
> >
> > where <path> -- the only mandatory argument -- specifies the location.
>
> All correct.  The per-worktree part of the repository data does live
> in a subdirectory of the ".git" directory and that was probably what
> Tao had in mind, though.

That could be. I read Tao's explanation as meaning that people do this:

    git clone foo.git foo
    cd foo
    git worktree add bar
    git worktree add baz

rather than (perhaps) this:

    git clone foo.git foo
    cd foo
    git worktree add ../bar
    git worktree add ../baz

But it's possible I misunderstood.

> >> Is it the case that this contrib script predates the current "git
> >> worktree" support?
> >
> > git-new-workdir predates git-worktree by quite a few years and, as I
> > understand it, remains in-tree because it fills a niche not entirely
> > filled by git-worktree.
>
> I actually think there is no longer a valid workflow whose support
> by "worktree" is still insufficient and the script has outlived its
> usefulness.  I have been a heavy user of the new-workdir script to
> maintain my build environments, but I always have the HEAD of these
> workdir's detached, so I can easily switch my arrangement to use the
> "git worktree" without losing any flexibility.

My response was based upon my recollection of the periodic message
which shows up on the mailing list reporting a bug or submitting an
improvement for git-new-workdir, accompanied by a statement that
git-new-workdir is still a better fit for the user's particular
use-case. But I've never used it myself, so it's good to hear from
someone (you) who does use it.

> Perhaps we should remove it, possibly leaving a tombstone file like
> how we removed stuff from the contrib/examples directory.

Perhaps.
