Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F7C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A6022314
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 22:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392013AbgJIWuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 18:50:44 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45362 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391164AbgJIWuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 18:50:15 -0400
Received: by mail-ej1-f68.google.com with SMTP id dt13so15327011ejb.12
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 15:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbXY+FMpb0TEv4OQoqQf4ucYFM7EDdtmbrGC6TBML9E=;
        b=kPB02u6J1+5BcDAXFRS2YsUy5QjydDDCjG9iifZ9gKB2D9ICWtRZhjh5Wd2Ro0b7QB
         5dAe8R52VS1bbWJOuiyEzdChuOlo2pVGsZRl0KSMuQKBz18SaennR/uHyGvNJ5S/GMAh
         seG9R8uUa21x1LUucqEJQwcIw5ynCTL3nG86AgKNZk18WgbodjkLEkjZHDLKlwrAkMuo
         1+f/q3MXylzavkHoAmsP4br/BF0aWlY+YVMsARROPIPgTLJSiTnJDMOJm8zxXtR2G6kH
         hud7MlVCx2Vb9io2AGFh72E2cycQ8WePSbELI87LwaWXxG4MD1Vd7VhC8bZWOYdi7q9H
         iG1A==
X-Gm-Message-State: AOAM531GWYLAil/S2DGowXYxSJByqZ8GIhi+owix852e1LABeiLrqL6v
        6JtoTgn+78zZi/naGDG7sMOrYmB9/dWSRNFq8kM=
X-Google-Smtp-Source: ABdhPJwjC44OQBXXW4QR6AdxIRdrMpr83fD5D4A8mz+n5Xd5HgqkpMoR0J1eHH9cyTwuZ3pM1dxyflRGL1n9ucV3P8s=
X-Received: by 2002:a17:907:68c:: with SMTP id wn12mr16367016ejb.202.1602283813423;
 Fri, 09 Oct 2020 15:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cQXkP8vTNR+LJ4fZRT-an0vEgKxcFpfi+aQ-BdipTgq=A@mail.gmail.com> <20201002162802.GA15646@contrib-buster.localdomain>
In-Reply-To: <20201002162802.GA15646@contrib-buster.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Oct 2020 18:50:02 -0400
Message-ID: <CAPig+cR8D13cM8OewRVYfg7wNjVC05tVQw80-dm4B5XPmjHJWw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 2, 2020 at 12:28 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> On Wed, Sep 30, 2020 at 03:19:27AM -0400, Eric Sunshine wrote:
> > [...] For reference, here are some earlier messages related to
> > this topic:
>
> Thank you for all this reference, it's really helpful. It is nice to see
> that we already have few discussion on this topic that we can use and
> work on top of that.
>
> Sorry for the bit late response.

Likewise.

> > I'm not suggesting that this patch series implement verbose mode, but
> > bring it to attention to make sure we don't paint ourselves into a
> > corner when deciding how the "locked" annotation should be presented.
>
> Doing a little investigation on the code, it seems the machinery for checking
> whether a worktree is prunable it seems is already there implemented
> on the `should_prune_worktree()`.

Yes, when I mentioned that in [1], I envisioned
should_prune_worktree() being moved from builtin/worktree.c to
top-level worktree.c and possibly generalized a bit if necessary.

One thing to note is that should_prune_worktree() is somewhat
expensive, so we'd probably want to make determination of "prunable
reason" lazy, much like the lock reason is retrieved lazily rather
than doing it when get_worktrees() is called. Thus, like the lock
reason, the prunable reason would be accessed indirectly via a
function, say worktree_prunable_reason(), rather than directly from
'struct worktree'.

[1]: https://lore.kernel.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/

> In such case, I would love to get started working on a bigger patch that
> will implemented not only the annotation, but the verbose mode as well.
> Specially because I was also thinking about how to make the "locked reason"
> message available to the command output and the design proposed by [2]
> sounds like a good way to manage that.

I'd be happy to see that implemented.

> Additionally, having the ability to see the annotation and the reason in
> case you see the annotation seems like more complete work for the intention
> of the patch.
>
> Unless you think that is better to start with the annotation, and some time
> later addressing the other changes specified by [2].

Whatever you feel comfortable tackling is fine. The simple "locked"
annotation is nicely standalone, so it could be resubmitted with the
changes suggested by reviewers, and graduate without waiting for the
more complex tasks which could be done as follow-up series. Or, expand
the current series to tackle verbose mode and/or prunable status or
both or any combination.

> > A reason that it would be nice to address the shortcomings of
> > porcelain format is because there are several additional pieces of
> > information it could be providing. Summarizing from [1], in addition
> > to the worktree path, its head, checked out branch, whether its bare
> > or detached, for each worktree, porcelain could also show:
> >
> >   * whether it is locked
> >    - the lock reason (if available)
> >    - and whether the worktree is currently accessible (mounted)
> >   * whether it can be pruned
> >    - and the prune reason if so
> >   * worktree ID (the <id> of .git/worktrees/<id>/)
>
> That something that can also work on. But I agreed that it could be bit
> more work for a newcomer. I was thinking that I can split the work in
> three series of patches.
>
>  1. Implementing the annotation for the standards "list" command, implementing
>   not only the locked but the prunable as on aforementioned in [2].
>
>  2. A second series of patch that will introduce the verbose as defined in [2]
>
>  3. Third and final series that extend the porcelain format.
>
> I would like to kindly ask your opnion on this. Whether you think it will
> be a good idea to implement all these changes this way and I can start
> working on that.

Such an organization would be fine. Tackle what you feel is
appropriate and what "scratches your itch". Breaking the changes down
into smaller chunks, as you propose, also helps reviewers since it's
easier to review a shorter series than a long one.

> I will change this series to become the first part of annotations, specially
> because after reading your response and references, it seems this will be
> much complete functionality that I would like to have on Git.

Makes sense.
