Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA7C202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbdJSVBn (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:01:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:58264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753294AbdJSVBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:01:42 -0400
Received: (qmail 4232 invoked by uid 109); 19 Oct 2017 21:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:01:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12398 invoked by uid 111); 19 Oct 2017 21:01:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:01:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:01:40 -0400
Date:   Thu, 19 Oct 2017 17:01:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 0/3] making test-suite tracing more useful
Message-ID: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sometimes run git's test suite as part of an automated testing
process. I was hoping to add "-x" support to get more details when a
test fails (since failures are sometimes hard to reproduce). But I hit a
few small snags:

  - you have to run with bash, since BASH_XTRACEFD is required to avoid
    failures in some tests when we capture the stderr of shell functions
    or subshells (which get polluted with the "set -x" outupt). This
    requirement isn't a big deal for me, but it showed some other
    issues.

  - the output with BASH_XTRACEFD is a little confusing; fixed by patch
    1.

  - there's one test that _only_ fails with BASH_XTRACEFD. That's fixed
    in patch 2.

  - I wanted to use "prove" since the output of "make -j64 test" is
    unreadable. But that means using "--verbose-log", which was
    incompatible with "-x". That's patch 3.

With these patches, I can now do:

  make -j64 test \
    SHELL_PATH=/bin/bash \
    GIT_TEST_OPTS="--verbose-log -x" \
    DEFAULT_TEST_TARGET=prove \
    GIT_PROVE_OPTS=-j64 || {
          echo "Failing tests:"
          echo "--------------"
	  grep -l '[^0]' t/test-results/*.exit |
	  while read failed; do
	          base=${failed%.exit}
		  name=${base#t/test-results/}
		  echo "==> $name"
		  cat "$base.out"
	  done
	  exit 1
    }

and get fairly readable output (a nice summary from prove, and then a
dump of any failing test output).

Johannes, I've seen that you do "-x" in the tests that the
git-for-windows bot uses to comment on GitHub. You may have seen the
bogus failure in t5615, which this series should fix (you may also have
seen the "set +x" cruft at the end of each test, which is fixed here,
too).

Lars, I think with this it should be possible to turn on "-x" for the
Travis build.

  [1/3]: test-lib: silence "-x" cleanup under bash
  [2/3]: t5615: avoid re-using descriptor 4
  [3/3]: test-lib: make "-x" work with "--verbose-log"

 t/t5615-alternate-env.sh |  6 +++---
 t/test-lib.sh            | 44 ++++++++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 15 deletions(-)

-Peff
