Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995161F406
	for <e@80x24.org>; Sun, 24 Dec 2017 09:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdLXJZA (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 04:25:00 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:62989 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdLXJY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 04:24:56 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z4Gzp04R5z5tlC;
        Sun, 24 Dec 2017 10:24:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3173141E2;
        Sun, 24 Dec 2017 10:24:53 +0100 (CET)
Subject: Re: [PATCH 6/6] wildmatch test: create & test files on disk in
 addition to in-memory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>
References: <20171223213012.1962-1-avarab@gmail.com>
 <20171223213012.1962-7-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8f4cdb23-8e2e-144a-1f70-99776b027166@kdbg.org>
Date:   Sun, 24 Dec 2017 10:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171223213012.1962-7-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.12.2017 um 22:30 schrieb Ævar Arnfjörð Bjarmason:
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   a[]b                 |   0
>   t/t3070-wildmatch.sh | 336 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 319 insertions(+), 17 deletions(-)
>   create mode 100644 a[]b
> 
> diff --git a/a[]b b/a[]b
> new file mode 100644
> index 0000000000..e69de29bb2

A big no-no! This file can't be created on Windows!

> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index 47b479e423..d423bb01f3 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -4,31 +4,146 @@ test_description='wildmatch tests'
>   
>   . ./test-lib.sh
>   
> +create_test_file() {
> +	file=$1
> +
> +	# `touch .` will succeed but obviously not do what we intend
> +	# here.
> +	test "$file" = "." && return 1
> +	# We cannot create a file with an empty filename.
> +	test "$file" = "" && return 1
> +	# The tests that are testing that e.g. foo//bar is matched by
> +	# foo/*/bar can't be tested on filesystems since there's no
> +	# way we're getting a double slash.
> +	echo "$file" | grep -q -F '//' && return 1
> +	# When testing the difference between foo/bar and foo/bar/ we
> +	# can't test the latter.
> +	echo "$file" | grep -q -E '/$' && return 1
> +
> +	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')

Booh! Booh! So many fork()s! ;)

	case "$file" in
	*//*)
		# The tests that are testing that e.g. foo//bar is matched by
		# foo/*/bar can't be tested on filesystems since there's no
		# way we're getting a double slash.
		return 1;;
	*/)
		# When testing the difference between foo/bar and foo/bar/ we
		# can't test the latter.
		return 1;;
	esac

	dirs=${file%/*}

> +
> +	# We touch "./$file" instead of "$file" because even an
> +	# escaped "touch -- -" means something different.
> +	if test "$file" != "$dirs"
> +	then
> +		mkdir -p -- "$dirs" 2>/dev/null &&
> +		touch -- "./$file" 2>/dev/null &&
> +		return 0
> +	else
> +		touch -- "./$file" 2>/dev/null &&
> +		return 0
> +	fi
> +	return 1
> +}
> +
>   wildtest() {
> -	match_w_glob=$1
> -	match_w_globi=$2
> -	match_w_pathmatch=$3
> -	match_w_pathmatchi=$4
> -	text=$5
> -	pattern=$6
> +	if test "$#" = 6
> +	then
> +		# When test-wildmatch and git ls-files produce the same
> +		# result.
> +		match_w_glob=$1
> +		match_f_w_glob=$match_w_glob
> +		match_w_globi=$2
> +		match_f_w_globi=$match_w_globi
> +		match_w_pathmatch=$3
> +		match_f_w_pathmatch=$match_w_pathmatch
> +		match_w_pathmatchi=$4
> +		match_f_w_pathmatchi=$match_w_pathmatchi
> +		text=$5
> +		pattern=$6
> +	elif test "$#" = 10
> +	then
> +		match_w_glob=$1
> +		match_w_globi=$2
> +		match_w_pathmatch=$3
> +		match_w_pathmatchi=$4
> +		match_f_w_glob=$5
> +		match_f_w_globi=$6
> +		match_f_w_pathmatch=$7
> +		match_f_w_pathmatchi=$8
> +		text=$9
> +		pattern=$10
> +	fi
>   
> +	# $1: Case sensitive glob match: test-wildmatch
>   	if test "$match_w_glob" = 1
>   	then
> -		test_expect_success "wildmatch:     match '$text' '$pattern'" "
> +		test_expect_success "wildmatch: match '$text' '$pattern'" "
>   			test-wildmatch wildmatch '$text' '$pattern'
>   		"
>   	elif test "$match_w_glob" = 0
>   	then
> -		test_expect_success "wildmatch:  no match '$text' '$pattern'" "
> +		test_expect_success "wildmatch: no match '$text' '$pattern'" "
>   			! test-wildmatch wildmatch '$text' '$pattern'
>   		"
>   	else
>   		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_glob" 'false'

I think you can write this as 'say ...; exit 1'. See t0000*.

>   	fi
>   
> +	# $1: Case sensitive glob match: ls-files
> +	if test "$match_f_w_glob" = 'E'
> +	then
> +		if create_test_file "$text"
> +		then
> +			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
> +				test_when_finished \"
> +					rm -rf -- * &&

Can we be a bit more careful with this rm -rf, please?
There is only one similarly loose case in t/t7003-filter-branch.sh,
and it is outside test_when_finished, i.e., it is well under control;
this instance here inside test_when_finished is not.

> +					git reset
> +				\" &&
> +				git add -A &&
> +				>expect.err &&
> +				printf '%s' '$text' >expect &&
> +				test_must_fail git --glob-pathspecs ls-files -z -- '$pattern'
> +			"
> +		else
> +			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
> +		fi
> +	elif test "$match_f_w_glob" = 1
> +	then
> +		if create_test_file "$text"
> +		then
> +			test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
> +				test_when_finished \"
> +					rm -rf -- * &&
> +					git reset
> +				\" &&
> +				git add -A &&
> +				>expect.err &&
> +				printf '%s' '$text' >expect &&

There are no single-quotes in any $text instances, right?

> +				git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&

If possible, do not put git commands in the upstream of a pipe.
It does not detect failures.

Unfortunately, printf '%s\0' foo is not portable. If it were,
you could omit the tr invocation alltogether.

> +				test_cmp expect.err actual.err &&
> +				test_cmp expect actual
> +			"
> +		else
> +			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
> +		fi

-- Hannes
