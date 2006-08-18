From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Fri, 18 Aug 2006 12:25:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 18 18:26:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE7Ab-0001n2-Gx
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 18:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWHRQ0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWHRQ0A
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 12:26:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:465 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030220AbWHRQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 12:25:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J47009RBCB9H230@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 Aug 2006 12:25:57 -0400 (EDT)
In-reply-to: <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25674>

On Fri, 18 Aug 2006, Jon Smirl wrote:

> On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> > A better way to get such a size saving is to increase the window and
> > depth parameters.  For example, a window of 20 and depth of 20 can
> > usually provide a pack size saving greater than 11% with none of the
> > disadvantages mentioned above.
> 
> Our window size is effectively infinite. I am handing him all of the
> revisions from a single file in optimal order. This includes branches.

In GIT packing terms this is infinite delta _depth_ not _window_.

> He takes these revisions, runs xdiff on them, and then puts the entire
> result into a single zlib blob.

This is not a good idea to have infinite delta depth.  The time to 
browse the repository history then becomes exponential with the number 
of revisions making the value of such a repository a bit questionnable 
(you could as well only preserve the last 2 years of history instead 
since further than that with infinite delta depth is likely to be too 
slow and painful to use).

But just for comparison I did a repack -a -f on the kernel repository 
with --window=50 --depth=5000 which should be a good approximation of 
the best possible delta matchingwith infinite depth.

Default delta params (window=10 depth=10) : 122103455 
Agressive deltas (window=50 depth=5000) : 105870516
Reduction : 13%

OK let's try it with delta chains in the same zlib stream using the 
patch I posted yesterday (with a minor tweak allowing the usage of -f 
with git-repack).

Agressive and grouped deltas (window=50 depth=5000 : 99860685

This is a mere 5.7% reduction over the non grouped deltas, less than the 
11% reduction I obtained yesterday when the delta depth is kept 
reasonably short.

The increased delta depth is likely to make a large difference on old 
repos with long history, maybe more so and with much less 
complexity than the delta grouping.

> I suspect the size reduction is directly proportional to the age of
> the repository. The kernel repository only has three years worth of
> data in it.  Linus has the full history in another repository that is
> not in general distribution. We can get it from him when he gets back
> from vacation.
> 
> If the repository doesn't contain long delta chains the optimization
> doesn't help that much. On the other hand it doesn't hurt either since
> the chains weren't long.  My repository is four times as old as the
> kernel one and I am getting 4x the benefit.

No that cannot be right.

Let's assume every whole objects are 10 in size and every deltas are 1.  
You therefore can have 1 base object and 10 delta objects, effectively 
storing 11 objects for a size of 20.  You therefore have a 1.8 vs 10 
size ratio.

If the delta depth is 100 then you potentially have 1 base object and 
100 deltas for a size ratio of 1.1 vs 10.

If the delta depth is 1000 the ratiobecomes 1.01 vs 10.

The size saving is therefore _not_ proportional with the age of the 
repository.  It rather tend to be asymptotic with the delta ratio (but 
impose an exponential runtime cost when fetching objects out of it).

The fact that your 4x old repository has 
a 4x size saving 
can be due only to packing malfunction I would say.


Nicolas
