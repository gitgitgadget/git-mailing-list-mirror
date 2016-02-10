From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 17:03:35 -0500
Message-ID: <20160210220334.GB5853@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
 <xmqqh9hgz3km.fsf@gitster.mtv.corp.google.com>
 <20160210212207.GB10155@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:04:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTcrv-0008Je-14
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbcBJWEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 17:04:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:40048 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751464AbcBJWDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 17:03:37 -0500
Received: (qmail 18716 invoked by uid 102); 10 Feb 2016 22:03:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 17:03:37 -0500
Received: (qmail 32274 invoked by uid 107); 10 Feb 2016 22:03:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 17:03:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 17:03:35 -0500
Content-Disposition: inline
In-Reply-To: <20160210212207.GB10155@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285936>

On Wed, Feb 10, 2016 at 01:22:07PM -0800, Jonathan Nieder wrote:

> > I am not quite sure if that is an advantage, though.  The second
> > message proposes that the lost-found computation to be done by the
> > client using *.pack, but any client, given the same *.pack, will
> > compute the same result, so if the result is computed on the server
> > side just once when the *.pack is prepared and downloaded to the
> > client, it would give us a better overall resource utilization.  And
> > in essence, that was what the *.info file in the first message was.
> 
> Advantages of not providing the list of roots:
>  1. only need one round-trip to serve the packfile as-is
>  2. less data sent over the wire (not important unless the list of roots
>     is long)
>  3. can be enabled on the server for existing repositories without an
>     extra step of generating .info files
> 
> Advantage of providing the list of roots:
> - speedup because the client does not have to compute the list of roots
> 
> For a client that is already iterating over all objects and inspecting
> FLAG_LINK, the advantage (3) seems compelling enough to prefer the
> protocol that doesn't sent a list of roots.

I'm not sure how compelling (3) is, since we are relying on the server
to make certain packing choices. I guess a stock "git repack -ad" would
do in a pinch; it should at least contain all needed objects, but it's
going to potentially have extra cruft objects (from reflogs, for
example).

I outlined some alternatives to Shawn's proposal elsewhere in the
thread. I think it's a useful feature for this redirect to not just be
"go fetch this packfile", but "go clone from here and come back to me".
That opens up a lot of flexibility.

It does make "go fetch this packfile without roots" a little harder, but
I think it's still do-able. Right now when git hits an http URL, we pass
the smart-http "?service=" magic, and we look at the response to figure
out whether we got:

  1. A smart-http server.

  2. A dumb-http server.

  N. Something else, in which case we die.

The alternative I outlined elsewhere (and the patches I posted long
ago) basically adds:

  3. If it's a bundle, fetch the bundle and then clone from that.

But we could also do:

  4. If it's a packfile, fetch the packfile and then do the
     find-the-roots magic.

> Except when people pass --depth, "git clone" sets
> 'check_self_contained_and_connected = 1'.  That means clients that
> already iterate over all objects and inspect FLAG_LINK are the usual
> case.

Somewhat related, but I've wondered if we could do something similar
even for non-clone cases. That is, `index-pack` could tell us the set of
referenced but missing objects, and we could verify that each of those
is reachable (we _could_ just have it verify that we have the object at
all; traditionally we only guaranteed that reachable objects were kept,
but these days we keep anything reachable from another object we are
keeping, so if you have X, you should always have X^, etc).

Anyway, that's quite a tangent from this topic.

-Peff
