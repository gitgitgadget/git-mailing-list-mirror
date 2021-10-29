Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F172EC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F7760E9B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhJ2UhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:37:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:49758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhJ2UhI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:37:08 -0400
Received: (qmail 23741 invoked by uid 109); 29 Oct 2021 20:34:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 20:34:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22606 invoked by uid 111); 29 Oct 2021 20:34:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 16:34:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 16:34:38 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
Message-ID: <YXxa3i3gXsutG4Cx@coredump.intra.peff.net>
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
 <20211028182824.GA1307@dcvr>
 <xmqqilxhq774.fsf@gitster.g>
 <20211029001552.GA29647@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029001552.GA29647@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 12:15:52AM +0000, Eric Wong wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a291a5d4a2..21f5fab999 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -489,6 +489,13 @@ then
>  	export GIT_PERL_FATAL_WARNINGS
>  fi
>  
> +case $GIT_TEST_FSYNC in
> +'')
> +	GIT_TEST_FSYNC=0
> +	export GIT_TEST_FSYNC
> +	;;
> +esac

I don't really have a problem with doing this by default, as it might
help and shouldn't hurt. But I didn't find it actually changed much for
me. Here are timings running the test suite on my machine:

  Benchmark 1: GIT_TEST_FSYNC=1 make
    Time (mean ± σ):     60.973 s ±  0.158 s    [User: 575.914 s, System: 333.243 s]
    Range (min … max):   60.731 s … 61.228 s    10 runs

  Benchmark 2: GIT_TEST_FSYNC=0 make
    Time (mean ± σ):     59.800 s ±  0.094 s    [User: 575.151 s, System: 337.111 s]
    Range (min … max):   59.643 s … 59.996 s    10 runs

  Benchmark 3: GIT_TEST_FSYNC=1 make GIT_TEST_OPTS=--root=/var/ram
    Time (mean ± σ):     56.966 s ±  0.066 s    [User: 572.353 s, System: 300.808 s]
    Range (min … max):   56.874 s … 57.063 s    10 runs

  Summary
    'GIT_TEST_FSYNC=1 make GIT_TEST_OPTS=--root=/var/ram' ran
      1.05 ± 0.00 times faster than 'GIT_TEST_FSYNC=0 make'
      1.07 ± 0.00 times faster than 'GIT_TEST_FSYNC=1 make'

So using an actual ram disk provided a much bigger edge for me than just
disabling fsync. This may be because the system is using a decent SSD
for its actual disk. But it may also be because I'm running 32 tests
simultaneously. So fsync introducing latency in tests isn't a big deal;
the bottleneck is CPU and there's always another script ready to run.
Though it is also interesting that the system CPU time is so much lower
in the tmpfs case.

Again, not really an objection, but I don't think this replaces the
"you're better off running the test suite on a RAM disk" wisdom.

-Peff
