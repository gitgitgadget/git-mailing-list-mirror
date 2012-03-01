From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no password,
 ask for password
Date: Thu, 01 Mar 2012 09:49:16 -0800
Message-ID: <4F4FB69C.7000708@vilain.net>
References: <4F4FBE6C.5050507@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3A84-0004XD-HL
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 18:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab2CARtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 12:49:20 -0500
Received: from uk.vilain.net ([92.48.122.123]:44724 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab2CARtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 12:49:19 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 018698276; Thu,  1 Mar 2012 17:49:18 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id 891498209;
	Thu,  1 Mar 2012 17:49:17 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F4FBE6C.5050507@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191953>

On 3/1/12 10:22 AM, Nelson Benitez Leon wrote:
> Support proxy urls with username but without a password, in which
> case we interactively ask for the password (using credential api).
> This makes possible to not have the password written down in
> http_proxy env var or in http.proxy config option.
>
> Signed-off-by: Nelson Benitez Leon<nbenitezl@gmail.com>
> ---
>   http.c |   16 +++++++++++++++-
>   1 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8932da5..5916194 100644
> --- a/http.c
> +++ b/http.c
> @@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
>   static const char *curl_http_proxy;
>   static const char *curl_cookie_file;
>   static struct credential http_auth = CREDENTIAL_INIT;
> +static struct credential proxy_auth = CREDENTIAL_INIT;
>   static int http_proactive_auth;
>   static const char *user_agent;
>
> @@ -303,7 +304,20 @@ static CURL *get_curl_handle(void)
>   		}
>   	}
>   	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		credential_from_url(&proxy_auth, curl_http_proxy);
> +		if (proxy_auth.username != NULL&&  proxy_auth.password == NULL) {
> +			/* proxy string has username but no password, ask for password */
> +			struct strbuf pbuf = STRBUF_INIT;
> +			credential_fill(&proxy_auth);

Wouldn't it be better to wait until the proxy returns a 403 before 
assuming that the proxy setting is incorrect/missing a password?  What 
if the administrator expects the user to fill in both the username and 
password?  That is the behaviour of a web browser.

Also, I think you should wait until that 403 to detect whether the proxy 
setting came from the environment, and only load it explicitly then.

Sam

> +			strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
> +				    proxy_auth.username, proxy_auth.password,
> +				    proxy_auth.host);
> +			free ((void *)curl_http_proxy);
> +			curl_http_proxy =  strbuf_detach(&pbuf, NULL);
> +			curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		} else {
> +			curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		}
>   		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>   	}
>
