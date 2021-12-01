Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD57C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353743AbhLAXNz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 1 Dec 2021 18:13:55 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:54990 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbhLAXNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:13:54 -0500
Received: by mail-pj1-f54.google.com with SMTP id np3so19149414pjb.4
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 15:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q8d66RfXdvpivs2LbI6vG2uH6EBDWi2y5SQrAX3t13Y=;
        b=j8/z2Jg4TyZqgIv9KpkARWYTWPNXhSmRZkIr9gS7/jV7/qfmnBSBljIzcvl7onvxlC
         mEg61HIIXdzV/F6smgv3L+nPsQwRhlVaTQ6uqSCEXSj9VlE6l6aoJbrxrGq+dtayTTjf
         UmZnWcJaehPauxb0Dj5KVtZkD4HX9SUcpJBTJwhPRrDYyZeIWhZbwG34zorjp6FOi+13
         muTybIfHldgMbsFwk75+1jIPsxaMtDhCsSAORcUSL0ss5EsY54qVmr2Tc2EMWfJd5v+x
         GCHyBAaYJZk2236fK0+f6hKlDFviZVswE7M4Vb+pcWlKyc3BvXzQ9O8aLqBHs7YXMi9M
         qheg==
X-Gm-Message-State: AOAM533SukU0nRkiISCtG94HVeI18EseVF6JyGOnbE2fJKBx/iKvjpzk
        noaOu/33ftDxSAdx3PHvgZ4/LFMNecEN5JCbvck=
X-Google-Smtp-Source: ABdhPJw6SsfVA7jj8f7HnPicbaqQtaM0Ws+Z3KfbAo6I/tc8Op+ItSaPsXhD2xDlptoQksSlZ5IihQuZK/dVDCmTAjc=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr11125739plq.18.1638400232370; Wed, 01
 Dec 2021 15:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-5-andersk@mit.edu>
In-Reply-To: <20211201221547.1796213-5-andersk@mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 18:10:21 -0500
Message-ID: <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 5:16 PM Anders Kaseorg <andersk@mit.edu> wrote:
> Storing the worktrees list in a static variable meant that
> find_shared_symref() had to rebuild the list on each call (which is
> inefficient when the call site is in a loop), and also that each call
> invalidated the pointer returned by the previous call (which is
> confusing).
>
> Instead, make it the caller’s responsibility to pass in the worktrees
> list and manage its lifetime.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> @@ -1486,12 +1486,17 @@ static const char *update(struct command *cmd, struct shallow_info *si)
> -       const struct worktree *worktree = is_bare_repository() ? NULL : find_shared_symref("HEAD", name);
> +       struct worktree **worktrees = get_worktrees();
> +       const struct worktree *worktree =
> +               is_bare_repository() ?
> +                       NULL :
> +                       find_shared_symref(worktrees, "HEAD", name);

As far as I can see, this code only cares whether find_shared_symref()
returned a result; it doesn't actually consult the returned worktree
at all, thus it semantically considers `worktree` as a boolean, not as
a `struct worktree`. I see in [7/8] that you do add an access to the
`worktree.is_bare` field, but that also is used purely in a boolean
fashion. If my understanding is correct, then it seems as if it would
be cleaner and make for a much less noisy patch if you did this
instead:

    struct worktree **worktrees = get_worktrees();
    int has_worktree = 0;
    if (!is_bare_repository()) {
        struct worktree *w = find_shared_symref(worktrees, ...);
        has_worktree = !!w;
    }
    free_worktrees(worktrees);
    ...
    if (has_worktree) {
        ...
    }

and in patch [7/8] augment that to:

    int is_worktree_bare = 0;
    if (!is_bare_repository()) {
        struct worktree *w = find_shared_symref(worktrees, ...);
        if (w) {
            has_worktree = 1;
            is_worktree_bare = w->is_bare;
        }
    }
    free_worktrees(worktrees);

which would then allow you to...

>         if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
>                 rp_error("refusing to create funny ref '%s' remotely", name);
> -               return "funny refname";
> +               ret = "funny refname";
> +               goto out;
>         }

... drop this change and all the other similar changes to this file
since `worktrees` gets cleaned up as soon as `has_worktree` and
`is_worktree_bare` have been determined, so there's no need to
introduce an `out` label just to clean up `worktrees` at the end of
the function.
