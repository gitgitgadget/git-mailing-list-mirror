From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] http: fix http_proxy specified without protocol part
Date: Fri, 4 May 2012 03:22:20 -0400
Message-ID: <20120504072220.GC21895@sigill.intra.peff.net>
References: <4FA2B4E6.3080009@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCqR-0007IT-TB
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab2EDHWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:22:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57620
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883Ab2EDHWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:22:22 -0400
Received: (qmail 16157 invoked by uid 107); 4 May 2012 07:22:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:22:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:22:20 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B4E6.3080009@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196999>

On Thu, May 03, 2012 at 06:40:06PM +0200, Nelson Benitez Leon wrote:

> An earlier patch broke http_proxy specified as <host>:<port> by abusing
> credential_from_url().  Teach the function to parse that format, but the
> caller needs to be updated to handle the case where there is no protocol
> in the parse result.
> 
> Also allow keyring implementations to differentiate authentication
> material meant for http proxies and http destinations by using a
> different token "http-proxy" to consult them for the former.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Should this be:

  From: Junio C Hamano <gitster@pobox.com>

?

Also, any time we read "an earlier patch broke..." and that earlier
patch is in this series, I have to wonder why the patches are not simply
reordered. Shouldn't the first half of this one come first, and just
explain the rationale as "teach credential_from_url to handle
protocol-less URLs, since those are used for proxy specifications, which
we will need to parse in a later patch".

> diff --git a/http.c b/http.c
> index 02f9fcd..22ffe0c 100644
> --- a/http.c
> +++ b/http.c
> @@ -366,17 +366,20 @@ static CURL *get_curl_handle(const char *url)
>  	}
>  	
>  	if (curl_http_proxy) {
> -		struct strbuf proxyhost = STRBUF_INIT;
> -
> -		if (!proxy_auth.host) /* check to parse only once */
> +		if (!proxy_auth.host) {
>  			credential_from_url(&proxy_auth, curl_http_proxy);
> +			if (!proxy_auth.protocol ||
> +			    !strcmp(proxy_auth.protocol, "http")) {
> +				free(proxy_auth.protocol);
> +				proxy_auth.protocol = xstrdup("http-proxy");
> +			}
> +		}

And then this hunk would just get squashed in in the first place.

>  		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
>  			/* proxy string has username but no password, ask for password */
>  			credential_fill(&proxy_auth);
>  
> -		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
> -		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
> +		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

And this too, which gets rid of my complaints about the previous patch.

-Peff
