Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C21C07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C40610D1
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGMDk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:40:27 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:39468 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhGMDk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 23:40:27 -0400
Received: by mail-ej1-f42.google.com with SMTP id ga14so23841221ejc.6
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 20:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3tn2f3XCg/BhB5rGqbb1tJ+wVboJaA0ru9ZQ5KNRM0=;
        b=tfuPDI2S66yKAaOj3KXBxwlagTHazdpjns1DQM0400qctviRGCe+U96igmv95f7Mt8
         qzN7GJDgD03/WybxiIkXQ9NurwRZKYnAnohrwNfWULfqrFjPuk+lHTCUJNpc+snBjjWW
         6ANkwZzFCYi1w40cdWcPy4ZnBdbl3e1PkKnVijDaglsBOeKXzKIcHh+a6cLlpbTII39r
         LSG4aOP+xuScpX0ge4iLFeaKKGliCllS54MGiYCQ6b75Kix8VvoLgQZmtiqwwUkXAHLx
         Zb8GkpNtwOdsaP1cSJrDppzXqJJZllesZMJ/byuBE9c7P+f90If6F6ovXz/vYgPisw0C
         3AGg==
X-Gm-Message-State: AOAM532Xf/MKJNN5P6HDB4d0UXk1WwRHKsEN0scgooSy4xfdGylmH2wt
        dEDQzg4b8rIx9NqK7Rfs9dh6MwxV5WDb0WtThXo=
X-Google-Smtp-Source: ABdhPJz5zmXTTEzzAkFzsJrLHrTTFvE2OeAH1qrMgiGZlvwirM+gDoLLWK3B/0BSWb9x+uSqmixx139JtCbVM0+jHaM=
X-Received: by 2002:a17:906:48cd:: with SMTP id d13mr2838143ejt.311.1626147456008;
 Mon, 12 Jul 2021 20:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
 <pull.992.v3.git.1625963240.gitgitgadget@gmail.com> <9a414a3078bb481ba19449065d47e6e27322cef2.1625963240.git.gitgitgadget@gmail.com>
In-Reply-To: <9a414a3078bb481ba19449065d47e6e27322cef2.1625963240.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Jul 2021 23:37:25 -0400
Message-ID: <CAPig+cQVSUg1aqry_hMydJ=Uo=-VhOog6TUTpG=0on0LUcw8Dg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] worktree: teach `add` to accept --reason <string>
 with --lock
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 8:27 PM Stephen Manz via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The default reason stored in the lock file, "added with --lock",
> is unlikely to be what the user would have given in a separate
> `git worktree lock` command. Allowing `--reason` to be specified
> along with `--lock` when adding a working tree gives the user control
> over the reason for locking without needing a second command.
>
> Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -302,10 +302,10 @@ static int add_worktree(const char *path, const char *refname,
>         strbuf_addf(&sb, "%s/locked", sb_repo.buf);
> -       if (!opts->keep_locked)
> -               write_file(sb.buf, _("initializing"));
> +       if (opts->keep_locked)
> +               write_file(sb.buf, "%s", opts->keep_locked);
>         else
> -               write_file(sb.buf, _("added with --lock"));
> +               write_file(sb.buf, _("initializing"));

Changing the condition around to handle the positive case first makes
the diff noisier, but the resulting code is a bit easier to reason
about. Okay.

> @@ -500,6 +504,13 @@ static int add(int ac, const char **av, const char *prefix)
> +       if (lock_reason && !keep_locked)
> +               die(_("--reason requires --lock"));
> +       if (lock_reason)
> +               opts.keep_locked = lock_reason;
> +       else if (keep_locked)
> +               opts.keep_locked = _("added with --lock");

The benefit of relocating the "added with --lock" literal from
add_worktree() to add() wasn't immediately obvious, aside from making
the `if` statement in add_worktree() a bit less complex. But I managed
to convince myself that the relocation makes sense since add() knows
about the `--lock` option, whereas add_worktree() is merely a consumer
of `add_opts` without specific knowledge of how the fields in that
structure get set. Okay.

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> @@ -72,6 +72,19 @@ test_expect_success '"add" worktree with lock' '
> +test_expect_success '"add" worktree with lock and reason' '
> +       git worktree add --detach --lock --reason "why not" here-with-lock-reason main &&
> +       test_when_finished "git worktree unlock here-with-lock-reason || :" &&
> +       test -f .git/worktrees/here-with-lock-reason/locked &&
> +       echo why not >expect &&
> +       test_cmp expect .git/worktrees/here-with-lock-reason/locked
> +'

Two very minor comments:

First, considering that test_cmp() will fail anyhow if the `locked`
file is missing, the `test -f` is redundant.

Second, the lack of quotes around "why not" in the `echo ... >expect`
statement gives me a moment's pause since it relies upon the fact that
`echo` will insert exactly one space between the "why" and "not"
arguments (which happens to match the single space in the
double-quoted argument to `--reason`). For clarity and that extra bit
of robustness, I'd probably have used a single double-quoted string
argument with `echo`.

Anyhow, those are extremely minor comments, probably not worth a
re-roll but perhaps something to keep in mind if you do re-roll for
some other more important reason.
