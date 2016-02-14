From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Sun, 14 Feb 2016 11:18:16 -0500
Message-ID: <20160214161816.GC5875@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
 <20160213174449.GH30144@sigill.intra.peff.net>
 <CF48D0B6-66BD-4C5D-A93B-AB0BBC00615D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:19:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUzO1-0004Hz-GI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 17:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbcBNQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 11:18:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:41837 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751487AbcBNQST (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 11:18:19 -0500
Received: (qmail 13461 invoked by uid 102); 14 Feb 2016 16:18:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:18:18 -0500
Received: (qmail 1365 invoked by uid 107); 14 Feb 2016 16:18:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Feb 2016 11:18:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2016 11:18:16 -0500
Content-Disposition: inline
In-Reply-To: <CF48D0B6-66BD-4C5D-A93B-AB0BBC00615D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286156>

On Sun, Feb 14, 2016 at 01:48:59PM +0100, Lars Schneider wrote:

> > I see you split this up more, but there's still quite a bit going on in
> > this one block. IMHO, it would be more customary in our tests to put the
> > setup into one test_expect_success block, then each of these
> > expect-run-cmp blocks into their own test_expect_success.
> > 
> > It does mean that the setup mutates the global test state for further
> > tests (and you should stop using test_config_*, which clean up at the
> > end of the block), but I think that's the right thing here. The point of
> > test_config is "flip on this switch just for a moment, so we can test
> > its effect without hurting further tests". But these are config tests in
> > the first place, and it is OK for them to show a progression of
> > mutations of the config (you'll note that like the other tests in this
> > script, you are clearing out .git/config in the first place).
> > 
> TBH I am always a little annoyed if Git tests depend on each other. It makes
> it harder to just disable all uninteresting tests and only focus on the one that 
> I am working with. However, I agree with your point that the test block does too
> many things. Would it be OK if I write a bash function that performs the test
> setup? Then I would call this function in the beginning of every individual 
> test. Or do you prefer the global state strategy?

In general, my opinion is that skipping arbitrary leading tests is a
losing strategy. It's just too easy to introduce hidden dependencies,
and not worth the programmer time to make sure each test runs in
isolation. But others on the list may disagree.

That being said, I think what I am proposing is a much milder form of
that. With what I am proposing, you can skip everything _except_ tests
which match /set.?up/ in their description. We do not perfectly adhere
to that in our tests, but I suspect it works a majority of the time.

If it is taking too long to get to a particular test in a test script,
maybe that is a sign we need to break up the script. There are also a
few tricks you can use to still _run_ the earlier blocks, but not have
them interfere with debugging a particular test:

  1. Use --verbose-only=123 to get verbose output only from a single
     test.

  2. Use "-i" to stop running tests at the first failure. Usually it is
     worth fixing that one, and then seeing if other tests fail, too, or
     were simply dependent.

  3. If you are using --valgrind, the tests run very slowly (normally
     t1300 takes 400ms to run on my machine, so I don't mind waiting
     that long to get to a new test at the end. With valgrind it is more
     like 90 seconds). You can use --valgrind-only=123 to test only the
     block you are debugging, and run the rest quickly.

We do use shell functions in some places to do repeated setup. In
general, I prefer setting up the global state. It's more efficient
(which does add up when running the whole suite), and I find it easier
to debug failing tests (it's just one less thing the failing block is
doing that you have to look at; and you can generally "cd" into the
leftover trash directory to investigate the global state).

-Peff
