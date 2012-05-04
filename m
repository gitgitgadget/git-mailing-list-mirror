From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] http: handle proxy proactive authentication
Date: Fri, 4 May 2012 03:16:32 -0400
Message-ID: <20120504071632.GB21895@sigill.intra.peff.net>
References: <4FA2B4DA.60908@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCkq-0003DA-ED
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab2EDHQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:16:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57615
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab2EDHQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:16:35 -0400
Received: (qmail 16090 invoked by uid 107); 4 May 2012 07:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:16:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:16:32 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B4DA.60908@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196997>

On Thu, May 03, 2012 at 06:39:54PM +0200, Nelson Benitez Leon wrote:

> If http_proactive_auth flag is set and there is a username
> but no password in the proxy url, then interactively ask for
> the password.
> 
> This makes possible to not have the password written down in
> http_proxy env var or in http.proxy config option.
> 
> Also take care that CURLOPT_PROXY don't include username or
> password, as we now set them in the new set_proxy_auth() function
> where we use their specific cURL options.

Do we actually need to do that? If we set CURLOPT_PROXYUSERNAME, will
curl ignore it in favor of what's in the URL? I ask, because there is a
bug here:

> @@ -351,8 +366,19 @@ static CURL *get_curl_handle(const char *url)
>  	}
>  	
>  	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		struct strbuf proxyhost = STRBUF_INIT;
> +
> +		if (!proxy_auth.host) /* check to parse only once */
> +			credential_from_url(&proxy_auth, curl_http_proxy);
> +
> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
> +			/* proxy string has username but no password, ask for password */
> +			credential_fill(&proxy_auth);
> +
> +		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
> +		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));

When you parse the URL via credential_from_url, the components you get
will have any URL-encoding removed. So when you regenerate the URL in
the proxyhost variable, you would need to re-encode.

But if we can stop doing this regeneration at all, then the problem goes
away.

Also, newer versions of curl will copy the string instead of taking
ownership of the pointer. Unfortunately we have to deal with both old
and new, but you can get around it by using a static strbuf (so we leak,
but we only leak once per program, not once per get_curl_handle call).
This issue would also go away if we stop regenerating the URL.

-Peff
