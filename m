From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 10:20:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org> 
 <2cfc403205061817181e4d6d5e@mail.gmail.com>  <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
  <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org> 
 <2cfc403205061903155a6090db@mail.gmail.com> <2cfc40320506190741409f3a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 19:13:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk3Lz-000506-SV
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 19:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVFSRSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 13:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVFSRSq
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 13:18:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262263AbVFSRSj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 13:18:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5JHIYjA025175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 10:18:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5JHIXNw016201;
	Sun, 19 Jun 2005 10:18:33 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320506190741409f3a5@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Jon Seymour wrote:
> 
> Would I be correct in stating that an intuitive  reason why your
> algorithm is better than selecting the linear middle is the following:
> 
> If you concentrate on testing merges, rather than non-merges, the
> chances are you are going to eliminate N-times as many possible good
> commits as if you pick a random commit, where N is the average fan-out
> of the commit graph.

No. You really shouldn't concentrate on merges either.

The thing is, you do _not_ want to test as many commits as possible, or as 
few commits as possible.

This is _not_ a "try to eliminate as many commits as possible" problem. 
It's really one of trying to eliminate _half_ the commits. Not more, not 
less. 

So to some degree you want to _avoid_ merges, because they pick up a lot 
of commits, and that might take you over the limit. But at the same time 
you need to be very aware of merges, since if you ignore them, you'll pick 
up too _few_ commits.

So in a very real sense, whether you pick a merge or not doesn't depend on 
whether that one entry is a merge itself - it really depends on the whole 
flow. You can't do any local measurements.

The reason my algorithm is so horrid (O(3)) is that you can't even cache 
the dang thing sanely: you can't optimize if by remembering how many 
interesting commits are reachable from one commit, and then doing "this 
commit reaches commits X and Y, so I can reach X.count + Y.count commits 
from it". That's just not true, because often (basically always) there is 
lots of common commits in X.count and Y.count..

So that's why I do that strange full reachability thing for _each_ commit,
and then clear the reachability flags and start with the next commit. It's
horrid, but I can't see a sane way to avoid it (I could do the clearing
less often by introducing the notion of "generations" in the reachability,
but I didn't want to add a new counter to the data structures - and it
wouldn't really change anything fundamental).

In your measurements:

> FWIW: my measurements of your algorithm thus far show that if the bug
> exists in the first 1070 of the 2119 commits between HEAD and
> v2.6.12-rc2 it consistently (very consistently) takes between 11 and
> 13 iterations of git-bug-blatt-script to find the bug.
> 
> Specifically: average (12.10), median (12), stdev(0.412), max(13), 
> min(11).

Yes. Consistency is the name of the game. A low standard deviation is what
it's all about, because that's how binary searches work. The point about
binary searching for a bug is that you're not really looking for "the one"  
commit, you're really looking for the _range_ of two adjacent commits: it
doesn't even help if you happen to pick the buggy commit on the first try,
because the only thing that matters is when you have zeroed in on the
"buggy and previous" one.

In other words, in a traditional search, when you pick an entry, you know 
that you got it right: you might be lucky and pick it first, and you'll be 
happy. But in the "search for a bug" case, you always have to go the 
_full_ "log2()" thing, because you will always have to not just pick the 
right entry, you will also have had to "bisect to zero" so that you know 
that the entry before it was not buggy.

This is because the "is it buggy" is not a unique thing, it's really just 
a partial ordering in the set (if you're really unlucky, you might have 
two bugs that interact, and you'll not actually find "the commit" at all, 
but the one you do end up zeroing in on should at least be _one_ border 
condition for the bug, so it should help you somewhat regardless). 

So you basically cannot avoid doing "ceil(log2(N))" tests, and with 2119
commits, you should pretty much _always_ get 12, and basically a standard
deviation of zero.

The reason you don't get that is that _occasionally_ you can't get close
enough to "half-way", and depending on whether the bug was in the smaller
set or bigger set, you might be lucky or unlucky. The problem here is that
by definition you'll be unlucky more of the time: the bigger set (the
unlucky case) is _bigger_, so it's more likely to have the bug, so what
you should see statistically is that you can't actually do _better_ than
ceil(log2(N)).

("cannot do better" obviously is true only in the statistical sense. You
can always be lucky in any individual test, and if you are intelligent and
choose the commits to test based on the symptoms of the bug you can always
do better, of course).

NOTE NOTE NOTE! The above is all based on random distribution of bugs,
where all commits count equally, which is obviously not even true. You 
coudl try to do a "weighted bisection", where you weigh commits 
differently: you might say, for example, that if the author field matches 
the string "torvalds", then the likelihood of a bug is obviously 
miniscule, so such a commit only counts as 0.1.

Or you could argue that a pure merge seldom introduces a bug (which is 
probably not true, but hey, this is theory), and you could decide that 
when you "count commits", then normal commits count as two, and merges 
count as one, and the bisection is trying to get equal "weights" on both 
sides, not "equal number of commits".

However, that's where "consistency" has another advantage: maybe it's
possible to get better results on average by taking statistical bug
distribution behaviour into account (like "bugs are likely new - try to
weigh the bisection 60% reachable / 40% unreachable instead of 50-50"), 
but that means that then occasionally you do worse, and from a 
psychological angle I think that's unacceptable. I think most bug hunters 
would much prefer to know that "I need to reboot 7 times and I'll get it", 
over "I probably need to reboot only 5 times, but it might be 10 if I'm 
unlucky".

> This compares with my naive literal middle algorithm (measurements
> only for the first 619 commits):
> 
> average(21), median(16), stdev(10.6), max(49), min(8).

Yes. I really don't believe you can do better than 12, unless you start 
depending on knowledge of the distribution of bugs.

		Linus
