Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF2AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5464661369
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGMSG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:06:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:11065 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGMSG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:06:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BF5093F40DA;
        Tue, 13 Jul 2021 14:04:06 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F173E3F4047;
        Tue, 13 Jul 2021 14:04:05 -0400 (EDT)
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fae8cdcd-8222-b253-f656-d9f5b76de001@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 14:04:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 10:47 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Change p7519 to use a single "test-tool touch" command to update
> the mtime on a series of (thousands) files instead of invoking
> thousands of commands to update a single file.
> 
> This is primarily for Windows where process creation is so
> very slow and reduces the test run time by minutes.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>   t/perf/p7519-fsmonitor.sh | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 5eb5044a103..f74e6014a0a 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
>   	fi &&
>   
>   	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> -	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
> -	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
> -	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
> -	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
> +	test-tool touch sequence --pattern="10_files/%d" --start=1 --count=10 &&
> +	test-tool touch sequence --pattern="100_files/%d" --start=1 --count=100 &&
> +	test-tool touch sequence --pattern="1000_files/%d" --start=1 --count=1000 &&
> +	test-tool touch sequence --pattern="10000_files/%d" --start=1 --count=10000 &&

The big win in taking *minutes* off of the run time of this
test was getting rid of the `for` loops and one `touch` invocation
per file.

So whether we keep my `test-tool touch` command or switch to
`test_seq` or `seq` is open for debate.  Mine seems quicker, but
it is more or less round off error in the larger picture considering
what we started with.

I'll play with this a bit.
Jeff

