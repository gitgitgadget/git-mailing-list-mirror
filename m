From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 16:01:44 -0400
Message-ID: <20110714200144.GE26918@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:01:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhS6a-0000Dr-SN
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab1GNUBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:01:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34257
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab1GNUBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:01:46 -0400
Received: (qmail 11098 invoked by uid 107); 14 Jul 2011 20:02:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 16:02:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 16:01:44 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177168>

On Thu, Jul 14, 2011 at 12:23:31PM -0700, Linus Torvalds wrote:

> On Thu, Jul 14, 2011 at 12:08 PM, Jeff King <peff@peff.net> wrote:
> >
> > If we aren't going to go whole-hog on generation numbers, I'm much more
> > tempted to simply keep using commit timestamps.
> 
> Sure. I think it's entirely reasonable to say that the issue basically
> boils down to one git question: "can commit X be an ancestor of commit
> Y" (as a way to basically limit certain algorithms from having to walk
> all the way down). We've used commit dates for it, and realistically
> it really has worked very well. But it was always a broken heuristic.

Yeah, I agree with that.

> So yes, I personally see generation counters as a way to do the commit
> date comparisons right. And it would be perfectly fine to just say "if
> there are no generation numbers, we'll use the datestamps instead, and
> know that they could be incorrect".

In that case, is it really worth adding generation numbers to the cache?
Because they _can_ be wrong, too. I suspect they will be wrong less
often than commit timestamps, if only because they're dirt simple to
calculate. But all it takes is some crappy porcelain doing:

  git cat-file commit $foo |
  munge_the_parents |
  git hash-object -t commit --stdin -w

to give us a bogus object. Sure, we can catch it via fsck. But we could
also catch commit timestamp skew via fsck just as easily.

> That "use the datestamps" fallback thing may well involve all the
> heuristics we already do (ie check for the stamps looking sane, and
> not trusting just one individual one).

Those aren't foolproof, of course. I asked people a few months ago to
run my skew-detection program on various repos, and some repos have long
runs of skew (think somebody with a bad clock or a bogus program doing a
whole series). But they're fast and work OK in practice. We should apply
them more consistently (name-rev, for example, will tolerate a day of
skew, but will not look past a single commit).

And if people really want to be thorough, we can mark the skewed commits
in a cache during "git gc" for them (or they can just say "for this
traversal, I want to be thorough; turn off timestamp cutoffs").


Out of curiosity, what don't you like about the generation cache? The
idea of using external storage? Generating it on the fly? The particular
implementation is too slow or crappy?

-Peff
