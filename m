Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A0C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD83F20774
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgFIRfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:35:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIRfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 13:35:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id r15so3975375wmh.5
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 10:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/fseRN+ZXbWWtQCEPTbCFxQgVQDoLFCJSVNARi1cd8=;
        b=HE6Ju4zE6PZcY0pFt3857uRK8eJFn4E0XZR8snJxEh+vMKawzqXK8VoozMmcqz1zFl
         q9erZ5TPLz7l1jkbNYGgLcwp9wqEtDIeI9Y3TFkahYZmO4xVWg1BdV/UI1wiv/9pwrCa
         j+VobSacDiSnmONKY1bfxtiODKwJ/niJOIku1GKSnMyZL6h+OPjdJK8JHuXE3LVu/6TO
         fv2wGVm/Uc/U4+sBBrKHp5FRPnFMd6bzw6d492khtMT8zltUD4r4jSACYGX/r4VB60MH
         gWRKbu2wzmkqqGCKQkOFO0LbvPiN40FtICj7hi5kTJcT0WxDTB5SXHT0TjunxFkIDjU3
         xYtw==
X-Gm-Message-State: AOAM530yhtVfXleQuaD1lz3rPQuy/gCsTIDbi7YeTFXPFV9uOZqg+xSV
        4beaIaR1/NfryQK6FFKRP6w7xT8HtJSuezdN7NM=
X-Google-Smtp-Source: ABdhPJzFc8uf4ocq0UV4woEpiQ1JAN6X3lPfjBqmdLAtq5TdO4y3SMF3nwuSjE+36fLAPdhauFYDsTuE0xweVJ7IQ4k=
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr5047585wmg.130.1591724106824;
 Tue, 09 Jun 2020 10:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200608062356.40264-1-sunshine@sunshineco.com>
 <20200608062356.40264-3-sunshine@sunshineco.com> <xmqqzh9djlpb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh9djlpb.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Jun 2020 13:34:55 -0400
Message-ID: <CAPig+cRd1_U7MZ41LBcFSTaFGq_ENdY9JufV_jvwSX=AMV0NOQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] worktree: prune corrupted worktree even if locked
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 5:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The .git/worktrees/<id>/locked file created by "git worktree lock" is
> > intended to prevent a missing worktree -- which might reside on a
> > removable device or network share -- from being pruned. It is not meant
> > to prevent a corrupt worktree from being pruned, yet it short-circuits
> > almost all "git worktree prune" corruption checks.
>
> The '.git/worktrees/<id>/locked' file is what 'It' in "It is not
> meant to" refers to, but the 'it' in "yet it short-circuits" cannot
> refer to the same thing---my reading hiccuped there.
>
> "Its presence causes most of the corruption checks skipped by 'git
> worktree prune'", perhaps.

I can adopt that wording, but see below...

> > This can make it
> > impossible[1] to prune a worktree which becomes corrupt after the lock
> > is placed since "git worktree prune" won't prune it, and it may not even
> > be possible to unlock it with "git worktree unlock", depending upon the
> > nature of the corruption.
>
> The latter is because... "worktree unlock" does not skip corruption
> check and refuses to unlock a corrupted worktree, or something?

That bit of the commit message was a late addition and somewhat
intentionally hand-wavy. I don't think "git worktree unlock" will
currently die or misbehave due to corruption, but was thinking that it
someday might if additional checks are ever added. But, it's not
worth pursuing since...

> But the intent of locking a worktree is "make sure that the end user
> is aware of the fact that it is locked before allowing the worktree
> to be pruned", isn't it? Unless there is a way for a corruption to
> add the "locked" file the end-user did not intend to have, if we
> sense the "locked" file given to a worktree, shouldn't we honor that
> existing "locked" file's intent?
>
> I am growing skeptical about the approach taken by this step. There
> must be something missing that I may become aware of after reading
> the remainder of the series.

You're not the only person skeptical about this patch. I flip-flopped
on it multiple times, first convincing myself it was the right thing
to do, then convincing myself that the original code was correct, and
so forth. That's a good indication that such a change overall is
questionable.

Aside from that, this patch is unrelated to the intent of this series.
So, I'll drop it when I re-roll.
