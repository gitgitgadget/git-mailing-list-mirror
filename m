Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4098C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F15661405
	for <git@archiver.kernel.org>; Thu, 13 May 2021 06:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhEMGvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 02:51:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhEMGvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 02:51:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 218BC147A8B;
        Thu, 13 May 2021 02:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A2B2aSGx+9Y+MvzRX7aAq276W9dklXuejBReGW
        WwciU=; b=aTcHv6T8tOViXcMUOYNaOita6ao7IeBHZXRXEPI0BIJht5Vc8aMPFK
        Mmamh4J/gIN8SrzoGSqcD+JmaUOraOmuTuLmwKq2BPepx8mJwrgalfYE6iNO0fVq
        +338muA2UvYHU6EL1KSkuZSxZ8UA0HHBK1K0d8Yktf+O9oRWE3LoE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A6A6147A8A;
        Thu, 13 May 2021 02:49:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81E2E147A89;
        Thu, 13 May 2021 02:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
Date:   Thu, 13 May 2021 15:49:52 +0900
In-Reply-To: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 13 May 2021 02:25:53 -0400")
Message-ID: <xmqqim3nb01b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C7D22DC-B3B7-11EB-A03A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course those extra lint checks are doing something useful, so paying
> a few extra seconds (at least on Linux) isn't so bad (though note the
> CPU time; we're bounded in our parallel run here by the slowest test, so
> it really is ~120s of CPU improvement).

Nice.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index adaa2db601..adaf03543e 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -947,8 +947,11 @@ test_run_ () {
>  		trace=
>  		# 117 is magic because it is unlikely to match the exit
>  		# code of other programs
> -		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
> -			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)" ||
> +		   {
> +			test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT:-1}}" != 0 &&
> +			$(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!')
> +		   }

We have been doing the more expensive one first, but we now
optionally skip it while retaining the one that uses the shell.
OK.

Nicely done.

>  		then
>  			BUG "broken &&-chain or run-away HERE-DOC: $1"
>  		fi
