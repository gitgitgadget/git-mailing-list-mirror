From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] http: handle proxy authentication failure (error
 407)
Date: Tue, 6 Mar 2012 03:54:45 -0500
Message-ID: <20120306085445.GE21199@sigill.intra.peff.net>
References: <4F54D9F8.2010401@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:55:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qAe-0007Ku-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840Ab2CFIyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:54:49 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38276
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758803Ab2CFIys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:54:48 -0500
Received: (qmail 5682 invoked by uid 107); 6 Mar 2012 08:54:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 03:54:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 03:54:45 -0500
Content-Disposition: inline
In-Reply-To: <4F54D9F8.2010401@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192316>

On Mon, Mar 05, 2012 at 04:21:28PM +0100, Nelson Benitez Leon wrote:

> Handle http 407 error code by asking for credentials and
> retrying request in case credentials were not present, or
> marking credentials as rejected if they were already provided.
> 
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
>  http.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

No tests. I wonder how hard it would be to set up an apache proxy for
automated testing, just as we set one up as a git server in
t/lib-httpd.sh. It should be basically the same process, but with a
different config file, I would think.

> diff --git a/http.c b/http.c
> index b0b4362..5fffa47 100644
> --- a/http.c
> +++ b/http.c
> @@ -812,6 +812,22 @@ static int http_request(const char *url, void *result, int target, int options)
>  				init_curl_http_auth(slot->curl);
>  				ret = HTTP_REAUTH;
>  			}
> +		} else if (results.http_code == 407) { /* Proxy authentication failure */
> +			if (proxy_auth.username && proxy_auth.password) {
> +				credential_reject(&proxy_auth);
> +				ret = HTTP_NOAUTH;
> +			} else {
> +				struct strbuf pbuf = STRBUF_INIT;
> +				credential_from_url(&proxy_auth, curl_http_proxy);
> +				credential_fill(&proxy_auth);
> +				strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
> +			    			proxy_auth.username, proxy_auth.password,
> +			    			proxy_auth.host);
> +				free ((void *)curl_http_proxy);
> +				curl_http_proxy =  strbuf_detach(&pbuf, NULL);
> +				curl_easy_setopt(slot->curl, CURLOPT_PROXY, curl_http_proxy);
> +				ret = HTTP_REAUTH;
> +			}

Hmm. So HTTP_REAUTH used to mean "try again, we got new http
credentials". And in http_request_reauth, we recognized the REAUTH flag,
and tried again. Now it also means "try again, we got new proxy
credentials". But what happens if you need to retry twice? That is, the
following sequence:

  1. We make a request; proxy returns 407, because we didn't give it a
     password. We ask for the password and return REAUTH.

  2. We make another request; the proxy passes it to the actual server,
     who returns 401, because we didn't give an http password. We ask
     for the password and return REAUTH.

  3. We make a third request, but this time everybody is happy.

I don't think step (3) actually happens with your code. We don't
actually look for REAUTH on the second step.

We need to actually loop, retrying if we get reauth (and arguably REAUTH
should simply be called RETRY). Like this:

diff --git a/http.c b/http.c
index e4afbe5..c325b00 100644
--- a/http.c
+++ b/http.c
@@ -810,10 +810,13 @@ static int http_request(const char *url, curl_write_callback cb, void *result,
 static int http_request_reauth(const char *url, curl_write_callback cb,
 			       void *result, unsigned long offset, int options)
 {
-	int ret = http_request(url, cb, result, offset, options);
-	if (ret != HTTP_REAUTH)
-		return ret;
-	return http_request(url, cb, result, offset, options);
+	int ret;
+
+	do {
+		ret = http_request(url, cb, result, offset, options);
+	} while (ret == HTTP_REAUTH);
+
+	return ret;
 }
 
 int http_get_strbuf(const char *url, struct strbuf *result, int options)


I think the whole thing would be a bit easier to read if
http_request_reauth actually handled the 401 and 407 itself, but
unfortunately we need to access the curl handle. Arguably http_request
should just be setting the auth from the http_auth struct itself each
time it is called (the http_auth struct is what caches the password, so
it's not like we would prompt the user again). But that refactoring is
unrelated to what you're doing, I think, so we can leave it.

-Peff
