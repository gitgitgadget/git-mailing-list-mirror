Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F3C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 06:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCYGhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYGhd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 02:37:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A715413D44
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 23:37:32 -0700 (PDT)
Received: (qmail 11305 invoked by uid 109); 25 Mar 2023 06:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 06:37:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10525 invoked by uid 111); 25 Mar 2023 06:37:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 02:37:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 02:37:31 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
Message-ID: <20230325063731.GB562387@coredump.intra.peff.net>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 11:17:11PM +0100, Michael J Gruber wrote:

> 1f2e05f0b7 ("wildmatch: fix exponential behavior", 2023-03-20)
> introduced a new test with a background process. Backgrounding
> necessarily gives a result of 0, so that a seemingly broken && chain is
> not really broken.
> 
> Adjust t3070 slightly so that our chain list test recognizes the
> construct for what it is and does not raise a false positive.

Good catch. While I agree that there's no missed exit code here, I'd say
that this is more than just a false positive. If there were any lines
above the "&", like:

  foo &&
  bar &
  pid=$! &&
  ...etc...

then we'd be losing the exit value of "foo". It's OK here because the
backgrounded command is the first line of the test, but it definitely
violates our guidelines.

Which isn't to say that your patch needs to do anything differently. I
just wondered if it meant we should be improving the chain linter, but I
think it is doing the right thing to alert us here.

> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index b91a7cb712..4dd42df38c 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -432,10 +432,12 @@ match 0 1 0 1 'z' '[Z-y]'
>  match 1 1 1 1 'Z' '[Z-y]'
>  
>  test_expect_success 'matching does not exhibit exponential behavior' '
> -	test-tool wildmatch wildmatch \
> -		aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
> -		"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
> -	pid=$! &&
> +	{
> +		test-tool wildmatch wildmatch \
> +			aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
> +			"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
> +		pid=$!
> +	} &&
>  	sleep 2 &&
>  	! kill $!

This looks like the right solution. I do wonder how Phillip managed to
miss it, though, since the test script complains loudly.

-Peff
