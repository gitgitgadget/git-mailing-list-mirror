Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A96F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfBHQrf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 11:47:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:37618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfBHQre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 11:47:34 -0500
Received: (qmail 5837 invoked by uid 109); 8 Feb 2019 16:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 16:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25397 invoked by uid 111); 8 Feb 2019 16:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 11:47:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 11:47:33 -0500
Date:   Fri, 8 Feb 2019 11:47:33 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: make '--stress' more bisect-friendly
Message-ID: <20190208164732.GA23461@sigill.intra.peff.net>
References: <20190208115045.13256-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208115045.13256-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 12:50:45PM +0100, SZEDER Gábor wrote:

>   - Make it exit with failure if a failure is found.
> 
>   - Add the '--stress-limit=<N>' option to repeat the test script
>     at most N times in each of the parallel jobs, and exit with
>     success when the limit is reached.
> [...]
> 
> This is a case when an external stress script works better, as it can
> easily check commits in the past...  if someone has such a script,
> that is.

Heh, I literally just implemented this kind of max-count in my own
"stress" script[1] to handle this recent t0025 testing. So certainly I
think it is a good idea.

Picking an <N> is tough. Too low and you get a false negative, too high
and you can wait forever, especially if the script is long. But I don't
think there's any real way to auto-scale it, except by seeing a few of
the failing cases and watching how long they take.

>  t/README      |  5 +++++
>  t/test-lib.sh | 18 ++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

Patch looks good. A few observations:

> @@ -237,8 +248,10 @@ then
>  				exit 1
>  			' TERM INT
>  
> -			cnt=0
> -			while ! test -e "$stressfail"
> +			cnt=1
> +			while ! test -e "$stressfail" &&
> +			      { test -z "$stress_limit" ||
> +				test $cnt -le $stress_limit ; }
>  			do
>  				$TEST_SHELL_PATH "$0" "$@" >"$TEST_RESULTS_BASE.stress-$job_nr.out" 2>&1 &
>  				test_pid=$!

You switch to 1-indexing the counts here. I think that makes sense,
since otherwise --stress-limit=300 would end at "1.299", etc.

> @@ -261,6 +274,7 @@ then
>  
>  	if test -f "$stressfail"
>  	then
> +		stress_exit=1
>  		echo "Log(s) of failed test run(s):"
>  		for failed_job_nr in $(sort -n "$stressfail")
>  		do

I think I'd argue that this missing stress_exit is a bug in the original
script, and somewhat orthogonal to the limit counter. But I don't think
it's worth the trouble to split it out (and certainly the theme of "now
you can run this via bisect" unifies the two changes).

-Peff
