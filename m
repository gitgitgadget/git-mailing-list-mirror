Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E6C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 06:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A405320786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 06:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgH0F5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:57:02 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:42331 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgH0F5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 01:57:00 -0400
Received: by mail-ej1-f65.google.com with SMTP id j25so6004653ejk.9
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 22:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRbT1fxxA/NHwiAarsbsyaS0HKzyJfx89gbbhWC1IUo=;
        b=Us/u2PKVBYHrpw4VwT8gHP74o9uMb6ArchMdYauBqzd75scRb0+8YR01Cpp+8jnh2g
         Lqq+QQIyUzh7qt11T7zlec9V1N8n2WZzfKTXWcHaWK73jGSPWpPbDQv59KsExnd/e3FL
         Zht7gvZCG07ug3JCYUvUdCQAaKNAWvNQ3SFm2Ctro/lqhZ6tkXdklL2Zc6reCNU1LC6E
         6o4oQdEF5fe/uf7mFujgLhCfqzkpO3c84q+D3tqqCueRqRSGPJZ3NBmxb80HLxYMCjxk
         4fBvzvDJbahiyyQLAa/I+0Ex5xwKcTPZaIAUdLYCKFAgqGfuFKsK9wTNOT95/jsTwUE1
         Cs3A==
X-Gm-Message-State: AOAM5316qR2WoMe0WKo9zrXMqO1+4nNIlihfMRYQY6ETk8BsgP/s6xrS
        OI850I/4Q9wuAPYfvr5fsFVmY7Mby8AilFCpbEE=
X-Google-Smtp-Source: ABdhPJyEFtR1CEVBgQAxKgV/1Ff1d7p+Vp7k/2+Rra3twIqzrobq/8mwyfgUCxWm32rxCxjHtasYfFU5gDWVjYtBoTM=
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr18681014ejx.311.1598507818380;
 Wed, 26 Aug 2020 22:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com> <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com> <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqmu2ht58g.fsf_-_@gitster.c.googlers.com> <20200827042157.GC3346457@coredump.intra.peff.net>
 <CAPig+cS1uMw6YDVjzb8FbBmC=iVjged-wHu0LF2+trmW-4ZfVw@mail.gmail.com>
 <20200827044420.GA3360616@coredump.intra.peff.net> <CAPig+cSA56xgNN0WP4t+YoyNU8fGf5eaz__=4Vh+s=He-tG=DA@mail.gmail.com>
 <20200827052504.GA3360984@coredump.intra.peff.net>
In-Reply-To: <20200827052504.GA3360984@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 01:56:47 -0400
Message-ID: <CAPig+cQxvq3MzyB3e8-ZeVSdCot04=9p4L8CZRnpYbrmnR70_g@mail.gmail.com>
Subject: Re: [PATCH] worktree: fix leak in check_clean_worktree()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 1:25 AM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 27, 2020 at 01:03:43AM -0400, Eric Sunshine wrote:
> > Right. I wonder why the author of 7f44e3d1de (worktree: make setup of
> > new HEAD distinct from worktree population, 2015-07-17) chose to clear
> > cp.args manually like that.
>
> I wondered if we might not have cleared the array automatically back
> then, but it looks like we did.

I had the same thought and came to the same conclusion. It's possible
that the manual clearing of the array was leftover cruft as the
implementation matured before the patch was submitted. I have a vague
(perhaps false) recollection that a local argv_array was populated and
assigned to cp.argv originally, until cp.args was discovered as a
cleaner alternative and used instead. If that was the case, then the
local argv_array wouldn't have been cleared automatically by
run_command(), which would account for clearing it manually.

> I do think this kind of child_process struct reuse is slightly sketchy
> in general. Looking at child_process_clear(), we only free the memory,
> but leave other fields set. And in fact we rely on that here; git_cmd
> needs to remain set for both commands to work. But if the first command
> had used, say, cp.in, then we'd be left with a bogus descriptor.

Agreed. The current usage in worktree.c is a bit too familiar with the
current internal implementation of run_command(). Reinitializing the
child_process struct or using a separate one would be a good cleanup.

> -- >8 --
> Subject: [PATCH] worktree: fix leak in check_clean_worktree()
>
> We allocate a child_env strvec but never free its memory. Instead, let's
> just use the strvec that our child_process struct provides, which is
> cleaned up automatically when we run the command.
>
> And while we're moving the initialization of the child_process around,
> let's switch it to use the official init function (zero-initializing it
> works OK, since strvec is happy enough with that, but it sets a bad
> example).

The various memset()'s in worktree.c seem to have been inherited (and
multiplied) from Duy's original "git checkout --to" implementation
(which later became the basis for "git worktree add" after which it
mutated significantly), and "git checkout --to" predates introduction
of child_process_init().

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -924,7 +924,6 @@ static int move_worktree(int ac, const char **av, const char *prefix)
> -       struct strvec child_env = STRVEC_INIT;
> @@ -935,15 +934,14 @@ static void check_clean_worktree(struct worktree *wt,
> -       strvec_pushf(&child_env, "%s=%s/.git",
> +       child_process_init(&cp);
> +       strvec_pushf(&cp.env_array, "%s=%s/.git",
>                      GIT_DIR_ENVIRONMENT, wt->path);
> -       strvec_pushf(&child_env, "%s=%s",
> +       strvec_pushf(&cp.env_array, "%s=%s",
>                      GIT_WORK_TREE_ENVIRONMENT, wt->path);
> -       memset(&cp, 0, sizeof(cp));
> -       cp.env = child_env.v;

Looks good to me. For what it's worth:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
