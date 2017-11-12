Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261B8201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 16:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdKLQLf (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 11:11:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:54064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751360AbdKLQLf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 11:11:35 -0500
Received: (qmail 6257 invoked by uid 109); 12 Nov 2017 16:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 16:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15910 invoked by uid 111); 12 Nov 2017 16:11:47 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 11:11:47 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 16:11:32 +0000
Date:   Sun, 12 Nov 2017 16:11:32 +0000
From:   Jeff King <peff@peff.net>
To:     Charles Bailey <charles@hashpling.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Make t4201-shortlog.sh test more robust
Message-ID: <20171112161132.au26ywjeeipxsor4@sigill.intra.peff.net>
References: <20171112152523.7186-1-charles@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171112152523.7186-1-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:25:23PM +0000, Charles Bailey wrote:

> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> The test for '--abbrev' in t4201-shortlog.sh assumes that the commits
> generated in the test can always be uniquely abbreviated to 5 hex digits
> but this is not always the case. If you were unlucky and happened to run
> the test at (say) Thu Jun 22 03:04:49 2017 +0000, you would find that
> the first commit generated would collide with a tree object created
> later in the same test.
> 
> This can be simulated in the version of t4201-shortlog.sh prior to this
> commit by setting GIT_COMMITTER_DATE and GIT_AUTHOR_DATE to 1498100689
> after sourcing test-lib.sh.
> 
> Change the test to test --abbrev=35 instead of --abbrev=5 to almost
> completely avoid the possibility of a partial collision and add a call
> to test_tick in the setup to make the test repeatable.

This generally makes sense to me, but I think there's one thing unsaid
in this last paragraph: why is it OK to switch from 5 to 35?

The answer is that the test is just checking that --abbrev is respected,
and doesn't care whether it's making things larger or smaller. There are
other cases of --abbrev=5 in the test suite which might fall into the
same boat.

You're also really doing two things to fix the problem here, either one
of which would have been sufficient: increasing the abbreviation size
and using test_tick to get a deterministic run.

I'm OK with doing that here, but some of the other --abbrev=5 cases
might already be fine due to using test_tick appropriately.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 9df054b..da10478 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -9,6 +9,7 @@ test_description='git shortlog
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> +	test_tick &&

Charles and I had a discussion off-list whether it's appropriate to
test_tick once, but not for each commit (simply because it's a minor
pain to remember to do so before each commit).

Doing it once is enough to make the test deterministic, and for this
particular case we don't actually care at all whether all of the commits
have the exact same timestamp. So I think it's fine.

One option is to try replacing the ad-hoc commits with test_commit, but
it turns out to be quite ugly in this case, as the tests depend on a lot
of oddly-formatted commit messages.

-Peff
