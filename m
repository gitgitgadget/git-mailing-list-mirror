Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8D920987
	for <e@80x24.org>; Fri,  7 Oct 2016 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941320AbcJGRQp (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 13:16:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59467 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbcJGRQn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 13:16:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3srGQd1MkVz5tlC;
        Fri,  7 Oct 2016 19:16:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AFEF05326;
        Fri,  7 Oct 2016 19:16:40 +0200 (CEST)
Subject: Re: [PATCH 4/4] mergetool: honor -O<order-file>
To:     David Aguilar <davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
 <1475797679-32712-4-git-send-email-davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Luis Gutierrez <luisgutz@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8f99b183-7f9b-f577-42eb-9ff7398ffbd1@kdbg.org>
Date:   Fri, 7 Oct 2016 19:16:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1475797679-32712-4-git-send-email-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2016 um 01:47 schrieb David Aguilar:
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 65696d8..9dca58b 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -9,7 +9,7 @@
>  # at the discretion of Junio C Hamano.
>  #
>
> -USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [file to merge] ...'
> +USAGE='[--tool=tool] [--tool-help] [-y|--no-prompt|--prompt] [-O<order-file>] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
>  NONGIT_OK=Yes
>  OPTIONS_SPEC=
> @@ -390,6 +390,7 @@ print_noop_and_exit () {
>  main () {
>  	prompt=$(git config --bool mergetool.prompt)
>  	guessed_merge_tool=false
> +	order_file=
>
>  	while test $# != 0
>  	do
> @@ -419,6 +420,9 @@ main () {
>  		--prompt)
>  			prompt=true
>  			;;
> +		-O*)
> +			order_file="$1"
> +			;;
>  		--)
>  			shift
>  			break
> @@ -459,8 +463,14 @@ main () {
>  		fi
>  	fi
>
> +	if test -n "$order_file"
> +	then
> +		set -- "$order_file" -- "$@"
> +	else
> +		set -- -- "$@"
> +	fi
>  	files=$(git -c core.quotePath=false \
> -		diff --name-only --diff-filter=U -- "$@")
> +		diff --name-only --diff-filter=U "$@")

You can write this as

	files=$(git -c core.quotePath=false \
		diff --name-only --diff-filter=U \
		${order_file:+"$order_file"} -- "$@")

without the case distinction earlier. This construct is usually used to 
attach the option (-O) in front of the argument, but it is already 
included in the value; so, we use the construct only to avoid an empty 
argument when the option is unset and to get a quoted string when it is set.

>
>  	cd_to_toplevel
>
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index fb2aeef..0f9869a 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -637,6 +637,33 @@ test_expect_success 'diff.orderFile configuration is honored' '
>  	test_cmp expect actual &&
>  	git reset --hard >/dev/null
>  '
> +
> +test_expect_success 'mergetool -Oorder-file is honored' '
> +	test_config diff.orderFile order-file &&
> +	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
> +	test_config mergetool.myecho.trustExitCode true &&
> +	test_must_fail git merge order-file-side1 &&
> +	cat >expect <<-\EOF &&
> +		Merging:
> +		a
> +		b
> +	EOF
> +	git mergetool -O/dev/null --no-prompt --tool myecho |
> +	grep -A 2 Merging: >actual &&
> +	test_cmp expect actual &&
> +	git reset --hard >/dev/null 2>&1 &&
> +
> +	git config --unset diff.orderFile &&
> +	test_must_fail git merge order-file-side1 &&
> +	cat >expect <<-\EOF &&
> +		Merging:
> +		b
> +		a
> +	EOF
> +	git mergetool -Oorder-file --no-prompt --tool myecho |
> +	grep -A 2 Merging: >actual &&

grep -A again. Furthermore, you call git mergetool in the upstream of a 
pipe. This will ignore the exit status.

> +	test_cmp expect actual &&
> +	git reset --hard >/dev/null 2>&1
>  '

Ah, the earlier lone quote should have been added in this patch.

-- Hannes

