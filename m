Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742E320D09
	for <e@80x24.org>; Sat, 27 May 2017 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750757AbdE0VYx (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 17:24:53 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:54306 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdE0VYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 17:24:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wZwxt4ZRfz5tlD;
        Sat, 27 May 2017 23:24:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5765F37A;
        Sat, 27 May 2017 23:24:49 +0200 (CEST)
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>, git@vger.kernel.org,
        bmwill@google.com, christian.couder@gmail.com, sbeller@google.com
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
 <83801d05-e3a9-b7e4-8f29-cd8172257dac@kdbg.org>
 <41781ba1-2284-cc5d-8736-bb87d580f5bf@ramsayjones.plus.com>
 <ef0b2850-ad3b-e33d-37b7-ece9a305a7a4@ramsayjones.plus.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4ba646ee-ca8a-f8c1-3ba2-2a108852c98e@kdbg.org>
Date:   Sat, 27 May 2017 23:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <ef0b2850-ad3b-e33d-37b7-ece9a305a7a4@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.2017 um 16:06 schrieb Ramsay Jones:
> To be more explicit, last Sunday I hacked into t7407 to show an
> example failure on cygwin (see patch below), but it passes on both
> Linux (expected) and cygwin! :( Perhaps you can see what I'm doing
> wrong?

As long as the git.exe you are using here is Cygwin's, Windows 
conventions do not apply. I think, the environment is transfered across 
the exec boundaries using Cygwin's own tools, and Windows's 
case-insensitive environment does not enter the game at all. But that's 
just a shot in the dark.

> 
> ATB,
> Ramsay Jones
> 
> -- >8 --
> Date: Sun, 21 May 2017 16:23:58 +0100
> Subject: [PATCH] submodule: foreach $path munging on cygwin
> 
> ---
>   t/t7407-submodule-foreach.sh | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6ba5daf42..c2d66bab7 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -68,17 +68,36 @@ Entering 'sub3'
>   $pwd/clone-foo3-sub3-$sub3sha1
>   EOF
>   
> +cat >expect-func <<EOF
> +Entering 'sub1'
> +running from TRASH
> +path is <<sub1>>
> +Entering 'sub3'
> +running from TRASH
> +path is <<sub3>>
> +EOF
> +
>   test_expect_success 'test basic "submodule foreach" usage' '
> +	PATH="$PWD:$PATH" &&
> +	write_script foreach-func <<-\EOF &&
> +	echo "running from TRASH"
> +	echo "path is <<$1>>"
> +	EOF
>   	git clone super clone &&
>   	(
>   		cd clone &&
>   		git submodule update --init -- sub1 sub3 &&
>   		git submodule foreach "echo \$toplevel-\$name-\$path-\$sha1" > ../actual &&
> +		git submodule foreach "foreach-func \$path" > ../actual-func1 &&
> +		git submodule foreach "export path; foreach-func \$path" > ../actual-func2 &&
>   		git config foo.bar zar &&
>   		git submodule foreach "git config --file \"\$toplevel/.git/config\" foo.bar"
>   	) &&
> +	test_i18ncmp expect-func actual-func1 &&
> +	test_i18ncmp expect-func actual-func2 &&
>   	test_i18ncmp expect actual
>   '
> +test_done
>   
>   cat >expect <<EOF
>   Entering '../sub1'
> 

