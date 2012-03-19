From: Jeff King <peff@peff.net>
Subject: Re: Feature request: don't require both bad and good when bisecting
Date: Mon, 19 Mar 2012 12:45:10 -0400
Message-ID: <20120319164510.GA27601@sigill.intra.peff.net>
References: <20120318212957.GS1219@chaosreigns.com>
 <4F67468B.4070502@op5.se>
 <20120319153006.GD24848@sigill.intra.peff.net>
 <4F675DD3.3040004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: darxus@chaosreigns.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fiD-0002oZ-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162194Ab2CSQpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:45:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53569
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162184Ab2CSQpO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:45:14 -0400
Received: (qmail 31887 invoked by uid 107); 19 Mar 2012 16:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Mar 2012 12:45:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Mar 2012 12:45:10 -0400
Content-Disposition: inline
In-Reply-To: <4F675DD3.3040004@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193438>

On Mon, Mar 19, 2012 at 05:24:51PM +0100, Andreas Ericsson wrote:

> >> On 03/18/2012 10:29 PM, darxus@chaosreigns.com wrote:
> >>> I'd like to be able to tell get only that I know the latest commit is bad,
> >>> and have it go find a good commit, then do the bisecting.  Maybe something
> >>> like the opposite of a binary search, start with the last commit, then
> >>> second to last, then 4th to last, 8th to last, etc., till it finds a good
> >>> commit.
> [...]
> Automatic bisection is a different beast, naturally, since writing
> a test-script that handles all corner cases (feature not added,
> feature added but different bug found, feature added and right bug
> found, etc) can be cumbersome, but that doesn't always apply, and
> darxus didn't mention it. He only mentioned "let's test 4 revisions
> back in history so I can find the good commit!", and I pointed out
> that it's ridiculous to do so regardless of whether one has a hunch
> of where the breakage is or not, since it will (almost) always be
> 100 times faster to just double the scanned range and let git get
> on with it, even if it means doing a manual bisect first to find
> when the feature was introduced and then an automated one to find
> when the bug came alive.

Hmm. What he wrote is confusing, since he uses "last" to refer to the
last commit, which would give strides of 2, 2, and then 4. Which makes
little sense to me. I took it to mean "2nd from the last tested, then
4th from the last tested, then 8th from the last tested". I.e., doubling
the stride each time.

If you take it to mean a fixed-size stride (e.g., maxing out at going
back 4 commits each time), then yes, that is absolutely horrible and
will do hundreds of times more work. I took it to mean exponential,
which has OK asymptotic behavior, but IMHO is _still_ not worth it.

> > IOW, my procedure for a bug like the above is usually to walk backwards
> > along major tagged versions, manually interpreting the results. When I
> > try v1.6.0 and my test blows up (because the feature isn't implemented),
> > I recognize it, dig a little with "git log" to find where it was
> > implemented, and only then write a script for automated bisection.
> 
> That means you've tested 81 tags (discarding rc tags between 1.7.6 and
> 1.6.0).

Actually, I would usually try v1.7.0, then v1.6.0, and so on, depending
on the bug (and then possibly look at minor versions manually). But my
main point was that I am using some domain-specific knowledge about what
constitutes a good break-point when features might have been added, or
how far back is "reasonable". For some projects and some features, v0.99
might be a reasonable place to look. For git, it is generally not, and
anything before v1.5.0 is not even worth bisecting.

> What I was getting at is that trying to be more efficient than O(log n)
> is hard and usually requires a really good educated guess to succeed.
> Picking a random number of jumps to go backwards certainly isn't the
> right way to do it, and especially since the problems you mentioned
> (feature missing) will still exist with such a solution.

Oh, absolutely. I should have been more clear in my email: I was
agreeing with you that the OP's plan was not a good one. My goal wasn't
to do better than O(log n), but to eliminate the need for the user to
worry about picking bisection boundaries in the first place.

That is, in theory, you could have something like this:

  git bisect start-run test.sh

which would test HEAD (which generally has the bug, or why are you
bisecting?), as well as all of the roots (which generally don't,
otherwise there is nothing to bisect). And it isn't much more work to
bisect because of the logarithmic nature of bisection (e.g., even if you
include 10 times as many commits, that's only ~3 extra bisection steps).

However, in practice that does not work because writing a test script to
handle antique code-bases automatically is at least as much work as just
finding a reasonable bisection boundary in the first place.

> I managed to use a lot of text to get to that final paragraph. Sorry.

That's OK. I read fast, and I may be guilty of verbosity from time to
time, as well. :)

-Peff
