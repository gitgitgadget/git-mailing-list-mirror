From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 28 Feb 2012 14:15:14 -0500
Message-ID: <20120228191514.GD11260@sigill.intra.peff.net>
References: <4F4CCE8A.4010800@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	sam.vilain@catalyst.net.nz, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SWB-0003q3-FU
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966019Ab2B1TPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:15:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60387
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956Ab2B1TPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:15:17 -0500
Received: (qmail 13179 invoked by uid 107); 28 Feb 2012 19:15:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:15:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:15:14 -0500
Content-Disposition: inline
In-Reply-To: <4F4CCE8A.4010800@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191767>

On Tue, Feb 28, 2012 at 01:54:34PM +0100, Nelson Benitez Leon wrote:

> diff --git a/http.c b/http.c
> index 8ac8eb6..79cbe50 100644
> --- a/http.c
> +++ b/http.c
> @@ -295,6 +295,16 @@ static CURL *get_curl_handle(void)
>  	if (curl_ftp_no_epsv)
>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>  
> +	if (!curl_http_proxy) {
> +		const char *env_proxy;
> +		env_proxy = getenv("HTTP_PROXY");
> +		if (!env_proxy) {
> +			env_proxy = getenv("http_proxy");
> +		}
> +		if (env_proxy) {
> +			curl_http_proxy = xstrdup(env_proxy);
> +		}
> +	}

Usually we would prefer environment variables to config. So that:

  $ git config http.proxy foo
  $ HTTP_PROXY=bar git fetch

would use "bar" as the proxy, not "foo". But your code above would
prefer "foo", right?

>From reading Thomas's messages, I think there is a slight complication
in that right now curl is respecting $http_proxy, and it is probably
letting git's http.proxy overwrite (though I didn't check). If that is
the case, then that is IMHO a bug that should be fixed. So the rationale
for this patch would be three-fold:

  1. Support HTTP_PROXY, which curl does not accept.

  2. Fix the precedence of environment variables over config.

  3. By handling the proxy variables ourselves, we have more flexibility
     in handling the authentication.

-Peff
