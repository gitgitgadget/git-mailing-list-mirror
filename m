From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] http: prompt for credentials on failed POST
Date: Mon, 27 Aug 2012 17:49:30 -0400
Message-ID: <20120827214930.GA18287@sigill.intra.peff.net>
References: <20120827132145.GA17265@sigill.intra.peff.net>
 <20120827132714.GH17375@sigill.intra.peff.net>
 <7v3938rztf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Iain Paton <ipaton0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 23:50:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T67CP-0006Zi-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab2H0Vtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 17:49:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40075 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754306Ab2H0Vte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 17:49:34 -0400
Received: (qmail 16249 invoked by uid 107); 27 Aug 2012 21:49:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 17:49:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 17:49:30 -0400
Content-Disposition: inline
In-Reply-To: <7v3938rztf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204375>

On Mon, Aug 27, 2012 at 10:48:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Most of the time, this is not a big deal; for both fetching
> > and pushing, we make a GET request before doing any POSTs,
> > so typically we figure out the credentials during the first
> > request, then reuse them during the POST. However, some
> > servers may allow a client to get the list of refs from
> > receive-pack without authentication, and then require
> > authentication when the client actually tries to POST the
> > pack.
> 
> A silly question.  Does the initial GET request when we push look
> any different from the initial GET request when we fetch?  Can we
> make them look different in an updated client, so that the server
> side can say "this GET is about pushing into us, and we require
> authentication"?

Yes, they are already different. A fetch asks for

  info/refs?service=git-upload-pack

and a push asks for

  info/refs?service-git-receive-pack

And I definitely think the optimal server config will authenticate the
client at that first GET step, because the client may do a significant
amount of work for the POST (due to the probe_rpc, it won't actually
_send_ a large pack, but it will do the complete delta-compression phase
before generating any output, which can be slow).

But doing it this way has been advertised in our manpage for so long, I
assume some people are using it. And given that it used to work for
older clients (prior to v1.7.8), and that the person who upgraded their
client is not always in charge of telling the person running the server
to fix their server, I think it's worth un-breaking it.

And we should definitely tweak what git-http-backend advertises on top
so that eventually this sub-optimal config dies out.

> >   1. If we are using gzip. However, we only do so when
> >      calling git-upload-pack, so it does not apply to
> >      pushes.
> >
> >   2. If we have a large request, the probe succeeds, but
> >      then the real POST wants authentication. This is an
> >      extremely unlikely configuration and not worth worrying
> >      about.
> >
> > While it might be nice to cover those instances, doing so
> > would be significantly more complex for very little
> > real-world gain. In the long run, we will be much better off
> > when curl learns to internally handle authentication as a
> > callback, and we can cleanly handle all cases that way.
> 
> I suspect that in real life, almost nobody runs smart HTTP server
> that allows anonymous push.
> 
> How much usability penalty would it be if we always fill credential
> before pushing?

It would reintroduce the problem that 986bbc0 was fixing: we would
prompt even when curl would end up pulling the credential from .netrc.
I find that somewhat less compelling a problem now that we have
credential helpers, though. And of course it does not fix (1) or (2)
above, either.

> Alternatively, how much latency penalty would it incur if we always
> send a probe request regardless of the request size when we try to
> push without having an authentication material?

It would be one http round-trip and no-op invocation of request-pack on
the server. If we did it only on push, that would probably not be too
bad, as we would hit it only when we were actually pushing something.

But that would still suffer from (1) and (2) above, so I don't see it as
a real advantage. You _could_ fix both cases by buffering the input data
and restarting the request. I just didn't think it was worth doing,
since they are unlikely configurations and the code complexity is much
higher.

-Peff
