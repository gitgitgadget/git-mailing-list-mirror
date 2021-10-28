Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FAC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B2B610F8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJ1W6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:58:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64092 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhJ1W6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:58:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF67B1563E1;
        Thu, 28 Oct 2021 18:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lga5oUAF/97kRcIHt/k1q/i5ovABnmPRFs9MMo
        cWkNc=; b=onJ1oVkn/5dYJQfCQX/9osdSmJQJujj2rYeq1uMl5I5RRU/LJQ+MQy
        uLRFt+Ybqjcz2Xdhe37sMgLTu85njeKlcEkGKgHrRAtpLk7W3oyzsM8QOe2Zmwz5
        mOuSbe88MVqPvO5M8x2y6jtDyqOt7oG6C8PNgbhX3QBIWu8oSIphg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D7CDA1563E0;
        Thu, 28 Oct 2021 18:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44BB21563DC;
        Thu, 28 Oct 2021 18:55:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/7] test-tool genzeros: generate large amounts of
 data more efficiently
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <6edcbae372ef63bd75ca6cc2d181f7506f35880f.1635454237.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 15:55:31 -0700
In-Reply-To: <6edcbae372ef63bd75ca6cc2d181f7506f35880f.1635454237.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 28 Oct 2021
        20:50:32 +0000")
Message-ID: <xmqq4k90pxng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28AB1F2C-3842-11EC-BA46-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  int cmd__genzeros(int argc, const char **argv)
>  {
> +	/* static, so that it is NUL-initialized */
> +	static char zeros[256 * 1024];

Of course, another benefit is that you do not waste 256kB of
stackspace for this array.  We could probably even mark it as
"const" to emphasize that it is initialized with and will stay
to be bunch of NULs.

>  	intmax_t count;
> +	ssize_t n;
>  
>  	if (argc > 2) {
>  		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
> @@ -12,9 +15,19 @@ int cmd__genzeros(int argc, const char **argv)
>  
>  	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
>  
> -	while (count < 0 || count--) {
> -		if (putchar(0) == EOF)

> +	/* Writing out individual NUL bytes is slow... */
> +	while (count < 0)
> +		if (write(1, zeros, ARRAY_SIZE(zeros) < 0))
>  			return -1;

Be careful where you close your parentheses.  

I wonder if your compiler didn't warn that ARRAY_SIZE(x) will never
be negative?

> +	while (count > 0) {
> +		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
> +			  count : ARRAY_SIZE(zeros));

This side looks OK.

> +		if (n < 0)
> +			return -1;
> +
> +		count -= n;
>  	}
>  
>  	return 0;

