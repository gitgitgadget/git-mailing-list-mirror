Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E641C46467
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 21:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjAOVhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjAOVhM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 16:37:12 -0500
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE11632E
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 13:37:10 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id HAgdpcCidG2OpHAgepiB6y; Sun, 15 Jan 2023 21:37:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673818629; bh=MCHgGLys4xnvpudBGz7XWtvXOGmByoKeQ97W2QtVXXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JfF40da7NeY3h1VkoZ/KYgEaOrFDZQK4cHkfJ7dGtLgXqEHz7ICkYH7Vtzdkib/Df
         EOWXRfuX/WkgePce2nVhH5QbOl4tHZ+RQ5fFX0LPWFCGox6PgL7L/Ke+hpQg4yH3BS
         vljd8ovamYvYddgVyWrhqpwvXjdqxz4dsp+Gxb6HNdZu5pTmJG0p58rTaekpI82T6N
         212RjtfKD615XiGZ8QoobeD0P+qiWuQQzZahEdXa4oynSACc63fXYDQRlyhSADs6F4
         KzIKy24kXiCDP28r8GUybV0pLwNc1wVW3SuTWuZ8nDAQdlBejXS777R3IbqhV22Pwx
         Y8NVfuuGpn7/g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Lo2Bd1Rc c=1 sm=1 tr=0 ts=63c47204
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=I7w6He0n0SIa6a5pwq0A:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <8f175d26-3d84-3019-031d-e358390f2de4@ramsayjones.plus.com>
Date:   Sun, 15 Jan 2023 21:37:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
Content-Language: en-GB
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM7nZ0LtwKX6hdgUDEUXw8KlpuUB/4SoHASOf62/m+xeLGLejtZf70sv1AWVdGqEQ46JSNSFX0eDclzbvqRCTzZ6ZPi5DWXWqJcGGyjcX77t8DO+pt8/
 xvMhUmZVyCMcpMOs76kkwRDNsiwNoAD+flXOGVXq9LzHjlRcSV6Q+KgkJAsWpypXbhmUI9NSus7ufPPm0dAymqRhM+lM7yDAih8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/01/2023 20:12, Jeff King wrote:
> The CURLOPT_PROTOCOLS (and matching CURLOPT_REDIR_PROTOCOLS) flag was
> deprecated in curl 7.85.0, and using it generate compiler warnings as of
> curl 7.87.0. The path forward is to use CURLOPT_PROTOCOLS_STR, but we
> can't just do so unilaterally, as it was only introduced less than a
> year ago in 7.85.0.

Yep, I hadn't quite finished my version of this patch yet, but you
would probably not be shocked to learn that I had two separate sets
of functions #ifdef-ed by curl version number! What you have here
looks *much* better!

> 
> Until that version becomes ubiquitous, we have to either disable the
> deprecation warning or conditionally use the "STR" variant on newer
> versions of libcurl. This patch switches to the new variant, which is
> nice for two reasons:
> 
>   - we don't have to worry that silencing curl's deprecation warnings
>     might cause us to miss other more useful ones
> 
>   - we'd eventually want to move to the new variant anyway, so this gets
>     us set up (albeit with some extra ugly boilerplate for the
>     conditional)
> 
> There are a lot of ways to split up the two cases. One way would be to
> abstract the storage type (strbuf versus a long), how to append
> (strbuf_addstr vs bitwise OR), how to initialize, which CURLOPT to use,
> and so on. But the resulting code looks pretty magical:
> 
>   GIT_CURL_PROTOCOL_TYPE allowed = GIT_CURL_PROTOCOL_TYPE_INIT;
>   if (...http is allowed...)
> 	GIT_CURL_PROTOCOL_APPEND(&allowed, "http", CURLOPT_HTTP);
> 
> and you end up with more "#define GIT_CURL_PROTOCOL_TYPE" macros than
> actual code.
> 
> On the other end of the spectrum, we could just implement two separate
> functions, one that handles a string list and one that handles bits. But
> then we end up repeating our list of protocols (http, https, ftp, ftp).
> 
> This patch takes the middle ground. The run-time code is always there to
> handle both types, and we just choose which one to feed to curl.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-curl-compat.h |  8 ++++++++
>  http.c            | 41 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index 56a83b6bbd..fd96b3cdff 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -126,4 +126,12 @@
>  #define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
>  #endif
>  
> +/**
> + * CURLOPT_PROTOCOLS_STR and CURLOPT_REDIR_PROTOCOLS_STR were added in 7.85.0,
> + * released in August 2022.
> + */
> +#if LIBCURL_VERSION_NUM >= 0x075500
> +#define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
> +#endif

Ah, I haven't really grokked what this file is about ... but this
looks simple enough. ;)

> +
>  #endif
> diff --git a/http.c b/http.c
> index ca0fe80ddb..e529ebc993 100644
> --- a/http.c
> +++ b/http.c
> @@ -764,18 +764,29 @@ void setup_curl_trace(CURL *handle)
>  	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
>  }
>  
> -static long get_curl_allowed_protocols(int from_user)
> +static void proto_list_append(struct strbuf *list_str, const char *proto_str,
> +			      long *list_bits, long proto_bits)
> +{
> +	*list_bits |= proto_bits;
> +	if (list_str) {
> +		if (list_str->len)
> +			strbuf_addch(list_str, ',');
> +		strbuf_addstr(list_str, proto_str);
> +	}
> +}
> +
> +static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
>  {
>  	long allowed_protocols = 0;
>  
>  	if (is_transport_allowed("http", from_user))
> -		allowed_protocols |= CURLPROTO_HTTP;
> +		proto_list_append(list, "http", &allowed_protocols, CURLPROTO_HTTP);
>  	if (is_transport_allowed("https", from_user))
> -		allowed_protocols |= CURLPROTO_HTTPS;
> +		proto_list_append(list, "https", &allowed_protocols, CURLPROTO_HTTPS);
>  	if (is_transport_allowed("ftp", from_user))
> -		allowed_protocols |= CURLPROTO_FTP;
> +		proto_list_append(list, "ftp", &allowed_protocols, CURLPROTO_FTP);
>  	if (is_transport_allowed("ftps", from_user))
> -		allowed_protocols |= CURLPROTO_FTPS;
> +		proto_list_append(list, "ftps", &allowed_protocols, CURLPROTO_FTPS);
>  
>  	return allowed_protocols;
>  }
> @@ -921,10 +932,26 @@ static CURL *get_curl_handle(void)
>  
>  	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
>  	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> +
> +#ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
> +	{
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		get_curl_allowed_protocols(0, &buf);
> +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS_STR, buf.buf);
> +		strbuf_reset(&buf);
> +
> +		get_curl_allowed_protocols(-1, &buf);
> +		curl_easy_setopt(result, CURLOPT_PROTOCOLS_STR, buf.buf);
> +		strbuf_release(&buf);

I used two static char arrays to accumulate the strings before
passing them to curl. I was unsure of the lifetime/ownership
semantics - I still haven't got around to looking them up!

> +	}
> +#else
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> -			 get_curl_allowed_protocols(0));
> +			 get_curl_allowed_protocols(0, NULL));
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> -			 get_curl_allowed_protocols(-1));
> +			 get_curl_allowed_protocols(-1, NULL));
> +#endif
> +
>  	if (getenv("GIT_CURL_VERBOSE"))
>  		http_trace_curl_no_data();
>  	setup_curl_trace(result);

(another reason for not completing these patches - I don't
know what the test coverage is like for these changes; are
more tests required? dunno).

For what it's worth, this LGTM.

Thanks!

ATB,
Ramsay Jones

