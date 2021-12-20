Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522DAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhLTP6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:58:33 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:46006 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhLTP6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:58:33 -0500
Received: by mail-pj1-f53.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so285384pjq.4
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvbJhFsFZaETaq1+2HQtEWqsEgSlAx8L5y+eyppnXOI=;
        b=KpjJpZqM+II2kXOcm05QADOJN3ANPTPu5ckZNrZoZ5QM5y2ql+u5lrU1FsalsWGVnu
         VHAMoAoYuTl++YXM9YwwlCr62eUdMVJL/41l7/u1zJb32mcwBMtxPXJOeACFElNmMFrH
         0qDagFQQ1CWU00GAjeq7sFnOP31w0Tm6SjO4OvI31hBPFFkXWDRwn5r9Zmf6IKA7h4Cy
         XiqtUJ6pUTw/QjmLqOnoUsDte+nG7dQAZ4BwzA6Riy+eA9jFYq+gHkBtjQ4bYSwrjK63
         5UquMN1Pk4vxYAnBBJA/SS4ynpo6psg2RfKrSenAg4l+H7d6qwTUNaPMJ9y63KprPZgm
         +6lw==
X-Gm-Message-State: AOAM530RuSQBj049G2g/X+1whtIUjILUGht50Ihqi38PdgbfqQ99U6a7
        7ZbWJmANQ6QVWeTwUjN+m3cERAu4FcO6U8uBWX8=
X-Google-Smtp-Source: ABdhPJxxaiuLAU5WpfgnlY6uoAApePQQUppL03xlxROpIRg1k+E9p3nC/KtZR0/Wx3Wki9QHYmelTS4X6gOyo4Ckwdo=
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr6624112pjb.236.1640015912396;
 Mon, 20 Dec 2021 07:58:32 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com> <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com>
In-Reply-To: <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 10:58:21 -0500
Message-ID: <CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Sean Allred <allred.sean@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <ttaylorr@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`On Mon, Dec 20, 2021 at 9:11 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/19/2021 7:58 PM, Eric Sunshine wrote:
> > On Sun, Dec 19, 2021 at 3:47 PM Sean Allred <allred.sean@gmail.com> wrote:
> >>> However, you missed the step (discussed in [1]) in which it is your
> >>> responsibility to move the `core.bare=true` setting from
> >>> git.git/config to git.git/worktree.config manually after setting
> >>> `extensions.worktreeconfig=true`.
>
> Thanks for this context of added responsibility. It seems a bit strange
> to require this, since it doesn't make any sense to have a bare worktree
> (at least not to me, feel free to elaborate on the need of such a
> situation).
>
> I think the most defensive thing to do would be to always special case
> core.bare to false when in a worktree. But if there is a reason to allow
> bare worktrees, then that isn't feasible.

I suppose one of Duy's motivations when adding worktree-specific
configuration -- and, importantly, configuration specific to the main
worktree -- was to get rid of the ugly special cases (such as
hard-coding overrides for `core.bare` and `core.worktree`) required by
the original (mis-)design. Importantly, those special-cases need to be
implemented by all third-party tools too, so it's not a winning
approach, whereas worktree-specific configuration gets by without
special cases and could easily be implemented by foreign tools. In the
long run, rather than re-introducing such overrides, a better solution
probably would be to make worktree-specific configuration the default,
but that's a decision for some other day.

> >> I think either the git-sparse-checkout-set command (or the
> >> git-checkout I ran after) would fail complaining that I was not in a
> >> worktree.
> >
> > It is indeed the `git sparse-checkout set` command which fails.
>
> Right, 'init' will set the sparse-checkout information in your worktree
> config and initialize it as needed, here:
>
>         if (upgrade_repository_format(1) < 0)
>                 die(_("unable to upgrade repository format to enable worktreeConfig"));
>         if (git_config_set_gently("extensions.worktreeConfig", "true")) {
>                 error(_("failed to set extensions.worktreeConfig setting"));
>                 return 1;
>         }
>
> So, we are manually specifying "put this in the config.worktree file"
> and not going through some "initialize worktree config" helper. Such
> a helper would be useful to avoid this issue in the future.

Yes, I was planning to suggest this in a follow-up message.
Specifically, I think top-level worktree.[hc] (not builtin/worktree.c)
should publish a function which enables worktree-specific
configuration _and_ does all the necessary bookkeeping, such as moving
`core.bare` and `core.worktree` from .git/config to
.git/worktree.config. That way, not only can git-sparse-checkout take
advantage of it, but so can any command which needs the functionality
in the future, as well as the fictitious "git worktree manage" command
I mentioned earlier if it ever materializes.

> >> I see two options for when to set `core.bare=false` in
> >> worktree-specific config:
> >>
> >>   1. At git-worktree-add: This is probably the earliest time which
> >>      makes sense, but may be over-reach.  I'm not up-to-speed on how
> >>      worktree-specific configs are generally considered on this list.
> >>      If I were implementing a workaround, though, this is probably
> >>      where I'd make it.
> >
> > My knee-jerk reaction is that applying a "fix" to `git worktree add`
> > to assign `core.bare=false` in the worktree-specific config may be
> > misguided, or at least feels too much like a band-aid. Although it's
> > true that that would address the problem for worktrees created after
> > `extensions.worktreeconfig=true` is set, it won't help
> > already-existing worktrees. This reason alone makes me hesitant to
> > endorse this approach.
>
> Yeah, my concern is that it requires the extension and could cause
> some tools to stop working immediately. If we have the extension
> already, it might make sense to initialize the file then.

I'm not following what you're saying. Initialize which file? When?

Anyhow, this does bring up a good point and it makes me wonder if
git-sparse-checkout (or whatever helper function is implemented)
should warn the user that setting this extension could break foreign
tools and that the repository format is being upgraded.

> >>   2. At git-sparse-checkout-init: This is where the problem begins to
> >>      have an effect, so this might also make sense.
> >
> > Yes, if I'm understanding everything correctly, this seems like the
> > best and most localized place to address the problem at this time. The
> > simple, but too minimal, approach would be for `git sparse-checkout
> > init` to simply add `core.bare=false` to the worktree-specific config,
> > however, this only addresses the immediate problem and still leaves
> > things broken in general for any non-sparse worktrees.
> >
> > So, the better and more correct approach, while still being localized
> > to `git sparse-checkout init` is for it to respect the documented
> > requirement and automatically move `core.bare` and `core.worktree`
> > from .git/config to .git/worktree.config if those keys exist. That
> > should leave everything in a nice Kosher state for all worktrees,
> > existing and newly-created.
>
> I agree that this is the only place that currently _writes_ to the
> worktree config. All other code paths that seem to care about the
> worktree config specifically only read from the config using a
> modified scope.
>
> My thought on the direction to go would be to extract some code
> from the set_config() in builtin/sparse-checkout.c into a config
> helper, say "ensure_worktree_config_exists()", that adds the
> extension, creates the file, and then adds core.bare=false.
>
> Even better, we could create a config helper that writes to the
> worktree config, and _that_ could ensure the config is set
> correctly before writing the requested value.

Please do not take the approach of setting `core.bare=false` in the
worktree-specific config file. As I mentioned in the quoted text just
above, that only resolves the problem for the worktree in question but
leaves all other potentially worktrees broken (both existing worktrees
and all new worktrees which are not being used for sparse checkout).
The _only_ correct thing to do, as far as I can see, is for the new
helper function to precisely implement the requirements as laid out by
git-worktree.txt: specifically, enable
`extensions.worktreeConfig=true` _and_ relocate `core.bare` and
`core.worktree` from .git/config to .git/worktree.config.
