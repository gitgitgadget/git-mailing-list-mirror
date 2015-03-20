From: Jeff King <peff@peff.net>
Subject: Re: test &&-chain lint (was: [PATCH 1/5] t5312: test object deletion
 code paths in a corrupted repository)
Date: Fri, 20 Mar 2015 01:10:52 -0400
Message-ID: <20150320051051.GA30803@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
 <20150320013217.GA15302@peff.net>
 <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
 <20150320020851.GC15302@peff.net>
 <20150320022532.GA5502@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 06:11:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYpD6-0004FV-9I
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 06:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbbCTFK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 01:10:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:35611 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750756AbbCTFKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 01:10:55 -0400
Received: (qmail 25517 invoked by uid 102); 20 Mar 2015 05:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 00:10:55 -0500
Received: (qmail 20046 invoked by uid 107); 20 Mar 2015 05:11:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 01:11:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 01:10:52 -0400
Content-Disposition: inline
In-Reply-To: <20150320022532.GA5502@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265863>

On Thu, Mar 19, 2015 at 10:25:32PM -0400, Jeff King wrote:

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index c096778..02a03d5 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -524,6 +524,21 @@ test_eval_ () {
> >  test_run_ () {
> >  	test_cleanup=:
> >  	expecting_failure=$2
> > +
> > +	if test -n "$GIT_TEST_CHAIN_LINT"; then
> > +		# 117 is unlikely to match the exit code of
> > +		# another part of the chain
> > +		test_eval_ "(exit 117) && $1"
> > +		if test "$?" != 117; then
> > +			# all bets are off for continuing with other tests;
> > +			# we expected none of the rest of the test commands to
> > +			# run, but at least some did. Who knows what weird
> > +			# state we're in? Just bail, and the user can diagnose
> > +			# by running in --verbose mode
> > +			error "bug in the test script: broken &&-chain"
> > +		fi
> > +	fi
> > +
> >  	setup_malloc_check
> >  	test_eval_ "$1"
> >  	eval_ret=$?
> > 
> > This turns up an appalling number of failures, but AFAICT they are all
> > "real" in the sense that the &&-chains are broken. In some cases these
> > are real, but in others the tests are of an older style where they did
> > not expect some early commands to fail (and we would catch their bogus
> > output if they did). E.g., in the patch below, I think the first one is
> > a real potential bug, and the other two are mostly noise. I do not mind
> > setting a rule and fixing all of them, though.

FWIW, I have spent about a few hours wading through the errors, and am
about 75% done. There are definitely some broken chains that were
causing test results to be ignored (as opposed to just minor setup steps
that we would not expect to fail). In most cases, the tests do passed. I
have a few that I still need to examine more closely, but there may be
some where there are actual test failures (but it's possible that I just
screwed it up while fixing the &&-chaining).

I hope to post something tonight, but I wanted to drop a note on the off
chance that you were actively looking at it at the same time.

-Peff
