Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582C8215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 19:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756598AbeD3Tcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 15:32:47 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50033 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756590AbeD3Tcq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 15:32:46 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40ZZSX5c2tz5tlD;
        Mon, 30 Apr 2018 21:32:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3456A1C94;
        Mon, 30 Apr 2018 21:32:44 +0200 (CEST)
Subject: Re: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
 <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7087f0b9-1362-f8ca-315d-96d27b91b26b@kdbg.org>
Date:   Mon, 30 Apr 2018 21:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2018 um 00:17 schrieb Johannes Schindelin:
> t1406 specifically verifies that certain code paths fail with a BUG: ...
> message.
> 
> In the upcoming commit, we will convert that message to be generated via
> BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
> regular exit code.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/t1406-submodule-ref-store.sh | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
> index e093782cc37..0ea3457cae3 100755
> --- a/t/t1406-submodule-ref-store.sh
> +++ b/t/t1406-submodule-ref-store.sh
> @@ -16,7 +16,7 @@ test_expect_success 'setup' '
>   '
>   
>   test_expect_success 'pack_refs() not allowed' '
> -	test_must_fail $RUN pack-refs 3
> +	test_must_fail ok=sigabrt $RUN pack-refs 3
>   '
>   
>   test_expect_success 'peel_ref(new-tag)' '
> @@ -27,15 +27,18 @@ test_expect_success 'peel_ref(new-tag)' '
>   '
>   
>   test_expect_success 'create_symref() not allowed' '
> -	test_must_fail $RUN create-symref FOO refs/heads/master nothing
> +	test_must_fail ok=sigabrt \
> +		$RUN create-symref FOO refs/heads/master nothing
>   '
>   
>   test_expect_success 'delete_refs() not allowed' '
> -	test_must_fail $RUN delete-refs 0 nothing FOO refs/tags/new-tag
> +	test_must_fail ok=sigabrt \
> +		$RUN delete-refs 0 nothing FOO refs/tags/new-tag
>   '
>   
>   test_expect_success 'rename_refs() not allowed' '
> -	test_must_fail $RUN rename-ref refs/heads/master refs/heads/new-master
> +	test_must_fail ok=sigabrt \
> +		$RUN rename-ref refs/heads/master refs/heads/new-master
>   '
>   
>   test_expect_success 'for_each_ref(refs/heads/)' '
> @@ -91,11 +94,11 @@ test_expect_success 'reflog_exists(HEAD)' '
>   '
>   
>   test_expect_success 'delete_reflog() not allowed' '
> -	test_must_fail $RUN delete-reflog HEAD
> +	test_must_fail ok=sigabrt $RUN delete-reflog HEAD
>   '
>   
>   test_expect_success 'create-reflog() not allowed' '
> -	test_must_fail $RUN create-reflog HEAD 1
> +	test_must_fail ok=sigabrt $RUN create-reflog HEAD 1
>   '

I can't quite follow the rationale for this change. A 'BUG' error exit 
must never be reached, otherwise it is a bug in the program by 
definition. It cannot be OK that SIGABRT is a valid result from Git.

If SIGABRT occurs as a result of BUG(), and we know that this happens 
for certain cases, it means we have an unfixed bug. Should then not run 
these cases under test_expect_failure instead of test_expect_success to 
identify them as known bugs?

Confused.

-- Hannes
