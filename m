From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 03:14:03 -0400
Message-ID: <20160419071403.GA22577@sigill.intra.peff.net>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asPrQ-0003JG-AI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 09:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcDSHOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 03:14:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:51932 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752373AbcDSHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 03:14:06 -0400
Received: (qmail 11161 invoked by uid 102); 19 Apr 2016 07:14:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 03:14:06 -0400
Received: (qmail 13792 invoked by uid 107); 19 Apr 2016 07:14:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 03:14:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 03:14:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291849>

On Mon, Apr 18, 2016 at 11:45:54AM -0700, Junio C Hamano wrote:

> David Turner <dturner@twopensource.com> writes:
> 
> > Add parameters for a list of refspecs to transport_get_remote_refs and
> > get_refs_list.  These parameters are presently unused -- soon, we will
> > use them to implement fetches which only learn about a subset of refs.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> 
> What the code tries to do I am more than halfway happy.  It is
> unfortunate that we cannot do this natively without upgrading the
> protocol in a fundamental way, but this is a nice way to work it
> around only for Git-over-HTTP transport without having to break the
> protocol.

I dunno, I am a bit negative on bringing new features to Git-over-HTTP
(which is already less efficient than the other protocols!) without any
plan for supporting them in the other protocols.

I thought Stefan's v2 protocol work looked quite good, but it seems to
have stalled. The hardest part of that topic is figuring out the upgrade
path. But for git-over-http, we can solve that in the same way that
David is passing in the extra refspecs.

So I'd rather see something like:

  1. Support for v2 "capabilities only" initial negotiation, followed
     by ref advertisement.

  2. Support for refspec-limiting capability.

  3. HTTP-only option from client to trigger v2 on the server.

That's still HTTP-specific, but it has a clear path for converging with
the ssh and git protocols eventually, rather than having to support
magic out-of-band capabilities forever.

It does require an extra round of HTTP request/response, though.

-Peff
