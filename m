From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Wed, 25 May 2016 16:29:09 -0500
Message-ID: <20160525212909.GA13776@sigill.intra.peff.net>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
 <1464130008.24478.134.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 25 23:29:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5gMm-0007vZ-TL
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 23:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbcEYV3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 17:29:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:44220 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbcEYV3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 17:29:13 -0400
Received: (qmail 19650 invoked by uid 102); 25 May 2016 21:29:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 17:29:12 -0400
Received: (qmail 13878 invoked by uid 107); 25 May 2016 21:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 17:29:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 16:29:09 -0500
Content-Disposition: inline
In-Reply-To: <1464130008.24478.134.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295589>

On Tue, May 24, 2016 at 06:46:48PM -0400, David Turner wrote:

> I tried to make libcurl do the receive-before-sending thing, but it
> doesn't seem to be designed for it (even if you prime things by sending
> a "hello" from the client first).  My thought was to hook up
> CURLOPT_READFUNCTION and CURLOPT_WRITEFUNCTION, and have the read
> function return CURL_READFUNC_PAUSE and then have the write (=client
> receiving data ) function unpause the reader (= client sending data)
> once it gets the capabilities.  But apparently pausing only works with
> chunked encoding, which seems to cause Apache's mod_cgi to fail.
> 
> Maybe I'm missing something.  Has anyone else ever made something like
> this work?

I don't think it can work in the general case. HTTP is not full-duplex,
and you have to send off the request and wait for the response. Even if
you could convince the client and git-http-backend to do it, you're
going to get foiled by proxies, web server implementations, and other
middle-men.

> Of course, I could always use CURLOPT_CONNECT_ONLY to write my own HTTP
> client, but that seems pretty unreasonable.
> 
> I also looked to see if libcurl had websockets support, since that's
> one kind of bidirectional conversation over HTTP, but it doesn't seem
> to.

I would love to see us move to a true bidirectional HTTP-based protocol.
It would clear up all of the drawbacks that the current HTTP protocol
has, and I think we could generally recommend it entirely over using
git://. But like you, I haven't figured out an easy way to do it.

I hoped that maybe HTTP/2 would solve some of that if we waited long
enough for it to be adopted, but it doesn't look like there's anything
out of the box. It seems like the recommended solutions still involve
websockets. I might be wrong, though; this is very much outside my area
of expertise.

> Another choice is to make a separate /capabilities endpoint that gets
> hit before /info/refs.  This is a bit bad because:
> (a) it's another HTTP request

Right, this is the extra round-trip I mentioned in:

  http://thread.gmane.org/gmane.comp.version-control.git/291640/focus=291951

I think you could get rid of it by making protocol v2 a true "client
speaks first" protocol, which aligns better with how HTTP works (but if
we do that, it would be nice to do it for _all_ of the transports, so
they stay closer to each other). But...

> (b) it adds implicit state to the HTTP conversation.  If multiple git
> servers were behind a load balancer, you might end up getting server A
> for /capabilities and server B for /info/refs, and those servers might
> have different capabilities.  This is not impossible when testing a git
> server upgrade on one machine before rolling it out to a whole fleet. 
>  Maybe the rule for clients re capabilities is that they can request
> whatever capabilities they want, but the server is free to ignore that
> request and send whatever data it feels like.  That's not great, but it
> should work (I think).

I think this is already the case today. Every non-trivial git-over-http
request requires at least two HTTP requests: one to receive the server
fetch advertisement, and the second to actually do the work (and in the
fetch case, the have/want negotiation in the second one may actually
span several requests).

The capabilities from the server come in the first request, and then the
client sends back its capabilities in the second one. So if you are
hitting multiple incompatible servers, the server may not understand
your request. Likewise, if an upload-pack request takes multiple hits,
we send up the client capabilities in each request.

I don't think quietly ignoring unknown capabilities is a good idea. The
results would range from confusing breakages (e.g., ignored multi-ack or
no-done capabilities) to subtly wrong behavior (e.g., a server which
ignores "atomic" and proceeds with a half-failed push anyway).  Given
the rarity of the situation, it's probably better for the server to barf
with an appropriate error message. That sucks for the user, but it's
probably better than the alternatives.

-Peff
