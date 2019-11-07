Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBC01F454
	for <e@80x24.org>; Thu,  7 Nov 2019 21:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKGV0P (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 16:26:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:42470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725906AbfKGV0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 16:26:15 -0500
Received: (qmail 7680 invoked by uid 109); 7 Nov 2019 21:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 21:26:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5911 invoked by uid 111); 7 Nov 2019 21:29:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 16:29:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 16:26:14 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] commit-graph: use start_delayed_progress()
Message-ID: <20191107212614.GC29042@sigill.intra.peff.net>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <3c0c9675e125f9357aeadd76f290413aaa09e4cf.1573148818.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c0c9675e125f9357aeadd76f290413aaa09e4cf.1573148818.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 05:46:58PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When writing a commit-graph, we show progress along several commit
> walks. When we use start_delayed_progress(), the progress line will
> only appear if that step takes a decent amount of time.
> 
> However, one place was missed: computing generation numbers. This is
> normally a very fast operation as all commits have been parsed in a
> previous step. But, this is showing up for all users no matter how few
> commits are being added.

This part of the patch is a good thing, and obviously correct. But I
wondered...

> The tests that check for the progress output have already been updated
> to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
> is one test in t6500-gc.sh that uses the test_terminal method. This
> mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,

Why doesn't GIT_PROGRESS_DELAY make it through? Overall it's not that
big a deal to me if it doesn't, but in this test:

>  test_expect_success TTY 'with TTY: gc --no-quiet' '
>  	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
>  	test_must_be_empty stdout &&
> -	test_i18ngrep "Enumerating objects" stderr &&
> -	test_i18ngrep "Computing commit graph generation numbers" stderr
> +	test_i18ngrep "Enumerating objects" stderr
>  '

We're not actually checking anything related to gc.writeCommitGraph
anymore.

> so we need to modify check on the output. We still watch for the

Minor typo: s/modify/& the/ or similar?

-Peff
