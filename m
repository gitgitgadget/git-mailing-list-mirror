From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 23:45:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705162309310.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site>
 <20070517010335.GU3141@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 17 05:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoWw2-00057A-21
	for gcvg-git@gmane.org; Thu, 17 May 2007 05:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbXEQDpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 23:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757793AbXEQDpn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 23:45:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64279 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbXEQDpm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 23:45:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI600JOB2FUJF90@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 16 May 2007 23:45:30 -0400 (EDT)
In-reply-to: <20070517010335.GU3141@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47492>

On Wed, 16 May 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Don't forget that those 10% probably do not do you the favour to be in 
> > large chunks. Chances are that _every_ _single_ wanted object is separate 
> > from the others.
> 
> That's completely possible.  Assuming the objects even are packed
> in the first place.  Its very unlikely that you would be able to
> fetch very large of a range from an existing packfile, you would be
> submitting most of your range requests for very very small sections.

Well, in the commit objects case you're likely to have a bunch of them 
all contigous.

For tree and blob objects it is less likely.

And of course there is the question of deltas for which you might or 
might not have the base object locally already.

Still... I wonder if this could be actually workable.  A typical daily 
update on the Linux kernel repository might consist of a couple hundreds 
or a few tousands objects.  This could still be faster to fetch parts of 
a pack than the whole pack if the size difference is above a certain 
treshold.  It is certainly not worse than fetching loose objects.

Things would be pretty horrid if you think of fetching a commit object, 
parsing it to find out what tree object to fetch, then parse that tree 
object to find out what other objects to fetch, and so on.

But if you only take the approach of fetching the pack index files, 
finding out about the objects that the remote has that are not available 
locally, and then fetching all those objects from within pack files 
without even looking at them (except for deltas), then it should be 
possible to issue a couple requests in parallel and possibly have decent 
performances.  And if it turns out that more than, say, 70% of a 
particular pack is to be fetched (you can determine that up front), then 
it might be decided to fetch the whole pack.

There is no way to sensibly keep those objects packed on the receiving 
end of course, but storing them as loose objects and repacking them 
afterwards should be just fine.

Of course you'll get objects from branches in the remote repository you 
might not be interested in, but that's a price to pay for such a hack.  
On average the overhead shouldn't be that big anyway if branches within 
a repository are somewhat related.

I think this is something worth experimenting.


Nicolas
