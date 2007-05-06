From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 09:38:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705060919010.25245@woody.linux-foundation.org>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
 <20070506101953.GA17498@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Hasselstr?m <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 18:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkjlX-0000sY-6N
	for gcvg-git@gmane.org; Sun, 06 May 2007 18:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbXEFQjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 12:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXEFQjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 12:39:09 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:43063 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669AbXEFQjI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 12:39:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l46Gcndf024111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 09:38:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l46GcmdR027134;
	Sun, 6 May 2007 09:38:49 -0700
In-Reply-To: <20070506101953.GA17498@diana.vm.bytemark.co.uk>
X-Spam-Status: No, hits=-2.981 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46344>



On Sun, 6 May 2007, Karl Hasselstr?m wrote:
> 
> OK, now I've tested it, and just as you said, it works (and is _very_
> useful) but looks like crap. :-)
> 
> Is there any fundamental reason why
> 
>   gitk -- some/path/name
> 
> generates a nice, connected graph, while
> 
>   gitk -S'some string'
> 
> generates disconnected spaghetti?

There is a reason, and it's fairly fundamental: the path limiting code is 
deeply embedded in the revision walking, and I've spent a fair amount of 
effort on making that work and efficient as hell (it's one of the few 
areas in git where I'm probably still the main author). Because it's 
literally what I do 90% of the time: for me, the path-limiting code is 
basically _the_ most important git feature, and I care very deeply.

In contrast, the "-S" thing is not actually part of the revision walking 
at all, and is a totally separate phase that is done when revisions are 
_shown_. I almost never use it myself, and it grew out of a totally 
separate effort by Junio. 

> Or could the latter be made to use the same parent-rewriting logic as 
> the first?

It would probably be possible to make the -S logic be another part of the 
"prune_fn()" logic in revision.c, and it might even simplify some of the 
logic, but I suspect it would actually suck really really badly from a 
performance standpoint.

Why? Because the prune_fn() logic is done when we generate the revision 
graph, which is generally something that a lot of the operations have to 
do up-front before they can do _anything_ else. Eg, any revision limiter 
(and that's a very common case) like "v2.6.21.." will cause the revision 
pruning to happen synchronously and early on.

And the path-limiting is *fast*. It's so incredibly fast that people don't 
really realize how fast it is. And it absolutely needs to be fast, because 
when you do something like "gitk v2.6.18.. drivers/" on the kernel you end 
up doing a _lot_ of tree comparisons. It's why I'm pretty sure nobody else 
can ever do what git does - it takes full advantage of how git can tell 
that a whole subdirectory hasn't changed without even recursing into it.

In contrast, "-S" is _slow_. It's a really really expensive operation. Git 
makes generating diffs faster than just about anything else, but it's 
still really expensive. This is a really unfair comparison, but:

	time git log drivers/net/ > /dev/null

	real    0m1.488s
	user    0m1.444s
	sys     0m0.040s

ie we can do the log pruning for the whole kernel git history on a 
subdirectory in less than two seconds. 

Try to compare it with

	time git log -Sdrivers/net/ > /dev/null

and I suspect you won't have the patience to wait for the end result.

And yeah, the operations are fundamentally very very different, and yes, 
the latter operation is really really expensive (which is why I said it's 
a really unfair comparison). But the point is that the expense comes from 
how git has been designed: seeing differences in the paths is cheap by 
design (it's how the data structures are laid out), but seeing differences 
in actual diffs means that we have to fully generate each diff for each 
revision!

A different approach to the underlying datastructures could change the 
equation. For example, if the fundamental data representation was the 
"diff" (rather than the "whole tree") maybe -S would be as fast as path 
limiting. But you'd *really* suck for other things.

To summarize a long story: the path limiting is simply more fundamental in 
git. Both by design, and then - obviously partly _due_ to that - by pure 
effort we've spent on it. It's something very deep and very important. In 
comparison, the -S thing is a cute extra feature, nothing really "deep".

		Linus
