From: Jeff King <peff@peff.net>
Subject: Re: test &&-chain lint (was: [PATCH 1/5] t5312: test object deletion
 code paths in a corrupted repository)
Date: Thu, 19 Mar 2015 22:25:32 -0400
Message-ID: <20150320022532.GA5502@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
 <20150320013217.GA15302@peff.net>
 <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
 <20150320020851.GC15302@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 03:25:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYmd7-0000gk-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 03:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbbCTCZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 22:25:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35595 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbbCTCZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 22:25:35 -0400
Received: (qmail 18050 invoked by uid 102); 20 Mar 2015 02:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 21:25:35 -0500
Received: (qmail 19557 invoked by uid 107); 20 Mar 2015 02:25:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 22:25:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 22:25:32 -0400
Content-Disposition: inline
In-Reply-To: <20150320020851.GC15302@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265860>

[+cc Jonathan, whose patch I apparently subconsciously copied]

On Thu, Mar 19, 2015 at 10:08:51PM -0400, Jeff King wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c096778..02a03d5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -524,6 +524,21 @@ test_eval_ () {
>  test_run_ () {
>  	test_cleanup=:
>  	expecting_failure=$2
> +
> +	if test -n "$GIT_TEST_CHAIN_LINT"; then
> +		# 117 is unlikely to match the exit code of
> +		# another part of the chain
> +		test_eval_ "(exit 117) && $1"
> +		if test "$?" != 117; then
> +			# all bets are off for continuing with other tests;
> +			# we expected none of the rest of the test commands to
> +			# run, but at least some did. Who knows what weird
> +			# state we're in? Just bail, and the user can diagnose
> +			# by running in --verbose mode
> +			error "bug in the test script: broken &&-chain"
> +		fi
> +	fi
> +
>  	setup_malloc_check
>  	test_eval_ "$1"
>  	eval_ret=$?
> 
> This turns up an appalling number of failures, but AFAICT they are all
> "real" in the sense that the &&-chains are broken. In some cases these
> are real, but in others the tests are of an older style where they did
> not expect some early commands to fail (and we would catch their bogus
> output if they did). E.g., in the patch below, I think the first one is
> a real potential bug, and the other two are mostly noise. I do not mind
> setting a rule and fixing all of them, though.
> 
> I seem to recall people looked at doing this sort of lint a while ago,
> but we never ended up committing anything. I wonder if it was because of
> all of these "false positives".

This turns out to be rather annoying to grep for in the list archives,
but I found at least one discussion:

  http://article.gmane.org/gmane.comp.version-control.git/235913

I don't know why we didn't follow it up then. Perhaps because the patch
there (which is rather similar to what I have above) was not
conditional, so whole chunks of the test suite needed fixing. There are
enough problems that we would probably want to do this conditionally,
fix them over time, and then finally flip the feature on by default.

-Peff
