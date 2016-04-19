From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 19:22:43 -0400
Message-ID: <20160419232243.GF18255@sigill.intra.peff.net>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
 <20160419071403.GA22577@sigill.intra.peff.net>
 <1461102001.5540.125.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:23:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asezf-0005EN-P9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbcDSXWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:22:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:52486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752281AbcDSXWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:22:46 -0400
Received: (qmail 29833 invoked by uid 102); 19 Apr 2016 23:22:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 19:22:46 -0400
Received: (qmail 21657 invoked by uid 107); 19 Apr 2016 23:22:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 19:22:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 19:22:43 -0400
Content-Disposition: inline
In-Reply-To: <1461102001.5540.125.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291951>

On Tue, Apr 19, 2016 at 05:40:01PM -0400, David Turner wrote:

> > I dunno, I am a bit negative on bringing new features to Git-over
> > -HTTP
> > (which is already less efficient than the other protocols!) without
> > any
> > plan for supporting them in the other protocols.
> 
> Interesting -- can you expand on git-over-http being less efficient?
> This is the first I'd heard of it.  Is it documented somewhere?

I don't know offhand of thorough discussion I can link to. But
basically, the issue is the tip negotiation that happens during a fetch.
In the normal git-over-ssh and git-over-tcp protocols, we're
full-duplex, and both sides remember all of the state. So the client is
spewing "want" and "have" lines at the server, which is responding
asynchronously with acks or naks until they reach a shared point to
generate the pack from.

In the HTTP protocol, this negotiation has to happen via synchronous
request/response pairs. So the client says "here are some haves; what do
you think?" and gets back the response. Then it prepares another of
haves, and so on, until the server says "OK, I've seen enough; here's
the pack". But because the server is stateless, each request has to
summarize the findings of the prior request. And so each request gets
slightly bigger as we iterate.

There are some tunable parameters there (e.g., how many haves to send in
the first batch?), and the current settings are meant to be a mix of not
wasting too much time preparing a request, but also putting enough into
it that common requests can complete with only a single round trip.

I don't have numbers on how often we have to fall back multiple
requests, or how big they can grow. I know I have very occasionally seen
pathological cases where we outgrew the HTTP buffer sizes, and re-trying
the fetch via ssh just worked.

I'm cc-ing Shawn, who designed all of this, and can probably give more
details (and may also have opinions on new http-only protocol features,
as he'd probably end up implementing them in JGit, too).

It would be nice if we could do a true full-duplex conversation over
HTTP. I looked into Websockets at one point, but IIRC there wasn't
libcurl support for them.

> > So I'd rather see something like:
> > 
> >   1. Support for v2 "capabilities only" initial negotiation, followed
> >      by ref advertisement.
> > 
> >   2. Support for refspec-limiting capability.
> > 
> >   3. HTTP-only option from client to trigger v2 on the server.
> > 
> > That's still HTTP-specific, but it has a clear path for converging
> > with
> > the ssh and git protocols eventually, rather than having to support
> > magic out-of-band capabilities forever.
> > 
> > It does require an extra round of HTTP request/response, though.
> 
> This seems way more complicated to me, and not necessarily super
> -efficient.  That is, it seems like rather a lot of work to add a whole
> round of negotiation and a new protocol, when all we really need is one
> little tweak.

It is less efficient because of the extra round. If the new protocol
were truly client-speaks-first, we could drop that round (which is
essentially what your proposal is doing; you're just sticking the
first-speak part into HTTP parameters).

I don't know how much that round costs if it's part of the same TCP
session, or part of the same pipelined HTTP connection.

> I wonder if it would be possible to just add these tweaks to v1, and
> save the v2 work for when someone has the time to implement it?

I don't think it's possible for the non-HTTP protocols. The single
change in v2 is to add a phase before the ref advertisement starts.
Without that, the server is going to start spewing advertisements.

You can find previous discussion on the list, but I think the options
basically are:

  1. Something like v2, where the client gets a chance to speak before
     the advertisement.

  2. Some out-of-band way of getting values from the client to the
     server (so maybe extra command-line arguments for git-over-ssh, and
     maybe shoving something after the "\0" for git-daemon, and of
     course extra parameters for HTTP).

  3. The client saying "stop spewing refs at me, I want to give you a
     ref filter" asynchronously, and accepting a little spew at the
     beginning of each conversation. That obviously only works for the
     full-duplex transports, so you'd probably fall back to (2) for
     http.

-Peff
