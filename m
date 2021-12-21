Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC7BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhLUX3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:29:48 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:33325 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhLUX3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:29:47 -0500
Received: by mail-pg1-f170.google.com with SMTP id f125so557255pgc.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 15:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqaRslyUQopSv5mpVrAF20ObMTLokjgN/Tg3QASOgBY=;
        b=Ldw7NbZO7ST3p3GZc9fG+Xm8Pk9NRnyZ7GmOuvM+LNZG4kfqiSGiBcT+0gbY0oECgl
         Hnvyhw2AyjlaynO4YjmxMlQb2FJhOAFT0AGAnCjvQ2/KzrceCs0tQI7jgGychWWd0CoX
         pPlHXyXsOEbsfNNzisc/bqxYCc5odhIEfsGTvYVXeaVSLD36dAXeM9en3E1ooMY94S5Q
         KA9LGNjldF2BwhX7e8w/MzdtILkEoDI7bU10GTHKaXAwVl/nFxxK7n1KuTIQTFP1jCri
         LrngVgpVQUMzww2S9qpV8EkVZcTfYwZyUDVrVEP4GR2yLMp2D2Zu0ntucRurG4JCJ8ki
         GByg==
X-Gm-Message-State: AOAM5336JRW4exUipNoQi1/e2HUzXi6nhVb/Jw8MVdg513iHTYtlaTWf
        fhsKxhEPRIpYT1eUVTHxrCb5qQlG79RxwFZT/f2wRpbEkGA7Mw==
X-Google-Smtp-Source: ABdhPJwXFPDxHeGzBXQshLXH9r/Jg4IfIBFNo4mvElfFvravQ7lwdyLVQLWe0Ngecvfn+zoEsnnF+BlQkSJQBztz4k4=
X-Received: by 2002:a63:e245:: with SMTP id y5mr531622pgj.139.1640129387122;
 Tue, 21 Dec 2021 15:29:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
 <CAPig+cT=evew0iePP-TZ+DTJ=oY6hrjiOiDtYqEr6KLRvkqC9Q@mail.gmail.com> <c8c995d3-c73c-6b3f-8d5c-f1411abd56e9@gmail.com>
In-Reply-To: <c8c995d3-c73c-6b3f-8d5c-f1411abd56e9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 18:29:35 -0500
Message-ID: <CAPig+cRombN-8g0t7Hs9qQypJoY41gK3+kvypH4D0G6EB4JgbQ@mail.gmail.com>
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

On Tue, Dec 21, 2021 at 8:46 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/21/2021 12:53 AM, Eric Sunshine wrote:
> > On Mon, Dec 20, 2021 at 10:57 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +/**
> >> + * Write a config value into the config.worktree file for the current
> >> + * worktree. This will initialize extensions.worktreeConfig if necessary.
> >> + */
> >> +int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
> >
> > I understand your desire to make this "setter" function as transparent
> > and simple for clients as possible, however, I think it does too much
> > by conflating two very distinct operations (one which changes the
> > nature of the repository itself, and one which simply sets a config
> > variable), and is far too magical. It doesn't help that the function
> > name gives no indication of just how magical it is, and it is easy to
> > imagine people calling this function thinking that it's just a simple
> > "config setter" like all the other similarly-named functions, without
> > realizing the impact it may have on the repository overall (i.e.
> > upgrading to version 1 and changing to per-worktree config).
> >
> > I would feel much more comfortable for the new utility function to
> > have a single-purpose: namely, to upgrade the repository to a
> > per-worktree configuration mode (if not already upgraded) as outlined
> > in [4]. That's it. It shouldn't do anything other than that. This way,
> > callers which need per-worktree configuration must call the new
> > function explicitly to obtain the desired behavior, rather than
> > getting per-worktree configuration as a magical and implicit
> > side-effect of calling what looks like a plain old "config setter".
> > This should make it easier to reason about. Taking this approach also
> > means that you don't need to introduce a special-purpose "config
> > setter" just for worktrees; instead, you'd use the normal existing
> > "config setter" functions. For instance, if the new utility function
> > is named enable_per_worktree_config(), then `git sparse-checkout init`
> > might do something like this:
>
> I understand your desire to separate these concerns, and maybe there
> is value in having another method that _just_ does the "upgrade to
> worktree config". However, if we don't also create this helper method
> for setting worktree-specific config, then we are going to hit this
> issue again.

There are several good reasons for having a single-purpose function
which upgrades to per-worktree config. Not only is it easier to
discover such a function, but it is also easier to reason about the
behavior when it does just this one thing. Moreover, aside from
providing a common implementation for modules which may want or
require the functionality (such as `git sparse-checkout init`), it
would form a solid basis for a git-worktree command for enabling
per-worktree configuration. And, such a command could be valuable for
people who want to utilize per-worktree configuration for their own
reasons (not related to `git-sparse-checkout`).

With only `git sparse-checkout init` wanting to write per-worktree
config, thus far, it does not feel like a convincing argument that an
automagical helper function which conflates upgrading the repository
to per-worktree config _and_ writing a per-worktree config key is a
good idea or that it will be needed again. But more on that below...

> >     enable_per_worktree_config(r);
> >     config_path = repo_git_path(r, "config.worktree")
> >     git_config_set_in_file_gently(config_path, "core.sparseCheckout", ...);
> >     git_config_set_in_file_gently(config_path, "core.sparseCheckoutCone", ...);
>
> If we expect every caller that assigns config to the worktree to follow
> this sequence of events, then we should encapsulate that in a method so
> developers can discover it and call it instead of needing to write these
> lines over again. Just repeating the literal "config.worktree" in
> multiple places is enough justification for making a helper, let alone
> these more subtle issues around bare repos and non-bare worktrees.

On the contrary, because it is such an unusual and potentially
dangerous step to take (i.e. it changes the repository in a way which
third-party tools may not understand), any module which absolutely
_requires_ per-worktree config support should be enabling it
explicitly rather than expecting it to happen implicitly and
magically. By keeping these concerns separate, it is not only easier
for people working on this code in the future to reason about the
behavior, but it also provides a cleaner path for electively aborting
the operation should that ever become desirable. For instance:

    % git sparse-checkout init
    WARNING: This operation will upgrade the repository format to
    WARNING: version 1 and enable per-worktree configuration, thus
    WARNING: potentially making the repository incompatible with
    WARNING: third-party tools.

    Are you sure you want to continue [y/N]?

Your response is also conflating the slight pain of repeated
`repo_git_path(r, "config.worktree")` with the need to upgrade to
per-worktree configuration, which highlights another issue...

The big question is: why does git-sparse-checkout mandate per-worktree
configuration? I haven't followed sparse checkout development closely,
so I may be missing some obvious reasons. I can see why you would want
to _recommend_ and even nudge people to use per-worktree
configuration, which you could do both in the documentation and even
as a "HINT" from the `git sparse-checkout init` command, but
absolutely forcing them into per-worktree configuration seems far too
opinionated for a general-purpose Git command and closes the door
unnecessarily on people who may have quite valid reasons for using
sparse checkout _without_ per-worktree configuration (i.e. perhaps
they only ever use a single worktree -- the main one -- or perhaps
they really do want the sparse checkout to apply to every worktree).
This unconditional enforcement of per-worktree config seems better
suited for `scalar` which is intentionally opinionated.

With the view that `git sparse-checkout init` is too opinionated and
closes doors unnecessarily, then `git sparse-checkout init` should not
be upgrading the repository to per-worktree configuration
unconditionally. Instead, either the documentation should recommend
this step to users; for example:

    It is recommended that sparse checkout be used with per-worktree
    configuration so that each worktree can have its own sparse
    settings. Per-worktree configuration can be enabled with the
    (fictitious) `git worktree config --enable-per-worktree` command:

    % git worktree config --enable-per-worktree
    % git sparse-checkout init

Or, enabling per-worktree configuration could be enabled _on-demand_
by `git sparse-checkout init`; for instance:

    % git sparse-checkout init --per-worktree

Although the immediate discussion is about git-sparse-checkout, this
idea that a command adapts to the repository rather than demanding a
specific repository arrangement, or indeed forcibly changing the
repository arrangement, is far friendlier and leaves doors open which
would otherwise be closed.

It also makes your proposed repo_config_set_worktree_gently() which
"does the right thing" much more palatable since "does the right
thing" no longer means forcibly changing the repository arrangement.
Instead, this convenience function would simply pick the correct
configuration file on behalf of the caller; namely, if
`extensions.worktreeConfig` is disabled, then it writes to
.git/config, whereas if `extensions.worktreeConfig` is enabled, then
it writes to .git/config.worktree or
.git/worktrees/<id>/config.worktree, depending upon the worktree
you're in. That behavior would satisfy your desire to have a
convenience function to modify the correct config file regardless of
whether the repository has per-worktree configuration or not, and
leaves git-sparse-checkout flexible enough to work with or without
per-worktree configuration. I would have no problem with a
repo_config_set_worktree_gently() function which works as described
here, whereas I feel plenty uncomfortable with the
repo_config_set_worktree_gently() implemented by this series.

Referring back to what you said earlier:

    However, if we don't also create this helper method for setting
    worktree-specific config, then we are going to hit this issue
    again. (Stolee)

Yes, we might hit this issue in the future if some command absolutely
requires per-worktree config, however, as outlined above, I think we
should strive as much as possible to make commands work without
requiring special repository arrangement, instead allowing people to
opt-in to repository-wide changes. By avoiding unconditionally
requiring the repository be configured in a particular way, we're less
likely to break third-party tools.
