From: Jeff King <peff@peff.net>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 2 Jun 2016 17:53:18 -0400
Message-ID: <20160602215317.GC13356@sigill.intra.peff.net>
References: <146489432847.688.11121862368709034386@typhoon>
 <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
 <146489800609.1944.4398103814754920753@typhoon.lan>
 <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:53:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aYQ-000363-0T
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932956AbcFBVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:53:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:48046 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932240AbcFBVxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:53:21 -0400
Received: (qmail 6030 invoked by uid 102); 2 Jun 2016 21:53:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:53:20 -0400
Received: (qmail 14627 invoked by uid 107); 2 Jun 2016 21:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:53:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 17:53:18 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296243>

On Thu, Jun 02, 2016 at 01:14:02PM -0700, Junio C Hamano wrote:

> > What exactly are you referring to (you only quoted the introduction)?
> > Do you think we should fix the git-gc issue but keep the general
> > behavior of printing messages unaltered? Do you think it would be
> > worthwhile to make server messages distinguishable in general?
> 
> The latter, which I think was what your implementation was attempting to do
> if I read it correctly.

And btw, I don't think this patch fixes the general case. E.g., if
receive-pack hits any of its die("BUG") lines, they will not be
prefixed. Most clients wouldn't see them, but ssh ones would.

To fix that you'd have to do a whole async process wrapping
`receive-pack` that just reads its stdout and stderr and muxes it back
over the sideband. But I can think of two roadblocks there:

  - I think the original design of receive-pack was _not_ to share all
    of stderr with the user, because it might contain secret-ish
    server-side things. That's why we have rp_error() which copies to
    the sideband.

    I don't know how useful that is in practice. We copy the stderr
    wholesale from sub-processes like index-pack, so things like file
    paths are likely to get leaked there.

  - the implementation is a bit tricky, because the die() will take
    down the mux thread, too.

-Peff
