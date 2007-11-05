From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 16:41:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051620230.7357@iabervon.org>
References: <20071105175654.GD6205@artemis.corp> <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
 <20071105210711.GA9176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9hh-0008MD-FL
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXKEVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 16:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbXKEVlj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:41:39 -0500
Received: from iabervon.org ([66.92.72.58]:58222 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbXKEVli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 16:41:38 -0500
Received: (qmail 28350 invoked by uid 1000); 5 Nov 2007 21:41:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 21:41:37 -0000
In-Reply-To: <20071105210711.GA9176@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63563>

On Mon, 5 Nov 2007, Jeff King wrote:

> On Mon, Nov 05, 2007 at 01:17:14PM -0500, Daniel Barkalow wrote:
> 
> > I think this is the bit that's wrong. I blame Jeff, in 334f4831. :)
> > 
> > The issue is that, in the previous version, we'd hit a continue on the 
> > not-an-ancestor message and not reach the update_tracking_ref() section 
> > for that ref. In 334f4831, all of the updating is after the loop, and it 
> > doesn't filter out the refs that didn't actually get pushed.
> 
> Nope, that's not the problem. We _only_ update any tracking refs at all
> if ret == 0, and if we fail to push, then we are setting ret to -2.

That's an odd combination of behavior: we update some of the refs, leave 
the ones that didn't work alone, report success on the ones that worked, 
but then we forget that some things worked?

If we're going to refuse to update local tracking refs, whose state 
doesn't matter much, we should certainly refuse to update the remote refs, 
which are probably public and extremely important. If we just pushed and 
we fetch, we should see exclusively changes that somebody else (including 
hooks remotely) did, not anything that we ourselves did.

> Hrm. Oh wait, it looks like we then totally write over the current value
> of 'ret' when we do pack_objects. Oops.
> 
> I'm unclear how to fix this, as I'm not really sure what ret is
> _supposed_ to be communicating. What does the '-2' mean, as compared to
> a '-4'? Should we be doing a 'ret += pack_objects(out, remote_refs)' or
> some other bit-masking magic?

I'd guess -2 is supposed to indicate that there were some errors but some 
things may have worked. If pack_objects() or receive_status() fails, we 
shouldn't update anything locally (because it won't have been accepted 
remotely); otherwise, we should make local updates of every remote efect 
we had, even if we end up returning non-zero to indicate that we didn't do 
everything asked.

	-Daniel
*This .sig left intentionally blank*
