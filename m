From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 14:37:10 -0400
Message-ID: <20110714183710.GA26820@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQmm-0001u7-HB
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab1GNShN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:37:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57344
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab1GNShM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:37:12 -0400
Received: (qmail 9420 invoked by uid 107); 14 Jul 2011 18:37:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 14:37:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 14:37:10 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177150>

On Thu, Jul 14, 2011 at 11:24:27AM -0700, Linus Torvalds wrote:

> And I have to say, with six years of git use, I think it's not a
> coincidence that the notion of generation numbers has come up several
> times over the years: I think the lack of them is literally the only
> real design mistake we have.

Agreed.

> And I absolutely *detest* the generation number cache thing I see on
> the list.

I'd love to have in-commit generation numbers. I'm just not sure we can
get the speeds we want without caching them for existing commits.

> Maybe I missed the discussion that actually added them to the commits
> (I don't read the git mailing list regularly any more) but I think
> it's a mistake to add an external cache to work around the fact that I
> didn't add the generation numbers originally.
> 
> So I think we should just add the generation numbers now. We can make
> the rule be that if a commit doesn't have a generation number, we end
> up having to compute it (with no real need for caching). Yes, it's
> expensive. But it's going to be a *lot* less expensive over time as
> people start using a git version that adds the generation numbers to
> commits.

I'm not sure that is the best plan. Calculating generation numbers
involves going to all roots. So once you have to find any generation
number, it's going to be expensive, no matter how many recent commits
have generation numbers already in them (but it won't get _more_
expensive as more commits are added; you'll always be traversing from
the commit in question down to the roots).

As we add new commits with generation numbers, we won't need to do a
calculation to get their numbers. But if you are doing something like
"tag --contains", you are going to want to know the generation number of
old tags (otherwise, you can't know whether your cutoff might hit them
or not). IOW, even if we add generation numbers _today_, every "tag
--contains" in linux-2.6 is going to end up traversing from v3.0-rc7
down to the roots to get its generation number (v3.0-rc8 would get an
embedded generation, of course).

So if you aren't going to cache generation numbers, then you might as
well write your traversal algorithm to assume you don't know them for
old commits. Because calculating them needs to touch every ancestor, and
that's probably equivalent to the worst-case for your algorithm.


There's also one other issue with generation numbers. How do you handle
grafts and object-replacement refs?  If you graft history, your embedded
generation numbers will all be junk, and you can't trust them.

-Peff
