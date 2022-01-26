Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97DC5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiAZAcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:32:46 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35705 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiAZAci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:32:38 -0500
Received: by mail-pf1-f180.google.com with SMTP id u130so16966026pfc.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX0pwMoatIyTnbdGn6Rx8ujxbY6eTEowGePpP/1SQeg=;
        b=iPMk1tNsU3Un0HRZqecmiiZjp55v2h8EYpZMtclWnNlt7QqoOTk1fN3sHsaBe3i3Cj
         OHzWznCZEUQV+Cv9GAMn2betShJPMiv6bDliUKRQM8jVQTu8WabMMXupLWd/5F6Wg1n3
         63YDLVeEeg0PjvgF4pvvw8EoAIK5mEDADAYqDA1i3O/5XJBOPMcCdFmsPwkh2OG7qXbJ
         kqwtxPr32HYTG/PJUCpLP711f90kheXn19dCuNMJl3CPbcGDbVNKcle4nXMF654BVVdZ
         txVndt71q3XB5jYuFMDFmLDFXpCRBm6/ntiR2KEX6eBsg5TJS6Uj/OL4XHdPguW9AzJS
         cVOQ==
X-Gm-Message-State: AOAM530a3zk53NCChRwNwMzQ2MNZDX9D4npaZhUIfH8K1rh3Zv7npN02
        OO5CF4VeFE5yY6PVKxevQjguqsQxpLEj6gIqFJE=
X-Google-Smtp-Source: ABdhPJz8KSmIGWKuQX64YZx+CnfqUkKX+L0NsZ8o4clemKWOXOL2AwsbAW+uodnO8jMwxOiTk387BWvDNzKaBkuYaPA=
X-Received: by 2002:aa7:8d02:0:b0:4c1:b464:9826 with SMTP id
 j2-20020aa78d02000000b004c1b4649826mr20712895pfe.67.1643157158106; Tue, 25
 Jan 2022 16:32:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
In-Reply-To: <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 25 Jan 2022 19:32:27 -0500
Message-ID: <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 6:59 PM Elijah Newren <newren@gmail.com> wrote:
> On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
> > This commit (which is already in master) introduces a bug that breaks
> > rebase when rebasing inside a subdirectory of a worktree. You can see
> > that the below test fails with:
>
> There's nothing wrong with running checkout from a subdirectory.  It
> is unfortunate that setup.c auto-discovers both the git directory and
> the working tree, but sets GIT_DIR without setting GIT_WORK_TREE in
> the case of a non-main worktree; it's not particularly friendly for
> subcommands.  Of course, it's also unfortunate that sequencer still
> forks subprocesses other than those requested by a user with e.g.
> --exec.
>
> But, anyway, I've got a patch that I'll send as soon as it passes CI
> (https://github.com/git/git/pull/1205).
>
> > +test_expect_success 'rebase when inside worktree subdirectory' '
> > +       git init main-wt &&
> > +       (
> > +               cd main-wt &&
> > +               git commit --allow-empty -m "initial" &&
> > +               # create commit with foo/bar/baz
> > +               mkdir -p foo/bar &&
> > +               touch foo/bar/baz &&
> > +               git add foo/bar/baz &&
> > +               git commit -m "add foo/bar/baz" &&
> > +               # create commit with a/b/c
> > +               mkdir -p a/b &&
> > +               touch a/b/c &&
> > +               git add a/b/c &&
> > +               git commit -m "add a/b/c" &&
> > +               # create another branch for our other worktree
> > +               git branch other &&
> > +               git worktree add ../other-wt other &&
> > +               (
> > +                       cd ../other-wt &&
> > +                       mkdir -p random/dir &&
> > +                       (
> > +                               cd random/dir &&
> > +                               git rebase --onto HEAD^^ HEAD^  # drops the HEAD^ commit
> > +                       )
> > +               )
> > +       )
> > +'

This is entirely minor, but all the inner subshells in this test are
superfluous. The outermost (...) will ensure that the working
directory is restored regardless of whether anything within its body
fails, no matter how much you `cd` around. Thus, all the inner
subshells could be dropped.

An alternative would be to close the outermost subshell immediately
after `git worktree add`:

    git init main-wt &&
    (
        cd main-wt &&
        ...
        git worktree add ../other-wt other
    ) &&
    mkdir -p other-wt/random/dir &&
    (
        cd other-wt/random/dir &&
        ...
    )

however, that may not buy you any clarity.
