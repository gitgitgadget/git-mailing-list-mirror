From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 18:49:41 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807291822590.3334@nehalem.linux-foundation.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org> <200807260512.40088.zippel@linux-m68k.org> <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <alpine.LFD.1.10.0807282023290.3334@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807291235350.6791@localhost.localdomain> <alpine.LFD.1.10.0807290838360.3334@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807300223010.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 03:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO0tT-0005b2-L0
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 03:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbYG3BxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 21:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYG3BxX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 21:53:23 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39057 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753370AbYG3BxW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 21:53:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U1qdSw011806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 18:52:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U1qdEc001103;
	Tue, 29 Jul 2008 18:52:39 -0700
In-Reply-To: <Pine.LNX.4.64.0807300223010.6791@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90725>



On Wed, 30 Jul 2008, Roman Zippel wrote:
> > 
> > 	time sh -c "git log <filename> | head"
> > 
> > nothing else matters. If you can make that one be fast, I'm happy. 
> 
> I already explained it, but you simply dismissed it. It's possible, but it 
> requires a bit of cached information (e.g. as part of the pack file, which 
> is needed for decent performance anyway).

Bzzt. Wrong. Try again.

> > In fact, you can see what I'm talking about by trying --topo-order in the 
> > above timing test.
> 
> Please give me full example.
> gitk --topo-order kernel/printk.c shows no difference (e.g. it doesn't 
> show 02630a12c7f72fa294981c8d86e38038781c25b7), several experiments with 
> git-rev-list show no improvement either.

Roman, what the f*ck is wrong with you? Let me repeat that thing one more 
time:

	you can see what I'm talking about by trying --topo-order in the
	above timing test.
	      ^^^^^^^^^^^

The fact is, --topo-order is a post-processing thing, exactly the way your 
half-way simplification would be. It requires _all_ commits, and it 
requires them because we cannot guarantee that we output all children 
before the parents when there are multiple threads without a central clock 
(ie any distributed environment).

So for --topo-order, we generate the whole history, and then we sort it. 

As a result, it has horrible interactivity behavior. Try it. Here's some 
random command lines, and the times:

	time git log --topo-order drivers/scsi/scsi_lib.c | head

	real    0m0.688s
	user    0m0.652s
	sys     0m0.036s

and without:

	time git log drivers/scsi/scsi_lib.c | head

	real    0m0.033s
	user    0m0.024s
	sys     0m0.008s

do you see the difference? They happen to output _exactly_ the same ten 
lines, but one of them takes the better part of a second (and that's on 
pretty much the fastest machine you can find right now - on a laptop with 
a slow disk and without things in cache, it would take many many seconds).

The other one is instantaneous.

Now, I realize that 0.033s vs 0.688s doesn't sound like a big deal, even 
though that's a 20x difference, but that 20x difference is a _really_ big 
deal when the machine is slower, or when "old history" isn't in the disk 
cache any more.

For example, try doing the timings after flushing the disk caches to 
simulate cold-cache behavior. Do it with a slow disk. Or do it over NFS. 
Yes, even the "fast" case will actually be painfully slow (well, it is for 
me, people who are used to CVS probably think it's just "normal"). 

And yes, it will depend a lot on the file in question too. Obviously, if 
the first change is far back in history, it will be slow _regardless_, but 
I've at least personally found that in practice, you tend to look at logs 
of _recent_ things much much much more than you look at things that 
haven't changed lately.	

It will also depend a lot on whether you are packed or not. For example, 
if you are well packed, the pack-file IO locality is really really good, 
and the 20x slowdown is much less. I just tested with a laptop with a slow 
disk, and the --topo-order case was "only" 2.5x slower, almost certainly 
because the IO required to bring in the first part of the history ended up 
being a large portion of the total IO, and so the "whole history" case was 
not 20x slower, because there was not 20x more IO due to the good locality 
and the kernel doing readahead etc.

But 2.5x slower is really bad, wouldn't you agree? We're not talking about 
a few percent here, we're talking about more than twice as long. It's very 
noticeable, especially when the end result was --topo-order: 29.8s, no 
topo-order 12.1s

(Yeah, that wasn't a very realistic example, but on that same machine, 
once it's in the cache, it's 0.13s vs 1.6s: one is "instant", the other is 
very much a "wait for it" kind of thing.)

THAT is the kind of performance difference you see.

And trust me, it's a performance difference that you can really notice in 
real life. I'm not kidding you. Just try it:

	git log kernel/sched.c
vs
	git log --topo-order kernel/sched.c

and one is instant, the other one pauses before it starts showing 
something. One feels fast, the other feels slow.

At the same time, if you actually time the _whole_ log, it's all exactly 
the same speed:

	[torvalds@nehalem linux]$ time git log --topo-order kernel/sched.c > /dev/null 
	real	0m0.708s
	user	0m0.684s
	sys	0m0.020s

	[torvalds@nehalem linux]$ time git log kernel/sched.c > /dev/null 
	real	0m0.703s
	user	0m0.672s
	sys	0m0.032s

Notice? The cost of the topological sort itself is basically zero. But 
from an interactivity standpoint, it's _deadly_.

And please note that here "--topo-sort" is just an example of a random 
"global history post-processing" thing. It's not that I want you to use 
the topological sort per se, it's just an example of the whole issue with 
_any_ post-factum operation. The topological sort is not expensive as a 
sort. What is expensive is that it needs to get the whole history to work.

And also please notice that this is a huge scalability issue. "git log" 
should not become slower as a project gets more history. Sure, the full 
log will take longer to generate (because there's _more_ of it), but the 
top commits should always show up immediately.

Again, if you have a filter (where "topological sort" is just an example 
of such a filter) that requires the full history to work, it simply 
_fundamentally_ cannot scale well. If very fundamentally will slow down 
with bigger history.

> The problem is that your picture doesn't include my specific problem, I'm 
> very interested in the big picture, but I'd like to be in it.

Roman, I've been trying to explain this "interactive" thing for _days_ 
now. That's the big picture. The whole "you have to be able to generate 
history incrementally" thing.

First generating the whole global history, and then simplifying it, is 
simply not acceptable. It's too slow, and it doesn't scale.

			Linus
