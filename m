Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2825CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhL3HkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:40:20 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35650 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL3HkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 02:40:19 -0500
Received: by mail-pl1-f179.google.com with SMTP id n16so17724853plc.2
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 23:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO/zr7DrcTZeCdkH79j0uEEag3ZPunX672olcQwpt3c=;
        b=rEU9PpWpKhjH4goyqCPJmyNc1JNNp4T8i4z1WzG2EAoK8RaJWsdH7ToY4AlnInflLZ
         89LCya/x8/ypbNKIPIBfB/BGqu2UMV3Sw3qnrtA+9pAZg/uBPm5srTpo0ZwqJsDPZvMR
         fLv2yOZR4u/AKOe6VRh3zg3LhAuKVJp6A1iTgsJ+PSUsHHf789bY3JW8MzWP8sXwub/W
         3MlLQAg7W59N8nLf6mGyxrUnBRrYMo1qpb6Q79GAeGdm+vmPXYjosJGOuqGYsXX65RTx
         tkF8ijJNSjLI6sWw7EA26/1RtRRpBPl4pheZn1sgJerTwLOcFs4/WC13Xcp9GavgeNgR
         qr0A==
X-Gm-Message-State: AOAM532JtfYF96cdcrWL5MEHVccYXbndK3QHfoJFMTdJ5NpNzGasZuDK
        TepnCVq1PwbCY0fYLKTWYi2PKtW1QriCc7HWVKQ=
X-Google-Smtp-Source: ABdhPJxLdKJnUZw2lXAihrbeTpcFCP4mgAZWhY7sfFy7QLnkOHziYPplmi0ymxHhOzY/tia83lAMzJhv/j+GFHvRKEc=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr4417412pls.145.1640850019135; Wed, 29
 Dec 2021 23:40:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
In-Reply-To: <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Dec 2021 02:40:07 -0500
Message-ID: <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 4:40 AM Elijah Newren <newren@gmail.com> wrote:>
> On Tue, Dec 28, 2021 at 1:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >      ++init-worktree-config::
> >      ++
> >      ++Initialize config settings to enable worktree-specific config settings.
> >      ++This will set `core.repositoryFormatversion=1` and enable
> >      ++`extensions.worktreeConfig`, which might cause some third-party tools from
> >      ++being able to operate on your repository. See CONFIGURATION FILE for more
> >      ++details.
>
> So, if users attempt to use `git worktree add` or `git sparse-checkout
> {init,set}` without first running this, they can break other
> worktrees.  And if they do run this new command, they potentially
> break third-party tools or older git versions.

When you say "can break other worktrees", you don't necessarily mean
that in general but rather in regard to sparse-checkout -- in
particular, the sparse-checkout config settings and the
`info/sparse-checkout file` -- correct? (Genuine question; I want to
make sure that I'm actually understanding the issues under
discussion.)

> >      +    After these steps, the first worktree will have sparse-checkout enabled
> >      +    with whatever patterns exist. The worktree does not immediately have
> >      +    those patterns applied, but a variety of Git commands would apply the
> >      +    sparse-checkout patterns and update the worktree state to reflect those
> >      +    patterns. This situation is likely very rare and the workaround is to
>
> No, it's not even rare, let alone very rare.  I'd actually call it
> common.  Since 'sparse-checkout disable' does not delete the
> sparse-checkout file, and we've encouraged folks to use the
> sparse-checkout command (or a wrapper thereof) instead of direct
> editing of the sparse-checkout file (and indeed, the sparse-checkout
> command will overwrite the sparse-checkout file which further
> discourages users from feeling they own it), having the file left
> around after disabling is the common case.  So, the only question is,
> how often do users disable and re-enable sparse-checkout, and
> potentially only do so in some of their worktrees?  At my $DAYJOB,
> that's actually quite common.  I got multiple reports quite soon after
> introducing our `sparsify` tool about users doing something like this;
> this is what led me to learn of the extensions.worktreeConfig, and why
> I pointed it out to you on your first submission of
> git-sparse-checkout[1]
> (https://lore.kernel.org/git/CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com/)

I think the link you provide here answers the genuine question I had
asked in [1] where I didn't understand why git-sparse-checkout is
forcing the repository to use per-worktree configuration. I also just
(re)discovered [2] which makes it clear that per-worktree
sparse-checkout was considered important very early on in the
development of "multiple checkouts".

[1]: https://lore.kernel.org/git/CAPig+cRombN-8g0t7Hs9qQypJoY41gK3+kvypH4D0G6EB4JgbQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/1404891197-18067-32-git-send-email-pclouds@gmail.com/

> So, here's the experience I expect from these patches at $DAYJOB:
>   (1) Several users per week hit the case of one worktree being
> sparsified when it wasn't supposed to be.
>   (2) These users have no idea how to figure out what they need to do
> to fix it.  The init-worktree-config is no more discoverable than the
> documentation on the official steps for enabling
> extensions.worktreeConfig (See
> https://lore.kernel.org/git/CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com/
> up through the paragraph, "Further, it's not even clear people would
> look at git-worktree.txt.)
>   (3) Even if they do discover it, and run it, it's an extra step they
> never needed to take before.  Why are we adding a "unbreak these other
> commands we want to run" step?
>   (4) Also, even if they do discover it, and run it, suddenly we are
> setting core.repositoryFormatVersion=1.  That scares me.  I have years
> of experience at $DAYJOB saying that the tooling we have works fine
> with extensions.worktreeConfig=true.  I have none with setting
> core.repositoryFormatVersion=1, but now we're effectively requiring it
> by your documentation.  I have no idea how
> jgit/egit/other-random-stuff interacts with that.  I'd be willing to
> do some tests with targetted users to try to learn more, but suddenly
> turning it on for everyone in cases that we know worked fine without
> it previously feels unsafe to me.  Maybe I'm over-worrying here, but
> see also commit 11664196ac ("Revert "check_repository_format_gently():
> refuse
> extensions for old repositories"", 2020-07-15) -- it just feels a bit
> late to recommend for users, especially when they'll see it as "oh, if
> you don't want this other bug we recently introduced you need to run
> this....".

Point #4 is pretty compelling, and the "ship" of enforcing
`core.repositoryFormatVersion=1` when using `extension` configs has
"already sailed" anyhow, as 11664196ac ("Revert
"check_repository_format_gently(): refuse extensions for old
repositories"", 2020-07-15) clearly indicates.

> So, I'd like to reiterate my earlier suggestion which would avoid
> these regressions while also fixing the reported bug:
>   * If core.bare=true or core.worktree is set, then at `git worktree
> add` time, automatically run the logic you have here for
> init-worktree-config.  Having either of those config settings with
> multiple worktrees is currently broken in all git versions and likely
> in most all external tools.  As such, being aggressive in the new
> config settings to allow new versions of git to work seems totally
> safe to me -- we can't be any more broken than we already were.
>   * If core.bare=false and core.worktree is not set, then:
>     * `git sparse-checkout {init,set}` should set
> extensions.worktreeConfig if not already set, and always set the
> core.sparse* and index.sparse settings in worktree-specific files.
>     * `git worktree add`, if extensions.worktreeConfig is already set,
> will copy both the info/sparse-checkout file and the config.worktree
> settings (module core.bare and core.worktree, if present) to the new
> worktree

Thanks for the clearly written enumeration of how you expect this to
work. This summary pretty well (or entirely) captures the conclusions
I arrived at, as well, after devoting a chunk of time today thinking
through the cases. If I'm understanding everything correctly, the
approach outlined here solves the bare-worktree problem in the least
invasive and least dangerous way (for older Git versions and foreign
tools). And we don't even need the `git worktree init-worktree-config`
subcommand (though we need the underlying functionality).
