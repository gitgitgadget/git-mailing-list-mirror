Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31712C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E733F64E04
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhA3J3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:29:18 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:5076 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhA3J2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:28:37 -0500
X-Greylist: delayed 1358 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 04:28:37 EST
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4DSSFr2tCXz5vHD
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 09:35:28 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4DSS6m3SBKz5tl9;
        Sat, 30 Jan 2021 09:29:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D68C94BCE;
        Sat, 30 Jan 2021 09:29:18 +0100 (CET)
Subject: Re: [PATCH] pager: exit without error on SIGPIPE
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Vincent Lefevre <vincent@vinc17.net>,
        Git Mailing List <git@vger.kernel.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a3e738e2-695e-cf01-5d01-50b6fea272ec@kdbg.org>
Date:   Sat, 30 Jan 2021 09:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.21 um 00:48 schrieb Denton Liu:
> If the pager closes before the git command feeding the pager finishes,
> git is killed by a SIGPIPE and the corresponding exit code is 141.
> Since the pipe is just an implementation detail, it does not make sense
> for this error code to be user-facing.
> 
> Handle SIGPIPEs by simply calling exit(0) in wait_for_pager_signal().
> 
> Introduce `test-tool pager` which infinitely prints `y` to the pager in
> order to test the new behavior. This cannot be tested with any existing
> git command because there are no other commands which produce infinite
> output. Without the change to pager.c, the newly introduced test fails.
> 
> Reported-by: Vincent Lefevre <vincent@vinc17.net>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

...

> diff --git a/pager.c b/pager.c
> index ee435de675..5922d99dc8 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -34,6 +34,8 @@ static void wait_for_pager_atexit(void)
>  static void wait_for_pager_signal(int signo)
>  {
>  	wait_for_pager(1);
> +	if (signo == SIGPIPE)
> +		exit(0);
>  	sigchain_pop(signo);
>  	raise(signo);
>  }
> diff --git a/t/helper/test-pager.c b/t/helper/test-pager.c
> new file mode 100644
> index 0000000000..feb68b8643
> --- /dev/null
> +++ b/t/helper/test-pager.c
> @@ -0,0 +1,12 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +
> +int cmd__pager(int argc, const char **argv)
> +{
> +	if (argc > 1)
> +		usage("\ttest-tool pager");
> +
> +	setup_pager();
> +	for (;;)
> +		puts("y");
> +}

My gut feeling tells that this will end in an infinite loop on Windows.
There are no signals on Windows that would kill the upstream of a pipe.
This call site will only notice that the downstream of the pipe was
closed, when it checks for write errors.

Let me test it.

-- Hannes
