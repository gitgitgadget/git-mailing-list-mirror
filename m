From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:00:11 -0400
Message-ID: <20060629180011.GA4392@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw0oT-00041O-Tv
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWF2SAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWF2SAQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:00:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:58850 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751127AbWF2SAN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:00:13 -0400
Received: (qmail 2663 invoked from network); 29 Jun 2006 13:59:51 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 13:59:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 14:00:11 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22877>

On Thu, Jun 29, 2006 at 11:42:14AM -0400, Nicolas Pitre wrote:

> So the negative cache should not be O(N^2) either.  It just has to be 
> O(N*window).

Yes, unless we use the cache information to change the window (but I
don't think that's worth it, unless our window heuristics are bad).
The implementation I posted should already grow to O(N*window), since it
only saves what we try (and fail at).

> My past experiments showed that the best window size for compression is 
> a bit larger than the current default of 10.  It was rather around 15 
> for the kernel repository, with higher values than 15 not providing 
> significant improvements anymore.  But that is clearly a function of the 
> repository nature (the average number of revisions for each file).  But 
> the window size is directly connected to the computational cost.

Increasing the window, of course, has virtually no speed impact on later
repacks with the cache in effect. Packing with a window of 15 drops my
linux-2.6 pack to 108M from 122M. That helps offset the cache size
(though of course it takes longer on the initial pack).

> This is way suboptimal.  First there is no reason for the cache to ever 
> grow to N^2.  At worst it should be N*10 where 10 is the current window 
> size.

I assumed the window would change over time (though our total is still
likely to hang around N*10 rather than N^2).

> none of the objects found in a given window.  Therefore we only have to 
> compute a hash for the object names found in that window and store that 
> in the cache.  So the cache entries would then be a pair of sha1: first 
> the sha1 of the victim object, and the sha1 of all sha1 names for the 
> objects against which the victim object was found not to delta well 
> against.

This will fail to hit the cache anytime the window changes. How often
does the window change? In my test case, I would think anytime I added a
bunch of new photos, it would be likely that one of them would make it
into the window, thus invalidating the cache entry and forcing me to try
against every object in the window (even though I've already tried
9/10).

Also, is it true to say "if this object did not delta against this
window, it will never delta?" What about interactions with the depth
parameter?

> So given my GIT repository such a cache would be 7610 * 40 = 304400 
> bytes if we stick to the full 40 bytes of sha1 to hash bad combinations.

Keep in mind that it will grow every time the window changes.

-Peff
