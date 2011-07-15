From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Fri, 15 Jul 2011 16:40:02 -0400
Message-ID: <20110715204002.GC356@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
 <7vpqlb1k1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhpBP-00044P-Tn
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab1GOUkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:40:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51954
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab1GOUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:40:05 -0400
Received: (qmail 26501 invoked by uid 107); 15 Jul 2011 20:40:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 16:40:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 16:40:02 -0400
Content-Disposition: inline
In-Reply-To: <7vpqlb1k1g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177227>

On Fri, Jul 15, 2011 at 11:22:03AM -0700, Junio C Hamano wrote:

> > +	/* stop searching if we go too far back in time */
> > +	if (commit_generation(candidate) < cutoff)
> > +		return 0;
> > +
> 
> Here, the "generation number" was the commit timestamp of the commit in
> your earlier round, but now it is not.

Yes.

> [...]
> What you are trying to say in this series is that "If a tag points at a
> commit X (i.e. candidate), another commit Y (i.e. "want") that is much
> younger than cannot possibly be included by it, because a tag was made on
> commit X way before Y was created". You cut off by "age".

More or less. Given two ages, X and Y, you cannot know right off the bat
whether one is an ancestor of the other. You can only know that the
higher generation cannot possibly be an ancestor of the lower
generation.

So yes, in some cases we will see that the tag has generation 5, and the
"want" commit has generation 10, and we will know there is no point in
traversing backwards from 5.

But we may also see a tag with generation 10, and a want commit with
generation 5. In that case, we have to explore backwards, looking to
either find the commit, or to pass a point where we hit a commit with
generation less than 5, at which point we know the want commit cannot be
an ancestor.

So if you have a history like:

    B
   /
  A--C--D--...--Z

and you want to know if "B" is in "Z", you will have to traverse all the
way from Z to A before realizing that B cannot be in it. That will have
the same complexity as finding a merge base (because the merge-base
would breadth-first traverse, looking at the highest age first, and
would therefore touch the same sequence of commits).

> The heuristics would work efficiently to check what tags point at a
> relatively recent commit (e.g. when trying to see which releases are
> affected and needing a fix by a recently discovered bug introduced by
> commit Y) by discarding tags for ancient releases. In such a scenario, the
> timestamp of a tagged and ancient commit X on a side branch that was never
> merged in the mainline that leads to commit Y (i.e. "want"), in an ideal
> world without clock skews, will be way older than the timestamp of commit
> Y. In other words, if you use timestamp as "age", even though X and Y do
> not relate to each other directly, except that they may share an ancient
> common ancestor, their "age"s can be compared and you could apply your
> heuristics to optimize.
> 
> But if you use the generation number as "age", even in an ideal world
> without clock skew nor miscomputed generation number, you no longer can
> compare "age" of X and Y.  The ancient side branch that led to X may have
> tons more commits than the history leading to Y.

Yes, there are cases where commit timestamps can save us some traversal
work over generation numbers. But I think there are also cases where the
reverse is true.

Your example is of a long side branch with very old commits. But you
could also have a short side branch with a very recent commit (think
recent bugfix forked from an old version). Then with commit timestamps
we need to go to the merge base to realize we are talking about
something very old. With a generation number, you can easily see that
the short branch's generation is very low.

Using both as a cutoff (if we assumed we had both, and that they were
both implicitly accurate) would let you optimize for either situation.
In practice, timestamps are either good enough that we don't need
generation numbers, or are considered to be strictly less accurate than
generation numbers.

So I think we will end up with one or the other. Of all of the
complaints I have seen over the use of timestamps for cutoffs, I don't
think performance of these corner cases has been an issue.

>    So how about marking commits (using the metainfo-cache facility) that
>    has an ancestor (not necessarily its direct parent) that records a
>    younger timestamp (e.g. 1 is such a commit, as its ancestors include
>    things like 2 and 4)? There should be relatively small number of them,
>    and still_interesting() logic can be told to dig through such commits
>    even if everybody is uninteresting in the active list.

You don't even need metainfo-cache for this. The number of commits is
very small, so the existing "notes-cache" is plenty fast. I even posted
a patch for this already:

  http://article.gmane.org/gmane.comp.version-control.git/176642

>  * As to "tag --contains", when timestamp based heuristics breaks down is
>    when a tagged commit incorrectly records way young timestamp or the
>    "want" commit records way old timetsamp. I haven't thought things
>    through, but the same metainfo-cache may be useful to detect which
>    commit to dig through ignoring the cutoff heuristics.

It can also break down if intermediate commits are wrong, because we
have to traverse backwards, and we may erroneously cutoff early.

For example:

   A--B--C

   timestamp(A) = 2
   timestamp(B) = 1 # skewed!
   timestamp(C) = 3

If tag=C and want=A, then we traverse backwards from C. We can't stop
immediately because we know that 2 < 3. But we go back to B, and see
that 2 > 1, and assume that A cannot possibly be an ancestor of B.

You can push through another N commits of slop (where N=1 would be fine
in this case). But you can always have a run of N+1 skewed commits (and
the higher N, the more time you are wasting). From earlier measurements
posted to the list, most repos have runs less than a dozen commits.
Linux-2.6 is actually the second highest of those measured, with a run
of 80. The mesa repo apparently has a run of 1520. See:

  http://article.gmane.org/gmane.comp.version-control.git/160163

and the surrounding thread (Jonathan did some measurements, too; he
didn't include a "longest run", but he does include "total number of
skewed commits", which obviously provides an upper bound on a run).

-Peff
