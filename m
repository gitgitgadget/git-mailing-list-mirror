Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C92F1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936325AbeF2BOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:14:37 -0400
Received: from avasout07.plus.net ([84.93.230.235]:60105 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935837AbeF2BOg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:14:36 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id Yhzef6OH4jlDzYhzffMRd4; Fri, 29 Jun 2018 02:14:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=fL9a29yD4FID4-bIHrsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/4] fsck: silence stderr when parsing .gitmodules
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <20180628220332.GA5128@sigill.intra.peff.net>
 <20180628220603.GD5524@sigill.intra.peff.net>
 <20180628221244.GA11462@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0859e051-d78c-6d6f-17e4-c2c513341eeb@ramsayjones.plus.com>
Date:   Fri, 29 Jun 2018 02:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628221244.GA11462@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFi3gGDfuSpMSZ4Pz2jfLoocWjJxVGrGbR5KNV0ZRSqHzGZ8RkSYe6E5Oe0AO4vUyFZmOgCwHNuAGvNGTGXyvwfopbhvgV7+x/uVioBMG3AFVmMK1xU5
 R+Np6T3ZImla7fdCEhuBK18CcCtoWfWoF1ELbalAKLQkSDc3KS3Fc7cU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/06/18 23:12, Jeff King wrote:
> On Thu, Jun 28, 2018 at 06:06:03PM -0400, Jeff King wrote:
> 
>> Note that we didn't test this case at all, so I've added
>> coverage in t7415. We may end up toning down or removing
>> this fsck check in the future. So take this test as checking
>> what happens now with a focus on stderr, and not any
>> ironclad guarantee that we must detect and report parse
>> failures in the future.
> 
> And such a patch _could_ look something like this. Though we could also
> perhaps leave it in place and tone it down to "ignore" by default.
> 
> There's another case that triggers gitmodulesParse, too, which is a blob
> so gigantic that we try not to hold it in memory. Technically that could
> also happen due to somebody using .gitmodules for something unrelated.
> But that seems even more far-fetched. And it _is_ dangerous to leave,
> because I think existing vulnerable clients will try to load a 500MB
> .gitmodules file in memory and parse it.

I also applied and tested the patch below. I think this patch
must be included in the series.

ATB,
Ramsay Jones

> ---
> diff --git a/fsck.c b/fsck.c
> index 87b0e228bd..296e8a8a7c 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -1013,11 +1013,9 @@ static int fsck_blob(struct blob *blob, const char *buf,
>  	data.options = options;
>  	data.ret = 0;
>  	config_opts.error_action = CONFIG_ERROR_SILENT;
> -	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
> -				".gitmodules", buf, size, &data, &config_opts))
> -		data.ret |= report(options, &blob->object,
> -				   FSCK_MSG_GITMODULES_PARSE,
> -				   "could not parse gitmodules blob");
> +	/* ignore errors */
> +	git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
> +			    ".gitmodules", buf, size, &data, &config_opts);
>  
>  	return data.ret;
>  }
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index ba8af785a5..9a7dae88a5 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -176,7 +176,7 @@ test_expect_success 'fsck detects non-blob .gitmodules' '
>  	)
>  '
>  
> -test_expect_success 'fsck detects corrupt .gitmodules' '
> +test_expect_success 'fsck does not complain about corrupt .gitmodules' '
>  	git init corrupt &&
>  	(
>  		cd corrupt &&
> @@ -185,9 +185,8 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
>  		git add .gitmodules &&
>  		git commit -m "broken gitmodules" &&
>  
> -		test_must_fail git fsck 2>output &&
> -		grep gitmodulesParse output &&
> -		test_i18ngrep ! "bad config" output
> +		git fsck 2>output &&
> +		! test -s output
>  	)
>  '
>  
> 
