Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC8CC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1279221FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgLHV7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:59:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51874 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLHV7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:59:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38A201087CE;
        Tue,  8 Dec 2020 16:58:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k4ceyNZwwxMSF0SJYuEVw9fCZ4g=; b=PXrwZX
        mTEg+pIZuEeHwPK4+lR8Nzmy5DGFDm3jhp5dOXoUVpqMP0BJSZRb8BTGa+bzYmsk
        7E6gc6Cl4GnJNcXzPKICOlA78ntIcL0auG1M/lHTPjGhndHiNTcyFCTUjF/ePEU1
        a1+RugzS79V5lZLQMi8p7MbFcL6G6LQiLUz8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wgQf36jZLthH5OJL/SPrF/E8YriBqPtY
        6lo+MmNxH/t/Tjd6BUi9Bx//mLM5h/UiL+/cS+LhGWQsgFVJANqunZcq/FXxVlTb
        CdxgjFzphACkuGOqMTo9zJUC1jdKktWp7tLpiCjZi0CTLhy+5QRcNUXlG01T78Qo
        BoTHtBOmLBM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 307251087CD;
        Tue,  8 Dec 2020 16:58:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A6501087CC;
        Tue,  8 Dec 2020 16:58:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
        <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
        <20201208201256.GK36751@google.com>
Date:   Tue, 08 Dec 2020 13:58:49 -0800
In-Reply-To: <20201208201256.GK36751@google.com> (Josh Steadmon's message of
        "Tue, 8 Dec 2020 12:12:56 -0800")
Message-ID: <xmqqsg8g559i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E9DA116-39A0-11EB-9932-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Caught a typo here, sending this as a squash patch since it's already in
> next:

The breakage and the fix looks obvious to me, but...

How did CI allow 'next' to pass with such a typo, I wonder?
Moreover, my pre-push tests of all the integration branches
I didn't notice this to fail, but I cannot see how it could
have been succeeded.  Puzzled...

Will queue, thanks.

>
> -- >8 --
> Subject: [PATCH] t7900: fix typo: "test_execpt_success"
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/t7900-maintenance.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 4ca3617173..8c061197a6 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -441,7 +441,7 @@ test_expect_success 'register preserves existing strategy' '
>  	test_config maintenance.strategy incremental
>  '
>  
> -test_execpt_success 'fails when running outside of a repository' '
> +test_expect_success 'fails when running outside of a repository' '
>  	nongit test_must_fail git maintenance run &&
>  	nongit test_must_fail git maintenance stop &&
>  	nongit test_must_fail git maintenance start &&
