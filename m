Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593AD20899
	for <e@80x24.org>; Sat, 12 Aug 2017 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdHLAaq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 20:30:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751948AbdHLAao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 20:30:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09C3E9A55A;
        Fri, 11 Aug 2017 20:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lArDYDBbdrNP+LpC75GeX3Zj3E=; b=ICDqgV
        Kj3qHUGXzutE9pU6Qdzpl9Ugsqf/zbnvoDn7E70MuJLO9UrregV5YQwxK1xPTK0J
        PyneQkRDYd6U2wzg/hXykCK65kR8m7TG4r8mzfPDocoihPczhmbKqC18tu4hrys+
        9VmMHsKcnm23oOyCV/D0sVzaDhNthC581uZ4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQBnI3qwFyAHEsn3UJyzi/GzO8H6KgK7
        1MhDaP+jIuiXShiLy4Z5v3YZSk0XtcxD7yeyZKUexLfRzY7eU3pKIlzjbbNv6wuv
        C/3r71ORlZih49jfQKW2T9ru/R4Dwf1ec6mrLoC+4XIHfQ6CTO70QNCCOw2w5WdC
        F03z4bottJQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F356E9A557;
        Fri, 11 Aug 2017 20:30:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59E569A555;
        Fri, 11 Aug 2017 20:30:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http: Fix handling of missing CURLPROTO_*
References: <cover.1502462884.git.tgc@jupiterrise.com>
        <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
        <cover.1502462884.git.tgc@jupiterrise.com>
        <4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com>
Date:   Fri, 11 Aug 2017 17:30:34 -0700
In-Reply-To: <4d29d43d458f61c6dabca093f591ad8698ca2ceb.1502462884.git.tgc@jupiterrise.com>
        (Tom G. Christensen's message of "Fri, 11 Aug 2017 18:37:33 +0200")
Message-ID: <xmqqo9rly6dx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 750B5626-7EF5-11E7-BC6B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tom G. Christensen" <tgc@jupiterrise.com> writes:

> Commit aeae4db1 refactored the handling of the curl protocol restriction
> support into a function but failed to add a version check for older
> versions of curl that lack CURLPROTO_* support.
> This adds the missing check and at the same time converts it to a feature
> check instead of a version based check.
> This is done to ensure that vendor supported curl versions that have had
> CURLPROTO_* support backported are handled correctly.
>
> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  http.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index e00264cff..569909e8a 100644
> --- a/http.c
> +++ b/http.c
> @@ -685,6 +685,7 @@ void setup_curl_trace(CURL *handle)
>  	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
>  }
>  
> +#ifdef CURLPROTO_HTTP
>  static long get_curl_allowed_protocols(int from_user)
>  {
>  	long allowed_protocols = 0;
> @@ -700,6 +701,7 @@ static long get_curl_allowed_protocols(int from_user)
>  
>  	return allowed_protocols;
>  }
> +#endif
>  
>  static CURL *get_curl_handle(void)
>  {
> @@ -798,7 +800,7 @@ static CURL *get_curl_handle(void)
>  #elif LIBCURL_VERSION_NUM >= 0x071101
>  	curl_easy_setopt(result, CURLOPT_POST301, 1);
>  #endif
> -#if LIBCURL_VERSION_NUM >= 0x071304
> +#ifdef CURLPROTO_HTTP
>  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
>  			 get_curl_allowed_protocols(0));
>  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,

This may make the code to _compile_, but is it sensible to let the
code build and be used by the end users without the "these protocols
are safe" filter, I wonder?  

Granted, ancient code was unsafe and people were happily using it,
but now we know better, and more importantly, we have since added
users of transport (e.g. blindly fetch submodules recursively) that
may _rely_ on this layer of the code safely filtering unsafe
protocols, so...

