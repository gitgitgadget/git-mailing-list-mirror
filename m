From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 15:04:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 21:06:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1oL-0006YH-L6
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 21:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWF2TES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 15:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWF2TER
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 15:04:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9342 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932099AbWF2TEQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 15:04:16 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1M0092YYB314Z0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 15:04:16 -0400 (EDT)
In-reply-to: <20060629185335.GA6704@coredump.intra.peff.net>
X-X-Sender: nico@localhost.localdomain
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22891>

On Thu, 29 Jun 2006, Jeff King wrote:

> On Thu, Jun 29, 2006 at 02:24:57PM -0400, Nicolas Pitre wrote:
> 
> > > I assumed the window would change over time (though our total is still
> > > likely to hang around N*10 rather than N^2).
> > It doesn't change unless you force a different window size.
> 
> Sorry, I meant "the items in the window for a given object would change
> over time." 
> 
> > > This will fail to hit the cache anytime the window changes. How often
> > > does the window change? In my test case, I would think anytime I added a
> > > bunch of new photos, it would be likely that one of them would make it
> > > into the window, thus invalidating the cache entry and forcing me to try
> > > against every object in the window (even though I've already tried
> > > 9/10).
> > Sure.  But on the lot how often will that happen?
> 
> Reasonably often, according to my test. I did this to simulate usage
> over time:
>   - create an empty repo
>   - from my test repo of 515 images, grab 20 at a time and add/commit
>     them
>   - after each commit, record the SHA1 of (object, window[0..n]) for
>     each object to be delta'd
> If doing the cache on the sha1 of the whole window is a good idea, then
> we should see many of the same hashes from commit to commit. If we
> don't, that means the newly added files are being placed in the old
> windows, thus disrupting their hashes.
> 
> The results were that there was typically only 1 reusable window each
> time I added 20 files. At that point, caching is largely pointless.

Right.  Your use pattern is a special case that doesn't work well with 
the whole window hash approach.  I'd expect it to work beautifully with 
the kernel repository though.

> > And even then, since my suggested method implies only one cache lookup 
> > in a much smaller cache instead of 10 lookups in a larger cache for each 
> > objects it might end up faster overall even if sometimes some windows 
> > don't match and deltas are recomputed needlessly.
> 
> I didn't benchmark, but I doubt it will have significant impact.
> Especially on my photo test repo, the lookups are dominated by the
> create_delta time by several orders of magnitude.

Again I think it is a repo like the linux kernel that would benefit 
more.

> > Of course a greater depth might allow for a hit where there isn't any 
> > otherwise.  But changing the delta depth is not something someone does 
> > that often, and when the depth is changed then you better use -f with 
> > git-repack as well which like I said should also ignore the cache.
> 
> That sounds reasonable to me for depth. What about other reasons for
> try_delta to fail? Preferred base?

Hmmm.  That might need to be dealth with (easily but still).


Nicolas
