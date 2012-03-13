From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Tue, 13 Mar 2012 18:04:11 -0400
Message-ID: <20120313220411.GA28357@sigill.intra.peff.net>
References: <4F5E3298.5030502@seap.minhap.es>
 <7vk42pr3c7.fsf@alter.siamese.dyndns.org>
 <4F5F41FF.4000204@seap.minhap.es>
 <7vy5r4wfru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 23:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ZpM-0003uQ-3Q
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 23:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674Ab2CMWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 18:04:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48742
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813Ab2CMWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 18:04:14 -0400
Received: (qmail 2779 invoked by uid 107); 13 Mar 2012 22:04:25 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 18:04:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 18:04:11 -0400
Content-Disposition: inline
In-Reply-To: <7vy5r4wfru.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193074>

On Tue, Mar 13, 2012 at 10:51:33AM -0700, Junio C Hamano wrote:

> > On 03/12/2012 09:06 PM, Junio C Hamano wrote:
> >> Whatever new token you use, please keep AUTH as a substring of it.
> >> 
> >> We may want to retry a request to deal with intermittent failures on
> >> the server side or the network between us and the server; HTTP_RETRY
> >> would be a good name to signal such condition after we see a failure
> >> response from the library.
> >
> > HTTP_REAUTH and HTTP_AUTH_RETRY seems like the same thing, so imo not 
> > deserving the rename, maybe Jeff can suggest a better name as he was
> > who suggest the rename.
> 
> Either has AUTH as a substring in it, and leaves a door open for us to
> later introduce HTTP_RETRY to tell the machinery that drives cURL library
> to retry the request, so in that sense I am OK with either, but as your
> log message said, we want to make it clear that this is not about doing
> the authentication again (re-auth) but retrying the authentication, so
> HTTP_AUTH_RETRY would be more logical name.

I suggested RETRY because that is all the caller needs to know: the
http_request machinery said "please call me again". Keep in mind that
this is a private interface within http.c, and this return code should
never make it out at all. Nor is it something anybody else would feed
us.

I am half-tempted to suggest refactoring it to return the actual error
code, and let the caller handle 401 and 407. That would be more readable
overall, I think. But it's a little complicated, because getting the
exact answer depends on the curl handle, which is local to http_request,
and I don't want to hold Nelson's actual feature improvement hostage to
such refactoring.

-Peff
