Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182BCC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 21:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355981AbhLBVD7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 2 Dec 2021 16:03:59 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45808 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhLBVD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 16:03:57 -0500
Received: by mail-pf1-f174.google.com with SMTP id x131so729983pfc.12
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 13:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/t26Rcy+DIHchJewj1XjgHmqKt1vfdLxYsNM+1Nga8k=;
        b=4SUDWIzFzV6rWOlyevJYRSDmUtfVdyNKBfmFhChmRWvcrjnkErs2uKxzKfZuM+AlGM
         KrxATcgYTIaH1kOvKsE7jd0ZvzkwQ3+aLoHAFuAx3Xbo64ShQvd4xFmF4rRIIQq+ToTs
         FsYmTnSm7yVWOrLPtSjv079jdEiH50UCTt2MEhsHvUnXQzin6UUvrBjjYVF67OeXJl3B
         goYYguAZEwE7erYJL0mkIYjQzMVvOyr3acmVsT20R2zgYxow7zvOYXmJX9ZFEGD8LxJB
         zCfxoC2tKimPbN4FpJ7S3lg/+ZQM7+Hb39lhfJpx6oMsW30NiMYkvdVIMiflHYfHv9DY
         H9aw==
X-Gm-Message-State: AOAM531Vub5Pb5czbw9yPP+pbUVIB2ubrxAhG4gmwutKJ54mbMUtBvN1
        UaF9alM2iyVOnPvXWNhSyiH/VZNgYqnJMeS3YiY=
X-Google-Smtp-Source: ABdhPJzZvveT4IzWZ7ZT4mZLZyhUyQzyp+svacUa8TP20Lm97w+QHuSPOboMZS0X9Bs7HUzzENyrTebRVqZffwe1TBk=
X-Received: by 2002:a65:4d4b:: with SMTP id j11mr1235631pgt.181.1638478834705;
 Thu, 02 Dec 2021 13:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-5-andersk@mit.edu>
 <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com>
 <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu> <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
 <alpine.DEB.2.21.999.2112020357510.14727@scrubbing-bubbles.mit.edu>
In-Reply-To: <alpine.DEB.2.21.999.2112020357510.14727@scrubbing-bubbles.mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Dec 2021 16:00:23 -0500
Message-ID: <CAPig+cS9n91nstp0zK-JywK3WHOVZ38+Ok850=aajx+hL4T2ZQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 2, 2021 at 4:07 AM Anders Kaseorg <andersk@mit.edu> wrote:
> On Wed, 1 Dec 2021, Eric Sunshine wrote:
> > If we instead hoist ownership of `worktrees` up to execute_commands()
> > -- which calls execute_commands_atomic() or
> > execute_commands_non_atomic() -- then we can get by with retrieving
> > the worktrees just once, and all those noise changes in update() can
> > be dropped since it will no longer be responsible for allocating or
> > freeing `worktrees`.
>
> Seems reasonable to me.  It’s a smaller textual change, potentially a
> larger conceptual change, but the efficiency improvement is probably
> worthwhile.
>
> That would modify patch 4 to the below.  Patches 5 through 8 cleanly
> rebase past this modification.

Yes, this version looks good. Thanks for accommodating my suggestion.
Not only does it make for a less noisy diff (which is pleasing), but
perhaps more importantly, it reduces cognitive load a small amount (at
least for me[1]).

> Subject: [PATCH v7½ 4/8] worktree: simplify find_shared_symref() memory ownership model

I suspect that Junio will find it easier to take a full re-roll than
dealing with a single patch replacement since he doesn't necessarily
follow these discussions closely. It's more likely that he'll pick up
this change if you post v8 in its entirety.

[1]: Although we regularly use `goto` for this sort of resource
cleanup, most such functions are much shorter than the one here;
somehow the length of this function made the new `goto`s a tiny bit
less easy to grasp-at-a-glance. Purely subjective, I know.
