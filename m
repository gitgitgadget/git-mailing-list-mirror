Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F1F1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 03:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKINay (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 08:30:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63692 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeKINay (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 08:30:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE0FA111055;
        Thu,  8 Nov 2018 22:52:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8Pp2w99ENMIgPwDGeiybEsS6aP4=; b=wFgkbS
        wgr0QIC0PEGIsDQV14TSaT4GDdXxb0djAQ2Qz4n3xTNp0tIZbHNnpkWM6S5DZFp6
        adDTHWZGxJ1eGGeXODSxJh0ggkfeGy6rMJ72I/V7e3meqrt/sPMPNaCRLBqUFi5Z
        4IOj/9j4PTN263Wsvfr2yY2y5VZUhzW/4EiZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=koWaI5PKyo2Yew5ykTVIx3AOqxJ9IFBN
        72v7jL6Gs44VUxb8gXcwiPms4NC9LuZzNpCS751LGA7rU32lQ7QvSTbVwBCJqyo8
        IfyWKmyN4JYAELi/gB4xJctRXma5959WPStKgZGV1OZyu0mgzhNZ6vICF/seKQmt
        iuZqY9JzYiw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D780E111054;
        Thu,  8 Nov 2018 22:52:05 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49B05111052;
        Thu,  8 Nov 2018 22:52:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH v7 1/1] http: add support selecting http version
References: <pull.69.v6.git.gitgitgadget@gmail.com>
        <pull.69.v7.git.gitgitgadget@gmail.com>
        <e26fc0d8c77df749c14dd433a0ee66ed1bca17ef.1541718916.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Nov 2018 12:52:03 +0900
In-Reply-To: <e26fc0d8c77df749c14dd433a0ee66ed1bca17ef.1541718916.git.gitgitgadget@gmail.com>
        (Force Charlie via GitGitGadget's message of "Thu, 08 Nov 2018
        15:15:19 -0800 (PST)")
Message-ID: <xmqqefbu6h7g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2BE857A-E3D2-11E8-9769-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force Charlie via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +http.version::
> +	Use the specified HTTP protocol version when communicating with a server.
> +	If you want to force the default. The available and default version depend
> +	on libcurl. Actually the possible values of
> +	this option are:
> +
> +	- HTTP/2
> +	- HTTP/1.1
> +

I just wanted to make sure this formats well; it uses the same
construct as used to make the list of allowed values for the next
entry (sslVersion), so this should be fine.

Thanks.

>  http.sslVersion::
>  	The SSL version to use when negotiating an SSL connection, if you
>  	want to force the default.  The available and default version
> diff --git a/http.c b/http.c
> index 3dc8c560d6..c22275bdee 100644
> --- a/http.c
> +++ b/http.c
> @@ -48,6 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
>  
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
> +static const char *curl_http_version = NULL;
>  static const char *ssl_cert;
>  static const char *ssl_cipherlist;
>  static const char *ssl_version;
> @@ -284,6 +285,9 @@ static void process_curl_messages(void)
>  
>  static int http_options(const char *var, const char *value, void *cb)
>  {
> +	if (!strcmp("http.version", var)) {
> +		return git_config_string(&curl_http_version, var, value);
> +	}
>  	if (!strcmp("http.sslverify", var)) {
>  		curl_ssl_verify = git_config_bool(var, value);
>  		return 0;
> @@ -789,6 +793,30 @@ static long get_curl_allowed_protocols(int from_user)
>  }
>  #endif
>  
> +#if LIBCURL_VERSION_NUM >=0x072f00
> +static int get_curl_http_version_opt(const char *version_string, long *opt)
> +{
> +	int i;
> +	static struct {
> +		const char *name;
> +		long opt_token;
> +	} choice[] = {
> +		{ "HTTP/1.1", CURL_HTTP_VERSION_1_1 },
> +		{ "HTTP/2", CURL_HTTP_VERSION_2 }
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(choice); i++) {
> +		if (!strcmp(version_string, choice[i].name)) {
> +			*opt = choice[i].opt_token;
> +			return 0;
> +		}
> +	}
> +
> +	return -1; /* not found */
> +}
> +
> +#endif
> +
>  static CURL *get_curl_handle(void)
>  {
>  	CURL *result = curl_easy_init();
> @@ -806,6 +834,16 @@ static CURL *get_curl_handle(void)
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
>  	}
>  
> +#if LIBCURL_VERSION_NUM >= 0x072f00 // 7.47.0
> +    if (curl_http_version) {
> +		long opt;
> +		if (!get_curl_http_version_opt(curl_http_version, &opt)) {
> +			/* Set request use http version */
> +			curl_easy_setopt(result, CURLOPT_HTTP_VERSION, opt);
> +		}
> +    }
> +#endif
> +
>  #if LIBCURL_VERSION_NUM >= 0x070907
>  	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
>  #endif
