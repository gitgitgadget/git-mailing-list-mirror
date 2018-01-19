Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70AF1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbeASV1U (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:27:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:50076 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756314AbeASV1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:27:19 -0500
Received: (qmail 24754 invoked by uid 109); 19 Jan 2018 21:27:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 21:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24707 invoked by uid 111); 19 Jan 2018 21:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 16:27:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 16:27:17 -0500
Date:   Fri, 19 Jan 2018 16:27:17 -0500
From:   Jeff King <peff@peff.net>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 4/6] Force test suite traps to be cleared for NonStop
 ksh
Message-ID: <20180119212716.GB10303@sigill.intra.peff.net>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-6-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180119173406.13324-6-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 12:34:04PM -0500, randall.s.becker@rogers.com wrote:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * t/lib-git-daemon.sh: fix incompatibilities with ksh traps not being
>   cleared automatically on platform. This caused tests to seem to fail
>   while actually succeeding.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  t/lib-git-daemon.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index 987d40680..955beecd9 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -68,6 +68,7 @@ start_git_daemon() {
>  		test_skip_or_die $GIT_TEST_GIT_DAEMON \
>  			"git daemon failed to start"
>  	fi
> +	trap '' EXIT
>  }

I don't think this can be right. The way these traps are supposed to
work is:

  - as soon as test-lib.sh is loaded, we "trap die EXIT" to catch an
    accidental death/exit from one of the scripts

  - when test_done is called, we clear the trap (i.e., it is OK to exit
    now because the script has given us a positive indication that all
    tests have been run)

  - while the child git-daemon is running, we'd want to clean up after
    ourselves. So during start_git_daemon() we add our cleanup (followed
    by the original "die", because shell traps don't push onto a stack).
    And then at stop_git_daemon(), we restore the original die trap.

But this patch means that while git-daemon is running, we have no trap
at all! That means that a failed test which causes us to exit would
leave a child daemon running.

Furthermore, both of these functions now drop the 'die' trap entirely,
meaning the script would fail to notice premature exit from one of the
test snippets.

So while this may be papering over a problem on NonStop, I think it's
breaking the intent of the traps.

I'm not sure what the root of the problem is, but it sounds like ksh may
be triggering EXIT traps when we don't expect (during function returns?
Subshell exits? Other?)

-Peff
