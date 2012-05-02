From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/Makefile: retain cache t/.prove across prove runs
Date: Wed, 2 May 2012 12:07:53 -0400
Message-ID: <20120502160753.GA7193@sigill.intra.peff.net>
References: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed May 02 18:08:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPc6S-0005OR-8m
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 18:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193Ab2EBQIC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 12:08:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55555
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261Ab2EBQIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 12:08:01 -0400
Received: (qmail 20874 invoked by uid 107); 2 May 2012 16:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 May 2012 12:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 May 2012 12:07:53 -0400
Content-Disposition: inline
In-Reply-To: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196837>

On Wed, May 02, 2012 at 05:31:52PM +0200, mhagger@alum.mit.edu wrote:

> prove(1) can write a summary of its test results and timings into a
> cache file, t/.prove, then use this information during later runs for
> various purposes.  But deleting t/.prove after every test run defeats
> this purpose.  So do not delete t/.prove as part of "make
> DEFAILT_TEST_TARGET=prove test".  (Continue to delete the file on
> "make clean".)

Thanks. I had found some odd behaviors with putting "--state" into
GIT_PROVE_OPTS when I first switched my setup to use prove, but I didn't
investigate. I think this issue explained some of what I saw.

Do note, though, that we only clean ".prove" on a successful run. So
something like "--state=hot,save" will still see the cache from the last
run if there were failures. However, the prove cache is meant to be kept
across many runs, even successful ones, so I think your patch makes
sense.

> ---
> prove(1) can be told to retain information about test runs, and to use
> it for interesting purposes during future invocations.  For example,
> it can be told to run tests that failed during the last run:
> 
>     GIT_PROVE_OPTS = --state=failed,save

I don't think this actually works, because we also feed all of the test
scripts to prove on the command line. So it will run them all, both
failed and successful.

I'm not sure if it is worth solving for "make test". I suspect having
that not test everything would be error prone (i.e., it's too easy to
accidentally not run the full suite when you meant to, and unexpected
regressions in other tests will go unnoticed). You can always run
"prove" yourself from the command line, or we can add a new target to do
a partial test (with other options set up properly).

-Peff
