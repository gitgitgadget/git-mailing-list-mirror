From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: Support sending custom HTTP headers
Date: Mon, 25 Apr 2016 13:03:26 -0400
Message-ID: <20160425170326.GA1551@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:03:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujv4-0005SU-7J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbcDYRDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:03:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:55836 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933030AbcDYRDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:03:30 -0400
Received: (qmail 27895 invoked by uid 102); 25 Apr 2016 17:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 13:03:29 -0400
Received: (qmail 3053 invoked by uid 107); 25 Apr 2016 17:03:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 13:03:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 13:03:26 -0400
Content-Disposition: inline
In-Reply-To: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292525>

On Mon, Apr 25, 2016 at 03:13:08PM +0200, Johannes Schindelin wrote:

> diff --git a/http.c b/http.c
> index 4304b80..02d7147 100644
> --- a/http.c
> +++ b/http.c
> @@ -114,6 +114,7 @@ static unsigned long http_auth_methods = CURLAUTH_ANY;
>  
>  static struct curl_slist *pragma_header;
>  static struct curl_slist *no_pragma_header;
> +static struct curl_slist *extra_http_headers;
>  
>  static struct active_request_slot *active_queue_head;
>  
> @@ -323,6 +324,12 @@ static int http_options(const char *var, const char *value, void *cb)
>  #endif
>  	}
>  
> +	if (!strcmp("http.extraheader", var)) {
> +		extra_http_headers =
> +			curl_slist_append(extra_http_headers, value);
> +		return 0;
> +	}

I wondered if this would trigger for "http.*.extraheader", too. And it
should, as that is all handled in the caller of http_options. Good.

> @@ -678,8 +685,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	if (remote)
>  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
>  
> -	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
> -	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
> +	pragma_header = curl_slist_append(http_get_default_headers(),
> +		"Pragma: no-cache");
> +	no_pragma_header = curl_slist_append(http_get_default_headers(),
> +		"Pragma:");

This looked wrong to me at first, because we are appending to the
default header list in each case. But the secret sauce is that calling
http_get_default_headers() actually creates a _new_ list that is a copy
of the default headers (and the caller can do what they will with it,
and must free it).

I think that's really the only sane way to do it because of curl's
interfaces. But maybe it is worth a comment either here, or along with
http_get_default_headers(), or both.

-Peff
