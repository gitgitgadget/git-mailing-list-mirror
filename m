Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F0C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 04:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiKWEZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 23:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiKWEYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 23:24:47 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E667E35
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 20:21:15 -0800 (PST)
Date:   Wed, 23 Nov 2022 04:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1669177272; x=1669436472;
        bh=r/J8OvAjJJ+ex2weppY9Zmb+OPqI5aCwIWo1eovnCDc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mbJzP1RM6BJE3M628Zi38AisLDN5qwG7KXt9X9FiuBHdoQY/q4PafFQgGS7nNh+tC
         6tmqVOiQBiGkNHNzxKrsJbGiVOhA2PL+Zhw3ccqRj8nKnIz6VOkSSGmNcD8jVeiQP+
         ZFbbSrGuz3qNvoadC/fEVwtfDQTY4jJkMNXMg07je/rjCbOSm2o+hEq0fY/Jqw5K4S
         D3yHdUWgBGuDr33UvM/CY+fPOm26fHnuFfAkJAhR8FHnG73g3O9kxZAyPSK91YmVK9
         +N0076fbM9I0bawKtw/ikseMj1FArKI8dRsMYHHf7mA8/aKczCuyPmD2cJrQQDM+gD
         2lBciWfwu2miQ==
To:     phillip.wood@dunelm.org.uk
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/2] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20221123042052.t42jmsqjxgx2k3th@phi>
In-Reply-To: <b1ac730b-b4bd-3045-ce3b-1e5d9aca169a@dunelm.org.uk>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <CAPig+cTTn764ObHJuw8epOtBdTUwocVRV=tLieCa4zf-PGCegw@mail.gmail.com> <221117.86sfihj3mw.gmgdl@evledraar.gmail.com> <20221119034728.m4kxh4tdpof7us7j@phi> <b1ac730b-b4bd-3045-ce3b-1e5d9aca169a@dunelm.org.uk>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/22 02:45PM, Phillip Wood wrote:
> On 19/11/2022 03:47, Jacob Abel wrote:
> > On 22/11/17 11:00AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> On Tue, Nov 15 2022, Eric Sunshine wrote:
> >>
> >>> On Thu, Nov 10, 2022 at 6:32 PM Jacob Abel <jacobabel@nullpo.dev> wro=
te:
> >>>> While working with the worktree based git workflow, I realised that =
setting
> >>>> up a new git repository required switching between the traditional a=
nd
> >>>> worktree based workflows. Searching online I found a SO answer [1] w=
hich
> >>>> seemed to support this and which indicated that adding support for t=
his should
> >>>> not be technically difficult.
> >>>>
> >>>>    * adding orphan branch functionality (as is present in `git-switc=
h`)
> >>>>      to `git-worktree-add`
> >>>
> >>> I haven't had a chance yet to read v3, but can we take a step back fo=
r
> >>> a moment and look at this topic from a slightly different angle?
> >>> Setting aside the value of adding --orphan to `git worktree add`
> >>> (which, I'm perfectly fine with, as mentioned earlier), I have a
> >>> question about whether the solution proposed by this series is the
> >>> best we can do.
> >>>
> >>> As I understand it, the actual problem this series wants to solve is
> >>> that it's not possible to create a new worktree from an empty bare
> >>> repository; for instance:
> >>>
> >>>      % git init --bare foo.git
> >>>      % git -C foo.git worktree add -b main bar
> >>>      Preparing worktree (new branch 'main')
> >>>      fatal: not a valid object name: 'HEAD'
> >>>      %
> >>>
> >>> This series addresses that shortcoming by adding --orphan, so that th=
e
> >>> following works:
> >>>
> >>>      % git init --bare foo.git
> >>>      % git -C foo.git worktree add --orphan main bar
> >>>      Preparing worktree (new branch 'main')
> >>>      %
> >>>
> >>> However, is this really the best and most user-friendly and most
> >>> discoverable solution? Is it likely that users are somehow going to
> >>> instinctively use --orphan when they see the "fatal: not a valid
> >>> object name: 'HEAD'" error message?
> >>>
> >>> Wouldn't a better solution be to somehow fix `git worktree add -b
> >>> <branch>` so that it just works rather than erroring out? I haven't
> >>> delved into the implementation to determine if this is possible, but
> >>> if it is, it seems a far superior "fix" for the problem shown above
> >>> since it requires no extra effort on the user's part, and doesn't
> >>> raise any discoverability red-flags (since nothing needs to be
> >>> "discovered" if `-b <branch>` works as expected in the first place).
> >>>
> >>> If fixing `-b <branch>` to "just work" is possible, then --orphan is
> >>> no longer a needed workaround but becomes "icing on the cake".
> >>
> >> That's a really good point, and we *could* "fix" that.
> >>
> >> But I don't see how to do it without overloading "-b" even further, in=
 a
> >> way that some users either might not mean, or at least would be
> >> confusing.
> >>
> >> E.g. one script "manually clones" a repo because it does "git init",
> >> "git remote set-url", "git fetch" etc. Another one makes worktrees fro=
m
> >> those fresh checkouts once set up.
> >>
> >> If we "DWYM" here that second step will carry forward the bad state
> >> instead of erroring early.
>
> Wouldn't the first script error out if there was a problem?
>
> >> I haven't fully thought this throuh, so maybe it's fine, just
> >> wondering...
> >>
> >> ...an alternate way to perhaps to do this would be to detect this
> >> situation in add(), and emit an advise() telling the user that maybe
> >> they want to use "--orphan" for this?
> >>
> >
> > Prior to writing this patch, I tried to determine if there was a succin=
ct way
> > to make `-b` "just work" however I wasn't able to find one that wouldn'=
t
> > introduce unintuitive behavior.
>
> Can you say a bit more about what the unintuitive behavior was? As I
> understand it the problem is that "git branch" errors out when HEAD is a
> symbolic ref pointing to a ref that does not exist. I think we can use
> read_ref() to check for that before running "git branch" and act
> accordingly. We might want to check if HEAD matches init.defaultBranch
> and only do an orphan checkout in the new worktree in that case.

The main issue is that creating an orphan branch is very rarely what the us=
er
intends to do. To modify `-b` to automatically create an orphan would requi=
re
that you set the behavior so that `-b` (and DWYM) creates a new orphan bran=
ch
only when the repository has no branches (i.e. a fresh init repo).

This has the effect that the command will perform separate operations depen=
ding
on the state of the repository and when mixed in with other commands it qui=
ckly
becomes confusing.

In the directory shown below:

    ../
    ./
    .git/

with `.git` containing a bare repository with no branches,

    % git worktree add foobar/

would now create a worktree `foobar/` with orphan branch `foobar` (which
technically speaking doesn't exist until a commit is made).

This behavior continues to apply until your first commit.

However after the following:

    % git worktree add foo/
    % cd foo/
    # create files
    % git add .
    % cd ../
    % git worktree add bar/
    % cd bar/
    # create files
    % cd ../foo/
    % git commit -m "foo commit"
    % cd ../bar/
    % git add .
    % git commit -m "bar commit"
    % cd ../foobar/
    # create files
    % git add .
    % git commit -m "foobar commit"

In that same directory:

    ../
    ./
    .git/
    foobar/ <- on branch foobar @ "foobar commit"
    foo/    <- on branch foo    @ "foo commit"
    bar/    <- on branch bar    @ "bar commit"

that same command now creates a branch which is based on whichever referenc=
e
HEAD happens to now refer to. In the case of a directory which is not a wor=
king
tree, it's not always clear to me what HEAD should actually point to. So no=
w
what should the following do:

    % git worktree add what_am_i/

The user has just created 3 worktrees containing orphan branches. Wouldn't =
the
user now reasonably expect that from this directory with no working tree th=
at
the above command would also create an orphan branch?

And when it doesn't, which branch is the history based off of? Which one wi=
ll
the user expect?

- worktree foobar/ which was created first but with the most recent initial=
 commit?
- worktree foo/ where the user has been working the longest?
- worktree bar/ which was created last but which had the earliest initial c=
ommit?

This isn't necessarily due to this change in particular but rather that thi=
s
change would expose users to an edge case where they can run into really
unintuitive behavior.

Of course this is a bit of an unusual use example but I'd rather warn & dir=
ect
the user when they need to do something slightly different/unusual to handl=
e an
edge case rather than risk users getting weird behavior that leaves them tu=
rning
to Stack Overflow when they encounter an edge case.

>
> > My conclusion was that it was probably best
> > to break it out into a separate command as the other tools had.
> >
> > I'd support adding an `advise()` for at least the basic case where you =
try to
> > create a worktree and no branches currently exist in the repository.
> > i.e. something like this:
> >
> >      % git init --bare foo.git
> >      % git -C foo.git branch --list
> >
> >      % git -C foo.git worktree add foobar/
> >      hint: If you meant to create a new initial branch for this reposit=
ory,
> >      hint: e.g. 'main', you can do so using the --orphan option:
> >      hint:
> >      hint:   git worktree add --orphan main main/
> >      hint:
> >      fatal: invalid reference: 'foobar'
> >
> > and
> >
> >      % git init --bare foo.git
> >      % git -C foo.git --no-pager branch --list
> >
> >      % git -C foo.git worktree add -b foobar foobardir/
> >      hint: If you meant to create a new initial branch for this reposit=
ory,
> >      hint: e.g. 'main', you can do so using the --orphan option:
> >      hint:
> >      hint:   git worktree add --orphan main main/
> >      hint:
> >      fatal: invalid reference: 'foobar'
> >
> > but not in the following circumstances:
> >
> >      % git init --bare foo.git
> >      % ...
> >      % git -C foo.git --no-pager branch --list
> >      + foo
> >        bar
> >      % git -C foo.git worktree add foobar/
> >      Preparing worktree (new branch 'foobar')
> >      HEAD is now at 319605f8f0 This is a commit message
> >
> > or
> >
> >      % git init --bare foo.git
> >      % ...
> >      % git -C foo.git --no-pager branch --list
> >      + foo
> >        bar
> >      % git -C foo.git worktree add -b foobar foobardir/
> >      Preparing worktree (new branch 'foobar)
> >      HEAD is now at 319605f8f0 This is a commit message
> >
> > Would there be any other circumstances where we'd definitely want an `a=
dvise()`?
> > Generally I'd assume that outside of those two circumstances, most user=
s will
> > rarely intend to make an orphan without already knowing they absolutely=
 need to
> > make an orphan.
>
> I don't think it matters if the repository is bare so I think it would
> be good to advise() on
>
> =09% git init foo
> =09% git -C foo worktree add bar
>
> Best Wishes
>
> Phillip

Correct. It shouldn't matter between bare and non-bare. I tend to prefer ba=
re repos
when working with worktrees which is why I wrote it that way but I'm defini=
tely
intending that the advise() works the same for both bare and non-bare.

