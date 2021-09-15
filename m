Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78642C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A260E90
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhIOROp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:14:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIOROo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:14:44 -0400
Received: (qmail 32578 invoked by uid 109); 15 Sep 2021 17:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 17:13:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25731 invoked by uid 111); 15 Sep 2021 17:13:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 13:13:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 13:13:24 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] update-ref: fix streaming of status updates
Message-ID: <YUIptJNN5DxrkydV@coredump.intra.peff.net>
References: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 4506cd435b..1e754e258f 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1598,6 +1598,38 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
>  	test_must_fail git show-ref --verify refs/heads/restart
>  '
>  
> +test_expect_success PIPE 'transaction flushes status updates' '
> +	mkfifo in out &&
> +	(git update-ref --stdin <in >out &) &&
> +
> +	exec 9>in &&
> +	test_when_finished "exec 9>&-" &&
> +
> +	echo "start" >&9 &&
> +	echo "start: ok" >expected &&
> +	read line <out &&
> +	echo "$line" >actual &&
> +	test_cmp expected actual &&
> +
> +	echo "create refs/heads/flush $A" >&9 &&
> +
> +	echo prepare >&9 &&
> +	echo "prepare: ok" >expected &&
> +	read line <out &&
> +	echo "$line" >actual &&
> +	test_cmp expected actual &&

I think this test may be racy. I saw a strange failure from it in CI:

  https://github.com/peff/git/runs/3605506649?check_suite_focus=true#step:5:6734

I can't reproduce the problem locally with "--stress", but the failure
there is on macOS (and likewise, a nearby run failed with a timeout just
for macOS, which could be caused by a racy deadlock).

I'm guessing the problem may be the continued opening and closing of
"out" by the read calls from the shell. The update-ref process may get
SIGPIPE as a result, depending on the write timing.

The solution is to use open a descriptor for "out" like we do for "in",
and then read from that. See 4783e7ea83 (t0008: avoid SIGPIPE race
condition on fifo, 2013-07-12) for some prior art.

-Peff
