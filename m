From: Jeff King <peff@peff.net>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 06:13:30 -0500
Message-ID: <20140115111330.GH14335@sigill.intra.peff.net>
References: <8761pl8raj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jan 15 12:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3OPj-0001Se-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaAOLNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:13:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:32792 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbaAOLNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:13:34 -0500
Received: (qmail 16741 invoked by uid 102); 15 Jan 2014 11:13:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 05:13:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 06:13:30 -0500
Content-Disposition: inline
In-Reply-To: <8761pl8raj.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240453>

On Wed, Jan 15, 2014 at 11:37:08AM +0100, David Kastrup wrote:

> The question is what guarantees I have with regard to the commit date of
> a commit in relation to that of its parent commits:
> 
> a) none
> b) commitdate(child) >= commitdate(parent)
> c) commitdate(child) > commitdate(parent)

a) none

> Obviously, I can rely on c) being true "almost always":

Actually, b) is quite often the case in automated processes (e.g., "git
am" or "git rebase"). The author dates are different, but the committer
dates may be in the same second.

And of course a) is the result of clock skew and software bugs.

> it's definitely
> good for a heuristic used for improving performance (meaning as an
> ordering criterion for a commit priority queue).  The problem is how
> much I should cater for graceful behavior for the cases where it's not.

Yes, this is exactly how git uses it. We generally walk breadth-first
through the graph, relying on commit times for performance but not
correctness.

There are some parts of the code that will behave badly with clock skew.
For example, "--since" will stop traversing when we hit a certain point.
It requires a fixed number of "too old" commits before quitting, though,
in an attempt to bypass small runs of skewed clocks.

The "git describe --contains" algorithm will also produce wrong results
in the face of skew. I believe it uses a "slop" of 24 hours in its skew.

The current "tag --contains" algorithm is currently correct in the face
of skew, but it can go much faster if you accept that skew will cause it
to go wrong. I suspect there are other algorithms that could be sped up,
too, if we had trustworthy generation numbers (I implemented and timed
the "--contains" algorithm, but haven't done so for other algorithms).

I've played with calculating and caching the generation numbers at
repack time, but there aren't any patches currently under consideration.

> Does git do any actual checks before pushing?

No. One problem with checking the commit relationships is that it may
not be the new commit which is broken (by skewing backwards), but rather
the commit it builds on (which has skewed forwards). If you are building
on such a fast-forward commit, it is often to late to fix that commit.
So you have to fast-forward yourself, propagating the bogus value.

If the receiving machine checked the incoming commits against its own
internal clock, that could work. You would still want to check the
commit relationships to catch new commits that erroneously claim to be
from the past, though (that is, before their parents).

-Peff
