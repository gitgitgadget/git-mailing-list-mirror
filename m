Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1191FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbcLSRYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:24:37 -0500
Received: from avasout05.plus.net ([84.93.230.250]:35262 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbcLSRYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:24:36 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id MtQZ1u0040srQBz01tQaFB; Mon, 19 Dec 2016 17:24:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=ZKOnoTzb c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=Snee-BRnNrnWHWtvWQkA:9
 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=Bn2pgwyD2vrAyMmN8A2t:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v1] t0021: fix flaky test
To:     larsxschneider@gmail.com, git@vger.kernel.org
References: <B3D96792-047D-4C91-8DCC-60C800B2861B@gmail.com>
 <20161218123748.72101-1-larsxschneider@gmail.com>
Cc:     peff@peff.net, gitster@pobox.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6e0ea8b0-181a-2ab6-5bab-4f8dfa1d76fa@ramsayjones.plus.com>
Date:   Mon, 19 Dec 2016 17:24:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161218123748.72101-1-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/12/16 12:37, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> t0021.15 creates files, adds them to the index, and commits them. All
> this usually happens in a test run within the same second and Git cannot
> know if the files have been changed between `add` and `commit`.  Thus,
> Git has to run the clean filter in both operations. Sometimes these
> invocations spread over two different seconds and Git can infer that the
> files were not changed between `add` and `commit` based on their
> modification timestamp. The test would fail as it expects the filter
> invocation. Remove this expectation to make the test stable.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> Notes:
>     Base Commit: f8bf8f2a7b (next)
>     Diff on Web: https://github.com/git/git/compare/f8bf8f2a7b...larsxschneider:9d88b66e03
>     Checkout:    git fetch https://github.com/larsxschneider/git filter-process/fix-flaky-test-v1 && git checkout 9d88b66e03
> 
>  t/t0021-conversion.sh | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 6f16983d3e..161f560446 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -377,22 +377,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  		EOF
>  		test_cmp_count expected.log rot13-filter.log &&
>  
> -		filter_git commit -m "test commit 2" &&
> -		cat >expected.log <<-EOF &&
> -			START
> -			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> -			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
> -			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> -			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
> -			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
> -			STOP
> -		EOF
> -		test_cmp_count expected.log rot13-filter.log &&
> -
> +		git commit -m "test commit 2" &&
>  		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
>  
>  		filter_git checkout --quiet --no-progress . &&
> 

I applied this to the pu branch and ran the test by hand
48 times in a row without failure. (the most trials without
error beforehand was 24).

Thanks.

ATB,
Ramsay Jones


