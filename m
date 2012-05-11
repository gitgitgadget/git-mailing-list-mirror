From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] http: handle proxy authentication failure (error 407)
Date: Fri, 11 May 2012 13:15:51 -0400
Message-ID: <20120511171550.GB26916@sigill.intra.peff.net>
References: <4FAD1084.4000605@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 11 19:16:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SStRo-0007FR-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624Ab2EKRPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 13:15:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab2EKRPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 13:15:53 -0400
Received: (qmail 13005 invoked by uid 107); 11 May 2012 17:16:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 13:16:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 13:15:51 -0400
Content-Disposition: inline
In-Reply-To: <4FAD1084.4000605@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197681>

On Fri, May 11, 2012 at 03:13:40PM +0200, Nelson Benitez Leon wrote:

> @@ -804,6 +819,15 @@ static int http_request(const char *url, void *result, int target, int options)
>  				init_curl_http_auth(slot->curl);
>  				ret = HTTP_REAUTH;
>  			}
> +		} else if (results.http_code == 407) { /* Proxy authentication failure */
> +			if (proxy_auth.username && proxy_auth.password) {
> +				credential_reject(&proxy_auth);
> +				ret = HTTP_NOAUTH;
> +			} else {
> +				credential_fill(&proxy_auth);
> +				set_proxy_auth(slot->curl);
> +				ret = HTTP_REAUTH;
> +			}

This part will fill in the username/password based on the proxy URL. But
we never set the proxy URL ahead of time, so there is no chance for
credential helpers to act, and the prompts will be confusing (they will
just say "Password" instead of "Password for ...", which will make it
unclear that we want the proxy password, not the remote server's
password).

So it's OK to drop the environment-parsing bits, but:

  1. When we _do_ get the proxy via config, should we still parse it? I
     could go either way. It's a nice feature, and I think we don't have
     to care about how the environment parsing or NO_PROXY works. On the
     other hand, we could just wait for the callback-based
     authentication that will come in newer versions of curl, and code
     to that, which will be even simpler. In the meantime, people can
     just accept it.

  2. When we don't know the proxy name beforehand, we should probably
     say something to stderr to indicate that it was a proxy
     authentication failure.

Also, what about the dumb http-push code-paths? They would need us to
handle http_proactive_auth in the same way. Which obviously won't work
for environment-based proxies, but could work for config-based proxies.
I'm not sure if it's worth caring about. In the long run, the
callback-based authentication is the way forward (though of course it
will take time for that feature to get released in curl, and then for
people to start having a curl that uses it, and so on).

If we just punt on (1) and the proactive auth thing, then I think as a
minimum we can get away with squashing this into your patch:

diff --git a/http.c b/http.c
index 0023119..86e68ee 100644
--- a/http.c
+++ b/http.c
@@ -824,6 +824,7 @@ static int http_request(const char *url, void *result, int target, int options)
 				credential_reject(&proxy_auth);
 				ret = HTTP_NOAUTH;
 			} else {
+				warning(_("http proxy did not accept our credentials, retrying"))
 				credential_fill(&proxy_auth);
 				set_proxy_auth(slot->curl);
 				ret = HTTP_AUTH_RETRY;

-Peff
