Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8450AC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F964E16
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBIMFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 07:05:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:54646 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhBIMEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 07:04:20 -0500
Received: (qmail 26230 invoked by uid 109); 9 Feb 2021 12:03:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 12:03:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4898 invoked by uid 111); 9 Feb 2021 12:03:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 07:03:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 07:03:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2] usage: trace2 BUG() invocations
Message-ID: <YCJ6D1wGgmo1a+KT@coredump.intra.peff.net>
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <20210205200908.805639-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205200908.805639-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 05, 2021 at 12:09:08PM -0800, Jonathan Tan wrote:

> die() messages are traced in trace2, but BUG() messages are not. Anyone
> tracking die() messages would have even more reason to track BUG().
> Therefore, write to trace2 when BUG() is invoked.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks everyone for your suggestions. I've used an in_bug static
> variable (which does prevent the infinite loop - I injected the bug that
> Peff described and verified that it indeed loops without the mitigation
> and doesn't loop with the mitigation) and moved the trace2 to be below
> the vreportf (necessitating a va_copy).

Thanks. I think the single static in_bug is sufficient. We can always
extend it later if that turns out not to be the case.

> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index ce7574edb1..81af180c4c 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -147,6 +147,25 @@ test_expect_success 'normal stream, error event' '
>  	test_cmp expect actual
>  '
>  
> +# Verb 007bug
> +#
> +# Check that BUG writes to trace2
> +
> +test_expect_success 'normal stream, exit code 1' '

Is this description accurate? It doesn't really seem like "exit code 1".
Maybe "99", though BUG is probably more accurate.

> +	test_when_finished "rm trace.normal actual expect" &&
> +	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
> +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
> +	cat >expect <<-EOF &&
> +		version $V
> +		start _EXE_ trace2 007bug
> +		cmd_name trace2 (trace2)
> +		error the bug message
> +		exit elapsed:_TIME_ code:99
> +		atexit elapsed:_TIME_ code:99
> +	EOF
> +	test_cmp expect actual

I wondered how we triggered the BUG_exit_code magic, since I didn't see
any environment set up. It turns out that it's hard-coded into
test-tool, so we don't need to do anything special here in the test.

-Peff
