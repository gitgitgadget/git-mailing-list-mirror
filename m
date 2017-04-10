Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0155920960
	for <e@80x24.org>; Tue, 11 Apr 2017 05:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbdDKFcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 01:32:32 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:34507 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdDKFcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 01:32:31 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id AED89D400C7;
        Tue, 11 Apr 2017 08:32:28 +0300 (MSK)
Date:   Mon, 10 Apr 2017 20:13:13 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Samuel =?UTF-8?B?w4VzbHVuZA==?= <samuel@update.uu.se>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>
Message-Id: <20170410201313.e69bc8798d569d85a493dc19@domain007.com>
In-Reply-To: <a967439f-117e-1f09-6f40-7f62bc6cbae1@update.uu.se>
References: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
        <20170410101336.c93a423e7d3a8594151bebef@domain007.com>
        <a967439f-117e-1f09-6f40-7f62bc6cbae1@update.uu.se>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: Git documentation on branching.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 10 Apr 2017 12:24:47 +0200
Samuel Åslund <samuel@update.uu.se> wrote:

[...]
> >> One feature with "git branch xyz" and "git checkout xyz" that is
> >> rather obvious if you know them but bit me a little since I did
> >> not, is that uncommitted work in progress is not affected or saved
> >> when switching between branches.
> > [...]
> > But neither is uncommitted work saved anywhere when you do
> > `svn switch` in Subversion which is analogous to `git checkout`.
> >
> > While I do know quite many people expect Git to somehow "preserve"
> > their work when switching branches without having them do anything,
> > I wonder what in Subversion workflow makes you think Git should have
> > had the behaviour you expected?
> 
> svn switch is heavy, thus I usually checked out a new branch in
> another directory. So probably not the Subversion workflow but rather
> _my_ workflow in Subversion.

Yes.  The equivalent thing with Git would be using its `git worktree`
subcommand (which is a stock subcommand since some time, and previously
was available in the form of an external script).  The said command
basically creates another "checkout" -- a working tree and a separate
index -- linked to the original repository.  You can have any number of
such separate work trees, and what's checked out in them is completely
irrelevant to the repository itself (which only keeps commits and the
data they refer to).

Note that since `git worktree` was (is?) sort of a clever hack not
originally envisioned as one of "stock" workflows, its insufficiently
covered by the documentation.  And while it indeed may be useful --
sometimes it's ineed convenient to have two versions of the same
codebase to be checked out side-by-side, -- I'd warn you against
rushing for using `git worktree` as it appears to support what you did
with Subversion: there is another approach to support your mindset
which I'll explain in a moment.

> Either way, your comment about peoples expectations was what I wanted
> to address. Expectation management is the responsibility of the 
> documentation, right?

It's hard to tell -- as Ævar Arnfjörð pointed out: there are two kinds
of documentation: manuals and books / introductory courses.  As was
shown to you, the manual page on `git checkout` explains what it does.
Whether that's clear right away to any newcomer, I cannot say.
Probably not, but if we'd turn that manual page to a book it will lose
its original meaning of being dry and to the point.

I have that problem with manual pages all the time: quite often they
are most useful on some Nth re-reading, where you approach them with
certain working knowledge under your belt -- and suddenly certain
things you read there "click" in your head; you did read them before
but your mind just skimmed over them while having the impression of
grasping the material.

> I find it quite reasonable to choose whether to stash the work in 
> progress myself before checking out another branch, but since I did
> not expect to need to do that I didn't.
> 
> I think that what made me expect Git to handle my uncommitted work is 
> how the documentation talks about making it easy to switch between 
> working on different features, most of the time I do not feel 
> comfortable checking in when a feature is in a broken state and 
> interruptions for quick fixes usually comes in those situations.

That's more complicated that it sounds.
Consider the following things (in no particular order).

Sometimes "carrying your uncommitted work over" to another state of the
codebase is precisely what you'd want to happen, and that's what
`git checkout` does for your.  It even has a specual "I DO REALLY WANT
IT TO HAPPEN" switch, "-m", which makes that command to try to merge
your local modifications into what is about to be checked out if
otherwise your changes would be in conflict with that state.

What's with untracked files?  Sometimes they should be considered part
of the work to be saved away before checking out another state, and
sometimes not (`git stash` has a special switch, "-u" to make it stash
untracked stuff as well).  What would be the default mode?  Think of
it, and supposedly you'll come to a conclusion that either mode Git
could implement would alienate some group of folks. ;-)

Now let's consider the most interesting bit.

People switching from a non-distributed VC system are inherently and
subconsciously afraid of committing anything which "is not ready".
This is definitely a correct mindset with Subversion (which, IIUC,
still does not implement shelving it considered for a long time)
but not with Git.

Here, it's absolutely OK to lump together all the stuff you're
currently working it by `git add`-ing them, `git commit` it all --
usually putting an informal "WIP" prefix in the front of the commit
message to indicate it's work in progress -- and then switch away to
another branch.

When back, you just to `git reset HEAD~1` to move your checked out
branch one commit back and still having all your changes where you had
them -- in your work tree.  You could have saved a series of N WIP
commits if you wanted it this way for some reason, and then you'd do
`git reset HEAD~N` to achieve the same effect.  When you record a new
commit afterwards it will be recorded on to of what you've just reset
your branch to -- as if those WIP commits never existed.

This way your "not ready yet" changes maintained on particular branches
are kept right there -- at the tips of those branches.
Since Git is fine with using any commit for anything -- forking a
branch off it or pushing it, -- it's okay if, say, your boss orders you
to push what you've done on the "develop" branch while you have some
WIP commits at its tip: you just push not its tip but the last "ready"
commit on that branch.

TL;DR
Consider more possibilities ;-)
