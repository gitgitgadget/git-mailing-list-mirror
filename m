Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B1C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiBXWfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiBXWfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:52 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2801470C7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:35:22 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 809E110E837;
        Thu, 24 Feb 2022 17:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/T/YnSNS0IFeokDHozkcZQxSg9dfYg1TGOi90F
        2blhc=; b=BPdMQHKgjvmaoQB/s02Lks3cKb3elkWU7CjaC5xZILzI9MQfYa52RO
        MyYtwsowba6nk+B9gXQ3x44jiFiytewDFmy7/WgauutNRiQQBNX3ncrtQH/Ambtr
        1ZFgp3YpfEPx05xS5xPfwIxm9zUGbFGKQytiYijTDxd+ppbiVQH+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78E1D10E836;
        Thu, 24 Feb 2022 17:35:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E768110E835;
        Thu, 24 Feb 2022 17:35:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/7] commit-graph: fix generation number v2 overflow values
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
        <de7ab2f39d90c6b33b21a5adf126ec2ef5ce27e6.1645735117.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 14:35:19 -0800
In-Reply-To: <de7ab2f39d90c6b33b21a5adf126ec2ef5ce27e6.1645735117.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 24 Feb 2022
        20:38:33 +0000")
Message-ID: <xmqqbkyvki54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CA064E4-95C2-11EC-87AE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
> +			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);

Wow, that's embarrassing.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 1afee1c2705..5e4b0216fa6 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -815,6 +815,19 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>  	)
>  '
>  
> +# The remaining tests check timestamps that flow over
> +# 32-bits. The graph_git_behavior checks can't take a
> +# prereq, so just stop here if we are on a 32-bit machine.
> +
> +if ! test_have_prereq TIME_IS_64BIT
> +then
> +	test_done
> +fi
> +if ! test_have_prereq TIME_T_IS_64BIT
> +then
> +	test_done
> +fi

The above is OK but is there a reason why we cannot do

	if A || B
	then
		test_done
	fi

here (I am assuming not, but in case I am missing the reason why it
has to be separate)?

> @@ -832,10 +845,10 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
>  # The largest offset observed is 2 ^ 31, just large enough to overflow.
>  #
>  
> -test_expect_success 'set up and verify repo with generation data overflow chunk' '
> +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
>  	objdir=".git/objects" &&
>  	UNIX_EPOCH_ZERO="@0 +0000" &&
> -	FUTURE_DATE="@2147483646 +0000" &&
> +	FUTURE_DATE="@4000000000 +0000" &&

OK. 16#EE6B2800 too large to fit and will cause wrapping around with
signed 32-bit integer.

> @@ -867,4 +880,8 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
>  
>  graph_git_behavior 'generation data overflow chunk repo' repo left right
>  
> +# Do not add tests at the end of this file, unless they require 64-bit
> +# timestamps, since this portion of the script is only executed when
> +# time data types have 64 bits.
> +
>  test_done
