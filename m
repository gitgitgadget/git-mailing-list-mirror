From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 13:48:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608211309270.3851@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain>
 <9e4733910608180615q4895334bw57c55e59a4ac5482@mail.gmail.com>
 <Pine.LNX.4.64.0608181057440.11359@localhost.localdomain>
 <20060821070609.GC24054@spearce.org>
 <Pine.LNX.4.64.0608211036150.3851@localhost.localdomain>
 <9e4733910608210914s1157f47eta821584928ce4dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 19:49:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFDtm-0006ZU-IH
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 19:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWHURtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 13:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWHURtB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 13:49:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23491 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1422733AbWHURtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 13:49:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4D000QX05N0XO0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Aug 2006 13:48:59 -0400 (EDT)
In-reply-to: <9e4733910608210914s1157f47eta821584928ce4dd5@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25806>

On Mon, 21 Aug 2006, Jon Smirl wrote:

> How about making the length of delta chains an exponential function of
> the number of revs? In Mozilla configure.in has 1,700 revs and it is a
> 250K file. If you store a full copy every 10 revs that is 43MB
> (prezip) of data that almost no one is going to look at.
> The chains
> lengths should reflect the relative probability that someone is going
> to ask to see the revs. That is not at all a uniform function.

1) You can do that already with stock git-repack.

2) The current git-pack-objects code can and does produce a delta "tree" 
   off of a single base object.  It doesn't have to be a linear list.

Therefore, even if the default depth is 10, you may as well have many 
deltas pointing to the _same_ base object effectively making the 
compression ratio much larger than 1/10.

If for example each object has 2 delta childs, and each of those deltas 
also have 2 delta childs, you could have up to 39366 delta objects 
attached to a _single_ undeltified base object.

And of course the git-pack-objects code doesn't limit the number of 
delta childs in any way so this could theoritically be infinite even 
though the max depth is 10.  OK the delta matching window limits that 
somehow but nothing prevents you from repacking with a larger window 
since that parameter has no penalty on the reading of objects out of the 
pack.

> Personally I am still in favor of a two pack system. One archival pack
> stores everything in a single chain and size, not speed, is it's most
> important attribute. It is marked readonly and only functions as an
> archive; git-repack never touches it. It might even use a more compact
> compression algorithm.
> 
> The second pack is for storing more recent revisions. The archival
> pack would be constructed such that none of the files needed for the
> head revisions of any branch are in it. They would all be in the
> second pack.

Personally I'm still against that.  All arguments put forward for a 
different or multiple packing system are based on unproven assumptions 
so far and none of those arguments actually present significant 
advantages over the current system.  For example, I was really intriged 
by the potential of object grouping into a single zlib stream at first, 
but it turns out not to be so great after actual testing.

I still think that a global zlib dictionary is a good idea.  Not because 
it looks like it'll make packs enormously smaller, but rather because it 
impose no performance regression over the current system.  And I 
strongly believe that you have to have a really strong case for 
promoting a solution that carries performance regression, something like 
over 25% smaller packs for example.  But so far it didn't happen.

> This may be a path to partial repositories. Instead of downloading the
> real archival pack I could download just an index for it. The index
> entries would be marked to indicate that these objects are valid but
> not-present.

An index without the actual objects is simply useless.  You could do 
without the index entirely in that case anyway since the mere presence 
of an entry in the index doesn't give you anything really useful.


Nicolas
