From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Fri, 10 Jan 2014 04:41:20 -0500
Message-ID: <20140110094120.GB17443@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235953.GD10657@sigill.intra.peff.net>
 <52CD7835.2020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 10 10:41:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Yb9-0003Gb-56
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 10:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbaAJJlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 04:41:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:58311 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751867AbaAJJlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 04:41:22 -0500
Received: (qmail 10789 invoked by uid 102); 10 Jan 2014 09:41:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Jan 2014 03:41:22 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jan 2014 04:41:20 -0500
Content-Disposition: inline
In-Reply-To: <52CD7835.2020708@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240299>

On Wed, Jan 08, 2014 at 05:09:25PM +0100, Michael Haggerty wrote:

> It's not only racy WRT other processes.  If the current git process
> would create a new reference, it wouldn't be reflected in the cache.
> 
> It's true that the main ref_cache doesn't invalidate itself
> automatically either when a new reference is created, so it's not really
> a fair complaint.  However, as we add places where the cache is
> invalidated, it is easy to overlook this cache that is stuck in static
> variables within a function definition and it is impossible to
> invalidate it.  Might it not be better to attach the cache to the
> ref_cache structure instead, and couple its lifetime to that object?

Yeah, I noticed that we don't ever invalidate the loose ref cache. I
think that's mostly fine, as we rely on resolve_ref to cover the cases
that need to be ordered properly. And in this particular case, it's
"only" a warning (and a rather obscure one, at that), so I think the
stakes are low.

That being said, it should not be hard at all to attach the cache to the
ref_cache. Since we are generated from that cache, the lifetimes should
be the same.

> Alternatively, the cache could be created and managed on the caller
> side, since the caller would know when the cache would have to be
> invalidated.  Also, different callers are likely to have different
> performance characteristics.  It is unlikely that the time to initialize
> the cache will be amortized in most cases; in fact, "rev-list --stdin"
> might be the *only* plausible use case.

The two I know of are "rev-list --stdin" and "cat-file --batch-check".

> Regarding the overall strategy: you gather all refnames that could be
> confused with an SHA-1 into a sha1_array, then later look up SHA-1s in
> the array to see if they are ambiguous.  This is a very special-case
> optimization for SHA-1s.

Yes, it is very sha1-specific. Part of my goal was that in the common
case, the check would collapse to O(# of ambiguous refs), which is
typically 0.

That may be premature optimization, though. As you note below, doing a
few binary searches through the in-memory ref cache is _probably_ fine,
too. And we can do that without a separate index.

> I wonder whether another approach would gain almost the same amount of
> performance but be more general.  We could change dwim_ref() (or a
> version of it?) to read its data out of a ref_cache instead of going to
> disk every time.  Then, at the cost of populating the relevant parts of
> the ref_cache once, we would have fast dwim_ref() calls for all strings.

I'm very nervous about turning dwim_ref into a cache. As we noted above,
we never invalidate the cache, so any write-then-read operations could
get stale data. That is not as risky as caching, say, resolve_ref, but
it still makes me nervous. Caching just the warning has much lower
stakes.

> It's true that the lookups wouldn't be quite so fast--they would require
> a few bisects per refname lookup (one for each level in the refname
> hierarchy) and several refname lookups (one for each ref_rev_parse_rule)
> for every dwim_ref() call, vs. a single bisect in your current design.
> But this approach it would bring us most of the gain, it might
> nevertheless be preferable.

I don't think this would be all that hard to measure. I'll see what I
can do.

> > I wanted to make the ref traversal as cheap as possible, hence the
> > NO_RECURSE flag I added. I thought INCLUDE_BROKEN used to not open up
> > the refs at all, but it looks like it does these days. I wonder if that
> > is worth changing or not.
> 
> What do you mean by "open up the refs"?  The loose reference files are
> read when populating the cache.  (Was that ever different?)

I meant actually open the ref files and read the sha1. But that is me
being dumb. We have always done that, as we must provide the sha1 via
to the for_each_ref callback.

That being said, we could further optimize this by not opening the files
at all (and make that the responsibility of do_one_ref, which we are
avoiding here). I am slightly worried about the open() cost of my
solution. It's amortized away in a big call, but it is probably
noticeable for something like `git rev-parse <40-hex>`.

> This doesn't correctly handle the rule
> 
> 	"refs/remotes/%.*s/HEAD"
>
> We might be willing to accept this limitation, but it should at least be
> mentioned somewhere.  OTOH if we want to handle this pattern as well, we
> could do use a technique like that of shorten_unambiguous_ref().

Yes, you're right. I considered this, but for some reason convinced
myself that it would be OK to just look for "refs/remotes/<40-hex>" in
this case (which is what my patch does). But obviously that's wrong.
The ref traversal won't find a _directory_ with that name.

I'll see how painful it is to make it work. I have to say I was tempted
to simply manually write the rules. It's a duplication that could go out
of sync with the ref_rev_parse rules, and that's nasty. But that list does
not change often, and the reverse-parsing of the rules is error-prone
and hard to understand itself.

-Peff
