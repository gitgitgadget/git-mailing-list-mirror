From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 8 Jun 2016 15:52:48 -0400
Message-ID: <20160608195248.GA4264@sigill.intra.peff.net>
References: <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
 <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
 <xmqq37onlawb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:53:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjXF-0001Bp-7N
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426027AbcFHTwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:52:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:51527 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1424668AbcFHTww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:52:52 -0400
Received: (qmail 1379 invoked by uid 102); 8 Jun 2016 19:52:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:52:51 -0400
Received: (qmail 12259 invoked by uid 107); 8 Jun 2016 19:53:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:53:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2016 15:52:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37onlawb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296848>

On Wed, Jun 08, 2016 at 12:48:36PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That made me wonder if we could repeatedly reuse a buffer attached to
> > the file descriptor. And indeed, isn't that what stdio is? The whole
> > reason this buffer exists is because we are using a direct descriptor
> > write. If we switched this function to use fprintf(), we'd avoid the
> > whole buffer question, have a fixed cap on our memory use (since we just
> > flush anytime the buffer is full) _and_ we'd reduce the number of
> > write syscalls we're making by almost a factor of 100.
> 
> The primary reason why we avoid stdio in the lower level part of I/O
> is that the error reporting and handling is horrible.
> 
> e.g. c.f. http://article.gmane.org/gmane.comp.version-control.git/27019
> 
> Otherwise, I'd agree with your "Why aren't we using stdio if
> counting and avoiding overflow is so hard?".

I agree it can be confusing (especially on the output side your errors
are likely deferred until the next flush). But in this particular case,
I think it's an improvement (see the patch I just sent and its
discussion of error handling).

I also think we could smooth over the rough edges by wrapping the
complexity (we already have fprintf_or_die, which arguably could be used
in this case, but I went with the solution that stayed closer to what
the original code was doing). And if stdio is truly too horrible, I'd
suggest we implement our own buffered I/O. Because that's effectively
what such call-sites are doing, but in a really ad-hoc and
non-performant way.

-Peff
