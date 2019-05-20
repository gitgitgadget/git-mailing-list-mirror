Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6BB1F461
	for <e@80x24.org>; Mon, 20 May 2019 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfETOOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 10:14:20 -0400
Received: from thyrsus.com ([71.162.243.5]:45692 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732627AbfETOOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 10:14:20 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id A429C470485F; Mon, 20 May 2019 10:14:17 -0400 (EDT)
Date:   Mon, 20 May 2019 10:14:17 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520141417.GA83559@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com>
 <87woiqvic4.fsf@evledraar.gmail.com>
 <86woimox24.fsf@gmail.com>
 <20190520004559.GA41412@thyrsus.com>
 <86r28tpikt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86r28tpikt.fsf@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com>:
> > What "commits that follow it?" By hypothesis, the incoming commit's
> > timestamp is bumped (if it's bumped) when it's first added to a branch
> > or branches, before there are following commits in the DAG.
> 
> Errr... the main problem is with distributed nature of Git, i.e. when
> two repositories create different commits with the same
> committer+timestamp value.  You receive commits on fetch or push, and
> you receive many commits at once.
> 
> Say you have two repositories, and the history looks like this:
> 
>  repo A:   1<---2<---a<---x<---c<---d      <- master
> 
>  repo B:   1<---2<---X<---3<---4           <- master
> 
> When you push from repo A to repo B, or fetch in repo B from repo A you
> would get the following DAG of revisions
> 
>  repo B:   1<---2<---X<---3<---4           <- master
>                  \
>                   \--a<---x<---c<---d      <- repo_A/master
> 
> Now let's assume that commits X and x have the came committer and the
> same fractional timestamp, while being different commits.  Then you
> would need to bump timestamp of 'x', changing the commit.  This means
> that 'c' needs to be rewritten too, and 'd' also:
> 
>  repo B:   1<---2<---X<---3<---4           <- master
>                  \
>                   \--a<---x'<--c'<--d'     <- repo_A/master

Of course that's true.  But you were talking as though all those commits
have to be modified *after they're in the DAG*, and that's not the case.
If any timestamp has to be modified, it only has to happen *once*, at the
time its commit enters the repo.

Actually, in the normal case only x would need to be modified. The only
way c would need to be modified is if bumping x's timestamp caused an
actual collision with c's.

I don't see any conceptual problem with this.  You appear to me to be
confusing two issues.  Yes, bumping timestamps would mean that all
hashes downstream in the Merkle tree would be generated differently,
even when there's no timestamp collision, but so what?  The hash of a
commit isn't portable to begin with - it can't be, because AFAIK
there's no guarantee that the ancestry parts of the DAG in two
repositories where copies of it live contain all the same commits and
topo relationships.

> And now for the final nail in the coffing of the Bazaar-esque idea of
> changing commits on arrival.  Say that repository A created new commits,
> and pushed them to B.  You would need to rewrite all future commits from
> this repository too, and you would always fetch all commits starting
> from the first "bumped"

I don't see how the second clause of your last sentence follows from the
first unless commit hashes really are supposed to be portable across
repositories.  And I don't see how that can be so given that 'git am'
exists and a branch can thus be rooted at a different place after
it is transported and integrated.

> Hash of a commit depend in hashes of its parents (Merkle tree). That is
> why signing a commit (or a tag pointing to the commit) signs a whole
> history of a commit.

That's what I thought.

> > How do they know they're not writing to the same ref?  What keeps
> > *that* operation atomic?
> 
> Because different refs are stored in different files (at least for
> "live" refs that are stores in loose ref format).  The lock is taken on
> ref (to update ref and its reflog in sync), there is no need to take
> global lock on all refs.

OK, that makes sense.

> For cookie to be unique among all forks / clones of the same repository
> you need either centralized naming server, or for the cookie to be based
> on contents of the commit (i.e. be a hash function).

I don't need uniquess across all forks, only uniqueness *within the repo*.

I want this for two reasons: (1) so that action stamps are unique, (2)
so that there is a unique canonical ordering of commits in a fast export
stream.

(Without that second property there are surgical cases I can't
regression-test.)

> >                                                          For my use cases
> > that cookie should *not* be a hash, because hashes always break N years
> > down.  It should be an eternally stable product of the commit metadata.
> 
> Well, the idea for SHA-1 <--> NewHash == SHA-256 transition is to avoid
> having a flag day, and providing full interoperability between
> repositories and Git installations using the old hash ad using new
> hash^1.  This will be done internally by using SHA-1 <--> SHA-256
> mapping.  So after the transition all you need is to publish this
> mapping somewhere, be it with Internet Archive or Software Heritage.
> Problem solved.

I don't see it.  How does this prevent old clients from barfing on new
repositories?

> P.S. Could you explain to me how one can use action stamp, e.g.
> <esr@thyrsus.com!2019-05-15T20:01:15.473209800Z>, to quickly find the
> commit it refers to?  With SHA-1 id you have either filesystem pathname
> or the index file for pack to find it _fast_.

For the purposes that make action stamps important I don't really care
about performance much (though there are fairly obvious ways to
achieve it).  My goal is to ensure that revision histories (e.g. in
their import-stream format) are forward-portable to future VCSes
without requiring any data outside the stream itself.

Please remember that I'm accustomed to maintaining infrastructure on
decadal timescales - I wrote code in the 1980s that is still in wide use
and I expect some of the code I'm writing now to be still in use thirty
years from now.

This gives me a different perspective on the fragility of things like
SHA-1 hashes.  From a decadal-scale POV any particular crypto-hash
format is unstable garbage, and having them in change comments is a
maintainability disaster waiting to happen.

Action stamps are specifically designed so that they're pointers to commits
that don't require anything but the target commit's import/export-stream
metadata to resolve.  Your idea of an archived hash registry makes me
extremely nervous; I think it's too fragile to trust.

So let me back up a step.  I will cheerfully drop advocating bumping
timestamps if anyone can tell me how a different way to define a per-commit
reference cookie that (a) is unique within its repo, and (b) only requires
metadata visible in the fast-export representation of the commit.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


