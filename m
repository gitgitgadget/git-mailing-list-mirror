Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FB0C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhLRVzq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 18 Dec 2021 16:55:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20563 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhLRVzp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 16:55:45 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BILtduT092395
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Dec 2021 16:55:42 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Sean Allred'" <allred.sean@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com> <014701d7f437$5ae45110$10acf330$@nexbridge.com> <CABceR4Z+CoaUuGrJS+D1C9x+nR278S4ATWozz-ni2Y96FJc3cg@mail.gmail.com>
In-Reply-To: <CABceR4Z+CoaUuGrJS+D1C9x+nR278S4ATWozz-ni2Y96FJc3cg@mail.gmail.com>
Subject: RE: Bug report - Can create worktrees from bare repo / such worktrees can fool is_bare_repository()
Date:   Sat, 18 Dec 2021 16:55:34 -0500
Organization: Nexbridge Inc.
Message-ID: <000401d7f45a$005abea0$01103be0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKeYwgHoGmGxJSEPR+fKunQIMLw7wHdi7v/AVn1BxyqkiufkA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 18, 2021 2:01 PM: Sean Allred wrote:
> On Sat, Dec 18, 2021 at 11:47 AM <rsbecker@nexbridge.com> wrote:
> >
> > On December 18, 2021 11:47 AM, Sean Allred wrote:
> > > Hi folks! See the following bug report. Let me know if anything is
> > > unclear -- in all honesty, I neglectfully `git worktree remove
> > > --force`'d the first one I wrote...
> > >
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your issue.
> > >
> > > What did you do before the bug happened? (Steps to reproduce your
> > > issue)
> > >
> > >     ~$ git clone --bare https://github.com/git/git.git
> > >     ---clip---
> > >
> > >     ~/gitbare$ git config --list --show-origin
> > >     file:config     core.repositoryformatversion=1
> > >     file:config     core.filemode=false
> > >     file:config     core.bare=true
> > >     file:config     core.ignorecase=true
> > >     file:config     remote.origin.url=https://github.com/git/git.git
> > >
> > >     ~/gitbare$ git worktree add --no-checkout ../next
> > >     Preparing worktree (checking out 'next')
> > >
> > >     ~/gitbare$ git config --list --show-origin
> > >     file:config     core.repositoryformatversion=1
> > >     file:config     core.filemode=false
> > >     file:config     core.bare=true
> > >     file:config     core.ignorecase=true
> > >     file:config     remote.origin.url=https://github.com/git/git.git
> > >
> > >     ~/gitbare$ cd ../next/
> > >
> > >     ~/next$ git config --list --show-origin
> > >     file:../gitbare/config    core.repositoryformatversion=1
> > >     file:../gitbare/config    core.filemode=false
> > >     file:../gitbare/config    core.bare=true
> > >     file:../gitbare/config    core.ignorecase=true
> > >     file:../gitbare/config    remote.origin.url=https://github.com/git/git.git
> > >
> > >     ~/next$ git rev-parse --is-bare-repository
> > >     false
> > >
> > >     ~/next$ git config extensions.worktreeconfig true
> > >     ~/next$ git rev-parse --is-bare-repository
> > >     true
> > >
> > >     ~/next$ git config --unset extensions.worktreeconfig
> > >     ~/next$ git rev-parse --is-bare-repository
> > >     false
> > >
> > > I actually found this situation (and narrowed it to the above) by
> > > trying to perform a sparse-checkout in the worktree.  It appears
> > > sparse-checkout by default uses a worktree-specific config (which does
> make sense).
> > >
> > > What did you expect to happen? (Expected behavior)
> > >
> > >     I expected one of the following to happen:
> > >
> > >     1. I should have been blocked from creating a worktree from a bare
> > >     repository.
> > >
> > >     2. is_bare_repository() shouldn't be fooled by this situation,
> > >     assuming it's valid.
> > >
> > >     All things being equal, I would more expect to have been blocked
> > >     from creating a worktree from a bare repository.  Personally, this
> > >     bare repo + worktree setup doesn't not align with my experience so
> > >     far with how bare repos are normally used (i.e., as a convenience
> > >     for centralized remotes that will never be doing a checkout).
> > >
> > > What happened instead? (Actual behavior)
> > >
> > >     is_bare_repository() is fooled and I'm prevented from performing
> > >     any operation that requires a worktree (like performing a sparse
> > >     checkout).
> > >
> > > What's different between what you expected and what actually
> happened?
> > >
> > >     is_bare_repository() is fooled into thinking the worktree is not a
> > >     worktree / I'm able to create a worktree from a bare repo.
> > >
> > > Anything else you want to add:
> > >
> > > Please review the rest of the bug report below.
> > > You can delete any lines you don't wish to share.
> > >
> > >
> > > [System Info]
> > > git version:
> > > git version 2.34.1
> > > cpu: x86_64
> > > no commit associated with this build
> > > sizeof-long: 8
> > > sizeof-size_t: 8
> > > shell-path: /bin/sh
> > > uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28
> > > 23:40:43 UTC 2020 x86_64 compiler info: gnuc: 9.3 libc info: glibc:
> > > 2.31 $SHELL (typically, interactive shell): /bin/bash
> > >
> > >
> > > [Enabled Hooks]
> > > not run from a git repository - no hooks to show
> >
> > My thoughts:
> >
> > 1. I think it is legitimate to create a worktree from a bare repository. The
> worktree is using its own working directory/index and does not require
> anything from the bare repo.
> > 2. You ran is_bare_repository from next, which was in your worktree - not
> a bare repo, so that answer actually makes sense.

> I'm not sure I follow. I did run is_bare_repository from the next-worktree,
> but the return value was evidently dependent on the value of
> extensions.worktreeconfig. When true, is_bare_repository returned true --
> even within the next-worktree. Unless I'm missing something fairly
> fundamental here...

I agree that this interpretation *may* be incorrect. Worktreeconfig allows a configuration associated with worktrees but does not mean that there is one. It seems like worktreeconfig=true is causing git to check the worktree-specific configuration, finds out that you are in a worktree but there is in fact no worktree configuration specified, so the main repo is checked, which is bare, so reports true. When worktreeconfig=false, it looks like a quick decision is made that because you are in a worktree, obviously you are not bare (this may be an incorrect interpretation). I can somewhat see both sides of this. Perhaps some clarification on the interpretation is required.

It does seem like is_bare_repository_cfg is false in is_bare_repository, which seems to be wrong in context. However, there is a strange comparison in worktree.c that bothers me - is_bare_repository_cfg == 1 around line 67 which is a numeric comparison to a boolean. I think that may be incorrect. There is a NEEDSWORK comment in the code immediately before that line.

Hoping someone else can chime in on this.

> > I'm not sure whether this is an expected use case but it does make sense
> > to be one. If you typically work in worktrees and write scripts under that
> > assumption, not having to worry about being in the non-worktree part of a
> > clone makes sense. So creating a worktree off a bare repo is not a bad thing,
> > assuming everything else is correct.

The essential part of create a worktree from a bare repo still makes sense to me.

