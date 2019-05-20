Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EE31F462
	for <e@80x24.org>; Mon, 20 May 2019 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfETVcE (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:32:04 -0400
Received: from thyrsus.com ([71.162.243.5]:58938 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfETVcE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:32:04 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id B1281470485F; Mon, 20 May 2019 17:32:03 -0400 (EDT)
Date:   Mon, 20 May 2019 17:32:03 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190520213203.GA110573@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
 <20190516002831.GC124956@thyrsus.com>
 <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
 <20190520170518.73ad912b@kitsune.suse.cz>
 <20190520163625.GA99397@thyrsus.com>
 <7e88805c-7e08-2631-599d-b47a098f1ce1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e88805c-7e08-2631-599d-b47a098f1ce1@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com>:
> What it sounds like you are doing is piping a 'git fast-import' process into
> reposurgeon, and testing that reposurgeon does the same thing every time.
> Of course this won't be consistent if 'git fast-import' isn't consistent.

It's not actually import that fails to have consistent behavior, it's export.

That is, if I fast-import a given stream, I get indistinguishable
in-core commit DAGs every time. (It would be pretty alarming if this
weren't true!)

What I have no guarantee of is the other direction.  In a multibranch repo,
fast-export writes out branches in an order I cannot predict and which
appears from the outside to be randomly variable.

> But what you should do instead is store a fixed file from one run of
> 'git fast-import' and send that file to reposurgeon for the repeated test.
> Don't rely on fast-import being consistent and instead use fixed input for
> your test.
> 
> If reposurgeon is providing the input to _and_ consuming the output from
> 'git fast-import', then yes you will need to have at least one integration
> test that runs the full pipeline. But for regression tests covering complicated
> logic in reposurgeon, you're better off splitting the test (or mocking out
> 'git fast-import' with something that provides consistent output given
> fixed input).

And I'd do that... but the problem is more fundamental than you seem to
understand.  git fast-export can't ship a consistent output order because
it doesn't retain metadata sufficient to totally order child branches.

This is why I wanted unique timestamps.  That would solve the problem,
branch child commits of any node would be ordered by their commit date.

But I had a realization just now.  A much smaller change would do it.
Suppose branch creations had creation stamps with a weak uniqueness property;
for any given parent node, the creation stamps of all branches originating
there are guaranteed to be unique?

If that were true, there would be an implied total ordering of the
repository.  The rules for writing out a totally ordered dump would go
like this:

1. At any given step there is a set of active branches and a cursor
on each such branch.  Each cursor points at a commit and caches the
creation stamp of the current branch.

2. Look at the set of commits under the cursors.  Write the oldest one.
If multiple commits have the same commit date, break ties by their
branch creation stamps.

3. Bump that cursor forward. If you're at a branch creation, it
becomes multiple cursors, one for each child branch.
If you're at a join, some cursors go away.

Here's the clever bit - you make the creation stamp nothing but a
counter that says "This was the Nth branch creation."  And it is
set by these rules:

4. If the branch creation stamp is undefined at branch creation time,
number it in any way you like as long as each stamp is unique. A
defined, documented order would be nice but is not necessary for
streams to round-trip.

5. When writing an export stream, you always utter a reset at the
point of branch creation.

6. When reading an import stream, the ordinal for a new branch is
defined as the number of resets you have seen.

Rules 5 and 6 together guarantee that branch creation ordinals round-trip
through export streams.  Thus, streams round-trip and I can have my
regression tests with no change to git's visible interface at all!

I could write this code.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


