Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB0D1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 09:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfJIJkL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 05:40:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:54922 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJIJkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 05:40:11 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1iI8S0-0000eT-WA; Wed, 09 Oct 2019 11:40:09 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
        id DD629120127; Wed,  9 Oct 2019 11:37:19 +0200 (CEST)
Date:   Wed, 9 Oct 2019 11:37:19 +0200
From:   Josef Wolf <jw@raven.inka.de>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Why is "Sparse checkout leaves no entry on working directory" a
 fatal error?
Message-ID: <20191009093719.GC30443@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
        Git Mailing List <git@vger.kernel.org>
References: <20191008064538.GB30443@raven.inka.de>
 <CABPp-BE8YmVTS=4UWy5jvxBwr3EOcqzbnpWf2Wc78Kv6YScKgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BE8YmVTS=4UWy5jvxBwr3EOcqzbnpWf2Wc78Kv6YScKgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comprehensive answer, Elijah!

On Di, Okt 08, 2019 at 09:14:27 -0700, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 11:52 PM Josef Wolf <jw@raven.inka.de> wrote:
> >
> > I am trying to add a file to an arbitrary branch without touching the current
> > worktree with as little overhead as possible.
>
> I can see the logical progression that a sparse worktree would be less
> overhead than a full worktree, and that a bare worktree would be even
> better.  But you're still dealing with unnecessary overhead; you don't
> need a worktree at all to achieve what you want.

Well, the "as little overhead as possible" must be seen from the context. This
is a repository with roundabout 10GB and more than 6200 files. Shared-clones
with sparse-worktree is a BIG BIG BIG improvement here, which reduces
operations from "minutes" to "withhin a second".

> Traditionally, if you wanted to modify another branch without touching
> the worktree at all, you would use a combination of hash-object,
> mktree, commit-tree, and update-ref.  That would be a better solution
> to your problem than trying to approximate it with a sparse checkout.
> However, that's at least four invocations of git, and you said as
> little overhead as possible, so I'd recommend you use fast-import.

I have taken a look into the commands you are recommending, and indeed, they
seem to be better suited. Especially fast-import looks very
promising. Unfortunately, those commands require intimate knowledge about git
internals. I'll take a closer look into this!

> It is very easy to mess up the sparse specifications.  We can't check
> for all errors, but a pretty obvious one is when people specify
> restrictions that match no path.

But why erroring out only on completely empty tree? Why not requiring that
_every_ line in .git/info/sparse-checkout should match at least one file?
Would make no sense, right?

> We can at least give an error in that case.

Why must this be a fatal error? Wouldn't a warning suffice?

> 2) When they've learned about sparse checkouts and just want to test
> what things are like in extreme situations.
[ ... ]
> For case 2, people learn that an empty working tree is a too extreme
> situation that we'll throw an error at and so they adjust and make
> sure to match at least one path.

When I am trying to learn how a new feature works, I tend to double-check the
results. If I expect contens but end up with an empty WT, I'd go and double
check the specifications I've given anyway.

I can easily understand that a warning might be desirable. But erroring out
and failing to honor the "-b" flag is a bit too drastic, IMHO.

> > Strange enough, I have some repositories at this machine where the
> > .git/info/sparse-checkout file contains only non-existing files and git
> > happily executes this "git checkout -b XXX remotes/origin/XXX" command leaving
> > the working tree totally empty all the time.
> 
> I can't reproduce:
> 
> $ git config core.sparseCheckout true
> $ echo 'non-existent' > .git/info/sparse-checkout
> $ git checkout -b next origin/next
> error: Sparse checkout leaves no entry on working directory
> 
> Can you provide any more details about how you get into this state?

Unfortunately not.

Honestly, I have tried to reproduce for several days, since I tried
to find a way how to work around that fatal error. Unfortunately, I could not
find how to reproduce it. The only thing I can say is: threre are several
clones on my disk which happily switch branches with an empty WT and without
any complaints.

> > Someone understands this inconsistent behaviour?
> 
> No, but I wouldn't be surprised if there are bugs and edge cases.  I
> think I ran into one or two when testing things out, didn't take good
> enough notes, and had trouble reproducing later.  The sparse checkout
> stuff has been under-tested and not well documented, something Stolee
> is trying to fix right now.

Yes, I've seen the work on the ML. But I am only a user of git and have a very
hard time to understand what is going on there.

-- 
Josef Wolf
jw@raven.inka.de
