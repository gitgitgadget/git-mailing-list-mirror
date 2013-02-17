From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] remote-curl: sanity check ref advertisement from
 server
Date: Sun, 17 Feb 2013 14:28:30 -0500
Message-ID: <20130217192830.GB25096@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U79vL-0003Pz-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 20:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab3BQT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 14:28:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50514 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab3BQT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 14:28:32 -0500
Received: (qmail 12875 invoked by uid 107); 17 Feb 2013 19:30:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Feb 2013 14:30:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Feb 2013 14:28:30 -0500
Content-Disposition: inline
In-Reply-To: <20130217110533.GF6759@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216405>

On Sun, Feb 17, 2013 at 03:05:34AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > If the smart HTTP response from the server is truncated for
> > any reason, we will get an incomplete ref advertisement. If
> > we then feed this incomplete list to "fetch-pack", one of a
> > few things may happen:
> >
> >   1. If the truncation is in a packet header, fetch-pack
> >      will notice the bogus line and complain.
> >
> >   2. If the truncation is inside a packet, fetch-pack will
> >      keep waiting for us to send the rest of the packet,
> >      which we never will.
> 
> Mostly harmless since the operator could hit ^C, but still unpleasant.

Fetching is not always interactive.  The deadlock I ran into (and again,
I am not sure if this fixes it or not, but it is _a_ deadlock) was on a
server farm doing a large number of "fetch && checkout && deploy"
operations. Only some of them hung, but it took a while to figure out
what was going on.

> [...]
> > This fortunately doesn't happen in the normal fetching
> > workflow, because git-fetch first uses the "list" command,
> > which feeds the refs to get_remote_heads, which does notice
> > the error. However, you can trigger it by sending a direct
> > "fetch" to the remote-curl helper.
> 
> Ah.  Would a test for this make sense?

A test would be great, if you can devise a way to reliably produce
truncated git output (but still valid http output). In the real-world
problem I had, I believe the truncation was caused by an intermediate
reverse proxy that hit a timeout. I simulated truncation by using netcat
to replay munged http headers and git output.

I suspect the simplest portable thing would be a static file of
truncated git output, served by apache, which would need custom
configuration to serve it with the correct content-type header. It
seemed like a lot of test infrastructure to check for a very specific
thing, so I abandoned trying to make a test.

> > +		if (verify_ref_advertisement(last->buf, last->len) < 0)
> > +			die("ref advertisement is invalid at %s", refs_url);
> 
> Won't this error out with
> 
> 	protocol error: bad line length character: ERR
> 
> instead of the current more helpful behavior for ERR lines?

I don't think so. Don't ERR lines appear inside their own packets? We
are just verifying that our packets are syntactically correct here, and
my reading of get_remote_heads is that the ERR appears inside the
packetized data.

The one thing we do also check, though, is that we end with a flush
packet. So depending on what servers produce, it may mean we trigger
this complaint instead of passing the ERR along to fetch-pack.

Rather than doing this fake syntactic verification, I wonder if we
should simply call get_remote_heads, which does a more thorough check
(and is what we _would_ call in the list case, and what fetch-pack will
call once we pass data to it). It's slightly less efficient, in that it
starts a new thread and actually builds the linked list of refs. But it
probably isn't that big a deal (and normal operation does a "list" first
which does that _anyway_).

> Same stylistic comment about "what would it mean for the return value
> to be positive?" as in patch 2/3.

Same response. :)

-Peff
