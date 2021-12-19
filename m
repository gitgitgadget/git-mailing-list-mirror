Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF75C433EF
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhLSXpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 18:45:12 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45914 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhLSXpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 18:45:11 -0500
Received: by mail-pg1-f180.google.com with SMTP id 2so984792pgb.12
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 15:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqLbsmK4VYCa8Yu/md3WK3WJjaSO7KiSc8ewPMWw4sY=;
        b=Wu0moO3y6VBs89wq882QjVDozxKqT584F8cb5Vf/WDEsievCo3Wytj8RYGIESeqwwp
         yv+swO7Wa9R/8s8O0PEeA05MA14HTwW7J31Gzv1jiEHeKuHUog7S0LY87JTPJKGLvgK3
         UMTZAf+KCnrVO2rbjgTi9st4+66FIpfKxjpSpCngomsf4225Mi3QnbR2bbdaWj+eWipp
         V2VGlbzwuIJRAxdlvc2m6dvmaljvW7LrNsAoh9wzr8B9YMLVoQCQSmEdVq+wbeBECkp0
         GCl0bzcaQwZl2shLOigCqm3eyowsQw4pnfaZXt51dw5La+Vnwxo/gASd6LkYC/26qdEb
         PgOQ==
X-Gm-Message-State: AOAM5303LdSkBGp6+sRKgvIIPKAOBsRMaYhAsemFvd49KGAihO7xq+f0
        NubBDdeTg9mrxY0/gAi0bP5l1/NyMEZCZnrQtn0=
X-Google-Smtp-Source: ABdhPJy05FIEfPo6JqNDlEHp417zDBvlX2580ctREw9WEJew6eyWf1KEropxt8b6m6jzDoMz3VqWKtY3DcYq4VnmlH8=
X-Received: by 2002:a05:6a00:2347:b0:4ba:bd36:1743 with SMTP id
 j7-20020a056a00234700b004babd361743mr5529488pfj.15.1639957510928; Sun, 19 Dec
 2021 15:45:10 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com> <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
 <004001d7f52a$f0367010$d0a35030$@nexbridge.com> <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
In-Reply-To: <CAPig+cTwmBViAGELF69mkYNoz+S-YW5-dcYuNfGeF-wob-=v9Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Dec 2021 18:45:00 -0500
Message-ID: <CAPig+cSUT3B1OQLatvfnbyRezWm68AzcdhmkiFhnJ3T5Hs=x_w@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Sean Allred <allred.sean@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 19, 2021 at 6:30 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Dec 19, 2021 at 5:51 PM <rsbecker@nexbridge.com> wrote:
> >         worktree->is_bare = (is_bare_repository_cfg == 1) ||
> >                 is_bare_repository();
> >
> > the == 1 comparison should not be done for boolean-style variables. It is an int, but initialized to -1. Unless -1 and 1 mean different things, but that is not really documented.
>
> `is_bare_repository_cfg` is not exactly a boolean; it's a tristate,
> with -1 meaning "not yet determined". I didn't, at the time, closely
> follow the discussion[1] of the particular bit of code you're
> questioning, but the `== 1` was mentioned at least a couple times,
> once in review by Junio[2], and then in the extra patch commentary by
> "jtan" when he submitted v2[3]. Anyhow, if I'm following the original
> discussion correctly, then the usage, `== 1` (or the equivalent `> 0`)
> is probably correct, and that treating it as a simple boolean (where
> -1 is true, too) would be undesirable. (Of course, I haven't traced
> through the init code at all, so I don't even know if it can ever be
> -1 at this point.) Five existing consumers of this global variable use
> `== 1`, and only two use `> 0`, so this usage is at least reasonably
> consistent with other parts of the project.

Thinking on it a bit more and re-reading jtan's commit message[1], it
seems that it can be -1 at this point if `core.bare` is not set in
configuration, as indicated at the end of his commit message:

   In order to avoid that, also check core.bare when setting is_bare. If
   core.bare=1, trust it, and otherwise, use is_bare_repository().

It does make me wonder if the code should have been:

    if (is_bare_repository_cfg > 0)
        worktree->is_bare = 1;
    else if (is_bare_repository_cfg < 0)
        worktree->is_bare = is_bare_repository();

in order to respect `core.bare=0`, which the existing code doesn't
seem to do, but perhaps I'm misunderstanding the case he was trying to
solve related to submodules. Anyhow, I think that's all a tangent from
the original issue raised in this thread by Sean (though I could be
wrong about that too).

[1]: https://lore.kernel.org/git/20190419172128.130170-1-jonathantanmy@google.com/
