Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377DC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 03:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiKSDu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiKSDuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 22:50:35 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B70C0513
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 19:47:51 -0800 (PST)
Date:   Sat, 19 Nov 2022 03:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1668829669; x=1669088869;
        bh=XVScfsJVpTV5FRVNnvZxrFfllDKx3oeJbv6AfPRsu0o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=JSna2JvqKCTX8ZRTqQOPMsEW0ts3pjkROqp3I58nkAOW9x62uDYM/6lKmHkjBhFpq
         q6bgHqRWLZpQuRllV8841qZp0wpKqctIj8maeHoHgrMkxfuhUbM9+4D5SSmEHh+ICK
         DgrzJNw9Of8c19A7YEcA+7Lamkg4xwoEygDkEZQVmcWRvVJi9pfFxSW/xMOSuKnILj
         Cpw4HWcIbMF1LlWvBRZTI11q3nVrQ+uL7cVcurnnAsOsqGTNejKHo1y0rAH1VWPcnQ
         E9w72KQRUPdorEKY55EIZIfZEZoF3NAdb8YInAMgUOPts89RqfhzUjGj8bRtZlSHfu
         O8SFZLJHULyZQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221119034728.m4kxh4tdpof7us7j@phi>
In-Reply-To: <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com> <221117.86sfihj3mw.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/17 11:00AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Tue, Nov 15 2022, Eric Sunshine wrote:
>
> > On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wrote=
:
> >> While working with the worktree based git workflow, I realised that se=
tting
> >> up a new git repository required switching between the traditional and
> >> worktree based workflows. Searching online I found a SO answer [1] whi=
ch
> >> seemed to support this and which indicated that adding support for thi=
s should
> >> not be technically difficult.
> >>
> >>   * adding orphan branch functionality (as is present in `git-switch`)
> >>     to `git-worktree-add`
> >
> > I haven't had a chance yet to read v3, but can we take a step back for
> > a moment and look at this topic from a slightly different angle?
> > Setting aside the value of adding --orphan to `git worktree add`
> > (which, I'm perfectly fine with, as mentioned earlier), I have a
> > question about whether the solution proposed by this series is the
> > best we can do.
> >
> > As I understand it, the actual problem this series wants to solve is
> > that it's not possible to create a new worktree from an empty bare
> > repository; for instance:
> >
> >     % git init --bare foo.git
> >     % git -C foo.git worktree add -b main bar
> >     Preparing worktree (new branch 'main')
> >     fatal: not a valid object name: 'HEAD'
> >     %
> >
> > This series addresses that shortcoming by adding --orphan, so that the
> > following works:
> >
> >     % git init --bare foo.git
> >     % git -C foo.git worktree add --orphan main bar
> >     Preparing worktree (new branch 'main')
> >     %
> >
> > However, is this really the best and most user-friendly and most
> > discoverable solution? Is it likely that users are somehow going to
> > instinctively use --orphan when they see the "fatal: not a valid
> > object name: 'HEAD'" error message?
> >
> > Wouldn't a better solution be to somehow fix `git worktree add -b
> > <branch>` so that it just works rather than erroring out? I haven't
> > delved into the implementation to determine if this is possible, but
> > if it is, it seems a far superior "fix" for the problem shown above
> > since it requires no extra effort on the user's part, and doesn't
> > raise any discoverability red-flags (since nothing needs to be
> > "discovered" if `-b <branch>` works as expected in the first place).
> >
> > If fixing `-b <branch>` to "just work" is possible, then --orphan is
> > no longer a needed workaround but becomes "icing on the cake".
>
> That's a really good point, and we *could* "fix" that.
>
> But I don't see how to do it without overloading "-b" even further, in a
> way that some users either might not mean, or at least would be
> confusing.
>
> E.g. one script "manually clones" a repo because it does "git init",
> "git remote set-url", "git fetch" etc. Another one makes worktrees from
> those fresh checkouts once set up.
>
> If we "DWYM" here that second step will carry forward the bad state
> instead of erroring early.
>
> I haven't fully thought this throuh, so maybe it's fine, just
> wondering...
>
> ...an alternate way to perhaps to do this would be to detect this
> situation in add(), and emit an advise() telling the user that maybe
> they want to use "--orphan" for this?
>

Prior to writing this patch, I tried to determine if there was a succinct w=
ay
to make `-b` "just work" however I wasn't able to find one that wouldn't
introduce unintuitive behavior. My conclusion was that it was probably best
to break it out into a separate command as the other tools had.

I'd support adding an `advise()` for at least the basic case where you try =
to
create a worktree and no branches currently exist in the repository.
i.e. something like this:

    % git init --bare foo.git
    % git -C foo.git branch --list

    % git -C foo.git worktree add foobar/
    hint: If you meant to create a new initial branch for this repository,
    hint: e.g. 'main', you can do so using the --orphan option:
    hint:
    hint:   git worktree add --orphan main main/
    hint:
    fatal: invalid reference: 'foobar'

and

    % git init --bare foo.git
    % git -C foo.git --no-pager branch --list

    % git -C foo.git worktree add -b foobar foobardir/
    hint: If you meant to create a new initial branch for this repository,
    hint: e.g. 'main', you can do so using the --orphan option:
    hint:
    hint:   git worktree add --orphan main main/
    hint:
    fatal: invalid reference: 'foobar'

but not in the following circumstances:

    % git init --bare foo.git
    % ...
    % git -C foo.git --no-pager branch --list
    + foo
      bar
    % git -C foo.git worktree add foobar/
    Preparing worktree (new branch 'foobar')
    HEAD is now at 319605f8f0 This is a commit message

or

    % git init --bare foo.git
    % ...
    % git -C foo.git --no-pager branch --list
    + foo
      bar
    % git -C foo.git worktree add -b foobar foobardir/
    Preparing worktree (new branch 'foobar)
    HEAD is now at 319605f8f0 This is a commit message

Would there be any other circumstances where we'd definitely want an `advis=
e()`?
Generally I'd assume that outside of those two circumstances, most users wi=
ll
rarely intend to make an orphan without already knowing they absolutely nee=
d to
make an orphan.

