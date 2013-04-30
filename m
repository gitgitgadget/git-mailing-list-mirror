From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 16:29:08 -0400
Message-ID: <20130430202908.GB3247@sigill.intra.peff.net>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
 <7v61z4ezlz.fsf@alter.siamese.dyndns.org>
 <20130430182732.GB1972@sigill.intra.peff.net>
 <CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
 <7vzjwfbwow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jerry Qassar <jqassar@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHB7-0001Ld-T1
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386Ab3D3U3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:29:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:41080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813Ab3D3U3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:29:11 -0400
Received: (qmail 24252 invoked by uid 102); 30 Apr 2013 20:29:25 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 15:29:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 16:29:08 -0400
Content-Disposition: inline
In-Reply-To: <7vzjwfbwow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223006>

On Tue, Apr 30, 2013 at 01:17:03PM -0700, Junio C Hamano wrote:

> Jerry Qassar <jqassar@gmail.com> writes:
> 
> > Curl already does support engine-based certificates (in code and
> > help).  Its problem is that a) it doesn't yet read your engine
> > defs out of OpenSSL config, and b) a bug in copying the engine
> > data, once that's patched, to the handle that calling apps use.
> 
> So once the problem (a) is fixed, if the user has OpenSSL config
> then the user doesn't need configuration from setopt() side?  That
> makes it sound like you do not need to patch us at all, but there
> must be something else going on...

My understanding is that we first have to tell curl "yes, use the
engine", and then the engine-specific OpenSSL config can be loaded by
curl. But I am just guessing from the conversation up until now; I know
nothing about ssl crypto engines.

As an aside, curl can be linked against gnutls, too. Does any of this
work with gnutls? I think we don't have to care; curl abstracts all of
that away from us, and it is up to the user to choose an engine that
matches their library versions. But it might be a good point of
reference when somebody later comes to the list and says "I followed the
documentation, but it doesn't work".

> > Errors are handled by curl (up to this point):
> >
> > 1) Setting the cert type to FOO:
> > error: not supported file type 'FOO' for certificate...
> > fatal: HTTP request failed
> >
> > 2) Setting the key type to FOO:
> > error: not supported file type for private key...
> > fatal: HTTP request failed
> >
> > 3) Setting engine type to something invalid:
> >  * SSL Engine 'pkcsfoo' not found (only with GIT_CURL_VERBOSE set)
> > error: crypto engine not set, can't load certificate...
> > fatal: HTTP request failed
> 
> Where do "error:" and "fatal:" happen in the codeflow?
>
> I am guessing that "error:" may come from these easy_setopt() calls, but
> the "fatal: HTTP request failed" come from us, much later in the
> callpath when we actually make http request.

Those are almost certainly from curl_errorstr() when we make the
info/refs http request.

> Between these two times, aren't we throwing user data at the cURL
> library and possibly over the wire to the remote side (with a SSL
> configuration that is different from what the user intended to use),
> no?

I assume that curl is smart enough not to send any data over the wire,
and that it is noticing early in the process that something is wrong and
is barfing there.

It would be nicer to notice earlier (when we are setting up the handle),
but in practice I don't think it matters. We start off all http
conversations by making a short GET, and we don't do any significant
work beforehand. So as long as curl does not do significant work before
hitting those errors internally, it probably does not matter much either
way.

-Peff
