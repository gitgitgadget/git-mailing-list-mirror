Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8570AC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4306E64E13
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBOTKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:10:00 -0500
Received: from [93.83.142.38] ([93.83.142.38]:47472 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229925AbhBOTJv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 14:09:51 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id EA3C61B281;
        Mon, 15 Feb 2021 20:09:29 +0100 (CET)
Subject: Re: [PATCH v2 23/27] userdiff tests: test hunk header selection with
 -U0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-24-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d0dfc18a-1f22-f4f1-bf99-6dc829f3cf04@kdbg.org>
Date:   Mon, 15 Feb 2021 20:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215154427.32693-24-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:44 schrieb Ævar Arnfjörð Bjarmason:
> The userdiff tests have used a custom -U1 context since
> f12c66b9bb (userdiff/perl: anchor "sub" and "package" patterns on the
> left, 2011-05-21). Changing it to -U0 doesn't change the results for
> any of the tests, except one.
> 
> Let's test for this case explicitly. I.e. that we go "beyond" the
> selected context to find our hunk header. In many cases the desired
> hunk header is part of the diff itself under -U1.

Is this intended as a sanity check of test cases? (Otherwise, I see only 
that we are running two diffs instead of just one against every test 
case, but not which problem this is solving.)

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t4018-diff-funcname.sh | 13 +++++++++++++
>   t/t4018/custom.sh        |  1 +
>   2 files changed, 14 insertions(+)
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 8b4500037f..d41aed9ba2 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -57,6 +57,7 @@ test_diff_funcname () {
>   	cat <&8 >arg.header &&
>   	cat <&9 >arg.test &&
>   	what=$(cat arg.what) &&
> +	arg_diff_U0=$2 &&
>   
>   	test_expect_success "setup: $desc" '
>   		cp arg.test "$what" &&
> @@ -78,6 +79,18 @@ test_diff_funcname () {
>   		test_cmp expected actual
>   	' &&
>   
> +	test_expect_success "$desc -U0" '
> +		git diff -U0 "$what" >diff &&
> +		last_diff_context_line diff >actual &&
> +		if test -n "$arg_diff_U0"
> +		then
> +			echo "$arg_diff_U0" >new-expected &&
> +			test_cmp new-expected actual
> +		else
> +			test_cmp expected actual
> +		fi
> +	' &&
> +
>   	test_expect_success "$desc (accumulated)" '
>   		git diff -U1 "$what".acc >diff &&
>   		last_diff_context_line diff >actual.lines &&
> diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
> index 886de9cddb..a090f7bfc2 100755
> --- a/t/t4018/custom.sh
> +++ b/t/t4018/custom.sh
> @@ -10,6 +10,7 @@ test_expect_success 'custom: setup non-trivial custom' '
>   '
>   
>   test_diff_funcname 'custom: non-trivial custom pattern' \
> +	'System.out.print(x + " bottles of beer on the wall "' \
>   	8<<\EOF_HUNK 9<<\EOF_TEST
>   int special, RIGHT;
>   EOF_HUNK
> 

-- Hannes
