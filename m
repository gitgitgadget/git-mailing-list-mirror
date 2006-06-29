From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:24:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:25:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1CH-0008SK-QX
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWF2SY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWF2SY7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:24:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50383 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751248AbWF2SY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:24:58 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M00EKOWHL7U10@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 14:24:57 -0400 (EDT)
In-reply-to: <20060629180011.GA4392@coredump.intra.peff.net>
X-X-Sender: nico@localhost.localdomain
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22884>

On Thu, 29 Jun 2006, Jeff King wrote:

> > This is way suboptimal.  First there is no reason for the cache to ever 
> > grow to N^2.  At worst it should be N*10 where 10 is the current window 
> > size.
> 
> I assumed the window would change over time (though our total is still
> likely to hang around N*10 rather than N^2).

It doesn't change unless you force a different window size.

> > none of the objects found in a given window.  Therefore we only have to 
> > compute a hash for the object names found in that window and store that 
> > in the cache.  So the cache entries would then be a pair of sha1: first 
> > the sha1 of the victim object, and the sha1 of all sha1 names for the 
> > objects against which the victim object was found not to delta well 
> > against.
> 
> This will fail to hit the cache anytime the window changes. How often
> does the window change? In my test case, I would think anytime I added a
> bunch of new photos, it would be likely that one of them would make it
> into the window, thus invalidating the cache entry and forcing me to try
> against every object in the window (even though I've already tried
> 9/10).

Sure.  But on the lot how often will that happen?
This trades a bit of CPU for much smaller cache which might be worth it.

And even then, since my suggested method implies only one cache lookup 
in a much smaller cache instead of 10 lookups in a larger cache for each 
objects it might end up faster overall even if sometimes some windows 
don't match and deltas are recomputed needlessly.

> Also, is it true to say "if this object did not delta against this
> window, it will never delta?" What about interactions with the depth
> parameter?

Of course a greater depth might allow for a hit where there isn't any 
otherwise.  But changing the delta depth is not something someone does 
that often, and when the depth is changed then you better use -f with 
git-repack as well which like I said should also ignore the cache.

> > So given my GIT repository such a cache would be 7610 * 40 = 304400 
> > bytes if we stick to the full 40 bytes of sha1 to hash bad combinations.
> 
> Keep in mind that it will grow every time the window changes.

What do you mean by window change?


Nicolas
