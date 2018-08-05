Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5F01F597
	for <e@80x24.org>; Sun,  5 Aug 2018 08:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeHEKib (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 06:38:31 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:64052 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeHEKib (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 06:38:31 -0400
Received: from [192.168.1.181] (unknown [185.39.175.185])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41jvGT6vxWz5tlK;
        Sun,  5 Aug 2018 10:34:41 +0200 (CEST)
Subject: Re: [PATCH v2] t/test-lib: make `test_dir_is_empty` more robust
To:     William Chargin <wchargin@gmail.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
References: <20180805033629.GH258270@aiede.svl.corp.google.com>
 <20180805042031.20447-1-wchargin@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ae85fef4-19f6-39a8-e680-3d08e74ecd5e@kdbg.org>
Date:   Sun, 5 Aug 2018 10:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805042031.20447-1-wchargin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.08.2018 um 06:20 schrieb William Chargin:
> While the `test_dir_is_empty` function appears correct in most normal
> use cases, it can fail when filenames contain newlines. This patch
> changes the implementation to use `ls -A`, which is specified by POSIX.
> The output should be empty exactly if the directory is empty.
> 
> The newly added unit test fails before this change and passes after it.
> 
> Signed-off-by: William Chargin <wchargin@gmail.com>
> ---
> 
> I originally wrote this patch for the standalone Sharness library, but
> that library advises that such patches be sent to the Git mailing list
> first.
> 
>   t/t0000-basic.sh        | 29 +++++++++++++++++++++++++++++
>   t/test-lib-functions.sh |  2 +-
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 34859fe4a..3885b26f9 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failures' "
>   	EOF
>   "
>   
> +test_expect_success 'test_dir_is_empty behaves even in pathological cases' "
> +	run_sub_test_lib_test \
> +		dir-empty 'behavior of test_dir_is_empty' <<-\\EOF &&
> +	test_expect_success 'should pass with actually empty directory' '
> +		mkdir empty_dir &&
> +		test_dir_is_empty empty_dir
> +	'
> +	test_expect_success 'should fail with a normal filename' '
> +		mkdir nonempty_dir &&
> +		touch nonempty_dir/some_file &&
> +		test_must_fail test_dir_is_empty nonempty_dir
> +	'
> +	test_expect_success 'should fail with dot-newline-dot filename' '
> +		mkdir pathological_dir &&
> +		printf \"pathological_dir/.\\\\n.\\\\0\" | xargs -0 touch &&
> +		test_must_fail test_dir_is_empty pathological_dir
> +	'
> +	test_done
> +	EOF
> +	check_sub_test_lib_test dir-empty <<-\\EOF
> +	> ok 1 - should pass with actually empty directory
> +	> ok 2 - should fail with a normal filename
> +	> ok 3 - should fail with dot-newline-dot filename
> +	> # passed all 3 test(s)
> +	> 1..3
> +	EOF
> +"
> +
> +
>   ################################################################
>   # Basics of the basics
>   
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 2b2181dca..f7ff28ef6 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -568,7 +568,7 @@ test_path_is_dir () {
>   # Check if the directory exists and is empty as expected, barf otherwise.
>   test_dir_is_empty () {
>   	test_path_is_dir "$1" &&
> -	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> +	if test "$(ls -A1 "$1" | wc -c)" != 0
>   	then
>   		echo "Directory '$1' is not empty, it contains:"
>   		ls -la "$1"
> 

Did you accidentally resend the same patch in this v2? I can't spot the 
difference to v1.

-- Hannes
