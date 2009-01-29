From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 02:08:35 -0800
Message-ID: <7v3af2h1b0.fsf@gitster.siamese.dyndns.org>
References: <1233221532.21518.1.camel@lena.gsc.riken.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Moriyoshi Koizumi <mozo@mozo.jp>
X-From: git-owner@vger.kernel.org Thu Jan 29 11:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSTqe-0002kd-Ai
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 11:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbZA2KIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 05:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZA2KIq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 05:08:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZA2KIp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 05:08:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E22A95ECD;
	Thu, 29 Jan 2009 05:08:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C4B0295ECC; Thu,
 29 Jan 2009 05:08:39 -0500 (EST)
In-Reply-To: <1233221532.21518.1.camel@lena.gsc.riken.jp> (Moriyoshi
 Koizumi's message of "Thu, 29 Jan 2009 18:32:12 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF1AD68A-EDEC-11DD-8883-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107651>

Moriyoshi Koizumi <mozo@mozo.jp> writes:

> Currently there is no way to specify the preferred authentication
> method for the HTTP backend and it always ends up with the CURL's
> default
> settings.
>
> This patch enables it if supported by CURL, adding a couple of new

"it" in "enables it" is a bit unclear...

> Signed-off-by: Moriyoshi Koizumi <mozo@mozo.jp>
> ---
>  http.c |  105
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 105 insertions(+), 0 deletions(-)

Linewrapped and whitespace damaged patch that would not apply.

> diff --git a/http.c b/http.c
> index ee58799..889135f 100644
> --- a/http.c
> +++ b/http.c
> @@ -25,6 +25,12 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv = 0;
>  static const char *curl_http_proxy = NULL;
> +#if LIBCURL_VERSION_NUM >= 0x070a06
> +static const char *curl_http_auth = NULL;
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070a07
> +static const char *curl_http_proxy_auth = NULL;
> +#endif

I am not a cURL expert, so I'd take your word for these version
dependencies.

We do not initialize static scope pointers to "= NULL" nor variables to 0,
instead we let BSS take care of that for us.  ftp_no_epsv we can see in
the context is doing unnecessary initialization that should be fixed.

>  static struct curl_slist *pragma_header;
>  
> @@ -153,11 +159,67 @@ static int http_options(const char *var, const
> char *value, void *cb)
>  			return git_config_string(&curl_http_proxy, var, value);
>  		return 0;
>  	}
> +#if LIBCURL_VERSION_NUM >= 0x070a06
> +	if (!strcmp("http.auth", var)) {
> +		if (curl_http_auth == NULL)

We tend to say "if (!pointer)".

I see you implemented "the first one wins" rule with this test, but I do
not think you want that.  We first read $HOME/.gitconfig and then
repository specific $GIT_DIR/config, so it is often more useful to use
"the last one wins" rule.

> +			return git_config_string(&curl_http_auth, var, value);
> +		return 0;
> +	}
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070a07
> +	if (!strcmp("http.proxy_auth", var)) {
> +		if (curl_http_proxy_auth == NULL)
> +			return git_config_string(&curl_http_proxy_auth, var, value);
> +		return 0;
> +	}
> +#endif
>  
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
>  
> +#if LIBCURL_VERSION_NUM >= 0x070a06
> +static long get_curl_auth_bitmask(const char* auth_method)
> +{
> +	char *buf = xmalloc(strlen(auth_method) + 1);
> +	const unsigned char *p = (const unsigned char *)auth_method;
> +	long mask = CURLAUTH_NONE;

Our isspace() is a sane_isspace(), so you do not have to play casting
games between signed vs unsigned char.

> +	for (;;) {
> +		char *q = buf;
> +		while (*p && isspace(*p))
> +			++p;
> +
> +		while (*p && *p != ',')
> +			*q++ = tolower(*p++);
> +
> +		while (--q >= buf && isspace(*(unsigned char *)q));
> +		++q;
> +
> +		*q = '\0';
> +
> +		if (strcmp(buf, "basic") == 0)

Say !strcmp(buf, "literal") like you did in the configuration parsing part
earlier.

> +			mask |= CURLAUTH_BASIC;
> +		else if (strcmp(buf, "digest") == 0)
> +			mask |= CURLAUTH_DIGEST;
> +		else if (strcmp(buf, "gss") == 0)
> +			mask |= CURLAUTH_GSSNEGOTIATE;
> +		else if (strcmp(buf, "ntlm") == 0)
> +			mask |= CURLAUTH_NTLM;
> +		else if (strcmp(buf, "any") == 0)
> +			mask |= CURLAUTH_ANY;
> +		else if (strcmp(buf, "anysafe") == 0)
> +			mask |= CURLAUTH_ANYSAFE;
> +
> +		if (!*p)
> +			break;
> +		++p;
> +	}

You leak "buf" here you forgot to free.  The string you can possibly
accept is a known set with some maximum length, so you can use a on-stack
buf[] and reject any token longer than that maximum, right?

> +	return mask;
> +}
> +#endif
> +
>  static CURL* get_curl_handle(void)
>  {
>  	CURL* result = curl_easy_init();
> @@ -210,6 +272,20 @@ static CURL* get_curl_handle(void)
>  	if (curl_http_proxy)
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  
> +	if (curl_http_auth) {
> +		long n = get_curl_auth_bitmask(curl_http_auth);
> +		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
> +	}
> +
> +	if (curl_http_proxy) {
> +		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +
> +		if (curl_http_proxy_auth) {
> +			long n = get_curl_auth_bitmask(curl_http_proxy_auth);
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, n);
> +		}
> +	}
> +

This part does not have to be protected with the LIBCURL_VERSION_NUM
conditional?  I somehow find it unlikely...

Instead of parsing the string every time a curl handle is asked for, how
about parsing them once and store the masks in two file scope static longs
in http_init() and use that value to easy_setopt() call here?

That way you can free the two strings much early without waiting for
http_cleanup(), too, right?
