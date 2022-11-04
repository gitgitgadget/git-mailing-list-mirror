Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F85C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 05:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDFDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDFDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 01:03:32 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39D25C3
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 22:03:30 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id r2so2108813ilg.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 22:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0B+i/O4axxKCz9ccisavJsC88J5io5z3I9EtYtMbCQ=;
        b=VAjlbMPypWrYHBAMyKZcLo9MWWv5xFdidUMzKEv3iYmNb2Gt21prCEEFLEBeppMAPr
         hhBHNLK7LSgWpYfHD0vAihnNw9PG97dTp1LzgM9T6C+soT6kQz9UqO5lI2kBeggEylTH
         jIpvY8dv+4a2dEEfQVfMI8D335oTQLdI60/2aTgMDiVDy+KwVClq9tR0Se0ceru2L70W
         PXz628kH7pmgxOfTZDxCcMQZSlnL32xnvNVZLrPVWoEEuNaqdOVMRAo/9XNlbbx1UBiY
         /Miwi0XlMkWE+OTu/ypxufFq1i0EHz2rL1JCHWIV5BYmoYxss1ePb66ghxdq+/flh1dU
         AuVQ==
X-Gm-Message-State: ACrzQf0uqYzsPllb/f4sgCgcaAxBfuq3qkpWfOHYhjcf996mrnbtD75Q
        59EgznukjWv2rRMkQ+pF7vCqDmbudVUqJ09ceLp+mLshDCM=
X-Google-Smtp-Source: AMsMyM5F7Z/I/WuyJtRfym8bUoJ/kn+YA7xTbygiCLVR3NDM8w/2ygKDL6nyAqLhO69q7zJNw29CGkR+K0HCog1/Khg=
X-Received: by 2002:a92:d2c2:0:b0:2f9:4023:d5e9 with SMTP id
 w2-20020a92d2c2000000b002f94023d5e9mr240726ilg.249.1667538209698; Thu, 03 Nov
 2022 22:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-4-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-4-jacobabel@nullpo.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Nov 2022 01:03:18 -0400
Message-ID: <CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcdLCU5svw@mail.gmail.com>
Subject: Re: [PATCH 3/4] worktree add: add --orphan flag
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 3, 2022 at 9:07 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> Adds support for creating an orphan branch when adding a new worktree.
> This functionality is equivalent to git checkout's --orphan flag.
> [...]
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -95,6 +95,17 @@ exist, a new branch based on `HEAD` is automatically created as if
> +------------
> +$ git worktree add --orphan <branch> <path> [<commit-ish>]
> +------------
> ++
> +Create a worktree containing an orphan branch named `<branch>` based
> +on `<commit-ish>`. If `<commit-ish>` is not specified, the new orphan branch
> +will be created based on `HEAD`.
> ++
> +Note that unlike with `-b` or `-B`, this operation will succeed even if
> +`<commit-ish>` is a branch that is currently checked out somewhere else.

Are we sure we want to be modeling this after `git checkout --orphan`?
If I understand correctly, that option has long been considered (by
some) too clunky, which is why `git switch --orphan` was simplified to
accept only a branch name but no commit-ish, and to start the orphan
branch with an empty directory. My own feeling is that modeling it
after `git switch --orphan` is probably the way to go...

> @@ -222,6 +233,11 @@ This can also be set up as the default behaviour by using the
> +--orphan <new-branch>::
> +       With `add`, create a new orphan branch named `<new-branch>` in the new
> +       worktree based on `<commit-ish>`. If `<commit-ish>` is omitted, it
> +       defaults to `HEAD`.

...which would mean that this would no longer talk about `<commit-ish>`.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -608,33 +613,52 @@ static int add(int ac, const char **av, const char *prefix)
>         struct option options[] = {
> +               OPT_STRING(0, "orphan", &opts.orphan_branch, N_("branch"),
> +                          N_("create a new unparented branch")),

The short help message for `git switch --orphan` and `git checkout
--orphan` say simply "new unparented branch", so this message should
probably follow suit (or consistency and to ease the job of
translators).

> -       if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
> -               die(_("options '%s', '%s', and '%s' cannot be used together"), "-b", "-B", "--detach");
> +               die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
> +                   "-b", "-B", "--orphan", "--detach");

Good to see this interlock updated for --orphan.

> +       if (opts.orphan_branch && opt_track)
> +               die(_("'%s' cannot be used with '%s'"), "--orphan", "--track");
> +       if (opts.orphan_branch && !opts.checkout)
> +               die(_("'%s' cannot be used with '%s'"), "--orphan",
> +                   "--no-checkout");

Good to have these additional interlocks. I think, however, for the
sake of translators, we should use the same terminology as the
existing message above (i.e. "options ... cannot be used together").

> +       /*
> +        * From here on, new_branch will contain the branch to be checked out,
> +        * and new_branch_force and opts.orphan_branch will tell us which one of
> +        * -b/-B/--orphan is being used.
> +        */

This can probably be worded a bit differently to make it clear that
from this point onward, those other variables are interpreted as if
they are booleans. Moreover, we can make this even clearer by
following the example of -B in which (by necessity due to
parse-options) the local variable in add() is a `const char *`, but
its counterpart in `struct add_opts` is a boolean (int).
