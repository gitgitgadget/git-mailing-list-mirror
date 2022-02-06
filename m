Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE664C4332F
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 11:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiBFLwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 06:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiBFLlV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 06:41:21 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B32FC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 03:41:20 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id on2so1761139pjb.4
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 03:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yOae6HGJ7XPJHlOz/YfDwtCW0a/gYz7ZYrzZK1HUz0=;
        b=GS6MBla3bojtCmtfjPMaWR0nASYui6fMH4cE9cpR1icGYJ+/sbrLb2i3hzL05g9kGk
         +/SlavqQAvG9q+XJqDGWHhiazUrDk07XdIyejdvKGILNGC3y8FGYinAVnqCOikbUT/mP
         CgC25gn2Q/tyGmcrqeLCKZFgVxqJw8WKLW7azTbIp97Uk0VUTuR66Nb2P3NrqDGZuuXk
         uGrooJ1z4mwhxpZioLH6EHqCAhHZoxkxGAB4Iv/wdB2dTyURoUmxVlPsvCOU6FiiWCoc
         kinSdUZpFtRXCOljukD5QriY9k9Cnv6cjJ2sz4Kq9+EQC5JSp6xdfM4mVGkEHysaS5bg
         dL0g==
X-Gm-Message-State: AOAM533ptOZJN4q5cTQGWys+xQd6PWJbO4Pb1emjYkM4MWHBnAcSTtbs
        CaF6h1Iy6+Hg9bZWPk7Nv8O57aAB5UEEP2JeteGnB0M/
X-Google-Smtp-Source: ABdhPJwVi5HZeSE48n+Suo7IwjuM/WXWOgXJEqdhHX9l6/G4Cfua7OqbzCgAh/iE0dRR3B0xJ5jA/92ZU+Bc60lBE1Q=
X-Received: by 2002:a17:902:da8a:: with SMTP id j10mr1383096plx.145.1644147679634;
 Sun, 06 Feb 2022 03:41:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr18jnr2t.fsf@gitster.g> <20220204081336.3194538-1-newren@gmail.com>
In-Reply-To: <20220204081336.3194538-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 06:41:08 -0500
Message-ID: <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
Subject: Re: Opinions on merging questions (Was: What's cooking in git.git
 (Feb 2022, #01; Thu, 3))
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 7:06 AM Elijah Newren <newren@gmail.com> wrote:
> On Fri, Feb 3, 2022 at 21:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * ds/sparse-checkout-requires-per-worktree-config (2022-01-31) 5 commits
> >  - worktree: copy sparse-checkout patterns and config on add
> >  - sparse-checkout: set worktree-config correctly
> >  - config: add repo_config_set_worktree_gently()
> >  - worktree: create init_worktree_config()
> >  - Documentation: add extensions.worktreeConfig details
> >
> >  What's the doneness of this one?
> >  source: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
>
> I think it's done and ready for next.
>
> Eric and I weighed in quite a bit on this series, and it changed
> direction pretty dramatically, and more than once.  But we eventually
> all came to an agreement about what should be done (the hard part),
> and this round implements it.  Stolee has diligently fixed or answered
> each item I've raised and I'm very happy with this version.

This version is much improved over earlier versions, and I think
everyone is in agreement now that the series is "doing the right
thing". However...

I just finished reviewing this round and left a bunch of comments.
Some of the comments are minor and wouldn't warrant a reroll, but I
also identified some memory leaks and fragile code, as well as
non-obvious test code which could be improved. The commit message of
[4/5] feels too weak for future readers by not fully explaining the
problem(s) that the patch is addressing, so I suggested a possible
rewrite of the message. All of these issues could be fixed by
follow-on patches (with the exception of the weak commit message),
however, taken together it feels like one more reroll is warranted.
