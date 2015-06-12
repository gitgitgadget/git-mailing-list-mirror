From: Jeff King <peff@peff.net>
Subject: Re: git push keeps writing after server failure
Date: Fri, 12 Jun 2015 14:50:16 -0400
Message-ID: <20150612185016.GA25214@peff.net>
References: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
 <20150612181256.GB9242@peff.net>
 <20150612182045.GA23698@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3U25-00025B-LP
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbbFLSuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:50:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:45373 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755884AbbFLSuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:50:19 -0400
Received: (qmail 3747 invoked by uid 102); 12 Jun 2015 18:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 13:50:19 -0500
Received: (qmail 16838 invoked by uid 107); 12 Jun 2015 18:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 14:50:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 14:50:16 -0400
Content-Disposition: inline
In-Reply-To: <20150612182045.GA23698@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271512>

On Fri, Jun 12, 2015 at 02:20:45PM -0400, Jeff King wrote:

> > > Notice GitHub prints "remote: fatal: pack exceeds maximum allowed
> > > size". That interrupted my "Writing objects" progress meter, and then
> > > git push just kept going and wrote really really fast (170 MiB/s!)
> > > until the entire pack was sent.
> > 
> > Sounds like it's writing to a closed fd, then. Which makes sense; I
> > think we should hang up the socket after writing the "fatal" message
> > above.
> 
> For reference, here's the patch implementing the max-size check on the
> server. It's on my long list of patches to clean up and send to the
> list; I never did this one because of the unpack-objects caveat
> mentioned below.

I did a little more digging on this.

With the max-size patch, we seem to reliably notice the problem and die
of EPIPE (you can bump receive.maxsize to something reasonable like 1m).
Pushing to GitHub[1], though, sometimes dies and sometimes ends up
pushing the whole pack over the ssh session. It seems racy.

I've confirmed in both cases that the receive-pack process dies on our
server. So presumably the problem is in between; it might be an ssh
weirdness, or it might be a problem with our proxy layer. I'll open an
issue internally to look at that.

-Peff

[1] I can tweak the max-size on a per-repo basis, which is how I did my
    testing without waiting for 2G to transfer. If anybody is interested
    in diagnosing the client side of this, I am happy to drop the
    max-size on a test repo for you. But AFAICT it is not a client
    problem at all.
