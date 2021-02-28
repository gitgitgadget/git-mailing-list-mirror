Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13113C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C931464E01
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhB1Kee (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 05:34:34 -0500
Received: from [93.83.142.38] ([93.83.142.38]:38138 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhB1Keb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 05:34:31 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 98889321EB;
        Sun, 28 Feb 2021 11:34:09 +0100 (CET)
Subject: Re: [PATCH v3 20/35] userdiff tests: assert that new built-in drivers
 have tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-21-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <377d555c-6bd0-4206-3f71-d4d51aaca692@kdbg.org>
Date:   Sun, 28 Feb 2021 11:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224195129.4004-21-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 20:51 schrieb Ævar Arnfjörð Bjarmason:
> Add an assertion to the userdiff test framework to check that
> everything except a narrow whitelist of existing built-in patterns has
> tests.
> 
> Since this test framework was added we've added new patterns without
> any tests. Let's make it obvious in the future in the diff for such
> patches that they should have those tests.
> 
> For anything with tests we can skip the "does the pattern compile?"
> test, as the actual tests will check that for us.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4018-diff-funcname.sh | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index b80546b4d7f..a3058fda130 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -15,6 +15,19 @@ test_expect_success 'setup' '
>  	sort <builtin-drivers >builtin-drivers.sorted &&
>  	test_cmp builtin-drivers.sorted builtin-drivers &&
>  
> +	# Do not add anything to this list. New built-in drivers should have
> +	# tests
> +	cat >drivers-no-tests <<-\EOF &&
> +	ada
> +	bibtex
> +	csharp
> +	html
> +	objc
> +	pascal
> +	ruby
> +	tex
> +	EOF
> +
>  	# for regexp compilation tests
>  	echo A >A.java &&
>  	echo B >B.java
> @@ -22,7 +35,12 @@ test_expect_success 'setup' '
>  
>  for p in $(cat builtin-drivers)
>  do
> -	test_expect_success "builtin $p pattern compiles" '
> +	P=$(echo $p | tr 'a-z' 'A-Z')
> +	if grep -q $p drivers-no-tests
> +	then
> +		test_set_prereq NO_TEST_FOR_DRIVER_$P
> +	fi
> +	test_expect_success NO_TEST_FOR_DRIVER_$P "builtin $p pattern compiles" '
>  		echo "*.java diff=$p" >.gitattributes &&
>  		test_expect_code 1 git diff --no-index \
>  			A.java B.java 2>msg &&

Please drop this hunk. It is extremly distracting to see, e.g.,

ok 8 # skip builtin cpp pattern compiles (missing NO_TEST_FOR_DRIVER_CPP)
ok 9 - builtin cpp wordRegex pattern compiles

It says "NO_TEST_FOR_DRIVER_CPP", but I know we have tests. I have to
waste time to check that something not related to "we have tests for the
driver" is meant here. It may be just a matter of naming the
prerequisite, but I think we do not need this optimization.

> @@ -119,11 +137,17 @@ test_diff_funcname () {
>  	'
>  }
>  
> +>drivers-had-no-tests
>  for what in $diffpatterns
>  do
>  	test="$TEST_DIRECTORY/t4018/$what.sh"
>  	if ! test -e "$test"
>  	then
> +		git -C t4018 ls-files ':!*.sh' "$what*" >other-tests &&
> +		if ! test -s other-tests
> +		then
> +			echo $what >>drivers-had-no-tests
> +		fi
>  		continue
>  	fi &&
>  
> @@ -135,4 +159,8 @@ do
>  	. "$test"
>  done
>  
> +test_expect_success 'we should not have new built-in drivers without tests' '
> +	test_cmp drivers-no-tests drivers-had-no-tests
> +'
> +
>  test_done
> 

