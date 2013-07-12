From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 11:41:17 -0700
Message-ID: <7vfvvjliya.fsf@alter.siamese.dyndns.org>
References: <a2ef80fd50c466e5c69726a1968f8ad@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 20:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxiHi-0005QB-G0
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 20:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300Ab3GLSld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 14:41:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933171Ab3GLSlb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 14:41:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4070A302DA;
	Fri, 12 Jul 2013 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IOkzHGjIo9cglatiGwAMNSvnkfg=; b=szcS+f
	2ZkTOn2WK0Qu98JDkQ1LmMcOCvf0jcjN6Qwr0KO7iGYmhuqKSZFCpef115hPdzgB
	jZ++32MviTYcs0T8/S5hoX5FX0xUJqbwnwIWy8UxIxj8EM44nKBdKfOoqI0rpunG
	SL5R8NqOoOzQGlp5jm4PNxDKF8is81RIdtvqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYKcK+wuScLsmvCpj4RYS9Z5tmyzJVXg
	kXHCkLkyVVH7AJW90aKgG19KPv45uFVmSth8XNkQFKW/Pd9StSLDn/RcYDifuD3+
	9Ag7qi0KfPn/VLIXJcLZd5bhx9c1Qn1A4uHNHr35TZR9QOEL1utcaADJWUV5dmMI
	LAR446gjgYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33990302D9;
	Fri, 12 Jul 2013 18:41:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAF84302D0;
	Fri, 12 Jul 2013 18:41:27 +0000 (UTC)
In-Reply-To: <a2ef80fd50c466e5c69726a1968f8ad@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Fri, 12 Jul 2013 04:20:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A98D8D76-EB22-11E2-A7C0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230235>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> The <url> value is considered a match to a url if the <url> value
> is either an exact match or a prefix of the url which ends on a
> path component boundary ('/').  So "https://example.com/test" will
> match "https://example.com/test" and "https://example.com/test/too"
> but not "https://example.com/testextra".
>
> Longer matches take precedence over shorter matches with
> environment variable settings taking precedence over all.
>
> With this configuration:
>
> [http]
>         useragent = other-agent
>         noEPSV = true
> [http "https://example.com"]
>         useragent = example-agent
>         sslVerify = false
> [http "https://example.com/path"]
>         useragent = path-agent
>
> The "https://other.example.com/" url will have useragent
> "other-agent" and sslVerify will be on.
>
> The "https://example.com/" url will have useragent
> "example-agent" and sslVerify will be off.
>
> The "https://example.com/path/sub" url will have useragent
> "path-agent" and sslVerify will be off.
>
> All three of the examples will have noEPSV enabled.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

I haven't reviewed this version (yet).

> ---
>
> The credentials configuration values already support url-specific
> configuration items in the form credential.<url>.*.  This patch
> adds similar support for http configuration values.

Let's move the above three lines into the proposed log message and
make it its first paragraph.  A log message should say what it is
about (i.e. what does "add support" really mean?  what kind of
functionality the new support brings to us?) upfront and then
explain what it does in detail (i.e. the explanation of matching
semantics you have as the first paragraph).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b4d4887..3731a3a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1531,6 +1531,17 @@ http.useragent::
>  	of common USER_AGENT strings (but not including those like git/1.7.1).
>  	Can be overridden by the 'GIT_HTTP_USER_AGENT' environment variable.
>  
> +http.<url>.*::
> +	Any of the http.* options above can be applied selectively to some urls.
> +	For example "http.https://example.com.useragent" would set the user
> +	agent only for https connections to example.com.  The <url> value
> +	matches a url if it is an exact match or a prefix of the url matching
> +	at a '/' boundary.

Given Peff's review, I am no longer sure if the "strictly textual
match" is the semantics we want.  At least, it is easy to explain
and understand, but it might be too limiting to be useful.

Let's assume it is what we want, for the rest of the review.

> diff --git a/http.c b/http.c
> index 2d086ae..feca70a 100644
> --- a/http.c
> +++ b/http.c
> @@ -30,6 +30,34 @@ static CURL *curl_default;
>  
>  char curl_errorstr[CURL_ERROR_SIZE];
>  
> +enum http_option_type {
> +	opt_post_buffer = 0,

Do we need to have "= 0" here?

Is this order meant to match some externally defined order
(e.g. alphabetical, or the value of corresponding constants defined
in the cURL library), other than "opt_max is not a real option but
just has to be there at the end to count all of them"?

I am wondering if it would make it easier to read to move all the #ifdef
at the end immediately before opt-max, or something.

> +	opt_min_sessions,
> +#ifdef USE_CURL_MULTI
> +	opt_max_requests,
> +#endif
> +...
> +	opt_user_agent,
> +	opt_passwd_req,
> +	opt_max
> +};

> +static int check_matched_len(enum http_option_type opt, size_t matchlen)
> +{
> +	/*
> +	 * Check the last matched length of option opt against matchlen and
> +	 * return true if the last matched length is larger (meaning the config
> +	 * setting should be ignored).  Upon seeing the _same_ key (i.e. new key
> +	 * has the same match length which is therefore not larger) the new
> +	 * setting will override the previous setting.  Otherwise return false
> +	 * and record matchlen as the current last matched length of option opt.
> +	 */
> +	if (http_option_max_matched_len[opt] > matchlen)
> +		return 1;
> +	http_option_max_matched_len[opt] = matchlen;
> +	return 0;
> +}

A "check_foo" that returns either 0 or 1 usually mean 1 is good and
0 is not.  A "check_foo" that returns either negative or 0 usually
mean negative is an error and 0 is good.

In general, "check_foo" is a bad name for a boolean function.  This
checks "seen_longer_match()", and it is up to the caller if it
considers good or bad to have a matching element that is longer or
shorter what it has already seen.  See below.

>  static int http_options(const char *var, const char *value, void *cb)
>  {
> -	if (!strcmp("http.sslverify", var)) {
> +	const char *url = (const char *)cb;

Cast?

> +	if (!strcmp("sslverify", key)) {
> +		if (check_matched_len(opt_ssl_verify, matchlen))
> +			return 0;
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
>  	}

At this caller, the name "check_matched_len()" is not immediately
obvious, other than it is checking matchlen, what it does.  "check"
needs "what is checked" (i.e. "matchlen"), but it also needs "how it
judges what is checked" (i.e. is longer the better?), but the name
does not convey that.  If you rename the function, it becomes a lot
easier to understand what is going on.

	if (!strcmp("sslverify", key)) {
		if (!seen_longer_match(opt_ssl_verify, matchlen))
			curl_ssl_verify = git_config_bool(var, value);
		return 0
	}

> @@ -344,7 +478,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	http_is_verbose = 0;
>  
> -	git_config(http_options, NULL);
> +	git_config(http_options, (void *)url);

Cast?
