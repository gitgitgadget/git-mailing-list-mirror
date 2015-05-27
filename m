From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of
 upload-pack
Date: Wed, 27 May 2015 17:46:17 -0400
Message-ID: <20150527214616.GA23259@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-5-git-send-email-sbeller@google.com>
 <20150527063558.GB885@peff.net>
 <CAGZ79kYaoViDrz9TKXWebif4mfyUjzJ6b3id8ozTqtwsmjAC1A@mail.gmail.com>
 <20150527203451.GD14309@peff.net>
 <CAGZ79kb6rsxpiXKg+eaVc+5bgUgPSaq+ocd-UHa=_K+rLxreTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxj9c-0001N5-I3
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbbE0VqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:46:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:36918 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751765AbbE0VqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:46:19 -0400
Received: (qmail 16529 invoked by uid 102); 27 May 2015 21:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:46:19 -0500
Received: (qmail 10921 invoked by uid 107); 27 May 2015 21:46:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:46:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:46:17 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kb6rsxpiXKg+eaVc+5bgUgPSaq+ocd-UHa=_K+rLxreTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270101>

On Wed, May 27, 2015 at 01:45:55PM -0700, Stefan Beller wrote:

> > Right, but I think (and please correct me if there's a case I'm
> > missing) that the behavior is the same whether it is spelled
> > "ping-pong" or "capability:ping-pong". That is, the rule for
> > "capability:" is "if you do not understand it, ignore it and do not
> > mention it in your capabilities; the server is required to assume
> > you were written before that capability was invented". But that is
> > _also_ the rule for ping-pong, I think.
> 
> The rules are the same, right. But the allowed characters are limited
> (in theory) as the regular expressions given for the capabilities
> don't allow for binary data for example, but only well formed ASCII
> text, space separated.  The "ping-pong" keyword could introduce a
> binary stream there including line feeds. (Today it sounds like a
> stupid idea though)

Do we need that restriction? IOW, as long as we parse from the start of
the packet and give up as soon as we realize it is not a thing we
understand, I do not think anybody is hurt by the contents of the item.

E.g., if an old client sees:

   00XXping-pong=<binary goo>

It knows:

  1. The item starts with ping-pong; we don't know what that is, so we
     never even bother looking at the binary goo.

  2. It's in a pkt-line. We read to the end of the packet line and throw
     the rest of the data away. Now we're synchronized to read the next
     item.

Of course, "ping-pong" may also introduce another phase to the protocol
which is not encapsulated in pkt-lines (e.g., if the data is too big to
fit right inside the capability pkt-line, or if it needs a lot of back
and forth like ref negotiation). But then we only proceed to that
phase if both sides have said "I understand ping-pong".

So I think we are capable of boot-strapping just about anything using
capability negotiation (with the exception of fixing the capability
negotiation itself; but even that, we can bootstrap a second more
intensive capability negotiation using a capability in the initial
list).

-Peff
