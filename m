Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8AC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 07:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiACHLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 02:11:44 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:55073 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiACHLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 02:11:43 -0500
Received: by mail-pj1-f43.google.com with SMTP id jw3so28145399pjb.4
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 23:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0yHX11hTCFUM9BxwUK4oV5ndqWKqhcIWivZHgYOEls=;
        b=Wza7hmohjsGWQx7DkeNDR+7Qod6nLLmWF4kdA9j+nWDgjE6gEXO2YN278OtiMh67rm
         UjNl25qgXG+rJ2S6O4Q3GxRll+ryo9+DvbUVJz8UDSbVmLGPwFNdpXMvp0kKOCxboUJ8
         ndKyayuCQ5sfOmmkeiFqu0hFPd/zmUwoSXF5WYxr6TsfK5GibdM4Rog4hvNh+FF2wkb6
         YbpyPvmUCdlGTo+Lw1MLJk5v+R3yvB9mdiLPemtFsD9Lax4F942kN1AIq4+eYnooWHxi
         TCeGO/ngHRO3jAJyDoSxdWZJ02961I9+5LRmIZYNKVUsQHosK6jJNWzUuO3XBl/CR87U
         3jAA==
X-Gm-Message-State: AOAM531UHzHGxmS3NFW6k03A+8VPYrQ7fI9ZgRV0Aywjg/hVL9l4X3KD
        /ptgDvp8HRs8mU/YadOcmoKzEpxA8E73z56J4/I=
X-Google-Smtp-Source: ABdhPJyk5ahkeyMP+RHTD+iJS4O3xQnqQUJyJR/ck0x0QWNlW+GJeWqhJpElLzUJWwyJx438f1xmxUHE4BBjFwnA7uk=
X-Received: by 2002:a17:902:e211:b0:149:8bd6:583b with SMTP id
 u17-20020a170902e21100b001498bd6583bmr28005086plb.35.1641193903167; Sun, 02
 Jan 2022 23:11:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
 <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
 <f62709d5-a0d4-dc0c-461a-c4c75c810340@gmail.com> <CABPp-BG2Ueb9rBRNZz3Z_8V7hin5SamzOJLNpjrg0k-QGUV4zA@mail.gmail.com>
In-Reply-To: <CABPp-BG2Ueb9rBRNZz3Z_8V7hin5SamzOJLNpjrg0k-QGUV4zA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 02:11:32 -0500
Message-ID: <CAPig+cS+-L-5feyjNS5QJm-NO5Ou0EDDks_cVPGrW9_BorCv=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 2:29 PM Elijah Newren <newren@gmail.com> wrote:
> On Thu, Dec 30, 2021 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> > On 12/30/2021 2:40 AM, Eric Sunshine wrote:
> > > On Wed, Dec 29, 2021 at 4:40 AM Elijah Newren <newren@gmail.com> wrote:>
> > >>   * If core.bare=true or core.worktree is set, then at `git worktree
> > >> add` time, automatically run the logic you have here for
> > >> init-worktree-config.  Having either of those config settings with
> > >> multiple worktrees is currently broken in all git versions and likely
> > >> in most all external tools.  As such, being aggressive in the new
> > >> config settings to allow new versions of git to work seems totally
> > >> safe to me -- we can't be any more broken than we already were.
> >
> > I'm not sure I agree with the "currently broken in all git versions"
> > because when extensions.worktreeConfig is not enabled, the core.bare
> > and core.worktree settings are ignored by the worktrees. This upgrade
> > during 'add' is the only thing I am not so sure about.
>
> Oh, you're right; I mis-spoke.  If someone has core.bare=true and has
> multiple worktrees, AND never attempts to use sparse-checkouts OR
> otherwise set extensions.worktreeConfig, then git still works due to
> git's special-case logic that will override core.bare in this
> configuration.  It's just setting them up for a ticking time bomb,
> waiting for them to either use an external tool that doesn't share
> that special case override-core.bare logic, or for the user to decide
> to set extensions.worktreeConfig directly or use sparse-checkouts.

So, how does this alter the proposed logic? Or does it? Does the above
condition get revised to:

    if extensions.worktreeConfig=true and
        (.git/config contains core.bare=true or core.worktree):
            relocate core.bare/core.worktree to .git/config.worktree

That is, we need to relocate core.bare and core.worktree from
.git/config to .git/config.worktree if and only if
extensions.worktreeConfig=true (because, due to the special-case
handling, those two keys don't interfere with anything when
extensions.worktreeConfig is not true).

This, of course, doesn't help the case if someone has existing
worktrees and decides to flip extensions.worktreeConfig to true
without doing the manual bookkeeping, but that case has always been
broken (and is documented, though not necessarily where people will
look). The new `git worktree add` logic, however, will fix that
brokenness automatically when a new worktree is added.

> > >>   * If core.bare=false and core.worktree is not set, then:
> >
> > >>     * `git sparse-checkout {init,set}` should set
> > >> extensions.worktreeConfig if not already set, and always set the
> > >> core.sparse* and index.sparse settings in worktree-specific files.
> >
> > This should happen no matter the case of core.bare and core.worktree
> > existing, right?
>
> Hmm.  I think that's safe for people who cloned and used `git worktree
> add` with newer git versions, since `git worktree add` will have moved
> core.bare and core.worktree to the config.worktree file when those
> have non-default values.
>
> But, we might want to help out the folks who have existing repos with
> which they have used older git versions.  So, we could have `git
> sparse-checkout {init,set}` check for non-default values of
> core.bare/core.worktree in the shared config file, and, if found, exit
> with an error which point users at some relevant documentation (which
> may just suggest 'git worktree add temporary && git worktree remove
> temporary' as a workaround for those caught in such a state.)

I'm probably missing something obvious, but rather than error out,
can't we just automatically relocate core.bare and core.worktree from
.git/config to .git/config.worktree in this case?
