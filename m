From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Sun, 20 Aug 2006 23:45:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608202257020.3682@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com>
 <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain>
 <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 05:45:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF0jT-0001Dv-CA
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 05:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWHUDpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 23:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHUDpo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 23:45:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46735 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932595AbWHUDpo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 23:45:44 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4B006P3X46I490@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 20 Aug 2006 23:45:43 -0400 (EDT)
In-reply-to: <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25777>

On Fri, 18 Aug 2006, Jon Smirl wrote:

> On 8/18/06, Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 18 Aug 2006, Jon Smirl wrote:
> >
> > > I attached Shawn's code. He is gone until Monday and can't defend it.
> >
> > I will have a look at it next week as I'll be gone for the weekend as
> > well.
> 
> I looked at it some and couldn't see anything obviously wrong with it,
> but it wasn't a detailed inspection.

I looked at it too and the code looks OK.

This doesn't mean there is no problem at a higher level though.  The 
deltification process is extremely crude and I think this is the cause 
of the original pack size.

For example, last April we discovered that a small change in the 
heuristics to determine base delta objects in git-pack-objects could 
create a pack size regression up to 4x the size of the same pack created 
before such change.

It is also possible to have a denser delta stream but once deflated it 
is larger than a less dense delta to start with.

Just to say that many tweaks and heuristics have been implemented and 
studied in git-pack-objects for over a year now in order to get the 
really small packs we have today.  And a really subtle and 
inocent-looking change can break it size wize.

So what I think is happening with the fastimport code is that the delta 
selection is not really good.  It is certainly much better than no delta 
at all but still not optimal which smells deja vu to me.  Then by 
deflating them all together the redundent information that the bad delta 
set still carries along is eliminated -- thanks to zlib sort of 
mitigating the real issue.

But... as my recent experiments show, the grouping of related deltas 
into a single zlib stream doesn't produce significant improvements when 
implemented directly into git-pack-objects.  Certainly not worth the 
inconvenients and costs it brings along.  I even think that if you used 
git-repack -a -f on the pack produced by the import process, with only 
delta deflated individually just like it did originally, then the 
repacked pack would _also_ shrink significantly.  Most probably around 
4x just like you observed with the grouping of deltas in the same zlib 
stream.

Not only would git-repack make it much smaller, but it also provicdes a 
much better layout where all objects for recent commits are all stored 
together at the beginning of the pack.  The fastimport code is instead 
storing them scattered all over the pack for every commit by making all 
revisions of each file next to each other which will cause horrible 
access patterns and really bad IO.

So I think that trying to make fastimport too clever is wrong.  It 
should instead focus on creating an initial pack as fast as possible and 
then rely on a final git-repack pass to produce the shrinked pack.  I 
really doubt the import code could ever make a better job than 
git-pack-objects does.

If I can make a suggestion, you should forget about this multiple deltas 
in one zlib stream for now and focus on making the import process work 
all the way to tree and commit objects instead.  Then, only then, if 
git-repack -a -f doesn't produce satisfactory pack size we could look at 
better pack encoding.  And so far the grouping of related deltas in one 
zlib stream is _not_ a better encoding given the rather small 
improvement over unmodified git-pack-objects vs the inconvenients and 
cost it brings with it.

> As comparison, I just tar/zipped the Mozilla CVS repo and it is 541MB.
> The 295MB git pack number does not have commits and trees in it, it is
> revisions only.

Running git-repack -a -f from a recent GIT on the Mozilla repo converted 
through cvsps and friends produces a pack smaller than 500MB.  I even 
brought it down to 430MB by using non default delta window and depth.


Nicolas
