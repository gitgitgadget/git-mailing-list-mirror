Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C0C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 06:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A7861185
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 06:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhGFGWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 02:22:34 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:36551 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGFGWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 02:22:34 -0400
Received: by mail-ej1-f47.google.com with SMTP id nd37so32354816ejc.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 23:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNPT0QDJQ7jmAY275gez/0/O0bf/0/f/eDitsw+hNaA=;
        b=UQ7y6VoL5titpMXKK7undlqe0+IP6AlrPsO+plu6ucPx/S4F87raH/ejj+uOFYeUcT
         heCjEjZJkLJlryM+FdehE8LN1Fc0L08S31mMkKM0bSEvRQjtFq2PV1IJBtiLsYB89bgN
         KwVCey/f747w4OkfuAyHxLsV9+5A/LpJy8llBXuFaaQ4o1VTxCVQgyPuKoYj4B4z6miQ
         /9ajlws0TACYJziTRJ5do6FQMmsXQcLNxBCDBfDRli1mQXPqgaYTs7NmP1dT36MMriMT
         2bZAl0WpLvNlPFuBfUQfLze5jqIPrprrLn4znooLXhehsz4e7gd0bbyYHalMnJTGIUq6
         W8cQ==
X-Gm-Message-State: AOAM531GKlMBRo05RaYec21cXXvs3QsFdwMHrvgEOX1KatkUI1nkDqi1
        tSYtGHGwAcfKwZ5SK9HDB2pZcMsCDUL05VPIZw8=
X-Google-Smtp-Source: ABdhPJy1W+Do6+ScnEPjSDOf36HWEVFeO+sx+8yaRzKIvt6WGdQnuZ0PozZpaAPnQZF58DhCnsR52nCwWuT0Npt6f3E=
X-Received: by 2002:a17:906:9b8d:: with SMTP id dd13mr16901269ejc.168.1625552394900;
 Mon, 05 Jul 2021 23:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Jul 2021 02:19:43 -0400
Message-ID: <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: teach `add` to accept --reason <string> with --lock
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 1:47 AM Stephen Manz via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The default reason stored in the lock file, "added with --lock",
> is unlikely to be what the user would have given in a separate
> `git worktree lock` command. Allowing `--reason` to be specified
> along with `--lock` when adding a working tree gives the user control
> over the reason for locking without needing a second command.

Thanks. I can see how the default lock reason in this case isn't very
interesting. In fact, I'd actually have expected the default reason to
be empty, just as it's empty when `git worktree lock` is invoked with
no `--reason`. That might be an additional thing to "fix" at some
point by someone (or in this series if you'd like to tackle it).

It's nice to see both documentation and test updates along with the
code change. See below for a few comments...

> Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
> +'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
>
>  --reason <string>::
> +       With `lock` or with `add --lock`, an explanation why the working tree is locked.

I realize that you're mimicking the interface of `git worktree lock`
which accepts an optional `--reason`, but I'm wondering if the
user-experience might be improved by instead allowing `--lock` to
accept the reason as an optional argument. For instance:

    git worktree add --lock='just because' ...

Aside from the dissymmetry with `git worktree lock`, I haven't come up
with a reason that `--lock[=<reason>]` wouldn't be an improvement. But
perhaps I'm not imaginative enough...

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -31,6 +31,7 @@ struct add_opts {
>         int checkout;
>         int keep_locked;
> +       const char *lock_reason;
>  };

Whether or not we do go with the approach of allowing `--lock` to take
the reason as an optional argument, we don't really need two structure
members here. Instead, we can repurpose `keep_locked` as a `const char
*` which is NULL if `--lock` was not specified, otherwise non-NULL.
For the non-NULL case, it would be an empty (zero-length) string if
the optional `<reason>` was omitted, otherwise it would be the reason
given. So, no need for a distinct `lock_reason` member.

> @@ -302,10 +303,15 @@ static int add_worktree(const char *path, const char *refname,
> +       if (!opts->keep_locked) {
>                 write_file(sb.buf, "initializing");
> -       else
> -               write_file(sb.buf, "added with --lock");
> +       }
> +       else {
> +               if (opts->lock_reason)
> +                       write_file(sb.buf, "%s", opts->lock_reason);
> +               else
> +                       write_file(sb.buf, _("added with --lock"));
> +       }

Style on this project is to cuddle `else` with both braces:

    } else  {

However, in this case, it should probably just be a simple `else if`:

    if (!opts->keep_locked)
        write_file(sb.buf, "initializing");
    else if (opts->lock_reason)
        write_file(sb.buf, "%s", opts->lock_reason);
    else
        write_file(sb.buf, _("added with --lock"));

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> @@ -67,11 +67,22 @@ test_expect_success '"add" worktree' '
>  test_expect_success '"add" worktree with lock' '
> -       git rev-parse HEAD >expect &&
>         git worktree add --detach --lock here-with-lock main &&
>         test -f .git/worktrees/here-with-lock/locked
>  '

Dropping this unused code makes sense, though on this project we would
normally do it as a separate (probably preparatory) patch, thus making
this a two-patch series (at minimum).

> +test_expect_success '"add" worktree with lock and reason' '
> +       git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
> +       test -f .git/worktrees/here-with-lock-reason/locked &&
> +       echo why not >expect &&
> +       test_cmp expect .git/worktrees/here-with-lock-reason/locked
> +'

To make this a bit friendlier to other tests which come later in the
script, it might be a good idea to unlock this worktree here at its
source. To do so unconditionally, whether the test succeeds or fails,
use test_when_finished() just after placing the lock. So, something
like this:

    git worktree add --detach --lock --reason ... &&
    test_when_finished "git worktree unlock here-with-lock-reason || :" &&
    test -f .git/worktrees/here-with-lock-reason/locked &&
    ...

> +test_expect_failure '"add" worktree with reason but no lock' '
> +       git worktree add --detach --reason "why not" here-with-reason-only main &&
> +       test -f .git/worktrees/here-with-reason-only/locked
> +'

test_expect_failure() is for indicating known bugs or unimplemented
features, however, you did implement the check that `--reason`
requires `--lock`, so test_expect_failure() is not quite what you want
here. Instead, use test_must_fail() in the test body, and you want to
make sure that the `locked` file did not get created. So, something
like this:

    test_expect_success '"add" worktree with reason but no lock' '
        test_must_fail git worktree add --detach --reason ... &&
        test_path_is_missing .git/worktrees/here-with-reason-only/locked
    '
