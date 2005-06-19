From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sat, 18 Jun 2005 20:43:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
 <2cfc403205061817181e4d6d5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 05:35:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djqau-0006HO-3L
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 05:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVFSDlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 23:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVFSDlL
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 23:41:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20970 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261638AbVFSDlD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2005 23:41:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5J3exjA029604
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 18 Jun 2005 20:41:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5J3ewir022995;
	Sat, 18 Jun 2005 20:40:59 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205061817181e4d6d5e@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 19 Jun 2005, Jon Seymour wrote:
> 
> Perhaps in answering this question, you can help me understand the
> intended behaviour of your bisection algorithm a little better. The
> question is this: for your purposes, given a rev-list output, why not
> simply use the literal middle element of the outputed list?

The literal middle tends to be in the middle _timewise_, but that's
irrelevant. It might be just a single step away from one of the commits
that has already been marked "good", and as such, testing that one might
well be totally pointless: if you have a thousand commits (not at all
unlikely), testing whether they are good or not one at a time is just not
reasonable.

What we want to get is the commit that basically bisects the other commits 
from a "reachability graph" angle. We want something that when selected as 
the new "top" will have roughly half the commits in it.

Put another way: let's say that we have those thousand commits that _may_ 
have introduced a bug, but we don't know which one. What do we want? We 
want to find a new head that contains roughly five hundred of the unknown 
commits. No more, no less. Maybe we won't find a  500/500 split, but we 
definitely want a 600/400 split over a 1/999 split, since the 1/999 split 
isn't likely to get us any closer to the answer.

Now, I say "roughly", because there may not _be_ any commit that exactly 
bisects the case. For a trivial case, let's say that we know that 'A' is 
bad, and 'B' is good, but the graph in between them looks like this:


                   A
                 / |
                a  | 
                |  b
                |  | \
                c  d  e
                 \ | /
                   B

so the bug might have been introduced by any of a-e, and we just don't
know which one was the cause.

Now, selecting either 'a' or 'b' as the new tip is a good choice, 'a'
reaches two unknowns (a+c) while b reaches 3 unknowns (b+d+e) but the
others only reach a single unknown.

And notice how the two good bisection places were both _recent_. They were 
not in the middle "time-wise".

Also note that we do NOT want to reach the maximal amount of commits: we 
want to reach _half_ the commits. If we select a commit that reaches a lot 
of other unknown commits ('A' is the maximal here, of course), then we're 
not actually bisecting the thing at all: we're just testing close to a 
"known bad" case.

But let's say that 'c' didn't actually exist (or, alternatively, we have
tested that one and know that "B+c" is good, which basically makes 'c'
irrelevant for bug-hunting): in that case there is no good bisection,
since whichever of the remaining ones we choose (a,b,d or e) we'll always
have split it up so that we basically test the addition or subtraction of
just one single commit. There's not anything "--bisect" can do about that, 
and it will just happen to pick one of them. And that's what I mean
by "there may not be any commit that is nicely in the middle".

		Linus
