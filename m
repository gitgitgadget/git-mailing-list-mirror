From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Thu, 07 May 2015 08:53:36 -0700
Message-ID: <xmqq8ud0s7sv.fsf@gitster.dls.corp.google.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:53:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqO7N-0003eK-1m
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 17:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbEGPxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 11:53:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751050AbbEGPxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 11:53:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E074DC9F;
	Thu,  7 May 2015 11:53:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=21lACsnP4BiLan+ON1W2u8ozAOI=; b=OnHrps
	Isewq9TPRIwCCFN/7H1fDhD3J7oGnMKw81yxEATlcL7VDzlseOkJ8G5WowVN5ufa
	RLEqSF2pZr59RohT8IRuBonwWHZ0dt9t0iKWX+6RKPk+EO+btXV6smaPVm+5962u
	BqrOcnl1vpNadlmxlyYcJH0OF3919AqBXaMZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RLGMbt25xRBunrJq2t1bz0SWlT/gdBc+
	Bzvy6ifdjYRb95rxzTi0VprMbTldQxz/ys5T4lLII0bwXerh2qgyvFfYelPzjEKx
	jizvjxYY41azrW2qBodOEPA/a10lATSt1tEvv1UgCJFe5qmzwNd3kmy9SORl9Qj5
	JEC3xRxyn04=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2232A4DC9C;
	Thu,  7 May 2015 11:53:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99E184DC9B;
	Thu,  7 May 2015 11:53:38 -0400 (EDT)
In-Reply-To: <1431008210-673-1-git-send-email-lars@redhat.com> (Lars
	Kellogg-Stedman's message of "Thu, 7 May 2015 10:16:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A00BBD0-F4D1-11E4-8B6F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268535>

Lars Kellogg-Stedman <lars@redhat.com> writes:

> Teach git about a new option, "http.sslCipherList", which permits one to
> specify a list of ciphers to use when negotiating SSL connections.  The
> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
> variable.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
> ---
>
> I was recently helping someone diagnose the following error when
> trying to clone a remote repository:
>
>   fatal: unable to access 'https://example.org/': Cannot communicate
>   securely with peer: no common encryption algorithm(s).
>
> This happens when the remote server and the default libcurl
> configuration do not share any ciphers in common.  In this particular
> case the solution was to add 'ecdhe_ecdsa_aes_128_gcm_sha_256' to the
> list of ciphers via CURLOPT_SSL_CIPHER_LIST.  This patch permits one
> to make such a configuration change in git.
>
>  Documentation/config.txt |  7 +++++++
>  http.c                   | 11 +++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..b17985c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1560,6 +1560,13 @@ http.saveCookies::
>  	If set, store cookies received during requests to the file specified by
>  	http.cookieFile. Has no effect if http.cookieFile is unset.
>  
> +http.sslCipherList::
> +  A list of SSL ciphers to use when negotiating an SSL connection.
> +  The available ciphers depend on whether libcurl was built against
> +  NSS or OpenSSL and the particular configuration of the crypto
> +  library in use.  Can be overwridden by the 'GIT_SSL_CIPHER_LIST'
> +  environment variable.

It is not clear to me what definition of "override" this sentence
uses.  If you set something to this configuration variable, and if
you want to revert the list back to whatever cURL uses by default,
what exact value should I set GIT_SSL_CIPHER_LIST to?  Do I have to
find out the list of cipher suites cURL uses by default from the doc
and list them all in the correct order, or can I merely set it to an
empty string, i.e.

	$ GIT_SSL_CIPHER_LIST= git fetch ...

or what?

I also wonder if this feature is something we would want a test or
two to protect against future changes accidentally breaking it, but
I do not offhand know how hard it would be to come up with a
reasonable test.

Thanks.

> diff --git a/http.c b/http.c
> index 4b179f6..8077f8d 100644
> --- a/http.c
> +++ b/http.c
> @@ -36,6 +36,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
> +static const char *ssl_cipherlist;
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
>  #endif
> @@ -187,6 +188,9 @@ static int http_options(const char *var, const char *value, void *cb)
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp("http.sslcipherlist", var)) {
> +		return git_config_string(&ssl_cipherlist, var, value);
> +	}
>  	if (!strcmp("http.sslcert", var))
>  		return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
> @@ -361,6 +365,13 @@ static CURL *get_curl_handle(void)
>  	if (http_proactive_auth)
>  		init_curl_http_auth(result);
>  
> +	if (getenv("GIT_SSL_CIPHER_LIST"))
> +		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> +
> +	if (ssl_cipherlist != NULL)
> +		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
> +				ssl_cipherlist);
> +
>  	if (ssl_cert != NULL)
>  		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>  	if (has_cert_password())
