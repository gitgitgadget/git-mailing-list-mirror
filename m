Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EA4C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 17:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGMR5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMR53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 13:57:29 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418E527159
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 10:57:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CE601AF094;
        Wed, 13 Jul 2022 13:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z6XBHgy03KYvPxG+H7WF+2V7Y0GuLzVZ31tL3y
        io6FA=; b=FcxPCqZkLZ065OLEXFNt0j1tShEDv/AOCM0MaMsGjp7380TKCz9CYF
        jnewjhtablkgVkDLfxXYuoXMiz5xwFhyFOhBk8zclZ140GGMDc9unlAMh3NBBcVz
        0YGKbPp11V1wgogkXig6EWXSPu5zLWmWYxuVxIpQConkQ7yMbqOoc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EFA91AF093;
        Wed, 13 Jul 2022 13:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD75A1AF090;
        Wed, 13 Jul 2022 13:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] checkout: document bug where delayed checkout
 counts entries twice
References: <cover.1657685948.git.matheus.bernardino@usp.br>
        <694aeb19f57297d9b9d07d47897385bdbedd309c.1657685948.git.matheus.bernardino@usp.br>
Date:   Wed, 13 Jul 2022 10:57:21 -0700
In-Reply-To: <694aeb19f57297d9b9d07d47897385bdbedd309c.1657685948.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 13 Jul 2022 01:19:55 -0300")
Message-ID: <xmqqfsj4dhfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F09DAD4-02D5-11ED-B324-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> At the end of a `git checkout <pathspec>` operation, git reports how
> many paths were checked out with a message like "Updated N paths from
> the index". However, entries that end up on the delayed checkout queue
> (as requested by a long-running process filter) get counted twice,
> producing a wrong number in the final report. We will fix this bug in an
> upcoming commit. For now, only document/demonstrate it with a
> test_expect_failure.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t0021-conversion.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index bad37abad2..00df9b5c18 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -1132,4 +1132,26 @@ do
>  	'
>  done
>  
> +test_expect_failure PERL 'delayed checkout correctly reports the number of updated entries' '

It is unfortunate that we depend on Perl only to run rot13-filter;
I'll leave a #leftoverbit label here to remind us to write a
"test-tool rot13-filter" someday.  No need to do so in this series.

> +	rm -rf repo &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
> +		git config filter.delay.required true &&
> +
> +		echo "*.a filter=delay" >.gitattributes &&
> +		echo a >test-delay10.a &&
> +		echo a >test-delay11.a &&
> +		git add . &&
> +		git commit -m files &&
> +
> +		rm *.a &&
> +		git checkout . 2>err &&
> +		grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delayed.log &&
> +		grep "IN: smudge test-delay11.a .* \\[DELAYED\\]" delayed.log &&
> +		grep "Updated 2 paths from the index" err
> +	)
> +'
> +
>  test_done
