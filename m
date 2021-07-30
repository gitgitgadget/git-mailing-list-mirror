Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D25C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D8C6054F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 16:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhG3QWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:22:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51778 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhG3QWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 12:22:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DAF6C2F0F;
        Fri, 30 Jul 2021 12:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GnjshMw2xzKU
        g4x4JgnLnCEt/HoAwkecEAvQp2tShV4=; b=YyIVPka0x2VmWx+KsDcEDAp6Oo3U
        wH5CJDDWd6pRnVzDJuCOmaigAG41kivRNt0k7uBkj0kJ3VgEzTH7cCe8hkCl5jZ0
        GxQIFmQv65YrWtO2D2oZX6gvMySz6gGWy5v/hSS2Mc7inBFrqM92u0KwEjp2w7iN
        GVEOXuCJsyz0GtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02BEBC2F0C;
        Fri, 30 Jul 2021 12:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78323C2F09;
        Fri, 30 Jul 2021 12:22:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 5/7] http: drop support for curl < 7.18.0 (again)
References: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <patch-v3-5.7-b857a9ef7b1-20210730T092843Z-avarab@gmail.com>
Date:   Fri, 30 Jul 2021 09:22:24 -0700
In-Reply-To: <patch-v3-5.7-b857a9ef7b1-20210730T092843Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Jul
 2021 11:31:57
        +0200")
Message-ID: <xmqq4kcb3h6n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 537ABC76-F152-11EB-B88D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In a preceding commit we dropped support for curl < 7.19.4, so we can
> drop support for this non-obvious dependency on curl < 7.18.0.
>
> It's non-obvious because in curl's hex version notation 0x071800 is
> version 7.24.0, *not* 7.18.0, so at a glance this patch looks
> incorrect.
>
> But it's correct, because the existing version check being removed
> here is wrong. The check guards use of the following curl defines:
>
>     CURLPROXY_SOCKS4                7.10
>     CURLPROXY_SOCKS4A               7.18.0
>     CURLPROXY_SOCKS5                7.10
>     CURLPROXY_SOCKS5_HOSTNAME       7.18.0
>
> I.e. the oldest version that has these is in fact 7.18.0, not
> 7.24.0. That we were checking 7.24.0 is just an mistake in
> 6d7afe07f29 (remote-http(s): support SOCKS proxies, 2015-10-26),
> i.e. its author confusing base 10 and base 16.

Heh, not just the author but everybody who reviewed it may have been
confused that the version number string was binary coded decimal.

Nicely found.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  http.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index e9446850a62..477bf591141 100644
> --- a/http.c
> +++ b/http.c
> @@ -927,7 +927,6 @@ static CURL *get_curl_handle(void)
>  		 */
>  		curl_easy_setopt(result, CURLOPT_PROXY, "");
>  	} else if (curl_http_proxy) {
> -#if LIBCURL_VERSION_NUM >=3D 0x071800
>  		if (starts_with(curl_http_proxy, "socks5h"))
>  			curl_easy_setopt(result,
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
> @@ -940,7 +939,6 @@ static CURL *get_curl_handle(void)
>  		else if (starts_with(curl_http_proxy, "socks"))
>  			curl_easy_setopt(result,
>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> -#endif
>  #if LIBCURL_VERSION_NUM >=3D 0x073400
>  		else if (starts_with(curl_http_proxy, "https")) {
>  			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
