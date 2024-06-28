Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B44315F
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598609; cv=none; b=hShlFnvh/ggdpzHidWXLy1cAjw2LZnc6g+U6DjOcPP24a1mz/r3YSPW7/hXs8/BsnZFPVssKK0CF8L1KCAi2s3hnBoMq0rYElYdEvLG0XRqJFOxq7+lHY3Hmf662j67VU/rP9rwNLiIDJYXPyZo6M8zGW/AaUhx7PBjl+Icomcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598609; c=relaxed/simple;
	bh=hh5Tlertm3jC7k27GxJPL79NK+ulF7dkvjjGqdy6oSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jAaj7O6HtxblkEe5Y34KkR+MqY+LdaCYvkpDYOL9w0MuFpYr9CG/U0os7f4oDxdHfuQwPUOXFX7WNe3dvdXpeim48UotzfKq9reJt8T2ImHcxgRfHLa6EZldy0arKQlPbcAZgra59HMplktuy+iCq5D70NuYatd0uaRuJseMThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eSmyID7Y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eSmyID7Y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EB443456A;
	Fri, 28 Jun 2024 14:16:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hh5Tlertm3jC7k27GxJPL79NK+ulF7dkvjjGqd
	y6oSs=; b=eSmyID7YShupu4csXTErC3AjGrPz1DT7iJOOGPCiJ5tIpgZVKxfNps
	1fKnT/omCVlKq6s/i7QvvpDY/kNHfOKLcC8/03oHoGV0Zt2O4plrVbLA9AvI5afu
	7ZJGp+OXAf7F86gv/zlhBjNyVJVTRBGECWqLYjzO3PcOtWynxSvdM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 754AF34569;
	Fri, 28 Jun 2024 14:16:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C684C34568;
	Fri, 28 Jun 2024 14:16:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] http: allow authenticating proactively
In-Reply-To: <20240628002742.3421311-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 28 Jun 2024 00:27:42 +0000")
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
	<20240628002742.3421311-2-sandals@crustytoothpaste.net>
Date: Fri, 28 Jun 2024 11:16:43 -0700
Message-ID: <xmqqa5j53pbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 937A6EF6-357A-11EF-ACFE-965B910A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index 2d4e0c9b86..2bacb2b862 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -56,6 +56,21 @@ http.emptyAuth::
>  	a username in the URL, as libcurl normally requires a username for
>  	authentication.
>  
> +http.proactiveAuth::
> +	Attempt authentication without first making an unauthenticated attempt and
> +	receiving a 401 response. This can be used to ensure that all requests are
> +	authenticated. If `http.emptyAuth` is set to true, this value has no effect.

Well written.

> ++
> +If the credential helper used specifies an authentication scheme (i.e., via the
> +`authtype` field), that value will be used; if a username and password is
> +provided without a scheme, then Basic authentication is used.  The value of the
> +option determines the scheme requested from the helper. Possible values are:
> ++
> +--
> +* `basic` - Request Basic authentication from the helper.
> +* `auto` - Don't request any scheme from the helper.
> +--

What does "don't request" exactly mean?  It is not like we are
telling the helper "Don't give us anything", right?  Are we telling
the helper "Give us any username/password for the URL in any
authentication scheme you know about?"

As we are not getting an initial "401 Unauthorized", which is a good
channel to convey WWW-Authenticate, Digest is not available to us in
this context; we may end up using Basic---if the other side then
says "No, I do not like basic, please use Diest in this realm with
this nonce" with a "401 Unauthorized" with WWW-Authenticate, then
all we gained was a chance to expose the username/password in
plaintext (ok, that's still TLS protected in practice so it may not
be a huge deal).  Hopefully that wouldn't be a problem, but perhaps
we would want to suggest that this mechanism should primarily be
used when the user _knows_ that the other side is happy accepting
you with Basic, or something, in the documentation?

> diff --git a/http.c b/http.c
> index 2dea2d03da..2e54eddb45 100644
> --- a/http.c
> +++ b/http.c
> @@ -106,12 +106,19 @@ static struct {
>  };
>  #endif
>  
> +enum proactive_auth {
> +	PROACTIVE_AUTH_NONE,
> +	PROACTIVE_AUTH_IF_CREDENTIALS,
> +	PROACTIVE_AUTH_AUTO,
> +	PROACTIVE_AUTH_BASIC,
> +};

PROACTIVE_AUTH_NONE being at the first position to be assigned 0
in this enum has significance, because ...

>  static struct credential proxy_auth = CREDENTIAL_INIT;
>  static const char *curl_proxyuserpwd;
>  static char *curl_cookie_file;
>  static int curl_save_cookies;
>  struct credential http_auth = CREDENTIAL_INIT;
> -static int http_proactive_auth;
> +static enum proactive_auth http_proactive_auth;

... this implicitly initializes the variable to *_NONE and we do
rely on that value.  It may clarify what we are doing, if we are a
bit more explicit, i.e.,

        enum proactive_auth {
                PROACTIVE_AUTH_NONE = 0,
		...

It would give a hint to future developers that they shouldn't
reorder the enum def without thinking.

> +static int always_auth_proactively(void)
> +{
> +	return http_proactive_auth != PROACTIVE_AUTH_NONE && http_proactive_auth != PROACTIVE_AUTH_IF_CREDENTIALS;
> +}

An overly long line.

>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> @@ -537,6 +549,18 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.proactiveauth", var)) {
> +		if (value && !strcmp(value, "auto"))
> +			http_proactive_auth = PROACTIVE_AUTH_AUTO;
> +		else if (value && !strcmp(value, "basic"))
> +			http_proactive_auth = PROACTIVE_AUTH_BASIC;
> +		else if (!value)
> +			http_proactive_auth = PROACTIVE_AUTH_NONE;

This is how you "reset" the variable that is set in lower-precedence
configuration source back to the default, but use of "I exist
therefore I represent true without giving any value" for that
purpose is rather unusual.  Even if this were about resetting a
multi-valued configuration variable to empty, don't we usually allow
an empty string to serve that purpose as well?

And more importantly we apparently do not use this variable as
multi-valued one---the above callback is a bog-standard "last one
wins" single value variable.

So instead of using the "I exist" true, I think it is a lot easier
to see if you used an explicit string "none" for this purpose.

If you insist to use "I exist" true, checking it upfront would allow
you (and future developers) to lose many "value&&", i.e.,

		if (!value || !*value)
			... reset ...;
		else if (!strcmp(value, "auto"))
			...

but I do not see a strong reason to use the !value to begin with.  I
suspect that the usual

		if (!value)
			return config_error_nonbool(var);
		elseif (!strcmp(value, "none"))
			http_proactive_auth = PROACTIVE_AUTH_NONE;
		else if ...

would be easier to read and maintain.

In any case, the documentation update above failed to mention the
mechanism to reset to the state that is equivalent to an
unconfigured state, which needs an update.  If we document what you
do in your patch, it would read something like this, perhaps.

        +
        An earlier setting made in configuration files with lower-precedence
        can be overridden by setting it to a valueless truth, e.g.,
        --
        [http]
		proactiveAuth ; no "= value" needed here.
        --

And that is awkward, which is one of the reasons why I would prefer
an explicit "none" (or "default" perhaps, if there were some reason
you wanted to avoid it).

> +		else
> +			warning(_("Unknown value %s for http.proactiveauth"), value);
> +		return 0;
> +	}
> +

> @@ -578,14 +602,29 @@ static void init_curl_http_auth(CURL *result)
>  {
>  	if ((!http_auth.username || !*http_auth.username) &&
>  	    (!http_auth.credential || !*http_auth.credential)) {
> -		if (curl_empty_auth_enabled())
> +		int empty_auth = curl_empty_auth_enabled();
> +		if ((empty_auth != -1 && !always_auth_proactively()) || empty_auth == 1) {
>  			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
> -		return;
> +			return;
> +		} else if (!always_auth_proactively()) {
> +			return;
> +		} else if (http_proactive_auth == PROACTIVE_AUTH_BASIC) {
> +			strvec_push(&http_auth.wwwauth_headers, "Basic");
> +		}
>  	}

When http.proactiveauth explicitly says "basic", we push "Basic" to
the strvec here.

>  	credential_fill(&http_auth, 1);
>  
>  	if (http_auth.password) {
> +		if (always_auth_proactively()) {

But when http.proactiveauth is set to either "auto" or "basic",
always_auth_proactively() returns true (because it is not set to
*_NONE and it is not *_IF_CREDENTIALS) and we come here, to do
curl_easy_setop() to use basic anyway.

> +			/*
> +			 * We got a credential without an authtype and we don't
> +			 * know what's available.  Since our only two options at
> +			 * the moment are auto (which defaults to basic) and
> +			 * basic, use basic for now.
> +			 */
> +			curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);

So users with "auto" will not see "Basic" in .wwwauth_headers
strvec, while those with "basic" will.  Is this intended?  What is
the expected difference in behaviour coming from this difference?

Or am I simply reading the code incorrectly and not understanding
what happens before the control reaches fwrite_wwwauth()?

> +		}
>  		curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
>  		curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
>  	}
> @@ -1048,7 +1087,7 @@ static CURL *get_curl_handle(void)
>  #endif
>  	}
>  
> -	if (http_proactive_auth)
> +	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
>  		init_curl_http_auth(result);

Makes sense.

> @@ -1292,7 +1331,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>  		die("curl_global_init failed");
>  
> -	http_proactive_auth = proactive_auth;
> +	if (proactive_auth && http_proactive_auth == PROACTIVE_AUTH_NONE)
> +		http_proactive_auth = PROACTIVE_AUTH_IF_CREDENTIALS;

The webdav http-push is the only caller of http_init() with the
proactive_auth parameter set to true.  In such a case, if we do not
see the configuration variable left/set to the default, we force the
"if-credentials" behaviour.  IOW, if http.proactive_auth is set to
some value, we leave it as-is even for http-push (which wants to use
the "if-credentials" behaviour).

I wonder if there are cases where you would want to do the
proactive-auth for fetches (which you couldn't do before), but you
want to drive http-push with if-credentials, and if so, if this
changes the behaviour in a way that is visible to the end-user.

Or perhaps http-push over webdav outlived its usefulness and we
should send a patch to Documentation/BreakingChanges.txt to declare
its deprecation and removal, in which case there is nothing to
wonder or be worried here ;-)

> @@ -1788,6 +1828,8 @@ static int handle_curl_result(struct slot_results *results)
>  				return HTTP_REAUTH;
>  			}
>  			credential_reject(&http_auth);
> +			if (always_auth_proactively())
> +				http_proactive_auth = PROACTIVE_AUTH_NONE;

Once we see a failure, there is not much point in doing the
proactive-auth to the same destination in requests we are going to
make from now on.  Makes sense.

> @@ -2184,7 +2226,12 @@ static int http_request_reauth(const char *url,
>  			       struct http_get_options *options)
>  {
>  	int i = 3;
> -	int ret = http_request(url, result, target, options);
> +	int ret;
> +
> +	if (always_auth_proactively())
> +		credential_fill(&http_auth, 1);
> +
> +	ret = http_request(url, result, target, options);
>  
>  	if (ret != HTTP_OK && ret != HTTP_REAUTH)
>  		return ret;

OK, if we need to auth proactively, of course we need to fill the
credential before making a request.  Makes sense.

Thanks.



