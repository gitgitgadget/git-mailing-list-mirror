From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] http: handle proxy proactive authentication
Date: Tue, 6 Mar 2012 03:30:52 -0500
Message-ID: <20120306083052.GD21199@sigill.intra.peff.net>
References: <4F54D98C.2070909@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 09:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pnP-00006T-EW
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 09:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758683Ab2CFIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 03:30:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38260
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758644Ab2CFIay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 03:30:54 -0500
Received: (qmail 5446 invoked by uid 107); 6 Mar 2012 08:31:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 03:31:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 03:30:52 -0500
Content-Disposition: inline
In-Reply-To: <4F54D98C.2070909@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192312>

On Mon, Mar 05, 2012 at 04:19:40PM +0100, Nelson Benitez Leon wrote:

> diff --git a/http.c b/http.c
> index 8932da5..b0b4362 100644
> --- a/http.c
> +++ b/http.c
> @@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static const char *curl_cookie_file;
>  static struct credential http_auth = CREDENTIAL_INIT;
> +static struct credential proxy_auth = CREDENTIAL_INIT;
>  static int http_proactive_auth;
>  static const char *user_agent;
>  
> @@ -303,6 +304,17 @@ static CURL *get_curl_handle(void)
>  		}
>  	}
>  	if (curl_http_proxy) {
> +		credential_from_url(&proxy_auth, curl_http_proxy);
> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password) {
> +			/* proxy string has username but no password, ask for password */
> +			struct strbuf pbuf = STRBUF_INIT;
> +			credential_fill(&proxy_auth);
> +			strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
> +			    	proxy_auth.username, proxy_auth.password,
> +			    	proxy_auth.host);

Can we pull this out into a helper function, since the next patch will
need to do the exact same thing in the 407 case?

Also, when turning it back into a URL to hand to curl, should we be
percent-encoding the items we put in? If my password has an "@" in it,
wouldn't we generate a bogus URL? Although looking at how the http auth
code handles this, we set CURLOPT_USERPWD directly. Should you be
setting CURLOPT_PROXYUSERPWD instead of munging the proxy URL?

> +			free ((void *)curl_http_proxy);

Please don't cast to void. This is C, not C++, and casts to void
pointers are implicit.  They can never help, and might cover up an
actual type error (e.g., casting a non-pointer type).

-Peff
