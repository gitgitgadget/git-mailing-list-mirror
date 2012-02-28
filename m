From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] http: when proxy url has username but no password,
 ask for password
Date: Tue, 28 Feb 2012 14:31:25 -0500
Message-ID: <20120228193125.GA11725@sigill.intra.peff.net>
References: <4F4CCEFD.90402@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Slo-0007f4-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346Ab2B1Tb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:31:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60417
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030303Ab2B1Tb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:31:27 -0500
Received: (qmail 13696 invoked by uid 107); 28 Feb 2012 19:31:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:31:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:31:25 -0500
Content-Disposition: inline
In-Reply-To: <4F4CCEFD.90402@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191772>

On Tue, Feb 28, 2012 at 01:56:29PM +0100, Nelson Benitez Leon wrote:

> diff --git a/http.c b/http.c
> index 79cbe50..68e3f7d 100644
> --- a/http.c
> +++ b/http.c
> @@ -306,7 +306,41 @@ static CURL *get_curl_handle(void)
>  		}
>  	}
>  	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		char *at, *colon, *proxyuser;
> +		const char *cp;
> +		cp = strstr(curl_http_proxy, "://");
> +		if (cp == NULL) {
> +			cp = curl_http_proxy;
> +		} else {
> +			cp += 3;
> +		}
> +		at = strchr(cp, '@');
> +		colon = strchr(cp, ':');
> +		if (at && (!colon || at < colon)) {
> +			/* proxy string has username but no password, ask for password */

Don't parse the URL by hand. Use credential_from_url, which will do it
for you (and will properly handle things like unquoting the various
components).

> +			char *ask_str, *proxyuser, *proxypass;

Shouldn't these be static globals? If we have multiple curl handles, you
would want them to share the authentication information we collect here,
and not have to ask the user again, no?

> +			strbuf_addf(&pbuf, "Enter password for proxy %s...", at+1);
> +			ask_str = strbuf_detach(&pbuf, NULL);
> +			proxypass = xstrdup(git_getpass(ask_str));

And this should be using credential_fill(), which will let it use
credential helpers to save passwords, give it the same type of prompt as
elsewhere, etc.

See Documentation/technical/api-credential.txt, and see how regular http
auth is handled for an example.

-Peff
