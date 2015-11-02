From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Mon, 02 Nov 2015 14:46:59 -0800
Message-ID: <xmqqfv0odnoc.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-2-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNsa-0004cd-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbbKBWrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:47:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751780AbbKBWrC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:47:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B307E2740C;
	Mon,  2 Nov 2015 17:47:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOz46dFMlM3dIXVp81bMXwwHtSA=; b=KPaW9R
	Ib5kMxXyobYWFqPYutQ1TAVlKZw8Pb6il1Osm8JE2n4ePxPBnCXDDfIdLT3YTOKa
	OEh2h6rnDz/LKSWOt4gYnhI60vvHnzN2AFszeOp4vReUwNDql6hYFfxyVHOZhM2m
	tUMQTAce0w/6RdvOc29ViV7u1AC6+1kpK/GTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CbhXjyTn0ogwauRPij1v3c5n7sfdTipz
	uSUj+V52v7n1ut7NOerVPxqK1wYFsaTgOWBN+CJc4BnwIIs18IZutpNS242nSRNH
	ugl6ygvFgBx7Pimnh2FI3bfiBJfje4Pi4V9u16E5Y5y1fi7t3G5kSkYYq08Yc14j
	0ODSPEU3aOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9BE02740B;
	Mon,  2 Nov 2015 17:47:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D940B27407;
	Mon,  2 Nov 2015 17:47:00 -0500 (EST)
In-Reply-To: <1446483264-15123-2-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Mon, 2 Nov 2015 17:54:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A14AAB74-81B3-11E5-846E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280734>

Knut Franke <k.franke@science-computing.de> writes:

> CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
> with a 307 redirect to an error page instead of a 407 listing supported
> authentication methods. Therefore, allow the authentication method to be set
> using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
> variables http.proxyAuthmethod and remote.<name>.proxyAuthmethod (in analogy
> to http.proxy and remote.<name>.proxy).
>
> The following values are supported:
>
> * anyauth (default)
> * basic
> * digest
> * negotiate
> * ntlm
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>


> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Please add these only when you are doing the final submission,
sending the same version reviewed by these people after they said
the patch(es) look good.  To credit others for helping you to polish
your patch, Helped-by: would be more appropriate.

> @@ -305,6 +326,42 @@ static void init_curl_http_auth(CURL *result)
>  #endif
>  }
>  
> +/* assumes *var is either NULL or free-able */
> +static void env_override(const char **var, const char *envname)
> +{
> +	const char *val = getenv(envname);
> +	if (val) {
> +		if (*var)
> +			free((void*)*var);

Just
		free((void *)*var);

would be more idiomatic (freeing NULL is not a crime but a norm).
Also as you did elsewhere, have a space between void and the
asterisk.

> +static void init_curl_proxy_auth(CURL *result)
> +{
> +	env_override(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");

Shouldn't this also be part of the #if/#endif?

> +
> +#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
> +	if (http_proxy_authmethod) {
> +		int i;
> +		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
> +			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
> +				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
> +						proxy_authmethods[i].curlauth_param);
> +				break;
> +			}
> +		}
> +		if (i == ARRAY_SIZE(proxy_authmethods)) {
> +			warning("unsupported proxy authentication method %s: using anyauth",
> +					http_proxy_authmethod);
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +		}
> +	}
> +	else
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +#endif
> +}
> +
>  static int has_cert_password(void)
>  {
>  	if (ssl_cert == NULL || ssl_cert_password_required != 1)
> @@ -466,9 +523,7 @@ static CURL *get_curl_handle(void)
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  	}
> -#if LIBCURL_VERSION_NUM >= 0x070a07
> -	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> -#endif
> +	init_curl_proxy_auth(result);
>  
>  	set_curl_keepalive(result);
>  
> @@ -509,6 +564,12 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	if (remote && remote->http_proxy)
>  		curl_http_proxy = xstrdup(remote->http_proxy);
>  
> +	if (remote && remote->http_proxy_authmethod) {
> +		if (http_proxy_authmethod)
> +			free((void*)http_proxy_authmethod);

Just
		free((void *)http_proxy_authmethod);

without NULL-ness check.

But this makes me wonder if env_override() was a good abstraction.

That is, with this helper:

        /* existing value in *var must be freeable */
        static void var_override(const char **var, char *value)
        {
                if (value) {
                        free((void *)(*var));
                        var = xstrdup(value);
                }
        }

the beginning of the init_proxy_auth() would become:

        static void init_curl_proxy_auth(CURL *result)
        {
        #if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
		...

and this code would be:

	if (remote)
		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);

which might be even cleaner.

> +		http_proxy_authmethod = xstrdup(remote->http_proxy_authmethod);
> +	}
> +
>  	pragma_header = curl_slist_append(pragma_header, "Pragma: no-cache");
>  	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
>  
> @@ -607,6 +668,11 @@ void http_cleanup(void)
>  		curl_http_proxy = NULL;
>  	}
>  
> +	if (http_proxy_authmethod) {
> +		free((void *)http_proxy_authmethod);
> +		http_proxy_authmethod = NULL;
> +	}

No need for NULL-ness check here, either.

Other than the above nits, looks cleanly done.

Thanks.
