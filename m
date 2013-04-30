From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 09:45:44 -0700
Message-ID: <7v61z4ezlz.fsf@alter.siamese.dyndns.org>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jerry Qassar <jqassar@gmail.com>
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:46:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDgp-0006EK-W1
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761178Ab3D3Qpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:45:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761091Ab3D3Qpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA161ACCA;
	Tue, 30 Apr 2013 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QldmaDESIZwcvuWstiF7UylSqxY=; b=X2C0sq
	XzeOGR4ntHq+NOKiAfr6e5qN0kGgUUlyQIWfLFye4nTbwrrfgcOrNxMz9yg12A90
	H3/320b98ECbwrepapgqRYuN1zGTM5Ti7xD4naSiYWfZGwhmpa1JpnKtejAuczk3
	k6twfFSRIU71vBDy4bYIJxfSq7Sam0Jk+K294=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUPG55zmQQlFExlt327qa35O4S2EqrOw
	bYPJ+hLFwk3KAa8KB3GD1p8HiyXV/15Uk+hiFZ3KRaolNblCFbS+Y/7IUMsuM9pj
	UsGpivP6Zk/5DAAlXMP0t54UM232jAExu2k+KtIH/QHbpOhe7b6OQZnd3KG7oWFA
	OvAK2YHJOP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DAEB1ACC5;
	Tue, 30 Apr 2013 16:45:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E1E01ACC4;
	Tue, 30 Apr 2013 16:45:45 +0000 (UTC)
In-Reply-To: <1366758207-7724-1-git-send-email-jqassar@gmail.com> (Jerry
	Qassar's message of "Tue, 23 Apr 2013 16:03:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 675373F4-B1B5-11E2-B21F-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222947>

Does anybody familiar with the http codepath have comments on this?

The authoritative source

https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions

tells me that the CURLOPT_* used in this patch are available since
cURL 7.9.3, but I see a #if LIBCURL_VERSION_NUM < 0x070704 in http.h
so these may have to be protected in a similar way.

[the entire message unsnipped for reference]
Jerry Qassar <jqassar@gmail.com> writes:

> curl provides many options for configuring the way it negotiates an SSL
> connection (with its default OpenSSL support), including ways to define
> the SSL engine used, and parameters to set the format of the key and
> certificate used.  Unfortunately, git does not parse some of the
> critical ones needed by curl to support PKCS#11.
>
> Add the following git config variables (and direct env-set variables):
>
> * http.sslengine
>   A string variable that sets CURLOPT_SSLENGINE on the back end.
>   Can be set from environment using GIT_SSL_ENGINE.
> * http.sslkeytype
>   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLKEYTYPE.
>   Can be set from environment using GIT_SSL_KEYTYPE.
> * http.sslcerttype
>   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLCERTTYPE.
>   Can be set from environment using GIT_SSL_CERTTYPE.
>
> Parsing these new variables combined with related patches to curl
> will allow git to support native authentication with smart cards.
>
> Note: It's difficult to test this without the related curl patches,
> which I will be submitting soon.  At the very least, leaving these new
> options unset doesn't break anything, and setting them has little
> effect without the back-end curl changes needed to 'turn on' PKCS#11.
> Any suggestions would be greatly appreciated.
>
> Signed-off-by: Jerry Qassar <jqassar@gmail.com>
> ---
>  Documentation/config.txt | 13 +++++++++++++
>  http.c                   | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c67038b..d155620 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1440,16 +1440,29 @@ http.sslVerify::
>  	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
>  	variable.
>  
> +http.sslEngine::
> +	String specifying the SSL engine to be used by curl.  This can be used to
> +	specify non-default or dynamically loaded engines.  Can be overridden by
> +	the 'GIT_SSL_ENGINE' environment variable.
> +
>  http.sslCert::
>  	File containing the SSL certificate when fetching or pushing
>  	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
>  	variable.
>  
> +http.sslCertType::
> +	Specifies the format of the certificate to curl as one of (PEM|DER|ENG).
> +	Can be overridden by the 'GIT_SSL_CERTTYPE' environment variable.
> +
>  http.sslKey::
>  	File containing the SSL private key when fetching or pushing
>  	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
>  	variable.
>  
> +http.sslKeyType::
> +	Specifies the format of the private key to curl as one of (PEM|DER|ENG).
> +	Can be overridden by the 'GIT_SSL_KEYTYPE' environment variable.
> +
>  http.sslCertPasswordProtected::
>  	Enable Git's password prompt for the SSL certificate.  Otherwise
>  	OpenSSL will prompt the user, possibly many times, if the
> diff --git a/http.c b/http.c
> index 92aba59..06cb22e 100644
> --- a/http.c
> +++ b/http.c
> @@ -49,6 +49,10 @@ static struct credential http_auth = CREDENTIAL_INIT;
>  static int http_proactive_auth;
>  static const char *user_agent;
>  
> +static const char *ssl_keytype;
> +static const char *ssl_certtype;
> +static const char *ssl_engine;
> +
>  #if LIBCURL_VERSION_NUM >= 0x071700
>  /* Use CURLOPT_KEYPASSWD as is */
>  #elif LIBCURL_VERSION_NUM >= 0x070903
> @@ -211,6 +215,17 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.useragent", var))
>  		return git_config_string(&user_agent, var, value);
>  
> +	/* Adding parsing for curl options relating to engines and */
> +	/* key/cert types.  This is necessary if attempting to     */
> +	/* specify an external engine (e.g. for smartcards.)       */
> +
> +	if (!strcmp("http.sslkeytype", var))
> +		return git_config_string(&ssl_keytype, var, value);
> +	if (!strcmp("http.sslcerttype", var))
> +		return git_config_string(&ssl_certtype, var, value);
> +	if (!strcmp("http.sslengine", var))
> +		return git_config_string(&ssl_engine, var, value);
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
> @@ -321,6 +336,22 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>  	}
>  
> +	/* Adding setting of engine-related curl SSL options. */
> +	if (ssl_engine != NULL) {
> +		curl_easy_setopt(result, CURLOPT_SSLENGINE, ssl_engine);
> +
> +		/* Within the lifetime of a single git execution, setting
> +		 * the default does nothing interesting.  When curl properly
> +		 * duplicates handles, the engine choice will propagate.
> +		 */
> +		/* curl_easy_setopt(result, CURLOPT_SSLENGINE_DEFAULT, 1L); */
> +	}
> +
> +	if (ssl_keytype != NULL)
> +		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_keytype);
> +	if (ssl_certtype != NULL)
> +		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_certtype);
> +
>  	return result;
>  }
>  
> @@ -405,6 +436,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  			ssl_cert_password_required = 1;
>  	}
>  
> +	/* Added environment variables for expanded engine-related options. */
> +	set_from_env(&ssl_keytype, "GIT_SSL_KEYTYPE");
> +	set_from_env(&ssl_certtype, "GIT_SSL_CERTTYPE");
> +	set_from_env(&ssl_engine, "GIT_SSL_ENGINE");
> +
>  #ifndef NO_CURL_EASY_DUPHANDLE
>  	curl_default = get_curl_handle();
>  #endif
