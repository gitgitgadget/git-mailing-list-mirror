From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 17:54:14 -0400
Message-ID: <20120801215414.GC16233@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwgsF-0002MP-SV
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab2HAVyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:54:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab2HAVyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:54:21 -0400
Received: (qmail 10694 invoked by uid 107); 1 Aug 2012 21:54:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Aug 2012 17:54:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Aug 2012 17:54:14 -0400
Content-Disposition: inline
In-Reply-To: <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202731>

On Tue, Jul 31, 2012 at 11:01:27PM -0700, Junio C Hamano wrote:

> > @@ -175,6 +177,11 @@ static int estimate_similarity(struct diff_filespec *src,
> >  	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
> >  		return 0;
> >  
> > +	hashcpy(pair.one, src->sha1);
> > +	hashcpy(pair.two, dst->sha1);
> > +	if (rename_cache_get(&pair, &score))
> > +		return score;
> > +
> 
> Random thoughts.
> 
> Even though your "rename cache" could be used to reject pairing that
> the similarity estimator would otherwise give high score, I would
> imagine that in practice, people would always use the mechanism to
> boost the similarity score of desired pairing.  This conjecture has
> a few interesting implications.

I agree that is the probable use. But low scores might also have a
purpose in preventing useless work from being done (IOW, storing a "0"
score is unlikely to happen manually, but it does let us avoid repeating
the calculation).

As you might have guessed, I am really more interested in caching and
performance gains than in manual overrides.

>  - As we track of only the top NUM_CANDIDATE_PER_DST rename src for
>    each dst (see record_if_better()), you should be able to first
>    see if pairs that have dst exist in your rename cache, and
>    iterate over the <src,dst> pairs, filling m[] with srcs that
>    appear in this particular invocation of diff.

Yes, although I don't know if it makes a big difference. We still run
estimate_similarity on the candidates to see if they make it into
record_if_better, and that is the expensive part. I don't think you want
to change that either (e.g., by assuming that cached scores will always
be in the top N; it would depend on the particular tree that the cached
scores came from).

Of course, that changes if it is not a cache at all, and simply a manual
override. Or if manual overrides are stored separately and take effect
first.

But I do not think you even want to care about NUM_CANDIDATE_PER_DST for
manual overrides. You simply want to take the highest scored one,
consider the it done, and not run estimate_similarity at all. Even if
you only had 1 (and NUM_CANDIDATE_PER_DST were 4), there is still no
point in looking at the others. The manual override should beat it,
regardless of score.

>  - If you find NUM_CANDIDATE_PER_DST srcs from your rename cache,
>    you wouldn't have to run estimate_similarity() at all, but that
>    is very unlikely.  We could however declare that user configured
>    similarity boost always wins computed ones, and skip estimation
>    for a dst for which you find an entry in the rename cache.

Right. See above.

>  - As entries in rename cache that record high scores have names of
>    "similar" blobs, pack-objects may be able to take advantage of
>    this information.

Yeah, although I suspect it is not as big a win as you might hope.  In
practice, you're going to diff a lot fewer objects than pack-objects
would consider, so most of the pack-objects candidate pairs will not
have a cache entry.  Which means that you really need to not rely on the
cache (since it is very likely that the best candidate is still to be
found), and you still do lots of computation.

You could cache the result of comparisons done by pack-objects, but that
cache ends up being large. You might remember that one of my very first
patches was a cache for recording negative delta finds (so we try to
delta A against B and find that it is not a good match, and record that
information). Even that cache was huge, and we ended up discarding it in
favor of Linus's much more sensible "if two things are in the same pack
and not delta'd, then either they are not a good match, or something
else is in better" heuristic. But one with full-on similarity scores
would be even bigger.

>  - If you declare blobs A and B are similar, it is likely that blobs
>    C, D, E, ... that are created by making a series of small tweaks
>    to B are also similar.  Would it make more sense to introduce a
>    concept of "set of similar blobs" instead of recording pairwise
>    scores for (A,B), (A,C), (A,D), ... (B,C), (B,D), ...?  If so,
>    the body of per-dst loop in diffcore_rename() may become:

Yes, this is the transitive bit I mentioned elsewhere. I think there are
dragons lurking there, as you end up with the edges of the set not
_really_ being that close to each other. You'd probably want some kind
of weighted association, like if A->B had 80% similarity, and B->C had
90% similarity, then A->C would be 72%. But even that is not accurate;
it is just a lower bound. The differences between A->B and B->C might
overlap, and A->C might be much more similar.

You can't know the true value without actually finding the score for
A->C.  And since we output the scores, they should probably be accurate.

> Regarding your rename-and-tweak-exif photo sets, is the issue that
> there are too many rename src/dst candidates and filling a large
> matrix takes a lot of time, or tweaking exif makes the contents
> unnecessarily dissimilar and causes the similarity detection to
> fail?

The former. We do find the renames; it is just that there are a lot of
them (and worse, they are large blobs, so estimate_similarity is slow to
run). I have to use "-l0" just to get the rename to run at all.

> As we still have the pathname in this codepath, I am wondering if we
> would benefit from custom "content hash" that knows the nature of
> payload than the built-in similarity estimator, driven by the
> attribute mechanism (if the latter is the case, that is).

Hmm. Interesting. But I don't think that attributes are a good fit here.
They are pathname based, so how do I apply anything related to
similarity of a particular version by pathname? IOW, how does it apply
in one tree but not another?

-Peff
