From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Wed, 29 May 2013 01:19:25 -0400
Message-ID: <20130529051924.GD31762@sigill.intra.peff.net>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
 <87hahwajgl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 07:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhYnN-0002Jm-E8
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab3E2FT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:19:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:35773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab3E2FT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:19:28 -0400
Received: (qmail 10753 invoked by uid 102); 29 May 2013 05:20:08 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 00:20:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 01:19:25 -0400
Content-Disposition: inline
In-Reply-To: <87hahwajgl.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225737>

On Tue, May 21, 2013 at 09:19:22AM +0200, Thomas Rast wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * tr/test-v-and-v-subtest-only (2013-05-16) 6 commits
> >  - test-lib: support running tests under valgrind in parallel
> >  - test-lib: allow prefixing a custom string before "ok N" etc.
> >  - test-lib: valgrind for only tests matching a pattern
> >  - test-lib: verbose mode for only tests matching a pattern
> >  - test-lib: refactor $GIT_SKIP_TESTS matching
> >  - test-lib: enable MALLOC_* for the actual tests
> >
> >  Allows N instances of tests run in parallel, each running 1/N parts
> >  of the test suite under Valgrind, to speed things up.
> >
> >  The tip one may be useful in practice but is a tad ugly ;-)
> 
> I was hoping for some success stories ;-)

Sorry, none yet, as I am just returning from vacation. Thanks very much
for working on it, though. I'm looking forward to trying it out for
real.

> I think Peff (who I stupidly managed to not Cc in the series, there's
> another git-send-email usability issue there) asked for the third from
> the tip, which lets you run valgrind only on a certain test.  (For
> example, if you've already had two coffees while your computer found out
> which test it was, this is a much faster way of seeing if the failure
> disappeared.)

Like Junio, I find the tip one a bit gross, and I do not expect to ever
use it myself. If I want to run more than one test, I am much more
likely to be running the whole suite, which already parallelizes nicely.
The "run one test under valgrind" may be used when double-checking a
failed test, as you mention. But the use case I had in mind was actually
more like:

  1. Notice a heisenbug/segfault.

  2. Write a new test for it, that logically goes into tXXXX. It may
     become tXXXX.85.

  3. Run tXXXX.85 under valgrind to confirm the bug.

  4. Fix, and re-run tXXXX.85 to confirm the fix.

This is the same procedure for a non-valgrind bugfix, and usually it is
not too big a deal to run all of tests 1-84, because it only wastes a
few seconds (and you need to run them anyway to create the proper
state). But under valgrind, running 1-84 may take minutes. With your
patches, it is no more painful than the non-valgrind case.

I just posted some feedback as a reply to the series itself, but
certainly I think the first four in the series (with that feedback
addressed) would be great to have. The top two I do not care about, but
I also do not mind if they are there for people to play with.

> So one obvious way of going forward is cooking this for a while and
> seeing whether people find the one-test-only or the massively-parallel
> feature useful (or maybe both).

One of the annoying things about test improvements is that you often
want them while working on something else. In the scenario above, it
does not help me when building a fix on "master" that the feature is
cooking in "next" or on a topic branch. But since the feature should not
hurt anybody who does not use it, and it involves no change to actual
git code, only test scripts, I would be inclined to move it fairly
quickly to master, and let it prove its worth there. We can always
improve it or revert it as a failed experiment later if we wish, without
worrying about compatibility issues.

The only downside would be the potential for textual conflicts with
other people improving the test scripts.

-Peff
