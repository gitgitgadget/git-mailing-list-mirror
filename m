Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EDC27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjHWVkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjHWVkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:40:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03D10F1
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:39:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C48728E4D;
        Wed, 23 Aug 2023 17:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pc88YPorqyMdLD6RnknnpSsCMWrfznwYNDiMGF
        6YQbg=; b=YEVcZgUVfsesZa6mV10NfFet8emgyKu9VP3czDJ8Z6N2PVA9mvKXRd
        J4SQsyLUKF2cGLIME0csK76yrBEtzela3WXvaNxJW0KtDsu+oAnr0VfNYLmwmHIv
        cqnvIhPtjpnnizfsH/L/7M/ZJCl3mzOy6tmlcTiXFUcJuftjBjEZg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 151A428E4C;
        Wed, 23 Aug 2023 17:38:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98E2D28E4B;
        Wed, 23 Aug 2023 17:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: beautify subject of reverts of reverts
References: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
        <ZOZnNDd2pMX6M2Au@nand.local>
Date:   Wed, 23 Aug 2023 14:38:36 -0700
In-Reply-To: <ZOZnNDd2pMX6M2Au@nand.local> (Taylor Blau's message of "Wed, 23
        Aug 2023 16:08:20 -0400")
Message-ID: <xmqqsf89e8wz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B37F812-41FD-11EE-A449-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This version is looking good. The main functionality is well-reasoned
> and straightforwardly implemented. One minor suggestion that you could
> consider squashing in is some test clean-up like so:
>
> --- 8< ---
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 7011e3a421..4dee71d6d5 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -176,29 +176,27 @@ test_expect_success 'advice from failed revert' '
>  	test_cmp expected actual
>  '
>
> +test_expect_commit_msg () {
> +	echo "$@" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual
> +}
> +
>  test_expect_success 'title of fresh reverts' '
>  	test_commit --no-tag A file1 &&
>  	test_commit --no-tag B file1 &&
>  	git revert --no-edit HEAD &&
> -	echo "Revert \"B\"" >expect &&
> -	git log -1 --pretty=%s >actual &&
> -	test_cmp expect actual &&
> +	test_expect_commit_msg "Revert \"B\"" &&
>  	git revert --no-edit HEAD &&
> -	echo "Reapply \"B\"" >expect &&
> -	git log -1 --pretty=%s >actual &&
> -	test_cmp expect actual &&
> +	test_expect_commit_msg "Reapply \"B\"" &&
>  	git revert --no-edit HEAD &&
> -	echo "Revert \"Reapply \"B\"\"" >expect &&
> -	git log -1 --pretty=%s >actual &&
> -	test_cmp expect actual
> +	test_expect_commit_msg "Revert \"Reapply \"B\"\""
>  '
>
>  test_expect_success 'title of legacy double revert' '
>  	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
>  	git revert --no-edit HEAD &&
> -	echo "Revert \"Revert \"Revert \"B\"\"\"" >expect &&
> -	git log -1 --pretty=%s >actual &&
> -	test_cmp expect actual
> +	test_expect_commit_msg "Revert \"Revert \"Revert \"B\"\"\""
>  '
>
>  test_expect_success 'identification of reverted commit (default)' '
> --- >8 ---
>
> To my eyes, it makes checking the subject of our revert commit against
> an expected value more readable by factoring out the echo, git log,
> test_cmp pattern.

Yeah it does make the test more concise and what is expected stand
out more clearly.  Good suggestion.



