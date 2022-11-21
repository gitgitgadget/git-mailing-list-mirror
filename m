Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E9BC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKURtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 12:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKURtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 12:49:14 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53496D02CB
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 09:49:12 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4NGFJ30SX0z5tl9;
        Mon, 21 Nov 2022 18:49:06 +0100 (CET)
Message-ID: <f0411dd9-bccb-b5d3-ed51-59be6b627a30@kdbg.org>
Date:   Mon, 21 Nov 2022 18:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local> <xmqqv8nbkg77.fsf@gitster.g>
 <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
 <f5d6c063-2fc4-4355-57e1-056eac1fb4a2@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f5d6c063-2fc4-4355-57e1-056eac1fb4a2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.22 um 18:50 schrieb René Scharfe:
> And with the following patch on top of eea7033409 (The twelfth batch,
> 2022-11-14) the test suite passes for me -- just one case of grep
> stealing CRs seems to need adjustment to make mingw_test_cmp
> unnecessary:

Wow, nice catch! Just let enough time pass, and a liability such as
mingw_test_cmp becomes obsolete by mere magic. ;)

> 
>  t/t3920-crlf-messages.sh | 2 +-
>  t/test-lib.sh            | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 4c661d4d54..353b1a550e 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt || true &&

This || true looks suspicious. I'll submit a patch in a new thread.

>  	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
>  	test_tick &&
>  	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 6db377f68b..af5ec357e5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1721,7 +1721,6 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=mingw_test_cmp
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM

