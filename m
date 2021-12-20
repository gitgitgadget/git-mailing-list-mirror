Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8BC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 21:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhLTV61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 16:58:27 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35737 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhLTV60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 16:58:26 -0500
Received: by mail-pj1-f50.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso555330pji.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 13:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZtknDGbNaUG5sOqm1NDrE6JxCgCVqBln3PJJZwGsJI=;
        b=vbq030xwsrtvKpG9BTQ9ncUjPLSwZ4wD6IbdPMJbn6iG2eU8xc/AMY+eO8xoaKJxwq
         Abspy0SZjQB91mpj+blYOFOk1737DQUWajPYuzTuj7GtJNVdmZOpkosp/JUwj72veYj8
         ewwnZHCC2hxC064swMh0UenF/WBIsegZosSbMI7PfRGHqE76c+CHCcr3kXXOqHainmdg
         z+kqbRBOKOfiPpwYXqgtAlpmdjoud4EGhypZt18XBlsyzpC+99dgDa6XfOnJlrh9hiWb
         Aiy7s5Iw/M636dv1V/zxRrmEqjl0zehjNiiyWXot3JB/aRWZIH/5TnhX/OfXpiv4jZZt
         0Oxg==
X-Gm-Message-State: AOAM530VadvXo0f13a6CWL10T53jIpndQtMOEFkCgT35FCIMhI0vGu6M
        fk9JlS6ucfh/ytmlF6gaiN54jgEL5BP3RI89I3VHI3vhkyG0RQ==
X-Google-Smtp-Source: ABdhPJwEK0gmypL3692OrHkFbVAEBj3LfDYny/K6BcqKVCSDrkml5xm8W/gSfH5a3GcrcJyQ+mKcdr/fUpc8XH9FKVI=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr19154333plh.35.1640037506108; Mon, 20
 Dec 2021 13:58:26 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
 <f39af047-d244-14be-4cd8-b6c3199545f3@gmail.com> <CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com>
 <0f98d3e5-f2c2-526a-0476-a89778e5b2b5@gmail.com>
In-Reply-To: <0f98d3e5-f2c2-526a-0476-a89778e5b2b5@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 16:58:15 -0500
Message-ID: <CAPig+cTzshfTeNDEbGTaCvZCAjnH-mmzi0i67Wu169wXG2XN2w@mail.gmail.com>
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

On Mon, Dec 20, 2021 at 12:29 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/20/2021 10:58 AM, Eric Sunshine wrote:
> > `On Mon, Dec 20, 2021 at 9:11 AM Derrick Stolee <stolee@gmail.com> wrote:
> >> So, we are manually specifying "put this in the config.worktree file"
> >> and not going through some "initialize worktree config" helper. Such
> >> a helper would be useful to avoid this issue in the future.
> >
> > Yes, I was planning to suggest this in a follow-up message.
> > Specifically, I think top-level worktree.[hc] (not builtin/worktree.c)
> > should publish a function which enables worktree-specific
> > configuration _and_ does all the necessary bookkeeping, such as moving
> > `core.bare` and `core.worktree` from .git/config to
> > .git/worktree.config. That way, not only can git-sparse-checkout take
> > advantage of it, but so can any command which needs the functionality
> > in the future, as well as the fictitious "git worktree manage" command
> > I mentioned earlier if it ever materializes.
>
> Ah. I put my change in config.[hc], but let's discuss that in the
> patch series [1].

My concern and sole reason for bringing it up is that this new
function (which should be generally useful) should not end up in
builtin/sparse-checkout.c. I had suggested worktree.c because its
functionality is closely related to worktrees, however, since config.c
has intimate knowledge of the location of worktree configuration, that
also is a reasonable home for the new function. Either location should
be fine; I don't feel strongly either way and don't think it needs a
lot (or any) discussion.
