Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9714A1F461
	for <e@80x24.org>; Mon, 20 May 2019 00:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfETAqA (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 20:46:00 -0400
Received: from thyrsus.com ([71.162.243.5]:42670 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfETAp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 20:45:59 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 66E494704887; Sun, 19 May 2019 20:45:59 -0400 (EDT)
Date:   Sun, 19 May 2019 20:45:59 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520004559.GA41412@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com>
 <87woiqvic4.fsf@evledraar.gmail.com>
 <86woimox24.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86woimox24.fsf@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com>:
> As far as I understand it this would slow down receiving new commits
> tremendously.  Currently great care is taken to not have to parse the
> commit object during fetch or push if it is not necessary (thanks to
> things such as reachability bitmaps, see e.g. [1]).
> 
> With this restriction you would need to parse each commit to get at
> commit timestamp and committer, check if the committer+timestamp is
> unique, and bump it if it is not.

So, I'd want to measure that rather than simply assuming it's a blocker.
Clocks are very cheap these days.

> Also, bumping timestamp means that the commit changed, means that its
> contents-based ID changed, means that all commits that follow it needs
> to have its contents changed...  And now you need to rewrite many
> commits.

What "commits that follow it?" By hypothesis, the incoming commit's
timestamp is bumped (if it's bumped) when it's first added to a branch
or branches, before there are following commits in the DAG.

>    And you also break the assumptions that the same commits have
> the same contents (including date) and the same ID in different
> repositories (some of which may include additional branches, some of
> which may have been part of network of related repositories, etc.).

Wait...unless I completely misunderstand the hash-chain model, doesn't the
hash of a commit depend on the hashes of its parents?  If that's the case,
commits cannot have portable hashes. If it's not, please correct me.

But if it's not, how does your first objection make sense?

> > You don't need a daemon now to write commits to a repository. You can
> > just add stuff to the object store, and then later flip the SHA-1 on a
> > reference, we lock those indivdiual references, but this sort of thing
> > would require a global write lock. This would introduce huge concurrency
> > caveats that are non-issues now.
> >
> > Dumb clients matter. Now you can e.g. have two libgit2 processes writing
> > to ref A and B respectively in the same repo, and they never have to
> > know about each other or care about IPC.

How do they know they're not writing to the same ref?  What keeps
*that* operation atomic?

> You do realize that dates may not be monotonic (because of imperfections
> in clock synchronization), thus the fact that the date is different from
> parent does not mean that is different from ancestor.

Good point. That means the O(log2 n) version of the check has to be done
all the time.  Unfortunate.

> >> That's the simple case. The complicated case is checking for date
> >> collisions on *other* branches. But there are ways to make that fast,
> >> too. There's a very obvious one involving a presort that is is O(log2
> >> n) in the number of commits.
> 
> I don't think performance hit you would get would be acceptable.

Again, it's bad practice to assume rather than measure. Human intuitions
about this sort of thing are notoriously unreliable.

> >> Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DAG.
> >> The presence of timestamps makes a total ordering possible.
> >>
> >> (I was a theoretical mathematician in a former life. This is all very
> >> familiar ground to me.)
> 
> Maybe in theory, when all clock are synchronized.

My assertion does not depend on synchronized clocks, because it doesn't have to.

If the timestamps in your repo are unique, there *is* a total ordering - 
by timestamp. What you don't get is guaranteed consistency with the
topo ordering - that is you get no guarantee that a child's timestamp
is greater than its parents'. That really would require a common
timebase.

But I don't need that stronger property, because the purpose of
totally ordering the repo is to guararantee the uniqueness of action
stamps.  For that, all I need is to be able to generate a unique cookie
for each commit that can be inserted in its action stamp.  For my use cases
that cookie should *not* be a hash, because hashes always break N years
down.  It should be an eternally stable product of the commit metadata.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


