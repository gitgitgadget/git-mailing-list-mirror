Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D98C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F6064E55
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhB1LNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:13:30 -0500
Received: from [93.83.142.38] ([93.83.142.38]:38238 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230468AbhB1LNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:13:20 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 5763E321F6;
        Sun, 28 Feb 2021 12:12:59 +0100 (CET)
Subject: Re: [PATCH v3 14/35] userdiff tests: add alternative hunk header test
 infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-15-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d3ee44f3-e7d7-e9a9-8fde-1bd48323c150@kdbg.org>
Date:   Sun, 28 Feb 2021 12:12:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-15-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 8a8a7a99c88..6fd3dce1364 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -87,7 +87,7 @@ last_diff_context_line () {
>  }
>  
>  # check each individual file
> -for i in $(git -C t4018 ls-files)
> +for i in $(git -C t4018 ls-files -- ':!*.sh')
>  do
>  	test_expect_success "setup hunk header: $i" "
>  		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
> @@ -106,4 +106,40 @@ do
>  	"
>  done
>  
> +test_diff_funcname () {
> +	desc=$1
> +	cat <&8 >arg.header &&
> +	cat <&9 >arg.test &&
> +	what=$(cat arg.what) &&
> +
> +	test_expect_success "setup: $desc" '
> +		cp arg.test "$what" &&
> +		cp arg.header expected &&
> +		git add "$what" &&
> +		do_change_me "$what"
> +	' &&

I think we should not chain test_expect_success with && because when one
of the tests early in the chain fails, test case numbers are shifted
compared to when all tests succeed. I don't know, though, whether that
is an important thing (or a thing at all).

> +
> +	test_expect_success "$desc" '
> +		git diff -U1 "$what" >diff &&
> +		last_diff_context_line diff >actual &&
> +		test_cmp expected actual
> +	'
> +}
> +
> +for what in $diffpatterns
> +do
> +	test="$TEST_DIRECTORY/t4018/$what.sh"
> +	if ! test -e "$test"
> +	then
> +		continue
> +	fi &&
> +
> +	test_expect_success "setup: hunk header for $what" '
> +		echo "$what diff=$what" >.gitattributes &&
> +		echo "$what" >arg.what
> +	' &&

Same here. And when this is removed, the && just above is not needed
anymore, either.

> +
> +	. "$test"
> +done
> +
>  test_done

-- Hannes
