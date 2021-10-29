Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8EC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C05A60F92
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 23:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhJ2XT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 19:19:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52341 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2XT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 19:19:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 469D715F289;
        Fri, 29 Oct 2021 19:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lkdYpGk8BbfzMiVHHAocD4lje0VvdikyNVnImh
        wdKyQ=; b=OFcBiprI8NmxC+kMGhnNH5ys8A+pxwu7BEitViZEZcAkZlDxPjvwoi
        c0/oY1L9GV4REAKbbhZXV5iqUSPPWYqWTAqphViPKZfxJgFzxXRA6xSZAPMgt20i
        SxDYblpJSYH7mUP3Kscic7mra//gOAedLVJ2aCuU9kLjtqCtrzQi8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EBE815F288;
        Fri, 29 Oct 2021 19:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0E0D15F287;
        Fri, 29 Oct 2021 19:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 8/8] clean/smudge: allow clean filters to process
 extremely large files
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <acc5591517fa519fc45c07c27defb309c891dea0.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 16:17:24 -0700
In-Reply-To: <acc5591517fa519fc45c07c27defb309c891dea0.1635515959.git.gitgitgadget@gmail.com>
        (Matt Cooper via GitGitGadget's message of "Fri, 29 Oct 2021 13:59:19
        +0000")
Message-ID: <xmqq4k8zh14r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60EBBC12-390E-11EC-80EC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# This clean filter writes down the size of input it receives. By checking against
> +# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
> +		'files over 4GB convert on input' '
> +	test-tool genzeros $((5*1024*1024*1024)) >big &&
> +	test_config filter.checklarge.clean "wc -c >big.size" &&
> +	echo "big filter=checklarge" >.gitattributes &&
> +	git add big &&
> +	test $(test_file_size big) -eq $(cat big.size)
> +'

I would have expected that the clean filter to be sending the count
to its standard output (to be hashed and made into a blob object),
and the test wuld be doing "git cat-file blob :big" to read the
contents of the raw blob, bypassing the filter system.  But we are
testing with only a single path anyway, use of this single extra
file is OK.

Looking good.

