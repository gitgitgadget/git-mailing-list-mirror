From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:53:35 -0400
Message-ID: <20060629185335.GA6704@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain> <20060629180011.GA4392@coredump.intra.peff.net> <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 20:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1e1-0004bG-5H
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWF2Sxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWF2Sxi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:53:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:14782 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751266AbWF2Sxh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:53:37 -0400
Received: (qmail 4811 invoked from network); 29 Jun 2006 14:53:15 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 29 Jun 2006 14:53:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jun 2006 14:53:35 -0400
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22889>

On Thu, Jun 29, 2006 at 02:24:57PM -0400, Nicolas Pitre wrote:

> > I assumed the window would change over time (though our total is still
> > likely to hang around N*10 rather than N^2).
> It doesn't change unless you force a different window size.

Sorry, I meant "the items in the window for a given object would change
over time." 

> > This will fail to hit the cache anytime the window changes. How often
> > does the window change? In my test case, I would think anytime I added a
> > bunch of new photos, it would be likely that one of them would make it
> > into the window, thus invalidating the cache entry and forcing me to try
> > against every object in the window (even though I've already tried
> > 9/10).
> Sure.  But on the lot how often will that happen?

Reasonably often, according to my test. I did this to simulate usage
over time:
  - create an empty repo
  - from my test repo of 515 images, grab 20 at a time and add/commit
    them
  - after each commit, record the SHA1 of (object, window[0..n]) for
    each object to be delta'd
If doing the cache on the sha1 of the whole window is a good idea, then
we should see many of the same hashes from commit to commit. If we
don't, that means the newly added files are being placed in the old
windows, thus disrupting their hashes.

The results were that there was typically only 1 reusable window each
time I added 20 files. At that point, caching is largely pointless.

> And even then, since my suggested method implies only one cache lookup 
> in a much smaller cache instead of 10 lookups in a larger cache for each 
> objects it might end up faster overall even if sometimes some windows 
> don't match and deltas are recomputed needlessly.

I didn't benchmark, but I doubt it will have significant impact.
Especially on my photo test repo, the lookups are dominated by the
create_delta time by several orders of magnitude.

> Of course a greater depth might allow for a hit where there isn't any 
> otherwise.  But changing the delta depth is not something someone does 
> that often, and when the depth is changed then you better use -f with 
> git-repack as well which like I said should also ignore the cache.

That sounds reasonable to me for depth. What about other reasons for
try_delta to fail? Preferred base?

> > > So given my GIT repository such a cache would be 7610 * 40 = 304400 
> > > bytes if we stick to the full 40 bytes of sha1 to hash bad combinations.
> > Keep in mind that it will grow every time the window changes.
> What do you mean by window change?

I meant that when the window we use for a given object changes, it will
insert a new cache entry. But if we deal with invalidating unused cache
entries as you suggested before, it won't matter.

-Peff
