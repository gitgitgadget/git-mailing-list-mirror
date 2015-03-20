From: Jeff King <peff@peff.net>
Subject: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 06:04:30 -0400
Message-ID: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:04:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtnJ-0007AE-JC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbbCTKEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:04:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:35662 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751875AbbCTKEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:04:33 -0400
Received: (qmail 5458 invoked by uid 102); 20 Mar 2015 10:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:04:33 -0500
Received: (qmail 21360 invoked by uid 107); 20 Mar 2015 10:04:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:04:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265874>

This is a cleanup of the &&-chain lint I posted earlier:

  http://thread.gmane.org/gmane.comp.version-control.git/265613/focus=265859

I don't know who came up with the idea for it originally, but the
concept certainly was floating in the back of my mind from Jonathan's
earlier version that is referenced in that thread.

The general idea is to detect &&-chain breakage that can lead to our
tests yielding false success. The first patch implements and discusses
the lint-check itself, which is quite simple. The bulk of the work was
fixing all of the issues in the existing tests. :)

That didn't all need to happen immediately. I mainly wanted to start on
it to answer two questions:

  1. Are &&-chain breakages actually preventing us from seeing any test
     failures? Or is it mostly just pedantry, and we miss out only on
     knowing whether "cat >expect <<-\EOF" failed (which presumably it
     never does).

  2. How bad are the false positives? Both how common, and how bad to
     work around.

But after a few hours, I reached a zen state and just kept going. So at
the end of this series, the whole test suite is --chain-lint clean
(modulo any tests that are skipped on my platform). We could even switch
the checks on by default at the end of the series, but I didn't do that
here. I think it would be sane to run them all the time, though; in the
normal success case, they don't add any forks (the shell just runs
"(exit) && ...", and realizes that the whole thing is one big &&-chain).
I couldn't measure any time difference running the suite with and
without it.

Anyway, to answer the questions: Yes, there were definitely tests whose
values were being thrown away, and we would not have noticed if they
failed. The good news is that all of them did pass once we started
checking their results. Hooray.

There were a number of false positives, though as a percentage of the
test suite, probably not many (it's just that we have quite a lot of
tests).  Most of them were in rather old tests, and IMHO the fixes I did
actually improved the readability of the result. So overall I think this
is a very positive change; I doubt it will get in people's way very
often, and I look forward to having one less thing to worry about
handling manually in review. The biggest downside is that I may have
automated Eric Sunshine out of a job. :)

The patches are:

  [01/25]: t/test-lib: introduce --chain-lint option
  [02/25]: t: fix severe &&-chain breakage
  [03/25]: t: fix moderate &&-chain breakage
  [04/25]: t: fix trivial &&-chain breakage
  [05/25]: t: assume test_cmp produces verbose output
  [06/25]: t: use verbose instead of hand-rolled errors
  [07/25]: t: use test_must_fail instead of hand-rolled blocks
  [08/25]: t: fix &&-chaining issues around setup which might fail
  [09/25]: t: use test_might_fail for diff and grep
  [10/25]: t: use test_expect_code instead of hand-rolled comparison
  [11/25]: t: wrap complicated expect_code users in a block
  [12/25]: t: avoid using ":" for comments
  [13/25]: t3600: fix &&-chain breakage for setup commands
  [14/25]: t7201: fix &&-chain breakage
  [15/25]: t9502: fix &&-chain breakage
  [16/25]: t6030: use modern test_* helpers
  [17/25]: t0020: use modern test_* helpers
  [18/25]: t1301: use modern test_* helpers
  [19/25]: t6034: use modern test_* helpers
  [20/25]: t4117: use modern test_* helpers
  [21/25]: t9001: use test_when_finished
  [22/25]: t0050: appease --chain-lint
  [23/25]: t7004: fix embedded single-quotes
  [24/25]: t0005: fix broken &&-chains
  [25/25]: t4104: drop hand-rolled error reporting

It's a lot of patches, and a few of them are long. I tried to group
them by functionality rather than file (though as you can see, some of
the tests were unique enough snowflakes that it made sense to discuss
their issues separately). I'm hoping it should be an easy review, if
not a short one.

I'll spare you the full per-file diffstat, but the total is a very
satisfying:

   84 files changed, 397 insertions(+), 647 deletions(-)

That's a lot of changes in a lot of hunks, but most of them are in files
that haven't been touched in a while. The series merges cleanly with
"pu", so I don't think I've stepped on anyone's topics in flight.

-Peff
