Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC9C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 02:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbiF1CMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiF1CMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 22:12:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319A20BF5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:12:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46DB1190B9C;
        Mon, 27 Jun 2022 22:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=BAuk8+xdN4HYMy4lhTC6sDyncY0zuVlNGREJwCKdtMM=; b=WcXS
        xLAwleigVO5Fi41l0wxtdGbplqXPXP5Xefil+YXcQn/ry0j4CmS1i2wX2pNx6xnf
        6iUkJ1Qj95MBcb5mt6Q1pj8xJAVQVDgjmr/sckVY3Uvb001WHj+xnEkdZo4Cp0d9
        tm3oLhWY66nWrzlnNFS0AAifY9Cqtn8WPQ85lTQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E50D190B99;
        Mon, 27 Jun 2022 22:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0861C190B92;
        Mon, 27 Jun 2022 22:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/16] bisect: verify that a bogus option won't try
 to start a bisection
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <30ddbd7affc83e9b20ecdd66d941f1acc2cbc787.1656354677.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 19:12:07 -0700
Message-ID: <xmqqilolmt8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6DBE3D6-F687-11EC-908A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We do not want `git bisect --bogus-option` to start a bisection. To
> verify that, we look for the tell-tale error message `You need to start
> by "git bisect start"` and fail if it was found.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Sorry, but this looks unclear to me.

In the test "--bisect-terms" is used, and from "git grep" it does
seem to be one of the valid options "git bisect--helper" can take.
It is unclear if the patch wanted to literally use "--bogus-option"
insteaed of it but used "--bisect-terms" by mistake, or if that
valid option is "bogus" only in the sense that the option is not yet
relevant immediately after "git bisect reset" before a new "git
bisect start" session has begun.  IOW, "bogus" both in the patch
title and the test title needs to be clarified.

To put it another way, can we demonstrate the same correctness by
seeing "git bisect --no-such-option" fail immediately after "git
bisect reset"?



>  t/t6030-bisect-porcelain.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 83931d482fb..6d6e72276ae 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -900,6 +900,16 @@ test_expect_success 'bisect start with one term1 and term2' '
>  	git bisect reset
>  '
>  
> +test_expect_success 'bogus command does not start bisect' '
> +	git bisect reset &&
> +	test_must_fail git bisect --bisect-terms 1 2 2>out &&
> +	! grep "You need to start" out &&
> +	test_must_fail git bisect --bisect-terms 2>out &&
> +	! grep "You need to start" out &&
> +	grep "git bisect.*visualize" out &&
> +	git bisect reset
> +'
> +
>  test_expect_success 'bisect replay with term1 and term2' '
>  	git bisect replay log_to_replay.txt >bisect_result &&
>  	grep "$HASH2 is the first term1 commit" bisect_result &&
