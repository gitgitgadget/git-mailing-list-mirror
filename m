Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133391F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfAHV12 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:27:28 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:58086 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729686AbfAHV11 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:27:27 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43Z5233kKrz5tlB;
        Tue,  8 Jan 2019 22:27:23 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D2AF0249;
        Tue,  8 Jan 2019 22:27:22 +0100 (CET)
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
To:     "Stephen P . Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-4-ischis2@cox.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a8a586d9-dad7-606f-948c-06725ac3e062@kdbg.org>
Date:   Tue, 8 Jan 2019 22:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181231003150.8031-4-ischis2@cox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.12.18 um 01:31 schrieb Stephen P. Smith:
> +check_human_date () {
> +	time=$1
> +	expect=$2
> +	test_expect_success "check date ($format:$time)" '
> +		echo "$time -> $expect" >expect &&
> +		TZ=${zone:-$TZ} test-tool date show:"$format" "$time" >actual &&
> +		grep "$expect" actual
> +	'
> +}
> +
>   # arbitrary but sensible time for examples
>   TIME='1466000000 +0200'
>   check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
> @@ -52,6 +62,20 @@ check_show unix "$TIME" '1466000000'
>   check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
>   check_show raw-local "$TIME" '1466000000 +0000'
>   check_show unix-local "$TIME" '1466000000'
> +check_show human "$TIME" 'Jun 15 2016'
> +
> +# Subtract some known constant time and look for expected field format
> +TODAY_REGEX='5 hours ago'
> +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
> +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
> +check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
> +check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
> +check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
> +check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
> +check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
> +check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
> +check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
> +check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
>   
>   check_show 'format:%z' "$TIME" '+0200'
>   check_show 'format-local:%z' "$TIME" '+0000'
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 819c24d10e..d7f3b73650 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1707,4 +1707,28 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
>   	test_must_fail git log --exclude-promisor-objects source-a
>   '
>   
> +check_human_date() {
> +	commit_date=$1
> +	expect=$2
> +	test_expect_success "$commit_date" "
> +		echo $expect $commit_date >dates &&
> +		git add dates &&
> +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> +		git log -1 --date=human | grep \"^Date:\" >actual &&
> +		grep \"$expect\" actual
> +"
> +}
> +
> +TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
> +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
> +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
> +check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
> +check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
> +check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
> +check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
> +check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
> +check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
> +check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
> +check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
> +
>   test_done
> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index 42d3db6246..0a0334a8b5 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -128,4 +128,29 @@ test_expect_success 'show --graph is forbidden' '
>     test_must_fail git show --graph HEAD
>   '
>   
> +check_human_date() {
> +	commit_date=$1
> +	expect=$2
> +	test_expect_success "$commit_date" "
> +		echo $expect $commit_date >dates &&
> +		git add dates &&
> +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> +		git show --date=human | grep \"^Date:\" >actual &&
> +		grep \"$expect\" actual
> +"
> +}
> +
> +TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
> +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
> +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
> +check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
> +check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
> +check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
> +check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
> +check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
> +check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
> +check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
> +check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago

The $...REGEX expansions must be put in double-quotes to protect them 
from field splitting. But then the tests do not pass anymore (I tested 
only t4202). Please revisit this change.

-- Hannes
