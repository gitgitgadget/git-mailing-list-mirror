From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
Date: Sun, 29 Dec 2013 02:17:59 -0500
Message-ID: <20131229071758.GA31788@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228092915.GA21109@sigill.intra.peff.net>
 <20131228221313.GB5544@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 29 08:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxAdq-0006nK-RL
	for gcvg-git-2@plane.gmane.org; Sun, 29 Dec 2013 08:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab3L2HSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Dec 2013 02:18:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:51922 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971Ab3L2HSB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Dec 2013 02:18:01 -0500
Received: (qmail 31129 invoked by uid 102); 29 Dec 2013 07:18:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Dec 2013 01:18:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Dec 2013 02:17:59 -0500
Content-Disposition: inline
In-Reply-To: <20131228221313.GB5544@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239794>

On Sat, Dec 28, 2013 at 02:13:13PM -0800, Jonathan Nieder wrote:

> So the idea if I am reading correctly is "Instead of relying on the
> implicit output directory chosen with chdir, which doesn't even work
> any more, set TEST_OUTPUT_DIRECTORY to decide where output for the
> sub-tests used by t0000's sanity checks for the test harness go".

Right.

> I'm not sure I completely understand the regression caused by 38b074d.
> Is the idea that before that commit, TEST_OUTPUT_DIRECTORY was only
> used for the test-results/ directory so the only harm done was some
> mixing of test results?

$TEST_OUTPUT_DIRECTORY was actually used in $TRASH_DIRECTORY, but some
code paths properly used $TRASH_DIRECTORY, and some used another
variable that (sometimes) contained a relative form of $TRASH_DIRECTORY.
The creation of the repo was one such code-path.  So there were already
potentially problems before 38b074d (any sub-test looking at its
$TRASH_DIRECTORY variable would find the wrong path), but I do not know
offhand if it could trigger any bugs.

Post-38b074d, we consistently use $TRASH_DIRECTORY (and therefore
respect $TEST_OUTPUT_DIRECTORY) everywhere.

> What is the symptom this patch alleviates?
> 
> > As a result, t0000's sub-tests are now created in git's
> > original test output directory rather than in our trash
> > directory.
> 
> This might be the source of my confusion.  Is "sub-tests" an
> abbreviation for "sub-test trash directories" here?

Yes, I should have said "sub-test trash directories". And I think that
answers your "what is the symptom" question.

> > We could fix this by passing a new "--root=$TRASH_DIRECTORY"
> > option to the sub-test. However, we do not want the sub-tests
> > to write anything at all to git's directory (e.g., they
> > should not be writing to t/test-results, either, although
> > this is already handled by separate code).
> 
> Ah, HARNESS_ACTIVE prevents output of test-results.

Yes. My original notion was "Oh, and this fixes broken test-results,
too!". But then I noticed that it is already handled in a different way.
:)

> Does the git test harness write something else to
> TEST_OUTPUT_DIRECTORY?  Is the idea that using --root would be
> functionally equivalent but (1) more confusing and (2) less
> futureproof?

Exactly. I do not think TEST_OUTPUT_DIRECTORY is used for anything else,
but if someone were to ever add a new use, the sub-tests would almost
certainly want that use to affect only the t0000 trash directory.

> So, to sum up: if I understand correctly

You answered these yourself in your follow-up. :)

> So the patch itself looks right.  I think describing the symptoms up
> front would probably be enough to make the commit message less
> confusing to read.

Would adding the missing "trash directories" wording above be
sufficient?

-Peff
