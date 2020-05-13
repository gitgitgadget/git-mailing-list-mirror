Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B113C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7E9206CC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MXTLLJkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbgEMT35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:29:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60867 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389529AbgEMT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 15:29:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0372BC93B;
        Wed, 13 May 2020 15:29:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1HTusU496v0li+8pkOOQCtHNY5I=; b=MXTLLJ
        kOUntRMI2B5XvzHD62/rV/JvtluUclvoWY3V9dgfFhGUHkKPsMk6MUmXlZKl4z7o
        uIUcf54YSSKgVgM6DJQVp3Ov1IaTsJARFKYk55IVjqK+Pi0SXH7FE7XB1oWsJgCm
        nvuyI8mOlC/RJaIUOUDT0QXTSZ9wkZNL0ATpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RSwiF2h+wKTF0HVX5xOxrzD3z2cTBx0d
        bU/6fRl+ByY16kw+9otSaDTy/qwWGW5UuEXej19pLvnkMVf7x3buTAxQxJ0QmffV
        yr6OpOlFxSvoscZJqmibUXmMwGF4lEYdeIvoIzvxZ5N3FFsEBgx6ZZjiZpDGp77q
        VxsWLN943NU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B833EBC93A;
        Wed, 13 May 2020 15:29:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD2B0BC939;
        Wed, 13 May 2020 15:29:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net
Subject: Re: [PATCH v2 2/3] http: make GIT_TRACE_CURL auth redaction optional
References: <cover.1589218693.git.jonathantanmy@google.com>
        <cover.1589394456.git.jonathantanmy@google.com>
        <8c70a45b24861290b64d4487383bdfa5960332ab.1589394456.git.jonathantanmy@google.com>
Date:   Wed, 13 May 2020 12:29:48 -0700
In-Reply-To: <8c70a45b24861290b64d4487383bdfa5960332ab.1589394456.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 13 May 2020 12:12:47 -0700")
Message-ID: <xmqqpnb7tyz7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CAC9DE0-9550-11EA-8E7F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/http.c b/http.c
> index 62aa995245..77eac95d64 100644
> --- a/http.c
> +++ b/http.c
> @@ -18,6 +18,7 @@
>  
>  static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
>  static int trace_curl_data = 1;
> +static int trace_curl_redact_authorization = 1;
>  static struct string_list cookies_to_redact = STRING_LIST_INIT_DUP;
>  #if LIBCURL_VERSION_NUM >= 0x070a08
>  long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
> @@ -642,8 +643,9 @@ static void redact_sensitive_header(struct strbuf *header)
>  {
>  	const char *sensitive_header;
>  
> -	if (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
> -	    skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header)) {
> +	if (trace_curl_redact_authorization &&
> +	    (skip_prefix(header->buf, "Authorization:", &sensitive_header) ||
> +	     skip_prefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {

Nice.

>  		/* The first token is the type, which is OK to log */
>  		while (isspace(*sensitive_header))
>  			sensitive_header++;
> @@ -859,6 +861,7 @@ static int get_curl_http_version_opt(const char *version_string, long *opt)
>  static CURL *get_curl_handle(void)
>  {
>  	CURL *result = curl_easy_init();
> +	const char *redact_authorization_envvar;
>  
>  	if (!result)
>  		die("curl_easy_init failed");
> @@ -997,6 +1000,10 @@ static CURL *get_curl_handle(void)
>  	setup_curl_trace(result);
>  	if (getenv("GIT_TRACE_CURL_NO_DATA"))
>  		trace_curl_data = 0;
> +	redact_authorization_envvar = getenv("GIT_REDACT_AUTHORIZATION");
> +	if (redact_authorization_envvar &&
> +	    !strcmp(redact_authorization_envvar, "0"))
> +		trace_curl_redact_authorization = 0;

Wasn't git_env_bool() designed exactly for this kind of usage?

Thanks.
