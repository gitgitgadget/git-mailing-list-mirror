From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Wed, 01 Mar 2006 12:22:22 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603011211370.29834@localhost.localdomain>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
 <7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
 <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602281017241.25336@localhost.localdomain>
 <7vmzgajvpl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEV1w-0000kL-SN
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCARWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWCARWX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:22:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53231 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932155AbWCARWW
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:22:22 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVG00BC8LL9ZM21@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Mar 2006 12:22:22 -0500 (EST)
In-reply-to: <7vmzgajvpl.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16993>

On Wed, 1 Mar 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> I tried an experimental patch to cull collided hash buckets
> >> very aggressively.  I haven't applied your last "reuse index"
> >> patch, though -- I think that is orthogonal and I'd like to
> >> leave that to the next round.
> >
> > It is indeed orthogonal and I think you could apply it to the next 
> > branch without the other patches (it should apply with little problems).  
> > This is an obvious and undisputable gain, even more if pack-objects is 
> > reworked to reduce memory usage by keeping only one live index for 
> > multiple consecutive deltaattempts.
> 
> Umm.  The hash-index is rather huge, isn't it?  I did not
> realize it was two-pointer structure for every byte in the
> source material, and we typically delta from larger to smaller,
> so we will keep about 10x the unpacked source.  Until we swap
> the windowing around, that means about 100x the unpacked source
> with the default window size.

That's why I said that the window reversal has to be done as well to be 
effective.  As for the index itself it can be reduced to a single 
pointer since the "ptr" value can be deduced from the offset of the 
index entry.

> Also, I am not sure which one is more costly: hash-index
> building or use of that to search inside target.  I somehow got
> an impression that the former is relatively cheap, and that is
> what is being cached here.

Yes, but caching it saves 10% on CPU time, probably more when the window 
is swapped around due to less memory usage.

> > Let's suppose the reference buffer has:
> >  
> > ***********************************************************************/
> >...
> > One improvement might consist of counting the number of consecutive 
> > identical bytes when starting a compare, and manage to skip as many hash 
> > entries (minus the block size) before looping again with more entries in 
> > the same hash bucket.
> 
> Umm, again.  Consecutive identical bytes (BTW, I think "* * *"
> and "** ** **" patterns have the same collision issues without
> being consecutive bytes, so such an optimization may be trickier
> and cost more),

First, those "** ** **" are less frequent in general. Next, they will be 
spread amongst 3 hash buckets instead of all the same one.  And with 
large binary files with lots of zeroes then scanning over those areas in 
one pass instead of iterating over them from every offset would help 
enormously as well, even without limiting the hash list length.

 when emitted as literals, would compress well,
> wouldn't they?  At the end of the day, I think what matters is
> the size of deflated delta, since going to disk to read it out
> is more expensive than deflating and applying.  I think you made
> a suggestion along the same line, capping the max delta used by
> try_delta() more precisely by taking the deflated size into
> account.

Yes.  But deflating a bunch of characters will never be as dense as a 4 
byte delta sequence that might expand to hundreds.


Nicolas
