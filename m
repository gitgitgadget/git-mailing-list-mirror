Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E3C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F77823104
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 07:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbhAFHal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 02:30:41 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:38126 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAFHal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 02:30:41 -0500
Received: by mail-ej1-f53.google.com with SMTP id 6so3822662ejz.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 23:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vo7ntJrSPIKvAluvW3RcrIyFsk4GHXsEImRvHdpK8bA=;
        b=ETTkqZ6TyM3kGCXgSMAafDvnk0YsMY5QRK2Ii1SCI+wyyyw4u6NECZypYVCGOzOBeC
         HsubpZ9enfd46EF1bzle4p42rYhS+7+dbtAVwKJkitzud0kdlinkKoYa3Nax+lL75ZQ2
         GgycOFZAd/EvJstA9zEi4eUjEDc0qqa83GqrsU9ZRGeHl7A9CMt0sssxu++67bk5JHyc
         3Vymfe50U9VrrHZYmZUJdmrBTeCQa8vQgb2F5vV06SuzFPmqjeexzaYaK2Xh3Gogkx0m
         L1QHLYckkOd+sgR3VILJkeiu8hhxwejQOMQ2F+yUQg5PRxNsYhmVPTOps2JWvyiysLXV
         szIQ==
X-Gm-Message-State: AOAM533Nkb+p0mraLQlL3NWp+j7l9MrF7J7/R40qIzIiYASp0Flt0n12
        F4sKtQWCuCeF7yv8fx7Ao7S+/fGEElYX3yTdCto=
X-Google-Smtp-Source: ABdhPJz9b3SCAdYs0rRIF/NTuzG5Z37jxlHtEMjjTu5hsw9waYjtElqcSp1LeImM7HKZDkDT5nlcBOk9E1QR2twr4Qc=
X-Received: by 2002:a17:906:b287:: with SMTP id q7mr1875705ejz.311.1609918198452;
 Tue, 05 Jan 2021 23:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-4-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-4-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 02:29:47 -0500
Message-ID: <CAPig+cRrU-T9ULyoNVtrWxm-5yb5NVSCT3+LvLmA5xJCv4n_9Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree: teach worktree_lock_reason() to gently
 handle main worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> The main worktree should not be locked and the worktree_lock_reason() API
> is aware of this fact and avoids running the check code for the main
> worktree. This checks is done via assert() macro, Therefore the caller

s/Therefore/therefore/

> needs to ensure the function is never called, usually by additional code.
>
> We can handle that case more gently by just returning false for the main
> worktree and not bother checking if the "locked" file exists. This will
> allowed further simplification from the caller as they will not need to
> ensure the main worktree is never passed to the API.
>
> Teach worktree_lock_reason() to be more gently and just return false for
> the main working tree.

The situation is even a bit worse since the main worktree restriction
isn't even documented. Here's a possible rewrite of the commit message
which addresses that point too:

    worktree_lock_reason() aborts with an assertion failure when
    called on the main worktree since locking the main worktree is
    nonsensical. Not only is this behavior undocumented, thus callers
    might not even be aware that the call could potentially crash the
    program, but it also forces clients to be extra careful:

        if (!is_main_worktree(wt) && worktree_locked_reason(...))
           ...

    Since we know that locking makes no sense in the context of the
    main worktree, we can simply return false for the main worktree,
    thus making client code less complex by eliminating the need for
    callers to have inside knowledge about the implementation:

        if (worktree_locked_reason(...))
            ...

> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -225,9 +225,7 @@ int is_main_worktree(const struct worktree *wt)
>  const char *worktree_lock_reason(struct worktree *wt)
>  {
> -       assert(!is_main_worktree(wt));
> -
> -       if (!wt->lock_reason_valid) {
> +       if (!is_main_worktree(wt) && !wt->lock_reason_valid) {
>                 struct strbuf path = STRBUF_INIT;

As mentioned in my review of patch [2/7], this would be more idiomatic
and easier to reason about if the function returns early for the main
worktree case, thus freeing the reader from having to think about that
case for the remainder of the code. So:

    if (is_main_worktree(wt))
        return NULL;
    if (!wt->lock_reason_valid) {
        ...

Subjective, and not necessarily worth a re-roll, though.
