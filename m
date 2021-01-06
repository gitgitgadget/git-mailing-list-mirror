Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF772C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C57F23102
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFHJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:09:16 -0500
Received: from mail-ej1-f44.google.com ([209.85.218.44]:39369 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFHJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 02:09:16 -0500
Received: by mail-ej1-f44.google.com with SMTP id n26so3756607eju.6
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 23:08:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUyrSZpFAfwbFqiA9ACfJUrVtcTgHzSM0rsrC6X10BU=;
        b=F8SNFS2vQxXluRw/O25VcumzB2abeGim0LRz1JgGHTaDBaU7n2NxbR8rjpYxwGvues
         YQv3oOdjh49lulGf2mWLl0nM0hACBOn7TOyYk1S51Dp+iNkS0PGEqc/lA85tXZZAee6P
         Wk7LOiVKFK2gVpYnseagWhLPI6OwrXXaoZV71i49/ugIq8bWpypDD0Ba8XAjTbka4chW
         9oVJoXrx1LTOcGyTvBr0L6xWTssp/qTEdlQoO1v5rZIwgXrEaft7wJ7imuIbGh3AB3Ha
         hIX90Le2Oz7gUN7jpyVxCXGBr0lC4fVnxj1+0CD9YJNIOG5duPUofq5FoQ9QMSq3tvTK
         cCGg==
X-Gm-Message-State: AOAM532AcLHL6+at+EREsRKf366v2pLFAG1oQlyZxMXTBvNktDTMkR7Y
        AZo9AHJp1fR6P0LTRsHypLgK7Q2yMC3BCo1rCMOaDNuAal0=
X-Google-Smtp-Source: ABdhPJwF81w+SsMUSskZcupFwU3Isl0SF2aX97ODn1lmCs3m5N4P2Q/nTZ2Lu9MtMzlF6urXpXN01oWk4jUGZ3/aScw=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr2007416ejb.168.1609916913320;
 Tue, 05 Jan 2021 23:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-3-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-3-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 02:08:22 -0500
Message-ID: <CAPig+cRNJeDS+TJL24_QGVE+goD2qBV7aorr+EKr9ORTTmusNg@mail.gmail.com>
Subject: Re: [PATCH 2/7] worktree: implement worktree_prune_reason() wrapper
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> worktree: implement worktree_prune_reason() wrapper

We might be able to give the reader more useful information in the
subject by explaining a bit more the goal of this patch. Perhaps
something like this:

    worktree: teach worktree to lazy-load "prunable" reason

> The should_prune_worktree() machinery is used by the "prune" command to
> identify whether a worktree is a candidate for pruning. This function
> however, is not prepared to work directly with "struct worktree" and
> refactoring is required not only on the function itself, but also also
> changing get_worktrees() to return non-valid worktrees and address the
> changes in all "worktree" sub commands.
>
> Instead let's implement worktree_prune_reason() that accepts
> "struct worktree" and uses should_prune_worktree() and returns whether
> the given worktree is a candidate for pruning. As the "list" sub command
> already uses a list of "struct worktree", this allow to simply check if
> the working tree prunable by passing the structure directly without the
> others parameters.

Everything through "not prepared to work directly with `struct
worktree`" makes sense when explaining why you are adding this wrapper
function, however, most of what follows is describing an aborted idea
about how you originally intended to implement this. The bit about
get_worktrees() not being able to return non-valid worktrees is
certainly an important limitation in the overall scheme of things, but
doesn't really help to sell the change made by this patch, and it
probably confuses the reader who didn't also read the cover-letter,
especially since this patch does nothing to help that situation.

It also isn't really necessary to talk about `git worktree list` at
this stage since this patch stands on its own by fleshing out the API
without having to cite a specific client.

> Also, let's add prune_reason field to the worktree structure that will
> store the reason why the worktree can be pruned that is returned by
> should_prune_worktree() when such reason is available.

In my opinion, this is the real reason this patch exists, thus should
be the focus of the commit message. All the description above this
paragraph can likely be dropped.

Taking the above comments into account, perhaps the entire commit
message could be collapsed to something like this:

    worktree: teach worktree to lazy-load "prunable" reason

    Add worktree_prune_reason() to allow a caller to discover whether
    a worktree is prunable and the reason that it is, much like
    worktree_lock_reason() indicates whether a worktree is locked and
    the reason for the lock. As with worktree_lock_reason(), retrieve
    the prunable reason lazily and cache it in the `worktree`
    structure.

> diff --git a/worktree.c b/worktree.c
> @@ -15,6 +15,7 @@ void free_worktrees(struct worktree **worktrees)
>                 free(worktrees[i]->lock_reason);
> +               free(worktrees[i]->prune_reason);
>                 free(worktrees[i]);

Remembering to free the prune-reason. Good.

> @@ -245,6 +246,24 @@ const char *worktree_lock_reason(struct worktree *wt)
> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
> +{
> +       if (!is_main_worktree(wt)) {
> +               char *path;
> +               struct strbuf reason = STRBUF_INIT;
> +
> +               if (should_prune_worktree(wt->id, &reason, &path, expire))
> +                       wt->prune_reason = strbuf_detach(&reason, NULL);
> +               else
> +                       wt->prune_reason = NULL;
> +
> +               free(path);
> +               strbuf_release(&reason);
> +       }
> +
> +       return wt->prune_reason;
> +}

A couple observations...

I realize you patterned this after worktree_lock_reason(), however, it
is more common in this codebase to return early from the function for
conditions such as `is_main_worktree(wt)` which don't require any
additional processing. One reason is that doing so allows us to lose
an indentation level. Another is that it is easier to reason about the
rest of the function if we get the simple cases out of the way early,
such that we don't have to think about them again while reading the
remainder of the code.

If I'm not mistaken, the intention here was to cache `prune_reason`
for reuse, however, this function just overwrites it each time it's
called for a particular worktree, thus providing no caching and
leaking the previously-retrieved reason as well. To fix this, I think
you need to add a private `prune_reason_valid` member to `struct
worktree` (similar to `lock_reason_valid`) and check it before calling
should_prune_worktree().

Taking the above comments into account, perhaps it should be written like this:

    if (is_main_worktree(wt))
        return NULL;
    if (wt->prune_reason_valid)
        return wt->prune_reason;
    if (should_prune_worktree(wt->id, &reason, &path, expire))
        wt->prune_reason = strbuf_detach(&reason, NULL);
    wt_prune_reason_valid = 1;
    free(path);
    strbuf_release(&reason);

> diff --git a/worktree.h b/worktree.h
> @@ -11,6 +11,7 @@ struct worktree {
>         char *id;
>         char *head_ref;         /* NULL if HEAD is broken or detached */
>         char *lock_reason;      /* private - use worktree_lock_reason */
> +       char *prune_reason;     /* private - use worktree_prune_reason */

As noted above, we also probably need a new `prune_reason_valid`
member, similar to the existing `lock_reason_valid`.

> @@ -73,6 +74,12 @@ int is_main_worktree(const struct worktree *wt);
> +/*
> + * Return the reason string if the given worktree should be pruned
> + * or NULL otherwise.
> + */
> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire);

The documentation should also talk about `expire` since its purpose
and meaning is unclear.

Nit: I realize that you patterned this description after the one for
worktree_lock_reason(), but it's a bit unclear. Perhaps rephrasing it
like this would help:

    Return the reason the worktree should be pruned, otherwise
    NULL if it should not be pruned.
