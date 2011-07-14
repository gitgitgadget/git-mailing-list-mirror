From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 15:08:44 -0400
Message-ID: <20110714190844.GA26918@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRHI-0003vK-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab1GNTIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:08:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab1GNTIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:08:47 -0400
Received: (qmail 10273 invoked by uid 107); 14 Jul 2011 19:09:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 15:09:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 15:08:44 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177159>

On Thu, Jul 14, 2011 at 11:47:45AM -0700, Linus Torvalds wrote:

> On Thu, Jul 14, 2011 at 11:37 AM, Jeff King <peff@peff.net> wrote:
> >
> > I'd love to have in-commit generation numbers. I'm just not sure we can
> > get the speeds we want without caching them for existing commits.
> 
> So my argument would be that we'd simply be much better off fixing the
> fundamental data structure (which we can), and let it become the
> long-term solution.
> 
> Now, if *may* turn out that we'd want to have some cache for
> generation numbers in commits that don't have them, but I absolutely
> think that that should be a "add-on" rather than anything fundamental.
> For example, if we just merge the "add generation numbers to the
> commit object" logic first, then the "cache" case never really needs
> to care about us generating new commits. They simply won't need the
> cache.

Sure, I'd be fine with that (modulo the graft issue, which you don't
seem to care about). I half-toyed with making an extra "add generation
numbers to commit header" on top of my series, but I wanted to first
prove that generation numbers actually could yield speedups.

> Also, I suspect that the cache could easily be done as a *small* and
> *incomplete* cache, ie you don't need to cache all commits, it would
> be sufficient to cache a few hundred spread-out commits, and just know
> that "from any commit, the cached commit will be quickly reachable".

Yeah, that would work. Is it worth the trouble? Your cache size is still
O(n). And you still have the complexity of _having_ a cache.  Yes, the
size is 1/100th of what it was (dropping from 6M to 600K on linux-2.6).
But you're also going to spend more time calculating. I think you'd have
to measure to see how it performs in practice.

> It only ends up being expensive if the commit has parents that don't
> have generation numbers.
> 
> That's a fairly short-term problem. For the kernel, for example,
> basically no development happens on a base that is older than one or
> two releases. So if I (and Greg, with the stable tree) start using my
> patch, within a couple of weeks, pretty much all development would
> have a generation number in its history.

Sure, that makes generation during commit-time cheaper, and eventually
the cost just goes away. I'm more concerned that it won't actually speed
up algorithms where you look at old commits, which was the whole point
in the first place.

> > As we add new commits with generation numbers, we won't need to do a
> > calculation to get their numbers. But if you are doing something like
> > "tag --contains", you are going to want to know the generation number of
> > old tags (otherwise, you can't know whether your cutoff might hit them
> > or not). IOW, even if we add generation numbers _today_, every "tag
> > --contains" in linux-2.6 is going to end up traversing from v3.0-rc7
> > down to the roots to get its generation number (v3.0-rc8 would get an
> > embedded generation, of course).
> 
> So that could easily be handled by caching. In fact, I suspect that
> you could make the cache no associate with a commit ID, but be
> associated with the tags and heads. But again, then the cache would be
> a "secondary" issue, not something fundamental.

Yeah, you could do that. And it would handle "tag --contains" and
"branch --contains" (the latter doesn't even really need a cache; as the
branch tips move, they will get new commits with generation numbers). I
suspect we could get faster topo-sorting and possibly faster merge-base
calculation out of generation numbers, too.  But that won't happen if we
only have generation numbers for a handful of specific commits.

> > So if you aren't going to cache generation numbers, then you might as
> > well write your traversal algorithm to assume you don't know them for
> > old commits.
> 
> But that's how our algorithms are *already* written.

Sort of. We tend to rely on commit timestamps as a proxy for generation
numbers. But in the face of clock skew, git will give wrong answers
(e.g., Ted posted some examples of name-rev giving wrong answers near
some skew in linux-2.6).

If we aren't going to go whole-hog on generation numbers, I'm much more
tempted to simply keep using commit timestamps. It's easy to build a
cache of commits with bogus timestamps (which I've already posted a
patch for) if you want to better accuracy at the cost of more
complexity. And as time progresses, you tend to ask about commits near
the skewed ones less often (and hopefully lessons learned from seeing
how the skew occurred will help us prevent them from reocurring in new
commits).

-Peff
