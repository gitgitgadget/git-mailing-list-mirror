Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C72C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 07:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhL0HPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 02:15:34 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:33721 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhL0HPd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 02:15:33 -0500
Received: by mail-pf1-f181.google.com with SMTP id 205so13050738pfu.0
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 23:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5kUBOp8K2K5Ldv5gR2rEqJLYLBy7ViYiXqlu7lJ8WM=;
        b=RRmgiiuMKOF6YetRAk7cwSl2/8NAqMpThlhJn7JMuivkX71ZllJ5hvr6PhiBeGLPzu
         vxWL0nSZOMAKt6GVxPlUoK3NjxG/MQ5mazPd2EkYMHyqdHvcJLlLT6cTr3pYV+4ruDKG
         EGeI7PJ+AUL9ryu+uJnEoZzMfRSdZeE62A67VGfBs0MbnPYcw/yUHp68y+B209vo3KvV
         RvRmKSto8ps3LsIoJzLBVEQgmf0d+ZIJ2ckhGjfg64jhd6w7QEebz3tnJCIyjM1jgAyJ
         t/th43L/53PCg+RHjHjuTU7uq2zMrL4Mjxp+nEqzQHGwvxNhI+WnFtLKtV+pOuO0NYaY
         DQ9g==
X-Gm-Message-State: AOAM531KHi9t2TIdZi3gfQp+N40sXi+VbgeXZ4Rv+M7DwmUlGUvwWHtA
        Rv5w8vtg5aghF60J9tfA28aX4kqWPcFt+6Tfjfw=
X-Google-Smtp-Source: ABdhPJzXzx+ICzvngxqlgKY7k1crszOtcE5uV2lmJ8iyyc547/1txSkecd86qXBRKrZmFaKXYyCwsH6sWsWm9EC5Aeo=
X-Received: by 2002:a63:380e:: with SMTP id f14mr14523654pga.227.1640589333323;
 Sun, 26 Dec 2021 23:15:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
In-Reply-To: <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Dec 2021 02:15:22 -0500
Message-ID: <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
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

On Wed, Dec 22, 2021 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 8:00 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This patch series includes a fix to the bug reported by Sean Allred [1] and
> > diagnosed by Eric Sunshine [2].
>
> This feels like a bandaid to me.  In addition to fixating on core.bare
> (thus overlooking core.worktree), it also overlooks that people can
> use worktrees without using sparse-checkout.  What if they do
> something like:
>
>   git clone --bare $URL myrepo
>   cd myrepo
>   git worktree add foo
>   git worktree add bar
>   git worktree add baz
>   ... days/weeks later ...
>   cd foo
>   git config extensions.worktreeConfig true
>   git config status.showUntrackedFiles no  # Or other config options
>   ... hours/days later ..
>   cd ../bar
>   git status
>
> At this point the user gets "fatal: this operation must be run in a
> work tree".

Your example indeed leads to a broken state because it doesn't follow
the instructions given by git-worktree.txt for enabling
`extensions.worktreeConfig`, which involves additional bookkeeping
operations beyond merely setting that config variable. It is exactly
this sort of situation which prompted me to suggest several
times[1,2,3] in the conversation following my diagnosis of the
problem, as well as in my reviews of this series, that we may want to
add a git-worktree subcommand which does all the necessary bookkeeping
to enable `extensions.worktreeConfig` rather than expecting users to
handle it all manually. In [1], I called this hypothetical command
`git worktree manage --enable-worktree-config ` and in [4], I called
it `git worktree config --enable-per-worktree` (not because I like
either name, but because I couldn't think of anything better).

> I think that "git
> worktree add" should check if either core.bare is false or
> core.worktree is set, and if so then set extensions.worktreeConfig and
> migrate the relevant config.

(I think you meant "...if either core.bare is _true_ or...".)

Similar to my response to Sean in [1] and to Stolee in [2], while this
may help the situation for worktrees created _after_
`extensions.worktreeConfig` is enabled, it does _not_ help existing
worktrees at all. For this reason, in my opinion, `git worktree add`
is simply not the correct place to be addressing this problem, and
it's why I suggested a separate command for enabling the feature and
doing all the necessary bookkeeping. It's also why I suggested[2] that
in the long run, we may want per-worktree config to be the default
(and only) behavior rather than the current (legacy) behavior of all
config being shared between worktrees.

Aside from that, I'm uncomfortable with the suggestion that `git
worktree add` should be responsible for making these sort of dramatic
changes (upgrading to version=1 and enabling
`extensions.worktreeConfig`) to the repository automatically. That
seems very much out of scope for what this command should be doing. On
the other hand, I would have no problem with `git worktree add`
protecting users by detecting whether `core.bare=true` or
`core.worktree` is set in the shared .git/config file and aborting
with an error if so, and giving a "HINT" telling the user to enable
per-worktree config via the (hypothetical) `git worktree config
--enable-per-worktree` command.

Regarding your feeling that this patch series is a "band-aid", while I
agree with you that we ultimately need a better approach, such as the
hypothetical `git worktree config --enable-per-worktree` (or
eventually making per-worktree config be the default), that better
solution does not need to be implemented today, and certainly
shouldn't derail _this_ patch series which is aimed at fixing a very
real bug which exists presently in `git sparse-checkout init`. This
patch series does need a good number of improvements and fixes before
it is ready -- as indicated by my v2 review comments[4,5,6], the most
obvious of which is its missing handling of `core.worktree` -- but I
do think this series is headed in the correct direction by focusing on
fixing the immediate problem with `git sparse-checkout init` (and
paving the way for an eventual more complete solution, such as `git
worktree config --enable-per-worktree `).

[1]: https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/
[3]: https://lore.kernel.org/git/CAPig+cRombN-8g0t7Hs9qQypJoY41gK3+kvypH4D0G6EB4JgbQ@mail.gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com/
[5]: https://lore.kernel.org/git/CAPig+cRi2SA6+poaemY8XR5ZoMweuztfiENpcRVOCnukg3Qa7w@mail.gmail.com/
[6]: https://lore.kernel.org/git/CAPig+cRuY40RNi4bC3CBfghLLqz74VUPRbaYJYEhmF78b0GfPQ@mail.gmail.com/#t

> I also think `git worktree add` should handle additional configuration
> items related to sparse checkouts (as we've discussed elsewhere in the
> past), but that's going a bit outside the scope of this series; I only
> mention it so that we're aware the functionality added to `git
> worktree add` will be getting some additions in the future.

I vaguely recall some mention of this not long ago on the list but
didn't follow the discussion at all. Do you have pointers or a
summary?
