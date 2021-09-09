Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B75C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6246D61108
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbhIIXQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:16:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62609 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhIIXQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:16:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 573F5157293;
        Thu,  9 Sep 2021 19:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jmXHF3OQ/fmG
        y09PK+Mc8Oyw9F/hNsx4jWbipaPZLkE=; b=iELKcobv2z1K+vnnhZKcYaZVv9La
        mA4Cz+Cj0rmNlkT2+ID58Sn2Vv9+rQ5WkThL3ef/UcAv+qWjIoFP7adidhder61j
        KlKWTyvq9ya5VWh96oB/Smbe+yPtia2oWu/j0FEJ3mh8s0OCLeA4lTlCvEBPmzvv
        x49iB+JZUXrVt6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FA95157292;
        Thu,  9 Sep 2021 19:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 951E6157290;
        Thu,  9 Sep 2021 19:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 5/5] http: don't hardcode the value of CURL_SOCKOPT_OK
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <patch-5.5-4f42c0e48b0-20210908T152807Z-avarab@gmail.com>
Date:   Thu, 09 Sep 2021 16:15:17 -0700
In-Reply-To: <patch-5.5-4f42c0e48b0-20210908T152807Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 8 Sep
 2021 17:31:56 +0200")
Message-ID: <xmqqr1dxwdbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCF0BEF2-11C3-11EC-AD86-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +/**
> + * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
> + */
> +#ifndef CURL_SOCKOPT_OK
> +#define CURL_SOCKOPT_OK 0
> +#endif
> +
>  /**
>   * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>   */
> diff --git a/http.c b/http.c
> index e38fcc34d64..c40439d39ce 100644
> --- a/http.c
> +++ b/http.c
> @@ -533,7 +533,7 @@ static int sockopt_callback(void *client, curl_sock=
et_t fd, curlsocktype type)
>  	if (rc < 0)
>  		warning_errno("unable to set SO_KEEPALIVE on socket");
> =20
> -	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
> +	return CURL_SOCKOPT_OK;
>  }

This is much better than the one in the previous round where an
extra CPP macro with GIT_CURL_SOCKOPT_OK_AVAILABLE or some other
name was used to conditionally return 0 or CURL_SOCKOPT_OK.
