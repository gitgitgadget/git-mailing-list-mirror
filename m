Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F160FA3744
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJaXXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJaXXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 19:23:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81084167D2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:22:49 -0700 (PDT)
Received: (qmail 3438 invoked by uid 109); 31 Oct 2022 23:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 31 Oct 2022 23:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16521 invoked by uid 111); 31 Oct 2022 23:22:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 19:22:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 19:22:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2BYyB3H9n2LDo/E@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98fa5270cb720f2f038c4bb9571c7d306ff5d759.1667245639.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:47:18PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It is unclear as to _why_, but under certain circumstances the warning
> about credentials being passed as part of the URL seems to be swallowed
> by the `git remote-https` helper in the Windows jobs of Git's CI builds.
> 
> Since it is not actually important how many times Git prints the
> warning/error message, as long as it prints it at least once, let's just
> make the test a bit more lenient and test for the latter instead of the
> former, which works around these CI issues.

This makes sense to me. Regardless of whether we actually fix the
multiple outputs (which are user-visible and kind of ugly), I don't
think there's any reason for our tests to assert the somewhat
undesirable output. So this can proceed independently of any fix.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8dd4610a8c2..980c594940b 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1860,15 +1860,15 @@ test_expect_success LIBCURL 'fetch warns or fails when using username:password'
>  
>  	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@224.0.0.1 2>err &&
>  	grep "warning: $message" err >warnings &&
> -	test_line_count = 3 warnings &&
> +	test_line_count -ge 1 warnings &&

I think this test_line_count (and all the others) is now superfluous;
the exit code of grep will tell us if we found anything.

I don't mind it too much, though, if we're planning to fix the duplicate
messages, at which point it becomes s/-ge/=/.

-Peff
