Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E289E1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfEPBqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:21 -0400
Received: from thyrsus.com ([71.162.243.5]:58604 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfEOXcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 19:32:33 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id C48B04703049; Wed, 15 May 2019 19:32:30 -0400 (EDT)
Date:   Wed, 15 May 2019 19:32:30 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190515233230.GA124956@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com>:
> On 5/15/2019 3:16 PM, Eric S. Raymond wrote:
> > The deeper problem is that I want something from Git that I cannot
> > have with 1-second granularity. That is: a unique timestamp on each
> > commit in a repository.
> 
> This is impossible in a distributed version control system like Git
> (where the commits are immutable). No matter your precision, there is
> a chance that two machiens commit at the exact same moment on two different
> machines and then those commits are merged into the same branch.

It's easy to work around that problem. Each git daemon has to single-thread
its handling of incoming commits at some level, because you need a lock on the
file system to guarantee consistent updates to it.

So if a commit comes in that would be the same as the date of the
previous commit on the current branch, you bump the incoming commit timestamp.
That's the simple case. The complicated case is checking for date
collisions on *other* branches. But there are ways to make that fast,
too. There's a very obvious one involving a presort that is is O(log2
n) in the number of commits.

I wouldn't have brought this up in the first place if I didn't have a
pretty clear idea how to do it in code!

> Even when you specify a committer, there are many environments where a set
> of parallel machines are creating commits with the same identity.

If those commit sets become the same commit in the final graph, this is
not a problem for total ordering.

> > Why do I want this? There are number of reasons, all related to a
> > mathematical concept called "total ordering".  At present, commits in
> > a Git repository only have partial ordering. 
> 
> This is true of any directed acyclic graph. If you want a total ordering
> that is completely unambiguous, then you should think about maintaining
> a linear commit history by requiring rebasing instead of merging.

Excuse me, but your premise is incorrect.  A git DAG isn't just "any" DAG.
The presence of timestamps makes a total ordering possible.

(I was a theoretical mathematician in a former life. This is all very
familiar ground to me.)

> > One consequence is that
> > action stamps - the committer/date pairs I use as VCS-independent commit
> > identifications in reposurgeon - are not unique.  When a patch sequence
> > is applied, it can easily happen fast enough to give several successive
> > commits the same committer-ID and timestamp.
> 
> Sorting by committer/date pairs sounds like an unhelpful idea, as that
> does not take any graph topology into account. It happens that commits
> can actually have an _earlier_ commit date than its parent.

Yes, I'm aware of that.  The uniqueness properties that make a total
ordering desirable are not actually dependent on timestamp order
coinciding with topo order.

> Changing the granularity of timestamps requires changing the commit format,
> which is probably a non-starter.

That's why I started by noting that you're going to have to break the
format anyway to move to an ECDSA hash (or whatever you end up using).

I'm saying that *since you'll need to do that anyway*, it's a good time
to think about making timestamps finer-grained and unique.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


