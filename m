Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BA8C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1168522E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 09:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgLEJYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 04:24:37 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37540 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLEJXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 04:23:05 -0500
Received: by mail-ej1-f42.google.com with SMTP id ga15so12251385ejb.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 01:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiVBwkaxxbmXHV3mbxpiWG5W4Zpm1W8li5oAdy8jHHM=;
        b=hLjRIUQyrgsCWorIH7lKe0U15N9sCw1PA2m/qSrFmUWskrszkZeRsGkM2ctCa879kp
         seXgmIZS6tdO/rjjG991NWXvO+W9JMevTrBJcB3tue6//RA+oDScBnKzPxSWMpEYcVIt
         T+bCRewta5vpvZOXdP3UiY423LWA6/nnO5xDcyZGr0UteC24F8cE1GCET8Hi68XtWbd7
         9S3a5LYzSfxjuKsdDmdgjBO+ErqS9ngFgkg316ppoNFRseVdeo2tqPfVBqTeFOGCOLsZ
         N+2zfpbhWyJkkjg/P4yp2Eka3/ueVL4aoP5JT7CZ6mfFd4KPdlXcD/9vWSFS76HA/vz8
         JW6w==
X-Gm-Message-State: AOAM531MKDuvaZ8GcID6WQFEnCd37qnbJSm+g1U1FB6y6C32BpX1nrgd
        /7ZnwR/BDn8uhChmlY732VUGpdxlvumAbas16I+5JUn/JDo=
X-Google-Smtp-Source: ABdhPJyTIk5DlXlXi8vMK2jjvb/DhvWOW9m4eDm0EmVu+QEG7YoMyaySIAi9GDdZaVPGTg75IYvhZpQ0cI9Qe+Vw6eY=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr11057217ejb.138.1607160137532;
 Sat, 05 Dec 2020 01:22:17 -0800 (PST)
MIME-Version: 1.0
References: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
In-Reply-To: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 Dec 2020 04:22:06 -0500
Message-ID: <CAPig+cT=-nNcfrzjSmTXymhFkB22bPFE6QRKXqPtat2ipUdboQ@mail.gmail.com>
Subject: Re: 'git worktree repair' can't repair when main and linked worktrees
 are moved
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 6:14 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> I've had to move all my Git clones to a new filesystem.
> Several of them use secondary worktrees, and all are
> at the same level ex:
>
> I had hoped to use the new 'git worktree repair' command
> but it seems it does not work for this use case.
>
> Is this supposed to work ? Or it's not something that
> 'git worktree repair' can currently cope with ?

This is a situation which `git worktree repair` can not yet handle.
The implementation of bare bones `git worktree repair` was
sufficiently complex that I decided that additional cases like this
and other bells and whistles should be built later atop the basic
implementation. At present, only the following cases are handled:

* secondary worktree has moved so main worktree doesn't know where it
is, but secondary worktree still knows where main worktree is, thus
`git worktree repair` within the secondary can contact the main and
fix up main's reference to the secondary

* main worktree has moved so secondary worktrees don't know where it
is, but main worktree still knows where secondary worktrees are, thus
`git worktree repair` within main can contact each secondary and fix
up their references back to main

There was a little discussion during review[1,2,3] about how the
situation might be handled in which both main and secondary worktrees
have been moved. Primarily, a new command-line option would be added
allowing the user to tell `git worktree repair` where the main
worktree is, in addition to also giving the paths to the secondary
worktrees as arguments (the latter of which is already supported). Now
that I'm thinking about it, I realize also that if invoked in the main
worktree, then `git worktree repair` can recognize that it is
operating in the main worktree (and infer the value of the new
command-line option for specifying location of the main worktree),
thus the user would only have to supply paths to the secondary
worktrees as arguments. My main concern with inferring too much
automatically is that the command could be used to hijack a worktree
belonging to another repository (but perhaps that's a case of "don't
do it if it hurts").

Of course, we could also get more fancy and provide some way to
specify path transformations. For instance, `git worktree repair
--map-path=/old/path:/new/path` might make it possible to repair links
in both directions by applying the path transformation to the paths
involved in the repair. However, this idea is barely germinated; it's
far less well thought out than the previous one.

[1]: https://lore.kernel.org/git/CAPig+cT-w6LV490MGNyG_ihWkSzdgfnEBrjQCsafjndTRmMgFA@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqlfi0qaru.fsf@gitster.c.googlers.com/
[3]: https://lore.kernel.org/git/CAPig+cT-ipENZQ39wpaGukRzx3d52OatKEXjWc3_mv56jMbDRg@mail.gmail.com/
