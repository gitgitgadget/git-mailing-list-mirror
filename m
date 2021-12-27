Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C04C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 07:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhL0He3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 02:34:29 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:55847 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhL0He3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 02:34:29 -0500
Received: by mail-pj1-f49.google.com with SMTP id iy13so12788809pjb.5
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 23:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAvTXUZ2MMVgjxQ+JD/6xssGbkbr5MkgJOB3Oj1BG9s=;
        b=sNHsCpY9NKgyjG90Xu/OThQK1uTvw2fg9oMliOZfjofkyE/7c4mrlqkWBnInOi+Y5S
         nqeYi1GGCJQ9n+CEw66TnP1s6UgtF1jv+O9M8xpdyaJlS7T1yuXAIjBK+cOQn39VxWtz
         w1yaLiBU2vYUnPhZjSKlBiFivsT5LqJt8xr4TBR5llyXXCQxZarI4Ub9tNnwCrvJf9Cx
         /JZK/y8X8F1pQlCCSfhUIbTF8Xx7moapdoN0Lde2rphQrKGGJhRGmGeaj/UBnLfs4s9k
         200E7FOZbp9P9ASJfBsfnN69PrA+KmwFsQx4nFJnJ2tU1ThpR7ZEqZF9LNx4Wezl29RZ
         PJSg==
X-Gm-Message-State: AOAM532W2Nmqa879xErWDFVWezwWKkfc7ZntXYaTFdSxWZo9ePzeEGBn
        eaFMM8bRr5IqJMgAJab69hnnQVkCMSmWBGponK0=
X-Google-Smtp-Source: ABdhPJzdJ7vU7qvh+4wKe2I5jNf3/c7Secd+5lfdHFbafFtcqysB2+I2d8LwcShLsBgoL3/hgE/oKjPhkYgBeoo0p48=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr16406047plh.35.1640590468695; Sun, 26
 Dec 2021 23:34:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
In-Reply-To: <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Dec 2021 02:34:17 -0500
Message-ID: <CAPig+cQjYiARBwSZTsswk442TvDC2UiyOx5wNdRwF6C7i8ENxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 2:15 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 22, 2021 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> > I think that "git
> > worktree add" should check if either core.bare is false or
> > core.worktree is set, and if so then set extensions.worktreeConfig and
> > migrate the relevant config.
>
> Similar to my response to Sean in [1] and to Stolee in [2], while this
> may help the situation for worktrees created _after_
> `extensions.worktreeConfig` is enabled, it does _not_ help existing
> worktrees at all. For this reason, in my opinion, `git worktree add`
> is simply not the correct place to be addressing this problem, and
> it's why I suggested a separate command for enabling the feature and
> doing all the necessary bookkeeping. It's also why I suggested[2] that
> in the long run, we may want per-worktree config to be the default
> (and only) behavior rather than the current (legacy) behavior of all
> config being shared between worktrees.

Thinking upon it further, I take back what I said about it not helping
existing worktrees.

Your proposal is _almost_ the same as my suggestion of eventually
making per-worktree config the default. The difference is that you're
only making it the default if `core.bare=true` or `core.worktree` is
set. But do we need that distinction? If people are comfortable with
that, then are they comfortable with simply flipping the switch and
making per-worktree config the default today regardless of `core.bare`
and `core.worktree`?

I'm not sure that I'm comfortable with it due to the potential of
breaking older versions of git which don't understand
`extensions.worktreeConfig`, as well as breaking third-party tools,
but maybe other people feel differently?
