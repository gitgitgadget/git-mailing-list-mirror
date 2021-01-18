Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2D7C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CEA22CA1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407566AbhARSXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:23:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:21448 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407562AbhARSWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:22:54 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4DKKr52YPPz5tlD;
        Mon, 18 Jan 2021 19:21:56 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EDD5F4B9E;
        Mon, 18 Jan 2021 19:21:55 +0100 (CET)
Subject: Re: [PATCH 1/2] t5411: remove file after use to prevent overwriting
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20210117222151.GY8396@szeder.dev>
 <20210118133011.15331-1-worldhello.net@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
Date:   Mon, 18 Jan 2021 19:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118133011.15331-1-worldhello.net@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.21 um 14:30 schrieb Jiang Xin:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> SZEDER reported that t5411 failed in Travis CI's s390x environment a
> couple of times, and could be reproduced with '--stress' test on this
> specific environment.  The test failure messages might look like this:
> 
>     + test_cmp expect actual
>     --- expect      2021-01-17 21:55:23.430750004 +0000
>     +++ actual      2021-01-17 21:55:23.430750004 +0000
>     @@ -1 +1 @@
>     -<COMMIT-A> refs/heads/main
>     +<COMMIT-A> refs/heads/maifatal: the remote end hung up unexpectedly
>     error: last command exited with $?=1
>     not ok 86 - proc-receive: not support push options (builtin protocol)
> 
> The file 'actual' is filtered from the file 'out' which contains result
> of 'git show-ref' command.  Due to the error messages from other process
> is written into the file 'out' accidentally, t5411 failed.  SZEDER finds
> the root cause of this issue:
> 
>  - 'git push' is executed with its standard output and error redirected
>    to the file 'out'.
> 
>  - 'git push' executes 'git receive-pack' internally, which inherits
>    the open file descriptors, so its output and error goes into that
>    same 'out' file.
> 
>  - 'git push' ends without waiting for the close of 'git-receive-pack'
>    for some cases, and the file 'out' is reused for test of
>    'git show-ref' afterwards.
> 
>  - A mixture of the output of 'git show-ref' abd 'git receive-pack'
>    leads to this issue.
> 
> To resolve this issue, we can remove the file 'out' after use.  The
> long-running 'git receive-pack' will not redirect its output to the new
> created 'out' file which has a different file descriptor.

On Windows, removing an open file is not possible and this...

> diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
> index 47b058af7e..694d8e8dc2 100644
> --- a/t/t5411/test-0000-standard-git-push.sh
> +++ b/t/t5411/test-0000-standard-git-push.sh
> @@ -40,6 +40,8 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
>  		-e "/^To / { p; }" \
>  		-e "/^ ! / { p; }" \
>  		<out >actual &&
> +	# Prevent accidential changes by the internal "receive-pack" process.
> +	rm out &&

... would fail.

That said, your next patch removes a lot of uses of the 'out' file
against which this 'rm out' should protect. Doesn't this make this patch
unnecessary?

>  	cat >expect <<-EOF &&
>  	To <URL/of/upstream.git>
>  	 ! [rejected] main -> main (non-fast-forward)

-- Hannes
