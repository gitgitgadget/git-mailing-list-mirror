From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fix http auth with multiple curl handles
Date: Fri, 13 Apr 2012 02:16:22 -0400
Message-ID: <20120413061622.GA27591@sigill.intra.peff.net>
References: <20120402083115.GA2235@sigill.intra.peff.net>
 <1334051620-18044-1-git-send-email-drizzd@aon.at>
 <1334051620-18044-3-git-send-email-drizzd@aon.at>
 <20120412070910.GA31122@sigill.intra.peff.net>
 <7v4nso4lb3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIZoA-00017C-49
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 08:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab2DMGQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 02:16:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32971
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab2DMGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 02:16:27 -0400
Received: (qmail 4577 invoked by uid 107); 13 Apr 2012 06:16:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 02:16:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 02:16:22 -0400
Content-Disposition: inline
In-Reply-To: <7v4nso4lb3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195400>

On Thu, Apr 12, 2012 at 03:50:08PM -0700, Junio C Hamano wrote:

> > diff --git a/http.c b/http.c
> > index f3f83d7..374c3bb 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -211,12 +211,12 @@ static int http_options(const char *var, const char *value, void *cb)
> >  static void init_curl_http_auth(CURL *result)
> >  {
> >  	if (http_auth.username) {
> > -		struct strbuf up = STRBUF_INIT;
> > +		static struct strbuf up = STRBUF_INIT;
> >  		credential_fill(&http_auth);
> > +		strbuf_reset(&up);
> >  		strbuf_addf(&up, "%s:%s",
> >  			    http_auth.username, http_auth.password);
> > -		curl_easy_setopt(result, CURLOPT_USERPWD,
> > -				 strbuf_detach(&up, NULL));
> > +		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
> >  	}
> >  }
> 
> Yeah, that's sad but I agree that is probably the best we could do.  Do
> you want me to squash it in?

We can use an #if-macro and only do the static thing for older versions
of curl (newer versions copy for us). But since we'd have to carry the
old code anyway, it doesn't clean up much.  However, since there is an
even newer interface for giving curl the credential, it might be worth
conditionally including that.

I'd rather not squash this bit. It's sufficiently subtle that I'd rather
do it on top as a separate patch. Plus I gotta keep up my shortlog
stats. ;)

So here are the two patches I think we should apply on top of what you
have in ct/http-multi-curl-auth.

  [1/2]: http: clean up leak in init_curl_http_auth
  [2/2]: http: use newer curl options for setting credentials

> > By the way, this touches on an area that I noticed while refactoring the
> > http auth code a while ago, but decided not to tackle at the time. We
> > fill in the auth information early, and then never bother to revisit it
> > as URLs change. So for example, if I got a redirect from host A to host
> > B, we would continue to use the credential for host A and host B. Which
> > is maybe convenient, and maybe a security issue.
> 
> Good point.  Do we follow redirects, though?

Curl follows them for us, since we set CURLOPT_FOLLOWLOCATION. However,
it does say this under CURLOPT_USERPWD (which I somehow missed the last
time I looked into this issue):

  When using HTTP and CURLOPT_FOLLOWLOCATION, libcurl might perform
  several requests to possibly different hosts. libcurl will only send
  this user and password information to hosts using the initial host
  name (unless CURLOPT_UNRESTRICTED_AUTH is set), so if libcurl
  follows locations to other hosts it will not send the user and
  password to those. This is enforced to prevent accidental information
  leakage.

So it looks like we are already doing the safe thing (unless we redirect
ourselves outside of curl, but I don't think we ever do so). We won't
properly retry auth if we get a 401 on a redirect (we never retry auth
if we already had both a username and password; we complain and exit).
But nobody has been complaining about that, so I guess it is a
non-issue.

-Peff
