Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B60C433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10E42070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgFJRSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:18:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43816 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbgFJRSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:18:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so3152512wrr.10
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LMQsZpDYBg8IM2tawVcSNE4mF+4MOlJ+O+H14cmfx8=;
        b=TePSIGdCO06Ht5BFAdl3Q49coXkbK7WI/Jx+jfUuD+v7YPZZUXqoF/vjgTtLfmacmQ
         L1XpkExcsEYOX002F9L8dpRxtNZFmoLXgnax8VJJN81ycIle4suCNkgYuBxGrKZufYNv
         /QgHWljwfEOISk+8o5QQDYKTYtPLRw8OPoKpLB1hybQ5f4LhxqkPPqgMLmdzB0TtDGYx
         Ze7q/R/cxiImRwNaiQ+AoUFYmKzpcapxvrkiLJW80NFhP/9wXllr6k1VDfisbTnuG8P1
         +0lQmyfmRtX9t55e1bXiFN/YoCV2jB/glKdzp8+y6N7Gh2mg6VO38wUC5gDVadFuqOAP
         5hVw==
X-Gm-Message-State: AOAM530C80z3aegndBZEJK+iCg6CzucFEFRlzLLn5LlAegTq/PGi2dXM
        vMMQU9g7WrFgaAvSze5b6ElyrfJtaN1xiQxCf7M=
X-Google-Smtp-Source: ABdhPJxaNDm/l42Ik42NlaehBEN+EGled9aYZOYmFVe9RWn7iE+i/AQ8RpXRLdsZyj3QbcWJXu+QlpKYY/D1KQ4NjlU=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr5147515wrw.277.1591809525312;
 Wed, 10 Jun 2020 10:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200610063049.74666-1-sunshine@sunshineco.com>
 <20200610063049.74666-7-sunshine@sunshineco.com> <20200610171153.GA39055@konoha>
In-Reply-To: <20200610171153.GA39055@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Jun 2020 13:18:34 -0400
Message-ID: <CAPig+cSLwPmDbk8Wjqb06OrNGHfmTLDOHjs88C+q1FhLGqLrrQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] worktree: generalize candidate worktree path validation
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 1:12 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> On 10/06 02:30, Eric Sunshine wrote:
> > "git worktree add" checks that the specified path is a valid location
> > for a new worktree by ensuring that the path does not already exist and
> > is not already registered to another worktree (a path can be registered
> > but missing, for instance, if it resides on removable media). Since "git
> > worktree add" is not the only command which should perform such
> > validation ("git worktree move" ought to also), generalize the the
> > validation function for use by other callers, as well.
>
> There is an extra 'the' after generalize.

Thanks for noticing. I'll fix it if I re-roll, otherwise it can stay
(unless Junio happens to fix it when queuing).

> >    if (!wt)
> > -       goto done;
> > +       return;
>
> Should we do a 'return 1' on failure instead of just a blank 'return' so
> that we can denote failure of finding a worktree?

This function is declared as returning 'void', so we can't "return 1".
The function instead signals a problem by die()'ing.

Changing it to return a success or failure result rather than dying is
a different matter which can be done later if someone wants to do so,
but is outside the scope of this patch series which is only making the
minimal necessary changes to adapt the function for wider use.

> > -       die(_("'%s' is a missing but locked worktree;\nuse 'add -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path);
> > +       die(_("'%s' is a missing but locked worktree;\nuse '%s -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), cmd, path);
>
> Let's wrap this to 72 characters at maximum per line maybe? Meaning that
> the error message gets split into 2 lines.

I'm not sure what you want to see wrapped; the warning message itself
or the source code line? As for the warning message, it already is
wrapped (see the embedded "\n").

At any rate, this patch makes the minimal change necessary to meet the
goal of making the function re-usable. Anything beyond that (such as
wrapping long lines) is outside the scope of the patch and would make
it harder to reason about the changes. Wrapping the line is certainly
something that someone can do later as a follow-up, but is not the
goal of this series.

> > -   validate_worktree_add(path, opts);
> > +   worktrees = get_worktrees(0);
> > +   check_candidate_path(path, opts->force, worktrees, "add");
> > +   free_worktrees(worktrees);
> > +   worktrees = NULL;
>
> It is necessary to call 'free_worktrees(worktrees)' at the end? The
> 'get_worktrees()' states that
>   The caller is responsible for freeing the memory from the returned
>   worktree(s).

This code _does_ call free_worktrees() as it should, so I'm not sure
what you're asking or saying. (Perhaps you're confusing "caller" and
"callee"?)
