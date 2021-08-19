Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEDC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E042561042
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhHSS3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:29:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57678 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSS3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:29:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEAE2DF475;
        Thu, 19 Aug 2021 14:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zw6Rxbb3HvNtuAMRNcNsd5zIgPUw1pS4Gcm37S
        2QBiA=; b=MnWrLCxig5Qo6bzzjSCGpAP252vN1yq+UYCKvpmTRzWO/ToAvloqml
        EKf96xdBYgoU6O+ipcngVzeTAqi+YWwa9BoZP31lePrPW4JLCXsSxUFgsMOHCI/t
        RYLAOurbfuVWxDqLroAfIu6NjEkY5CxD/ddz1tgkihlI1gEg+/F+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5B0FDF473;
        Thu, 19 Aug 2021 14:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70885DF472;
        Thu, 19 Aug 2021 14:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xia XiaoWen <haoyurenzhuxia@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, worldhello.net@gmail.com,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>
Subject: Re: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack
 receiving speed
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
Date:   Thu, 19 Aug 2021 11:28:53 -0700
In-Reply-To: <20210819091433.348-1-chenan.xxw@alibaba-inc.com> (Xia XiaoWen's
        message of "Thu, 19 Aug 2021 17:14:33 +0800")
Message-ID: <xmqq4kbl2sre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F1EE6F6-011B-11EC-9BBD-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xia XiaoWen <haoyurenzhuxia@gmail.com> writes:

> Sometimes need to limit the receive speed of git `clone/fetch`
> because of the limited network bandwidth, otherwise will prevent
> other applications from using the network normally.

No subject in these two half-sentences.

    In order to avoid hogging all the available bandwidth, users may
    want to limit the speed to receive traffic for "git clone" or
    "git fetch".

perhaps.

> Add `http.maxReceiveSpeed` to limit `git-receive-pack` receiving

"limit `git-receive-pack`'s" or "limit receiving speedk of ..."

> speed, Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` eivironment
> variable.
>
> The default is unlimited, same if the value is 0 or negative. The

Let's error it out when the configuration gives a value that does
not make sense instead.  That way, we could in the future use some
of these invalid values to signal special behaviour if we wanted to.

> default unit is Bytes/s, common unit suffixes of k, m, or g are supported.

OK.

> this configuration is valid for `clone`, `fetch`, `pull` commands of the

s/this/This/

> https protocol, and only supports libcurl 7.15.5 and above.

We are likely be raising the floor versions of libcURL to 7.16.0 or
even 7.19.4 soonish.  It probably would make it easier to allow it
unconditionally (otherwise you'd probably need to implement error or
warning messages when configuration is given but the libcURL version
used is too old, etc.).

> ---
>  http.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 8119247149..12030cf3bc 100644
> --- a/http.c
> +++ b/http.c
> @@ -83,6 +83,9 @@ static const char *ssl_pinnedkey;
>  static const char *ssl_cainfo;
>  static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +static ssize_t curl_max_receive_speed = -1;

On cURL side, CURLOPT_MAX_RECV_SPEED_LARGE takes curl_off_t, which
is typically off_t (which is signed).

I wonder if ssize_t is overkill for our purpose, though.  Can't this
be a plain vanilla "int" or perhaps "long", just like the variable
defined above uses "long" for "speed"?  Or is 2gb/s too low to be
practical and we must use a 64-bit type?

> +#endif
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static const char *http_proxy_authmethod;
> @@ -361,7 +364,12 @@ static int http_options(const char *var, const char *value, void *cb)
>  		curl_low_speed_time = (long)git_config_int(var, value);
>  		return 0;
>  	}
> -
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	if (!strcmp("http.maxreceivespeed", var)) {
> +		curl_max_receive_speed = git_config_ssize_t(var, value);

Check for nonsense values, so that we can later use them to mean
something special.  It is good to remember is that you can always
loosen the rules after you give your software to your users, but it
is very hard to tighten the rules.  As you never need more than one
way to specify "the default" (aka "unlimited"), reserving any
non-positive value to mean the default is a design that is
extensible poorly.

I.e. insert something like

		if (curl_max_receive_speed < 0)
			die("negatigve number for %s: %s", var, value);

here.

> +		return 0;
> +	}
> +#endif
>  	if (!strcmp("http.noepsv", var)) {
>  		curl_ftp_no_epsv = git_config_bool(var, value);
>  		return 0;
> @@ -974,6 +982,12 @@ static CURL *get_curl_handle(void)
>  				 curl_low_speed_time);
>  	}
>  
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	if (curl_max_receive_speed > 0)

The "result" handle was created anew in this function, so the
distinction does not really matter in practrice, but since you are
carefully initializing the variable to "-1" so that we can
differentiate the case where it is unconfigured (hence we want to
use the default) and it is set to zero (hence we want to use the
default), it would be more consistent and future-proof if you also
allowed 0 to be passed here, i.e.

	if (curl_max_receive_speed >= 0)

> +		curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
> +				 curl_max_receive_speed);

This call, if you use anything but curl_off_t as the type for
curl_max_receive_speed variable where it is declared, needs a cast,
like in the example https://curl.se/libcurl/c/CURLOPT_MAX_RECV_SPEED_LARGE.html

> +#endif
> +
>  	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
>  #if LIBCURL_VERSION_NUM >= 0x071301
>  	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> @@ -1105,6 +1119,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  {
>  	char *low_speed_limit;
>  	char *low_speed_time;
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	char *max_receive_speed;
> +#endif
>  	char *normalized_url;
>  	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
>  
> @@ -1196,6 +1213,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	low_speed_time = getenv("GIT_HTTP_LOW_SPEED_TIME");
>  	if (low_speed_time != NULL)
>  		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
> +#if LIBCURL_VERSION_NUM >= 0x070f05
> +	max_receive_speed = getenv("GIT_HTTP_MAX_RECEIVE_SPEED");
> +	if (max_receive_speed && !git_parse_ssize_t(max_receive_speed, &curl_max_receive_speed))

Overlong line.

Unlike curl_max_receive_speed that must be visible and
understandable long haul in this file, the temporary string variable
lives only during these handful of lines and shortened name is
easier to see and understand what is going on.  Also, you can avoid
repeated spelling out of the environment variable name by giving a
constant for it near the top of this function, e.g.

	static const char mrs_env[] = "GIT_HTTP_MAX_RECEIVE_SPEED";

Then this part would become:

	if (mrs) {
		if (!git_parse_ssize_t(mrs, &curl_max_receive_speed))
			die(_("invalid number for %s: %s", mrs_env, mrs);
		if (curl_max_receive_speed < 0)
			die(_("negative number for %s: %s", mrs_env, mrs);
	}

> +		warning("failed to parse GIT_HTTP_MAX_RECEIVE_SPEED: %s", max_receive_speed);


Thanks.
