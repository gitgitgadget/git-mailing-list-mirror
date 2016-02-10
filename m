From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 18:03:07 -0500
Message-ID: <20160210230307.GA6633@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net>
 <20160210221758.GC10155@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 00:03:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTdn3-00063o-1f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 00:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbcBJXDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 18:03:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:40079 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752564AbcBJXDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 18:03:09 -0500
Received: (qmail 21610 invoked by uid 102); 10 Feb 2016 23:03:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 18:03:09 -0500
Received: (qmail 32723 invoked by uid 107); 10 Feb 2016 23:03:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 18:03:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 18:03:07 -0500
Content-Disposition: inline
In-Reply-To: <20160210221758.GC10155@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285940>

On Wed, Feb 10, 2016 at 02:17:58PM -0800, Jonathan Nieder wrote:

> > Because the magic happens in the git protocol, that would mean this does
> > not have to be limited to git-over-http. It could be "resumable=<url>"
> > to point the client anywhere (the same server over a different protocol,
> > another server, etc).
> 
> Thanks for bringing this up.  A worry with putting the URL in the
> capabilities line is that it makes it easy to run into the 1000-byte
> limit.  It's been a while since v1.8.3-rc0~148^2~6 (pkt-line: provide
> a LARGE_PACKET_MAX static buffer, 2013-02-20) but we still can't
> rely on clients having that applied.

I hadn't considered that, but I'm not sure how much of a problem it is
in practice. The first line is 40-hex sha1, space, HEAD, NUL, then
capabilities. The current capabilities string from github.com on a
sample repo (which has a rather large agent string, and a normal-sized
symref pointer for HEAD) is 188 bytes. So that's still over 750 bytes
available for a URL. The space isn't infinite, and we may want to add
more capabilities later. But I'd think that devoting even 256 bytes to a
url would be reasonable, and leave us with fair room to grow.

> Another nice thing about using a 302 is that you can set cookies
> during the redirect, which might make authenticated access easier.
> (That said, authenticated access through e.g. signed URLs can work
> fine without that.)

Yeah, I can see there are advantages to assuming all the world is HTTP,
but it just doesn't seem that practical to me.

> > Clients do not have to _just_ fetch a packfile. They could get a bundle
> > file that contains the roots along with the packfile. I know that one of
> > your goals is not duplicating the storage of the packfile on the server,
> > but it would not be hard for the server to store the packfile and the
> > bundle header separately, and concatenate them on the fly.
> 
> Doesn't that prevent using a git-unaware file transfer service to
> serve the files?

Sort of. They would just need to serve the combined file. But _if_ you
have a git-unaware service (rsync?) _and_ its hitting the same storage
(so you could in theory not store the packfile twice), _and_ it cannot
be taught to do any kind of concatenation, then yes, it would be a
problem.

I do think I favor the "split bundle" anyway, though, just for
simplicity on both ends.

> > And you'll notice, too, that all of the bundle-http magic kicks in
> > during step 2 because the client sees they're grabbing a bundle. Which
> > means that the <url> in step 1 doesn't _have_ to be a bundle. It can be
> > "go fetch from kernel.org, then come back to me".
> 
> I think that use case brings in complications that make it not
> necessarily worth it.  In this example, if kernel.org is serving pack
> files, why shouldn't I point directly at the advertised pack CDN URL
> instead of adding an extra hop that puts added load on kernel.org
> servers?

Sure, that would be more efficient if kernel.org is providing such a CDN
URL. But they aren't now, because it doesn't exist yet, and this feature
can be used by you without having to coordinate their use of the
feature. And you can replace kernel.org in my example with any other
server that happens to be preferable to fetching from you, for whatever
reason.

> My motivation comes from the example of
> alternates: it is pretty and very flexible and ended up as a support
> and maintenance headache instead of being widely useful.

I guess one man's trash is another's treasure. Alternates are in wide
use at GitHub, and are pretty much what make our data model feasible.
I'm pretty sure that git.or.cz uses them for similar purposes, too.

> I think what
> you are proposing is more harmless but I'd still want to have an
> example of what it's used for before going in that direction.

Unless there is a big immediate downside, I'd rather err in the opposite
direction: keep orthogonal concerns separate (e.g., redirecting to X
versus protocol details of X).

-Peff
