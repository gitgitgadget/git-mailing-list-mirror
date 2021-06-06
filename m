Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1DC47082
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7BE60C3D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFFBnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 21:43:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53552 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFBnb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 21:43:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BC66CF891;
        Sat,  5 Jun 2021 21:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0mYozpfbQQaE
        uYNlSxOJ4BNfNJU1VYbfxUE+AcfPUjY=; b=UE4oXiXdF8B0rGRp759vTV85J0TO
        vhx1aZduoul9QXjWXW1yTZCJOpzyLTouMh4bx5dUFL+6fAQVFYMos744Dd/Y9rNW
        vhYPTA7hMrXx5zNWcmVI9d8Fn+Z2HQ1sdpLXAF3CoEq4Z/Wj+/w8BmYsEDzWwg8O
        SrbFU8YtXL5bfbU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43F5DCF890;
        Sat,  5 Jun 2021 21:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C634DCF88F;
        Sat,  5 Jun 2021 21:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] parallel-checkout: avoid dash local bug in tests
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
        <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
        <3b71b62d-b299-aac8-f796-ee7a5d7f87b0@web.de>
Date:   Sun, 06 Jun 2021 10:41:41 +0900
In-Reply-To: <3b71b62d-b299-aac8-f796-ee7a5d7f87b0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 6 Jun 2021 03:01:57 +0200")
Message-ID: <xmqq5yyr22i2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57E28D58-C668-11EB-8649-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
> lets the shell erroneously perform field splitting on the expansion of =
a
> command substitution during declaration of a local variable.  It causes
> the parallel-checkout tests to fail e.g. when running them with
> /bin/dash on MacOS 11.4, where they error out like this:
>
>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
>
> That's because the output of wc -l contains leading spaces and the
> returned number of lines is treated as another variable to declare, i.e=
.
> as in "local workers=3D 0".
>
> Work around it by enclosing the command substitution in quotes.
>
> Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
> Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Changes since v2:
> - Use minimal fix.
> - New commit message.

Thanks.  As I said, I do not necessarily think this is conceptually
"minimal", but we use workers only once and without surrounding dq
so it is easy to see that this also is correct.

Will queue.

>
>  t/lib-parallel-checkout.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index 21f5759732..83b279a846 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -27,7 +27,7 @@ test_checkout_workers () {
>  	rm -f "$trace_file" &&
>  	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>
> -	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$tr=
ace_file" | wc -l) &&
> +	local workers=3D"$(grep "child_start\[..*\] git checkout--worker" "$t=
race_file" | wc -l)" &&
>  	test $workers -eq $expected_workers &&
>  	rm "$trace_file"
>  } 8>&2 2>&4
> --
> 2.31.1
