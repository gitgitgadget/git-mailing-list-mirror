Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1CC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59567610E6
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhEFOLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 10:11:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53379 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233737AbhEFOLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 10:11:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 146EAP66023199
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 May 2021 10:10:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B039A15C39BD; Thu,  6 May 2021 10:10:25 -0400 (EDT)
Date:   Thu, 6 May 2021 10:10:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Yuri <yuri@rawbw.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
Message-ID: <YJP40YnfqTpKB9H/@mit.edu>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
 <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
 <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
 <6093ab6bd3ea8_24e620862@natae.notmuch>
 <8c802d6a-3cba-4c10-0430-0dbf95a56760@rawbw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c802d6a-3cba-4c10-0430-0dbf95a56760@rawbw.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 01:45:41AM -0700, Yuri wrote:
> 
> So you advocate to use branches? If branches are same or better than stash,
> why was the stash feature created?
> 
> Maybe it should be removed in favor of branches?

Stash is actually *implemented* in terms of a branch and reflogs.
It's syntactic sugar --- a user interface --- for a simple use case,
which is designed for use by users who don't care to learn a richer,
more complex set of commands, or who want to use for simple, temporary
use cases.

So you can see the top-most stash by running the command:

   git log refs/stash

You can also see that these two commands produce essentially the same
output:

   git stash list
   git reflog refs/stash

By the way, reflogs by default expire after 90 days.  And if you do
something like this:

  git reflog expire --expire=now --all
  git stash list

*Poof* Watch all of your stashed patches disappear.  So if you are
storing things that you consider especially valuable using git stash,
I'd encourage you to rethink your strategy.

For anything that needs to be saved more than a few minutes, I tend to
create explicit branches, which can be named, so it's obvious is going
on.  Those branches aren't pushed out publically by default, any more
than the branch refs/stash is pushed out publically.  But because they
are branches, you can push them out explicitly, perhaps to a private
remote repo, if you like.

You can then use git cherry-pick, git rebase, git rebase -i, git
commit --amend, etc., to manage your work in progress.  This gives
much finer-grained control over how you manage your in-progress work,
at the cost of needing to learn a more complex set of commands.

Cheers,

					- Ted

P.S.  One hint: if the reason why you don't like using explicit branches is
because you get confused what branch you are on, it's helpful to put
your current branch on shell prompt.  I do something like this:

<tytso@cwcc> {/usr/projects/e2fsprogs/e2fsprogs}   (next)
1822% git checkout tt/pfsck
Switched to branch 'tt/pfsck'
<tytso@cwcc> {/usr/projects/e2fsprogs/e2fsprogs}   (tt/pfsck)
1823%

One of the conventions I use is that [initials]/* for branch names
that are generally never pushed out.  "tt" is my own initials, for my
own work.  Other people's initials are used for when they send me
branches to look at, that aren't quite ready to be merged into the
master, next, or maint branches.  Sometimes I will follow Junio's
convention of merging other people's in-progress work that they've
sent me into a pu (proposed updates) branch, for other people to test
and review, and for integration testing.  I tend not to do that often
since e2fsprogs' development tends not to be as complex/dynamic as
git's.


My shell prompt is accomplished through this in my .bashrc:

    if [ $UID = 0 ]; then
	u="${LOGNAME}.root"
	p="#"
    else
	u="$LOGNAME";
	p="%"
    fi
    if [ $SHLVL != 1 ]; then
	s=", level $SHLVL"
    fi
    h=${HOSTNAME}
    if [ -n "$debian_chroot" ]; then
	h=${debian_chroot}-CHROOT.${h}
    fi
    if test -f /etc/bash_completion ; then
	. /etc/bash_completion
    fi
    if test -f /usr/local/share/bash-completion/bash_completion.sh ; then
	. /usr/local/share/bash-completion/bash_completion.sh
    fi
    if test -f /usr/local/share/git-core/contrib/completion/git-prompt.sh ; then
	. /usr/local/share/git-core/contrib/completion/git-prompt.sh
    fi
    if type __git_ps1 >& /dev/null ; then
	PS1="<${u}@${h}> {\${PWD}}$s  \$(__git_ps1)\n\!$p "
    else
	PS1="<${u}@${h}> {\${PWD}}$s\n\!$p "
    fi
    unset u s h
