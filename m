Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8636C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A521220716
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfLQUYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:24:06 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:12344 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfLQUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:24:06 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47cqNb2Q2Vz5tlB;
        Tue, 17 Dec 2019 21:23:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9F670230;
        Tue, 17 Dec 2019 21:23:57 +0100 (CET)
Subject: Re: [PATCH 03/15] t0000: replace test_must_fail with ! for
 run_sub_test_lib_test()
To:     Denton Liu <liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
 <fcfccebd7aaf120674691ba92a657802c2482d7e.1576583819.git.liu.denton@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <de3d194a-bb05-8049-673b-267f53a271d6@kdbg.org>
Date:   Tue, 17 Dec 2019 21:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <fcfccebd7aaf120674691ba92a657802c2482d7e.1576583819.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.19 um 13:01 schrieb Denton Liu:
> The test_must_fail function should only be used for git commands since
> we should assume that external commands work sanely. We use
> test_must_fail to test run_sub_test_lib_test() but that function does
> not invoke any git commands internally. Replace these instances of
> `test_must_fail` with `!`.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t0000-basic.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 8a81a249d0..d60ad4b78b 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -155,7 +155,7 @@ test_expect_success 'pretend we have a fully passing test suite' "
>  "
>  
>  test_expect_success 'pretend we have a partially passing test suite' "
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		partial-pass '2/3 tests passing' <<-\\EOF &&

It is a very uncommon situation (read: I doubt that it ever occurs) in
our test suite that we expect a shell function to fail, but that we do
*not* care at all which of its sub-commands actually failed. We actually
do care which sub-command failed. Therefore, we have, e.g., the idiom
"test_i18n_grep ! ...". And in fact, in the case of
run_sub_test_lib_test we have the form run_sub_test_lib_test_err to
check for error exit in the subordinate test. All of the cases you
change here should use it.

>  	test_expect_success 'passing test #1' 'true'
>  	test_expect_success 'failing test #2' 'false'
> @@ -219,7 +219,7 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
>  "
>  
>  test_expect_success 'pretend we have a pass, fail, and known breakage' "
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		mixed-results1 'mixed results #1' <<-\\EOF &&
>  	test_expect_success 'passing test' 'true'
>  	test_expect_success 'failing test' 'false'
> @@ -238,7 +238,7 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' "
>  "
>  
>  test_expect_success 'pretend we have a mix of all possible results' "
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		mixed-results2 'mixed results #2' <<-\\EOF &&
>  	test_expect_success 'passing test' 'true'
>  	test_expect_success 'passing test' 'true'
> @@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
>  "
>  
>  test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		t1234-verbose "test verbose" --verbose <<-\EOF &&
>  	test_expect_success "passing test" true
>  	test_expect_success "test with output" "echo foo"
> @@ -301,7 +301,7 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
>  '
>  
>  test_expect_success 'test --verbose-only' '
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		t2345-verbose-only-2 "test verbose-only=2" \
>  		--verbose-only=2 <<-\EOF &&
>  	test_expect_success "passing test" true
> @@ -834,7 +834,7 @@ then
>  fi
>  
>  test_expect_success 'tests clean up even on failures' "
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
>  	test_expect_success 'tests clean up even after a failure' '
>  		touch clean-after-failure &&
> @@ -863,7 +863,7 @@ test_expect_success 'tests clean up even on failures' "
>  "
>  
>  test_expect_success 'test_atexit is run' "
> -	test_must_fail run_sub_test_lib_test \
> +	! run_sub_test_lib_test \
>  		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
>  	test_expect_success 'tests clean up even after a failure' '
>  		> ../../clean-atexit &&
> 

-- Hannes
