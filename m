Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D10C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C67620789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 07:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgI3HfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:35:20 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38822 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 03:35:19 -0400
Received: by mail-ej1-f67.google.com with SMTP id dd13so1352494ejb.5
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4eqmn6/0neGvY4iIr28qdd0gEPt7rf4u6b1nctFzOA=;
        b=OHVJYMtHgSY4bii+lqHycyVdVp33cmUii9nld4w0TUoT/cvDhouLNZ9HVSx7TfUjfU
         PXpmMph6uzgJSynMwwTVbsPpNuzVuGFtDMHH0jT5uIn/i2c8/isWHeMHKpjM2H7mwHIl
         F9IL0xNW2zDiTTTH+rlYvb5Mhmbqxn4qWG3/6XEiAQNj35ZTa2d43hymeX/7UIKU5n1f
         0tO/GC0C2pFdZgNGFgH9jubenzlSxCLUGdtvXuGn1HaqZvLqOFUOijXFuPmgcrej0h/e
         u9X4jar8SjjdoT5r100MWx1u+UclRra7+fPKc59NnxkTphXI+44S/YbQHQVstgvHZxQv
         Tscg==
X-Gm-Message-State: AOAM533ur7KMsqOohHosKD1YfTuyO3yShKmhysUZjdTB/7R9E6dXO7tY
        pGohMNQk//ayMbO8A34ejYsP/jfnOJrEuwZuSnw=
X-Google-Smtp-Source: ABdhPJwMcbvAqlFpTueJziITR9Z+qKAyw64teNHEtlYImU/lNJrjhS/vVqnaceXSLx0/LKSc+sXW3nvyVfk6wNYvqJE=
X-Received: by 2002:a17:906:50e:: with SMTP id j14mr559202eja.138.1601451317940;
 Wed, 30 Sep 2020 00:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20200928154953.30396-2-rafaeloliveira.cs@gmail.com> <xmqq8sctlgzx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sctlgzx.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 Sep 2020 03:35:07 -0400
Message-ID: <CAPig+cQHDuWy1vc_ngXbMQZQ=a9fd6S5_cCU-2sb_+Te5aEOhw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] worktree: teach `list` to mark locked worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 5:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> Rafael Silva <rafaeloliveira.cs@gmail.com> writes:
> > The output of `worktree list` command is extended to mark a locked
> > worktree with `(locked)` text. This is used to communicate to the
> > user that a linked worktree is locked instead of learning only when
> > attempting to remove it.
>
> For this change, it might look like this:
>
>     The "git worktree list" shows the absolute path to the working
>     tree, the commit that is checked out and the name of the branch.
>     It is not immediately obvious which of the worktrees, if any,
>     are locked.
>
>     "git worktree remove" refuses to remove a locked worktree with
>     an error message.  If "git worktree list" told which worktrees
>     are locked in its output, the user would not even attempt to
>     remove such a worktree.

Nicely written. I might end the final sentence like this:

    ... the user would not even attempt to remove such a worktree or
    would know to use `git worktree remove -f -f <path>`.

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -676,8 +676,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
> > +     if (!is_main_worktree(wt) &&
> > +         worktree_lock_reason(wt))
> > +             strbuf_addstr(&sb, " (locked)");
>
> Is this because for the primary worktree, worktree_lock_reason()
> will always yield true?
>
>     ... goes and looks ...
>
> Ah, OK, the callers are not even allowed to ask the question on the
> primary one.  That's a bit strange API but OK.

That is indeed a slightly hostile API, and it wouldn't hurt to change
it simply to return 'false' for the main worktree, but that's not
something this patch series need tackle.
