Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD80C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A1722C9D
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394111AbhARTlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:41:37 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34584 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394021AbhARTlF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:41:05 -0500
Received: by mail-ed1-f42.google.com with SMTP id d22so7874016edy.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8r9NgPPTXn6ApMHK1EEJFZW1uDmT5JVlyKjeEYXqVE=;
        b=S+KtfTLYsF9OWrbxUMvfbgRHV2/8e1tcqg3ZNVfQIcUhs6JMA+BlLVtKuHx92ggJC9
         G/Sv9jF+9ec1rsrVERcVUIXYf7BqM1WNks7SsO+tfDrkj6uLWeCxg9My5hPCPkVQDexZ
         Gb9iI+eVFeopjAC8Mk0XV9cxcgwJuxHV/5xEu9ovkyLtTjUugGCJWXwkSX3T0v5i5Ri+
         8DI9HaFMG9u7fg3ioF6EG4E+EHlKifSipGIAC7VMc49Vk8q3Zm7PoOWI5goA9rNVPh7L
         40PN3jbZ9DorTiLZQBJUQxuHQfta6oLw1sj+oVxRxS5gZXfNQZ0aDI63fmeqibApbWEI
         CyUg==
X-Gm-Message-State: AOAM531SyZ1xE3/NtdrYQrZfaavfbQRqAyZ6tF3EjptAoPB2+AZ22vvq
        zkI/YHlkHXalt0FAJalBEVrTwaQ5851SY14b0n0LBnr5z2w=
X-Google-Smtp-Source: ABdhPJxoZvVO3AODelXXBUu2SupqZXwhYUZj4Anmskc7yzcT5jFoj/XupXsLZWgwMzWj9Ke1/eGwMiBNYWZn4wSTv/w=
X-Received: by 2002:a05:6402:40c4:: with SMTP id z4mr745856edb.233.1610998823028;
 Mon, 18 Jan 2021 11:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-7-rafaeloliveira.cs@gmail.com>
 <CAPig+cQ4jeSkOLb-Ski0G2tvafxh0Jjv+ObB7ZkbcryVYedGZQ@mail.gmail.com>
In-Reply-To: <CAPig+cQ4jeSkOLb-Ski0G2tvafxh0Jjv+ObB7ZkbcryVYedGZQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Jan 2021 14:40:12 -0500
Message-ID: <CAPig+cTGZPKSb6iJKM=sY22QirhEQX7+K08cGqru=Pp6m4QXxw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] worktree: teach `list` verbose mode
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 12:15 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
> > +test_expect_success '"list" all worktrees --verbose with locked' '
> > +       test_when_finished "rm -rf locked out actual expect && git worktree prune" &&
> > +       git worktree add locked --detach &&
> > +       git worktree lock locked --reason "with reason" &&
> > +       test_when_finished "git worktree unlock locked" &&
> > +       echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
> > +       printf "\tlocked: with reason\n" >>expect &&
> > +       git worktree list --verbose >out &&
> > +       sed -n "s/  */ /g;/\/locked  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
> > +       test_cmp actual expect
> > +'
>
> At first, I wondered if we would also want this test to have a
> locked-no-reason worktree to ensure that its `locked` annotation stays
> on the same line as the worktree, but that's not needed because that
> case is already covered by the existing test. Fine.

Erm, I think what I said is wrong. There is no existing test to show
that `locked` without a reason stays on the same line as the worktree
in --verbose mode. So having a locked-no-reason worktree in this test
could be beneficial.
