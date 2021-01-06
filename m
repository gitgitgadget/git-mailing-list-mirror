Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A808C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 04:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108BE22D04
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 04:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbhAFEVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:21:08 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35849 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFEVH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 23:21:07 -0500
Received: by mail-ed1-f44.google.com with SMTP id b2so3205686edm.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 20:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDrwx771hWCZTzRebtDlXM8aI2i4djxB8YvvXoiTpXs=;
        b=eZWRsSwj31BBMG8iAMgPZwjz+/dR42KbPgEMkxnElb1RHPPHWbO9rhHinwdWCPCVWD
         IsS3uAhNH8Pvybyq04pKQZhOhu2LU/FBsYdHKSyZP/x34wigCP33VAZIrvGooMhnvZc+
         DczTTmUm5b7SIvVTlwh9bEU5J58FwC22PmmRsz4VcVfZ8QBLBG0iajDFX8eIHInJ1kHk
         vIeuLIlqKg5t4bIWHn6PGlJ6VcO54A4EjxIFqX+bcKH7FCGGSnTwlt4yPX1hfJXviZfk
         loiXjuc5/zth+nwzUBzBEXwe3P4O1qXgG6n8sbVGR4+YnrFGHG9mfvO8Jxun8COZ/cly
         81/A==
X-Gm-Message-State: AOAM531+DTF/mgFxUsFKpiAFEPJtFaKpD9rf92wwExWr1blQ4ld23Mq5
        2z5Rmtby7N383pwcubbcyczcUeTpZyE5IZ8C7G6byr4SZJk=
X-Google-Smtp-Source: ABdhPJyfoUwpeiODNEFryaPBzgdX17Y1iGQd6wyEi4MDHWYuzbghDU51+U0LUjJwlON11NroFqvPZf3K+Fnh0vJxWqU=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr2662450edc.89.1609906825145;
 Tue, 05 Jan 2021 20:20:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com> <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
In-Reply-To: <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jan 2021 23:20:14 -0500
Message-ID: <CAPig+cRGWzz5n_PZ=_OiHy2hkmeru3=fo2zX3_hnsEhnPq+giQ@mail.gmail.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 9:20 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 1/5/2021 12:55 PM, Eric Sunshine wrote:
> > On Tue, Jan 5, 2021 at 9:44 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > Probably not worth a re-roll, but the above has higher cognitive load than:
> >
> >     if (!value)
> >         return 0;
> >
> > which indicates clearly that the command succeeded, whereas `return
> > result` makes the reader scan all the code above the conditional to
> > figure out what values `result` could possibly hold.
>
> True. Looking at this again, it might be better to just update the
> loop to be
>
>         for (i = 0; values && i < values->nr; i++) {
>
> which would run the loop zero times when there are zero results.

I find the explicit `return 0` easier to reason about since I can see
immediately that it handles a particular boundary condition, after
which I no longer have to think about that condition as I continue
reading the code.

That said, I don't think it matters greatly one way or the other
whether you use `return result`, `return 0`, or adjust the loop
condition. It might matter if more functionality is added later, but
we don't have to worry about it now, and it's not worth re-rolling
just for this, or spending a lot of time discussing it.

> >> +       git for-each-repo --config=bogus.config -- these args would fail
> >
> > The `these args would fail` arguments add mystery to the test,
> > prompting the reader to wonder what exactly is going on: "Fail how?",
> > "Is it supposed to fail?". It might be less confusing to use something
> > more direct like `nonexistent` or `does not exist`.
>
> I guess the point is that if we actually did try running a subcommand
> on a repo (for instance, accidentally running it on the current repo)
> then the command would fail when running "git these args would fail".
>
> To me, "nonexistent" or "does not exist" doesn't adequately describe
> this (hypothetical) situation.
>
> Perhaps "fail-subcommand" might be better?

I had never even looked at git-for-each-repo before, so I took the
time to read the documentation and the source code before writing this
reply. Now that I understand what is supposed to happen, I might be
tempted to suggest `this-command-wont-be-run` as an argument, but
that's a mouthful. If you want to be really explicit that it should
fail if a bug gets re-introduced which causes the argument to be run
even though the config is empty, then perhaps use `false`:

    git for-each-repo --config=bogus.config -- false

By the way, when reading the documentation, some questions came to mind.

Is the behavior implemented by this patch desirable? That is, if the
user mistypes the name of the configuration variable, would it be
better to let the user know about the problem by returning an error
code rather than succeeding silently? Or do you foresee people
intentionally running the command against an empty config variable?
That might be legitimate in automation situations. If legitimate to
have an empty config, then would it be helpful to somehow distinguish
between an empty config variable and a non-existent one (assuming we
can even do that)?

Is the API of this command ideal? It feels odd to force the user to
specify required input via a command-line option rather than just as a
positional argument. In other words, since the config variable name is
mandatory, an alternative invocation format would be:

    git for-each-repo <config-var> <cmd>

Or do you foresee future enhancements expanding the ways in which the
repo list can be specified (such as from a file or stdin or directly
via the command-line), in which case the `--config` option makes
sense.
