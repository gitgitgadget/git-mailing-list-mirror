Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856481F462
	for <e@80x24.org>; Mon, 20 May 2019 23:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfETXMY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 19:12:24 -0400
Received: from thyrsus.com ([71.162.243.5]:33844 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfETXMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 19:12:24 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 7FA06470485F; Mon, 20 May 2019 19:12:23 -0400 (EDT)
Date:   Mon, 20 May 2019 19:12:23 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520231223.GA117962@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <20190515233230.GA124956@thyrsus.com>
 <87woiqvic4.fsf@evledraar.gmail.com>
 <86woimox24.fsf@gmail.com>
 <20190520004559.GA41412@thyrsus.com>
 <86r28tpikt.fsf@gmail.com>
 <20190520141417.GA83559@thyrsus.com>
 <CABPp-BHK1N2zZoeBeSgnh12LPqLgZxfbL0DzALj28y97_Q-ahg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHK1N2zZoeBeSgnh12LPqLgZxfbL0DzALj28y97_Q-ahg@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com>:
> Hi,
> 
> On Mon, May 20, 2019 at 11:09 AM Eric S. Raymond <esr@thyrsus.com> wrote:
> 
> > > For cookie to be unique among all forks / clones of the same repository
> > > you need either centralized naming server, or for the cookie to be based
> > > on contents of the commit (i.e. be a hash function).
> >
> > I don't need uniquess across all forks, only uniqueness *within the repo*.
> 
> You've lost me.  In other places you stated you didn't want to use the
> commit hash, and now you say this.  If you only care about uniqueness
> within the current copy of the repo and don't care about uniqueness
> across forks (i.e. clones or copies that exist now or in the future --
> including copies stored using SHA256), then what's wrong with using
> the commit hash?

Because it's not self-describing, can't be computed solely from visible
commit metadata, and relies on complex external assumptions about how
the hash is computed which break when your VCS changes hash algorithms.

These are dealbreakers because one of my major objectives is forward
portability of these IDs forever. And I mean *forever*.  It should be
possible for someone in the year 40,000, in between assaulting planets
for the God-Emperor, to look at an import stream and deduce how to
resolve the cookies to their commits without seeing git's code or
knowing anything about its hash algorithms.

I think maybe the reason I'm having so much trouble getting this
across is that git insiders are used to thinking of import streams as
transient things.  Because I do a lot of repo migrations, I have a
very different view of them.  I built reposurgeon on the realization
that they're a general transport format for revision histories, and
that has forward value independent of the existence of git.

If a stream contained fully forward-portable action stamps, it would be
forward-portable forever.  Hashes in commit comments are the *only*
blocker to that.  Take this from a person who has spent way too much time
patching Subversion IDs like r1234 during repository conversions.

It would take so little to make this work. Existing stream format is
*almost there*.

> A stable ordering of commits in a fast-export stream might be a cool
> feature.  But I don't know how to define one, other than perhaps sort
> first by commit-depth (maybe optionally adding a few additional
> intermediate sorting criteria), and then finally sort by commit hash
> as a tiebreaker. Without the fallback to commit hash, you fall back
> on normal traversal order which isn't stable (it depends on e.g. order
> of branches listed on the command line to fast-export, or if using
> --all, what new branch you just added that comes alphabetically before
> others).
>
> I suspect that solution might run afoul of your dislike for commit
> hashes, though, so I'm not sure it'd work for you.

It does. See above.

> > So let me back up a step.  I will cheerfully drop advocating bumping
> > timestamps if anyone can tell me how a different way to define a per-commit
> > reference cookie that (a) is unique within its repo, and (b) only requires
> > metadata visible in the fast-export representation of the commit.
> 
> Does passing --show-original-ids option to fast-export and using the
> resulting original-oid field as the cookie count?

I was not aware of this option.  Looking...no wonder, it's not on my
system man page.  Must be recent.

OK. Wow.  That is *useful*, and I am going to upgrade reposurgeon to read
it.  With that I can do automatic commit-reference rewriting.

I don't consider it a complete solution. The problem is that OID is
a consistent property that can be used to resolve cookies, but there's
no guaranteed that it's a *preserved* property that survives multiple
round trips and changes in hash functions.

So the right way to use it is to pick it up, do reference-cookie
resolution, and then mung the reference cookies to a format that is
stable forever.  I don't know what that format should be yet.  I
have a message in composition about this.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


