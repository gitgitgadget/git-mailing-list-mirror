Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85755C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 00:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhLUABr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 19:01:47 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:38508 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhLUABq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 19:01:46 -0500
Received: by mail-pj1-f43.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso768990pjf.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 16:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvYB3AIgOBX7pJn2ellHOPx/j+5QpSDcYfJnbC6PjYo=;
        b=keIqWgOgWW5HUW/7NiwFMOgsyCb8aroSXdnlVYwgKv5J1AcrhIHMeUyE3bNTglULZb
         uUR7BCuu985BohQrXDJSfYwAYwnmjZO/EEsOh1nz+WgFk015xtbJmK5xHTd31jrwYoxf
         N1LaEEqv32hm2dr4s0H0gop3vKjAZtQgL0C3imkpJnL9GrTy+cQdRDxiMEVGP43TFced
         alNKZVMmxGOlrfmUII/OxRuFBDTjF2HlVbgFONLE8WLteEaH14vu31j83pWa1CxbDnfC
         SeZBVwAZkIWirWunDKyLp2ew1Na3JjFYpJfMnCkFljO/5xkTtrj9J7LBJHaF0NM/hv4G
         dfhQ==
X-Gm-Message-State: AOAM530/+y+QLXt885NXZg2ynJstCVHeVYD5SVPykJHUlrYV/377kXSL
        grfaGVrLxOfO/0f8dUfi461tpznbfx8afzio2YM=
X-Google-Smtp-Source: ABdhPJzN6d201ml18xk60HXFyCFD7HlNHJ89g9IUnuft7A6vm937uyVfAxPDVuoaLUcFpl8yaoSS864BzGifrBbzYA8=
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr778757pjb.236.1640044905924;
 Mon, 20 Dec 2021 16:01:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
 <6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com>
In-Reply-To: <6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 19:01:34 -0500
Message-ID: <CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com>
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 12:32 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/20/2021 10:57 AM, Derrick Stolee via GitGitGadget wrote:
> > +     /*
> > +      * Ensure that core.bare reflects the current worktree, since the
> > +      * logic for is_bare_repository() changes if extensions.worktreeConfig
> > +      * is disabled.
> > +      */
> > +     if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
> > +                                                       r->worktree ? "false" : "true",
> > +                                                       NULL, 0))) {
>
> As mentioned by Eric, this portion isn't correct. It fixes _this_ worktree, but
> any other existing worktrees would become broken.
>
> The fix would be to detect if the core config file has core.bare=false and then
> to move that setting into the base repo's config.worktree file.
>
> I believe that if we do that change, then the rest of this patch series is valid.

Sorry, but I'm not following what you're suggesting, and I'm not sure
what you mean by "core config file" and "base repo's config.worktree
file". Also, we aren't specifically concerned that `core.bare=false`.

Conceptually the proper fix is quite simple. (Whether the actual
implementation is simple is a different question; I haven't looked
closely at the code yet to be able to answer that.) First, though,
let's make clear what different config files are involved:

.git/config -- config shared by the repository and all worktrees
(including the main worktree)

.git/config.worktree - config specific to the main worktree (or to the
repository itself if bare)

.git/worktrees/<id>/config.worktree -- config specific to worktree <id>

In the above list, I'm using ".git/" loosely to mean either a bare
repository (i.e. "bare.git") or the ".git/" directory within the main
worktree; the difference is immaterial to this discussion. When
`extensions.worktreeConfig` is false or unset, only the first item in
the above list is consulted; when `extensions.worktreeConfig` is true,
then the `config.worktree` files are consulted, as well (depending
upon which worktree you're in).

Regarding the actual "fix": we want a new utility function which
enables per-worktree configuration and handles all the required
bookkeeping actions described in git-worktree.txt. Specifically, if
per-worktree configuration is not already enabled, the function will
need to:

(1) set `extensions.worktreeConfig=true` in .git/config

(1) relocate `core.bare` from .git/config to .git/config.worktree if
that key exists

(2) relocate `core.worktree` from .git/config to .git/config.worktree
if that key exists

That's it. It doesn't need to create or touch any
.git/worktrees/<id>/config.worktree file(s); it should _not_ add a
`core.bare=false` to .git/worktrees/<id>/config.worktree, as this v1
patch series does.
