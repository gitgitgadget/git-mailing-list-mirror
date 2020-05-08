Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECBDC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73D620CC7
	for <git@archiver.kernel.org>; Fri,  8 May 2020 16:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fe6r01QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHQiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 12:38:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53535 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHQiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 12:38:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89C2CD7D68;
        Fri,  8 May 2020 12:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=beyDPAf9z9CSnulb3dYE+UQgXiw=; b=Fe6r01
        QUdQYEDSo2VVAWSgQUA1L94tfDY2ZQIIw+6IvCh9TFKXwPOCthBTOVm9d8Pra7XJ
        O4ZgYpC/edMAuGIhL7X2Ow42kYEeWAvYj5erbfPOxkHAfmzk/fX950SvxaSv6JSt
        9N87jCwuorsU6Ir0oRvVdhNWhj/HSLGPTk9N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xt55L3CTrpzRseZL/guNZoJAX4IIMc4z
        hVanmpU/D6hOoHmSzh0vx6hq8DSj2X6rylxgQdQLOxbeHCf5kbcYSvV5lokKuwZ/
        B43rpspDAjvxQel7ZdMXXL/51YB1uYSGLuSl0ZHedvWLUw1Np01ONWyoQpgmTvGr
        6UM8uVcUL3g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8157BD7D67;
        Fri,  8 May 2020 12:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2630DD7D64;
        Fri,  8 May 2020 12:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        chrisitan.couder@gmail.com, Denton Liu <liu.denton@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Re* [PATCH v4] submodule: port subcommand 'set-url' from shell to C
References: <xmqqtv0t6l84.fsf@gitster.c.googlers.com>
        <20200506181239.GA5683@konoha>
        <xmqqwo5o6hzp.fsf@gitster.c.googlers.com>
        <20200507044028.GA5168@konoha>
        <xmqqv9l849i4.fsf@gitster.c.googlers.com>
        <20200508054728.GA8615@konoha>
        <CAP8UFD0=_8D8hkT5VVPV_F++dr131bkjby357fA+QfhQxktcMg@mail.gmail.com>
        <xmqq8si21mlz.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQP_9onrq-z5db1GhXSSHaeKJ+UhNewWP25wLCsMRzSrA@mail.gmail.com>
        <xmqqpnbezaga.fsf@gitster.c.googlers.com>
        <20200508161315.GA3504@flurp.local>
Date:   Fri, 08 May 2020 09:38:17 -0700
In-Reply-To: <20200508161315.GA3504@flurp.local> (Eric Sunshine's message of
        "Fri, 8 May 2020 12:13:15 -0400")
Message-ID: <xmqq4ksqz8jq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52D83442-914A-11EA-B36C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH] CodingGuidelines: do not ==/!= compare with 0 or '\0' or NULL
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/CodingGuidelines | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 390ceece52..6dfc47ed7d 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -236,6 +236,18 @@ For C programs:
>          while( condition )
>  		func (bar+1);
>  
> + - Do not explicitly compare an integral value with constant 0 or '\0',
> +   or a pointer value with constant NULL.  For instance, to validate a
> +   counted array ptr that has cnt elements, write:

I think this should be

      counted array <ptr, cnt> is initialized but has no elements, write:

> +
> +	if (!ptr || cnt)
> +		BUG("empty array expected");
> +
> +   and not:
> +
> +	if (ptr == NULL || cnt != 0);
> +		BUG("empty array expected");
> +
>   - We avoid using braces unnecessarily.  I.e.
>  
>  	if (bla) {
