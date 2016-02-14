From: Jeff King <peff@peff.net>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Sun, 14 Feb 2016 12:05:25 -0500
Message-ID: <20160214170525.GB10219@sigill.intra.peff.net>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <20160210214945.GA5853@sigill.intra.peff.net>
 <CAJo=hJv-GWZOsv31iekW+AdNazLGQ=XYD=UXMO+RuB15baTsow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 18:05:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV072-0004p0-Lc
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 18:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbcBNRF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 12:05:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:41846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751516AbcBNRF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 12:05:28 -0500
Received: (qmail 15835 invoked by uid 102); 14 Feb 2016 17:05:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 12:05:27 -0500
Received: (qmail 1503 invoked by uid 107); 14 Feb 2016 17:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 12:05:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2016 12:05:25 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJv-GWZOsv31iekW+AdNazLGQ=XYD=UXMO+RuB15baTsow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286158>

On Sat, Feb 13, 2016 at 06:14:31PM -0800, Shawn Pearce wrote:

> > And with "resumable=<url>", the client does not have to hit the server
> > to do a redirect; it can go straight to the final URL, saving a
> > round-trip.
> 
> It occurred to me today that to make the above ("resumable=<url>") as
> efficient as possible, we should allow HTTP clients to include
> &resumable=1 in the GET /info/refs URL as a hint to the server that if
> it serves a resumable=<url> it can shrink the ref advertisement to 1
> line containing the capabilities.

I'm slightly wary of this. The client advertising "resumable=1" does not
mean "I will definitely do a resumable clone". It means "I support the
resumable keyword, and if you share a resumable URL with me, I _might_
use it, depending on things that are none of your business" (e.g., if it
does not like the server URL's protocol).

It is recoverable by having the client re-contact the server without the
resumable flag, so it could still be a net win if the client will select
the resumable URL a majority of the time.

I'm also not happy about having an HTTP-only feature in the protocol. I
liked Stefan's proposal for the "v2" protocol that would let the two
sides exchange capabilities before the ref advertisement. Then the
client, having seen the server's resumable URL, knows whether or not
to proceed with the advertisement.

> Clients are going to follow the returned <url> to get a bundle header,
> which contains the references. And then incremental fetch from the
> server after downloading the pack. So returning references with the
> resumable URL during a clone is an unnecessary waste of bandwidth.

If the bundle is up to date, the client can skip the follow-up
incremental fetch, as it knows that it has everything needed for the
original ref advertisement it got. Whether that's a net win depends on
how up-to-date the bundles are.

If "C" is the cost to contact the server at all and "A" is the cost of
the advertisement, then a "hit" with this scheme means the overhead is
C+A (we contact the server only once). A "miss" means we have do the
followup fetch anyway, and we pay 2C+2A (paying the advertisement cost
both times). Whereas with your scheme, we pay 2C+A always; two contacts,
but only the second has an advertisement.

So it depends on the relative cost of C and A, and how often we expect
it to kick in.

In practice, I suspect it's mostly dominated by the cost of the actual
clone objects anyway, but maybe that is different for Gerrit. I hear
refs/changes/ can get pretty big. :)

But if that is the case, then "C" is almost certainly negligible
compared to "A".

> We could also consider allowing resumable=<url> to be relative to the
> repository, so that on HTTP schemes a server could just reply
> resumable=pack-HASH.info or something short and not worry about
> overflowing the capabilities line.

I think that's orthogonal, but yeah, it might be a nice feature for
admins setting up the server side config.

-Peff
