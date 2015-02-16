From: Jeff King <peff@peff.net>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 10:47:45 -0500
Message-ID: <20150216154745.GA10120@peff.net>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
 <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
 <20150216150305.GA8279@peff.net>
 <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNNto-000079-U0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 16:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbbBPPrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 10:47:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:49585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753017AbbBPPrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 10:47:47 -0500
Received: (qmail 2116 invoked by uid 102); 16 Feb 2015 15:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 09:47:47 -0600
Received: (qmail 15923 invoked by uid 107); 16 Feb 2015 15:47:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 10:47:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 10:47:45 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263904>

On Mon, Feb 16, 2015 at 07:31:33AM -0800, David Lang wrote:

> >Then the server streams the data to the client. It might do some light
> >work transforming the data as it comes off the disk, but most of it is
> >just blitted straight from disk, and the network is the bottleneck.
> 
> Depending on how close to full the WAN link is, it may be possible to
> improve this with multiple connections (again, referencing bbcp), but
> there's also the question of if it's worth trying to use the entire WAN for
> a single user. The vast majority of the time the server is doing more than
> one thing and would rather let any individual user wait a bit and service
> the other users.

Yeah, I have seen clients that make multiple TCP connections to each
request a chunk of a file in parallel. The short answer is that this is
going to be very hard with git. Each clone generates the pack on the fly
based on what's on disk and streams it out. It should _usually_ be the
same, but there's nothing to guarantee byte-for-byte equality between
invocations. So you'd have to multiplex all of the connections into the
same server process. And even then it's hard; that process knows its
going to send you byte the bytes for object X, but it doesn't know at
exactly which offset until it gets there, which makes sending things out
of order tricky. And the whole output is checksummed by a single sha1
over the whole stream that comes at the end.

I think the most feasible thing would be to quickly spool it to a server
on the LAN, and then use an existing fetch-in-parallel tool to grab it
from there over the WAN.

-Peff
