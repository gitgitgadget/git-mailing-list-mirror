From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 18:05:16 -0400
Message-ID: <20120412220516.GG21018@sigill.intra.peff.net>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
 <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIS8s-0000A8-73
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934799Ab2DLWFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:05:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60422
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934761Ab2DLWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 18:05:19 -0400
Received: (qmail 32037 invoked by uid 107); 12 Apr 2012 22:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 18:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 18:05:16 -0400
Content-Disposition: inline
In-Reply-To: <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195377>

On Thu, Apr 12, 2012 at 02:25:12PM -0700, Junio C Hamano wrote:

> Outside git, these actually come from things like these:
> 
> 	http_proxy=127.0.0.1:1080
> 	HTTPS_PROXY=127.0.0.1:1080
> 
> And http.proxy configuration variable we have is a substitute for
> http_proxy.  So if we want to keep the credentials for destination servers
> and the credentials for proxies, "http.proxy" codepath should be asking
> you with "http".  If we are looking at HTTPS_PROXY, you should get "https".
> The patch that broke the unauthenticated proxy access does neither.

Hmm. Does the distinction between http and https actually matter to
curl? My reading of the code and documentation is that only "http" is
meaningful (actually, anything besides socks*:// gets converted to
http).

So as far as I can tell, these are equivalent:

  http_proxy=http://127.0.0.1:1080
  http_proxy=https://127.0.0.1:1080
  http_proxy=foobar://127.0.0.1:1080

And furthermore, the decision to use http_proxy versus https_proxy is
about what the _target_ connection wants to do. So if you see this:

  HTTPS_PROXY=127.0.0.1:1080

it is still an http proxy; it is just that it is used for requests going
to https:// servers, and it will ask to tunnel via CONNECT instead of
GET. But in either case, the conversation with the proxy is over
straight http.

So the value should always be "http" in that case. This is a credential
we are handing to the proxy, not to the target server, and it is done
over http, not https.

I can't see that there is a way to tell curl to speak SSL to the proxy
itself.  Maybe I am missing it, but I couldn't find anything in the
code, nor make it work with "curl -x" to an "openssl s_server" instance.

> That is something we may want to think carefully about.
> 
> If it is better to separate them, then we can easily invent "http-proxy",
> "https-proxy" etc. for them, e.g.
> 
> 	HTTPS_PROXY=http://127.0.0.1:1080
> 	git fetch https://over.there.xz/repo/sito/ry.git
> 
> would ask you for a credential to access 127.0.0.1:1080 in "https-proxy"
> domain, and another to access over.there.xz in "https" domain.

No, it should ask for the credential for 127.0.0.1:1080 in the "http"
domain, per the above discussion.

Not splitting "http" and "http-proxy" does have a slight confusion, as
the default proxy port is "1080". So a proxy of "http://127.0.0.1" would
mean "http://127.0.0.1:1080", whereas a regular request would mean
"http://127.0.0.1:80". The credential code includes the port as part of
the unique hostname, but since the default-port magic happens inside
curl, we have no access to it (short of re-implementing it ourselves).

In practice, I doubt it matters much; do people really have different
credentials for proxies and regular servers on the same host? And if so,
there is already a workaround by using the port number in the proxy
specification.

I really wish curl's credential-handling was implemented as a callback;
this would be much simpler if could let curl decipher the request and
come to us with the complete request (protocol, host, port, path, etc).
But even if we got such a feature in curl, we are stuck supporting the
old way for a while anyway.

-Peff
