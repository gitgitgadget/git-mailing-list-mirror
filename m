Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287271F406
	for <e@80x24.org>; Tue,  9 Jan 2018 23:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbeAIXBA (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 18:01:00 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:51759 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeAIXA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 18:00:59 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zGSL23Cp9z5tlB;
        Wed, 10 Jan 2018 00:00:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B2014F9B;
        Wed, 10 Jan 2018 00:00:57 +0100 (CET)
Subject: Re: [PATCH] Prototype PATH_MAX length detection in tests,
 demonstrated in t0001-init.sh
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <f08a9506afb73c57751d3d413bfb433a.squirrel@secure.elehost.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <47197839-720f-3c8d-729c-3fcb615aeb36@kdbg.org>
Date:   Wed, 10 Jan 2018 00:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <f08a9506afb73c57751d3d413bfb433a.squirrel@secure.elehost.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.01.2018 um 19:12 schrieb Randall S. Becker:
> This patch create a configuration variable PATH_MAX that
> corresponds with the value in limits.h. The value of PATH_MAX,
> if supplied, is added to BASIC_CFLAGS and will validate with
> limits.h. PATH_MAX is also added to GIT-BUILD-OPTIONS and is
> available in the git test suite.
> 
> This patch also creates a test_expected_success_cond, taking a
> single function as first argument. In the t0001-init.sh case,
> subtest 34 this function is test_path_max_is_sane, although any
> 0/1 returning function can be used. The prototype allows the long base
> path test to be skipped if PATH_MAX is less than 2048 bytes.

OK, but...

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index c4814d2..58dad87 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -315,7 +315,7 @@ test_expect_success 'init with separate gitdir' '
>   	test_path_is_dir realgitdir/refs
>   '
> 
> -test_expect_success 'init in long base path' '
> +test_expect_success_cond 'test_path_max_is_sane' 'init in long base path' '
>   	# exceed initial buffer size of strbuf_getcwd()
>   	component=123456789abcdef &&
>   	test_when_finished "chmod 0700 $component; rm -rf $component" &&

... why would you want to skip this test? If I'm reading the test case 
correctly, it requires only a path length of 127 plus whatever your 
build directory is plus a score for the trash directory. That should 
pose a problem only if your system is even more crippled than Windows 
with its PATH_MAX of 260.

> +test_path_max_is_sane() {
> +	if test -z "$PATH_MAX"
> +	then
> +		retval=1
> +	elif test $PATH_MAX -ge 2048
> +	then
> +		retval=1
> +	else
> +		retval=0
> +	fi
> +	return "$retval"
> +}

This can probably be reduced to

test_path_max_is_sane () {
	test "${PATH_MAX:-4000}" -ge 2048
}

(Style note: we have a blank before the () pair in shell scripts.)

-- Hannes
