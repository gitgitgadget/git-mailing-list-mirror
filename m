Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE267C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929256109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhKCU01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:26:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhKCU0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:26:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9505CF4F6B;
        Wed,  3 Nov 2021 16:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iQSxfuo5Kew2
        DZ2PrKP2QtYNUiIaw2xAoi3a2V4wDDw=; b=QXEZYjwPomNDbwzFnZo/0xcCm4Js
        GFPdvA9k1/F2cFtFjmQAP3WvdkHAQxSSTUka785uFt8aAIx0YMokngILcvCB3mwv
        tgf1kNqMZcYcESPswkwf5xErDULB41/Ogy6D1NVv7PTyg8/WNwYKPWq5N1VC7ifG
        lnGn91JEuzD6Z6A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C286F4F6A;
        Wed,  3 Nov 2021 16:23:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE415F4F69;
        Wed,  3 Nov 2021 16:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] var: add GIT_DEFAULT_BRANCH variable
References: <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
        <20211103201702.117771-1-thomas@t-8ch.de>
Date:   Wed, 03 Nov 2021 13:23:45 -0700
In-Reply-To: <20211103201702.117771-1-thomas@t-8ch.de> ("Thomas
 =?utf-8?Q?Wei=C3=9Fschuh=22's?=
        message of "Wed, 3 Nov 2021 21:17:02 +0100")
Message-ID: <xmqq1r3x6l9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F2C60C90-3CE3-11EC-BDA1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> writes:

> Introduce the logical variable GIT_DEFAULT_BRANCH which represents the
> the default branch name that will be used by "git init".

Sorry for not realizing this earlier, but we are not reporting the
"default" with this feature.  If you have ~/.gitconfig with your
favourite configuration in it, what this reports is the name of the
branch created by "git init" without the "--initial-branch=3D<name>"
option.

So GIT_INITIAL_BRANCH_NAME might be a more appropriate name for the
variable from that realization.  But I do not feel too strongly
about it, so let's not keep rerolling but see what others think
first.

Thanks.  Will queue this version as-is.  The updated test looks good.

> +test_expect_success 'get GIT_DEFAULT_BRANCH without configuration' '
> +	(
> +		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +		git init defbranch &&
> +		git -C defbranch symbolic-ref --short HEAD >expect &&
> +		git var GIT_DEFAULT_BRANCH >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
> +	test_config init.defaultbranch foo &&
> +	(
> +		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +		echo foo >expect &&
> +		git var GIT_DEFAULT_BRANCH >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  # For git var -l, we check only a representative variable;
>  # testing the whole output would make our test too brittle with
>  # respect to unrelated changes in the test suite's environment.
>
> base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
