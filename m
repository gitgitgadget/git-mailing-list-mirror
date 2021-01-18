Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0840C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 04:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998FE224B0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 04:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbhAREqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 23:46:52 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:43651 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbhAREqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 23:46:39 -0500
Received: by mail-ej1-f51.google.com with SMTP id a10so5200702ejg.10
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 20:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4wXCwf1eqtzTM96atELrCWeFUZy0C6miwBQQ1DmRBs=;
        b=aktZxa8E/TGkK4k8iL98xJr6Z+ufm5wkwyiO7lOu8YphHNea01kfXXv0bmfomH0LNB
         MgVB3ygOiV8VmOWEtGtG8aSc4ngECPN48JYP4uCeY8jNfuUItkbBSEMohARE+koAyzET
         sFlQRMTw4N2JiEyvzmQC8hPsL16R5GNa0VVTDOhmbb3g9folO4yO6uv+9cHGFEk+vYVS
         7W9ygEXsCD0/YA2ZYCB0uqGVvEUUV7Rsg3I7LzgPN51qYZ9YNKGkZGc/Y8YC8SpAX1nD
         qpYAf6u+GPBR+7wadWhgWZG1aHHBM7P2sErx7zPx/nyqCHIYHT01HFLwpZz6YZpMVBZy
         s9pw==
X-Gm-Message-State: AOAM5333WiyguZ4TSQmbzDQVuZWc6f9p2+2T9s2G/xUTgT5eN53Llpqo
        D7tQ/NOYIklINUPSMaZ4bdkM/x0a2zrR6hj73+o=
X-Google-Smtp-Source: ABdhPJzaxykFjUgtwY5jo8VZwxPgQvNBTEishG/7Upabf3a5Sfy6+X3PVwZfC2TFBAyjyQv/n7zGRwO+t1C+CN8CYOc=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr16409699ejm.371.1610945158084;
 Sun, 17 Jan 2021 20:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-6-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210117234244.95106-6-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jan 2021 23:45:47 -0500
Message-ID: <CAPig+cRUrN62CDT+e+q02-S_sCD1Qvi5XtgU3D1dr9fXt--YJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] worktree: teach `list` to annotate prunable worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> The "git worktree list" command shows the absolute path to the worktree,
> the commit that is checked out, the name of the branch, and a "locked"
> annotation if the worktree is locked, however, it does not indicate
> whether the worktree is prunable.
> [...]
> Let's teach "git worktree list" to show when a worktree is a prunable
> candidate for both default and porcelain format.

Good.

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -234,6 +235,9 @@ This can also be set up as the default behaviour by using the
>  --expire <time>::
>         With `prune`, only expire unused working trees older than `<time>`.
> ++
> +With `list`, annotate missing working trees as prunable if they are
> +older than `<mtime>`.

s/mtime/time/

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -592,6 +592,10 @@ static void show_worktree_porcelain(struct worktree *wt)
> +       reason = worktree_prune_reason(wt, expire);
> +       if (reason && *reason)
> +               printf("prunable %s\n", reason);

I lean toward not including `*reason` in the condition here. While one
may argue that `*reason` is future-proofing the condition, we know
today that worktree_prune_reason() will only ever return NULL or a
non-empty string. So, having `*reason` in the condition is misleading
and confuses readers into thinking that worktree_prune_reason() could
return an empty string or that perhaps it did in the past. And
studying the history of this file or even this commit won't help them
understand why the author included `*reason` in the condition.

> @@ -617,9 +622,14 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
> -       if (!is_main_worktree(wt) && worktree_lock_reason(wt))
> +       reason = worktree_lock_reason(wt);
> +       if (reason)
>                 strbuf_addstr(&sb, " locked");

Although I understand what happened here because I read the entire
series, for anyone reading this patch in the future or even someone
reading this patch in isolation, the disappearance of
is_main_worktree() from the condition is mysterious. They won't know
if its removal was an accident or intentional, or if the change
introduces a bug. Therefore, it would be better to drop
is_main_worktree() from this conditional in patch [3/6], which is the
patch which makes it safe to call worktree_lock_reason() even for the
main worktree. Thus, in [3/6], this would change from:

    if (!is_main_worktree(wt) && worktree_lock_reason(wt))

to:

    if (worktree_lock_reason(wt))

and then in this patch [5/6], it becomes:

    reason = worktree_lock_reason(wt);
    if (reason)

> +       reason = worktree_prune_reason(wt, expire);
> +       if (reason)
> +               strbuf_addstr(&sb, " prunable");

Looking at this also makes me wonder if patches [5/6] and [6/6] should
be swapped since it's not clear to the reader why you're adding the
`reason` variable in this patch when the same could be accomplished
more simply:

    if (worktree_lock_reason(wt))
        strbuf_addstr(&sb, " locked");
    if (worktree_prune_reason(wt, expire))
        strbuf_addstr(&sb, " prunable");

If you swap the patches and add --verbose mode first which requires
this new `reason` variable, then the mystery goes away, and the use of
`reason` is obvious when `prunable` annotation is added in the
subsequent patch.

Having said that, I'm not trying to make extra work for you by
expecting patch perfection. Sometimes it's fine to craft a patch in
such a way that it makes subsequent patches simpler, even if it looks
slightly odd in the current patch, and I haven't read [6/6] yet, so
whatever opinion I express here is based only upon what I've read up
to this point.
