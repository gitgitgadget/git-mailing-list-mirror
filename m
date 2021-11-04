Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2951BC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 06:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06934611CB
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 06:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKDGii (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:38:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55743 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhKDGih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 02:38:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EF261750D4;
        Thu,  4 Nov 2021 02:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=55ZhY6+2ZbMCxLXySlhbz6wHCqeGUZnrudzIWi
        CidoA=; b=x/f9iZmfLema2Fkr8PRGREqQDIdqnd6a8Ad3t43HPnUloVh2LLJlmX
        8ACQogZ+Ozr8lGC3lL7+CPqcr32LIW48hc9z3SeAeDW/Gbr4ftpViYjGKgC4sHbL
        iW69noIoKEArIDPgwdDI1NH5N+ytslsZ4qdNVAOax7hzBD+/oW1Wg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B61D1750D3;
        Thu,  4 Nov 2021 02:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F64D1750D2;
        Thu,  4 Nov 2021 02:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
        <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
Date:   Wed, 03 Nov 2021 23:35:54 -0700
In-Reply-To: <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Thu, 04 Nov 2021 04:01:03 +0000")
Message-ID: <xmqqzgqk2zsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 770347B6-3D39-11EC-9714-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> This fix corrects an issue found in the `dockerized(pedantic, fedora)` CI
> build, first appearing after the introduction of a new version of the Fedora
> docker image version. This image includes a version of `glibc` with the
> attribute `__attr_access_none` added to `pthread_setspecific` [1], the
> implementation of which only exists for GCC 11.X - the version included in
> the Fedora image. The attribute requires that the pointer provided in the
> second argument of `pthread_getspecific` must, if not NULL, be a pointer to
> a valid object. In the usage in `async_die_is_recursing`, `(void *)1` is not
> valid, causing the error.
>
> This fix imitates a workaround added in SELinux [2] by using the pointer to
> the static `async_die_counter` itself as the second argument to
> `pthread_setspecific`. This guaranteed non-NULL, valid pointer matches the
> intent of the current usage while not triggering the build error.
>
> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
> [2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/
>
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---

Looks like they timed their update to disrupt us most effectively,
but we are gifted with watchful eyes and competent hands ;-).

Thanks for coming up with a clearly written description and a clean
fix so quickly.

Will apply.
