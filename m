Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3EC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 02:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F2D2245C
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 02:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbhARC6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 21:58:02 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:45491 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbhARC54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 21:57:56 -0500
Received: by mail-ej1-f47.google.com with SMTP id ke15so13939395ejc.12
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 18:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/KH15ALwExS0+6dIy46DZ+tG1sikAP/Az2Bq13llEA=;
        b=KGQ+WpXsWjzTTp15ie4D0o5GCnZbWqrW0B8qvNHZCdUF8RKbB9+4n+QP94BS+519h0
         69hbldLxfYQVM+8iL/LVHhyYjApeombYfUMoJWREjLwB+SSKjMpDSM3MjfxayOfIrxPC
         bwHh0paiViC5kkq6wP16O+5iITRqgx7P5TynCNzgSJZ1CivpqyfXlXJok+BNtgGdXRHH
         R+jnu6rl2VNU2ZLy7FH/Z0yxjF2E4UdFS5MjmVHg6l0RyMWxTywCjDFGIfGq6X0e308W
         KeCMaC0lFrV7DiH/6v9hw6cd56QK641gSy0sS4SMYvsI3M+rfgF4M6rYntcJYff9Uw5Y
         q4ZA==
X-Gm-Message-State: AOAM531hbcqg11WsDAh5U9IxgjTD1ixC+WVG68VvuRL9uEYl6kWbr9I2
        s2z/cLplhmpacwXB4zYSMwQ0ST+436bbdnAt+qM=
X-Google-Smtp-Source: ABdhPJx/sz6jXHI/Q4XJ+txuj79Nk4i3lRtQCYuFZZ0CXPp63cxGTSuBe3wftbDz9AZac5eujtRZfEB2IB1TTeXZhHs=
X-Received: by 2002:a17:906:4159:: with SMTP id l25mr11128507ejk.311.1610938634430;
 Sun, 17 Jan 2021 18:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-3-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210117234244.95106-3-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jan 2021 21:57:03 -0500
Message-ID: <CAPig+cQX27n6vpGP4m3S9paUnpNw5etLLAXr=WO9rC1KSSLMmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] worktree: teach worktree to lazy-load "prunable" reason
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Add worktree_prune_reason() to allow a caller to discover whether a
> worktree is prunable and the reason that it is, much like
> worktree_lock_reason() indicates whether a worktree is locked and the
> reason for the lock. As with worktree_lock_reason(), retrieve the
> prunable reason lazily and cache it in the `worktree` structure.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -245,6 +246,25 @@ const char *worktree_lock_reason(struct worktree *wt)
> +const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
> +{
> +       struct strbuf reason = STRBUF_INIT;
> +       char *path;

The `path` variable is uninitialized...

> +       if (should_prune_worktree(wt->id, &reason, &path, expire))
> +               wt->prune_reason = strbuf_detach(&reason, NULL);

...but the very first thing should_prune_worktree() does is
unconditionally set it to NULL, so it's either NULL or an allocated
string regardless of the value returned by should_prune_worktree()...

> +       strbuf_release(&reason);
> +       free(path);

...which makes the behavior of `free(path)` deterministic. Good.

I'm on the fence about whether or not we should initialize `path` to NULL:

    char *path = NULL;

just to make it easier for the next person to reason about it without
having to dig into the implementation of should_prune_worktree(). This
is a really minor point, though, not worth a re-roll.
