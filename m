Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D65DC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiFHWDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFHWDk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 18:03:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1ABE156
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 15:03:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A9B612FCE9;
        Wed,  8 Jun 2022 18:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GAEbkoOlSvME9UZQYLkJB7YlWi/cqSQ5CfsMGs
        VcvrA=; b=U+5c05AO3AOeOgzkYZ1fRapO/d7fEvO5vBRpV2M1/JSriXJW/5ceeH
        YziY9czxcHq1KETb+PVPzrDuuCH5RfVeHtg+dGrBD1qzTBXxs5VT42ukQo2wU2uS
        3FyfL7eqg3JnA/lnQEUBDyI15JU4MsyzF2KgtvGtcZv7ppwsr9rtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E3A112FCE8;
        Wed,  8 Jun 2022 18:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 690B812FCE5;
        Wed,  8 Jun 2022 18:03:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] branch: check for bisects and rebases
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <18bad9b0c496fc0ceab1e567aee83f2160ae5d75.1654718942.git.gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 15:03:35 -0700
In-Reply-To: <18bad9b0c496fc0ceab1e567aee83f2160ae5d75.1654718942.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 08 Jun 2022
        20:09:00 +0000")
Message-ID: <xmqqsfoeq0co.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9003F2C-E776-11EC-AE65-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index dd905dc1a5c..12faca7f655 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -21,4 +21,33 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
>  	done
>  '
>  
> +test_expect_success 'refuse to overwrite: worktree in bisect' '
> +	test_when_finished test_might_fail git -C wt-4 bisect reset &&
> +
> +	(
> +		git -C wt-4 bisect start &&
> +		git -C wt-4 bisect bad HEAD &&
> +		git -C wt-4 bisect good HEAD~3
> +	) &&
> +
> +	test_must_fail git branch -f wt-4 HEAD 2>err &&
> +	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
> +'
> +
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> +
> +test_expect_success 'refuse to overwrite: worktree in rebase' '
> +	test_when_finished test_might_fail git -C wt-4 rebase --abort &&
> +
> +	(
> +		set_fake_editor &&
> +		FAKE_LINES="edit 1 2 3" \
> +			git -C wt-4 rebase -i HEAD~3 >rebase &&
> +		git -C wt-4 status
> +	) &&
> +
> +	test_must_fail git branch -f wt-4 HEAD 2>err &&
> +	grep "cannot force update the branch '\''wt-4'\'' checked out at" err
> +'
> +
>  test_done

Nice to see that each additional feature corresponds to each
additional test.

Thanks.
