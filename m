Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F42E1F40E
	for <e@80x24.org>; Tue, 15 Nov 2016 07:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbcKOHDc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 02:03:32 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:46736 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbcKOHD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 02:03:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tHyz16t2xz5tlj;
        Tue, 15 Nov 2016 08:03:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 15E4539C;
        Tue, 15 Nov 2016 08:03:25 +0100 (CET)
Subject: Re: [PATCH 1/2] push: --dry-run updates submodules when
 --recurse-submodules=on-demand
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479172735-698-2-git-send-email-bmwill@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4a72ad14-0a8f-ede9-9f54-601fcd37740b@kdbg.org>
Date:   Tue, 15 Nov 2016 08:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1479172735-698-2-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.2016 um 02:18 schrieb Brandon Williams:
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 198ce84..e6ccc30 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -427,7 +427,31 @@ test_expect_success 'push unpushable submodule recursively fails' '
>  		cd submodule.git &&
>  		git rev-parse master >../actual
>  	) &&
> -	test_cmp expected actual
> +	test_cmp expected actual &&
> +	git -C work reset --hard master^

This line looks like a clean-up to be done after the test case. You 
should wrap it in test_when_finished, but outside of a sub-shell, which 
looks like it's just one line earlier, before the test_cmp.

> +'
> +
> +test_expect_failure 'push --dry-run does not recursively update submodules' '
> +	(
> +		cd work &&
> +		(
> +			cd gar/bage &&
> +			git checkout master &&
> +			git rev-parse master >../../../expected_submodule &&
> +			> junk9 &&
> +			git add junk9 &&
> +			git commit -m "Ninth junk"
> +		) &&

Could you please avoid this nested sub-shell? It is fine to cd around 
when you are in a sub-shell.

> +		git checkout master &&
> +		git rev-parse master >../expected_pub

Broken && chain.

> +		git add gar/bage &&
> +		git commit -m "Ninth commit for gar/bage" &&
> +		git push --dry-run --recurse-submodules=on-demand ../pub.git master
> +	) &&
> +	git -C submodule.git rev-parse master >actual_submodule &&
> +	git -C pub.git rev-parse master >actual_pub &&

All of the commands above are 'git something' that could become 'git -C 
work something' and then the sub-shell would be unnecessary. I'm not 
sure I would appreciate the verbosity of the result, though. (Perhaps 
aligning the git subcommands after -C foo would help.)

> +	test_cmp expected_pub actual_pub &&
> +	test_cmp expected_submodule actual_submodule
>  '
>
>  test_done
>

