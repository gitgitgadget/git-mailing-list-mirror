Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2824120A
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846828; cv=none; b=tG8rsGbrN1UdiWO38r51UYop9tBAa2ZdeQ+vx2MI8lear+ox4bxm8nY3FGCPUbQ9r81OA4SU+RPImku6qqYQIEou2+josHzsnA3OJ6mNhFWb6jZGiivZQ64l6HUQGUUmZpc3XaREUvIBkG4c4h6E/tiTDlLV6xJ5IITwMdzryMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846828; c=relaxed/simple;
	bh=NyQwoAGbHpxOB2ZgrA/LQiUOkKiHzHpDfUwpw1HP1JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKECrej+Oot1rtnJzwgtkB7h85j+yo4qiOjCUl0EIFKKEObm2MK3v+8JOTlIaxHfPiC5PNj9WJCbKMvJVEQ31lqCgvzFz7FpDNtxVAyufTeCo4UHV5siKlQ2TwQbFpxeA/0qDiaN5Gt9JwWrjtchwf1TOZUEWSSBOY4iPv4PBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29005 invoked by uid 109); 16 May 2024 08:07:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 May 2024 08:07:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11903 invoked by uid 111); 16 May 2024 08:07:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 May 2024 04:07:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 May 2024 04:07:04 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
Message-ID: <20240516080704.GA85197@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
 <20240513190340.GC2675586@coredump.intra.peff.net>
 <ZkK3KYkA6+zUxu9A@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkK3KYkA6+zUxu9A@nand.local>

On Mon, May 13, 2024 at 08:58:17PM -0400, Taylor Blau wrote:

> > I was going to complain that explanatory text like this should probably
> > go into the documentation, not a commit message. But I see you do later
> > add documentation. Which seems to happen when this code is actually
> > wired up to the bitmap-writer. Maybe a moot point now that I figured it
> > out, but I think we'd be better off with the two commits squashed
> > together.
> 
> I dunno. This commit is already rather large, and I like the split of
> "here's how we select these things", versus "now we actually start
> selecting/writing them".
> 
> But maybe it results in a slightly awkward break in the middle that
> leaves some of the stuff that would otherwise fit well in the EXAMPLES
> section (as you mention below) in a weird limbo state.

It's not the break to me so much as the fact that you end up explaining
the concepts twice. Is it the same material presented in two ways? Or is
there stuff in one spot that is not in the other? I think the answer is
that it's a little bit of both. And as a reviewer (and an author) it's
hard to put yourself in the shoes of a user who is only going to see
what's in the docs.

So I'd rather even see the first patch as "here's some config; don't
worry about what it does too much, as we'll explain it in the next
commit" and then in the second patch say "go look at the config added by
this patch". And then we know we're looking at the same thing a user
will.

> There's a good amount of information already in
> Documentation/technical/bitmap-format.txt, though perhaps some of the
> pieces mentioned here could be added there. Let me know if you think one
> is missing something the other has (or if we could move significant
> portions of the latter into the former).

I don't think we should expect most users to read anything in
Documentation/technical. Now I don't expect most users to fiddle with
this feature at all. But reading over the config docs added by the
subsequent patch, it's not at all clear to me when I would want to tweak
the knobs or why.

I think there might need to be an "advanced packing concepts"
user-directed manual. Either as part of git-pack-objects(1), or maybe
broken out into its own page ("gitpacking(7)" or similar). Specifically
for this feature, I think it would want to cover:

  - what is this thing, and why would I want it. You cover this in the
    format doc, but I think it makes more sense in a user-directed doc
    (and to leave the format doc strictly as a technical reference).

  - what you wrote in "use cases" there is still, IMHO, introducing
    things in the wrong order for a regular user. They're going to come
    to the documentation either with a specific problem, or with an idea
    to browse around for things that might help them.

    So I feel like it needs to start with the concept and the
    motivation. Something like (assuming we're following a section on
    bitmaps in the "advanced packing" page, something I recognize also
    does not yet exist):

      Reachability bitmaps are most efficient when we have on-disk
      stored bitmaps for one or more of the starting points of a
      traversal. For this reason, Git prefers storing bitmaps for
      commits at the tips of refs, because traversals tend to start with
      those points.

      But if you have a large number of refs, it's not feasible to store
      a bitmap for _every_ ref tip. It takes up space, and just OR-ing
      all of those bitmaps together is expensive.

      One way we can deal with that is to create bitmaps that represent
      _groups_ of refs. When a traversal asks about the entire group,
      then we can use this single bitmap instead of considering each ref
      individually. Because these bitmaps represent the set of objects
      which would be reachable in a hypothetical merge of all of the
      commits, we call them pseudo-merge bitmaps.

   I don't think this is saying anything that your technical doc
   doesn't, but I think it's more important what it _isn't_ saying.
   We don't need to talk about commit bitmaps and merge bitmaps at all.
   We just want the user to have the concept of grouping refs. And then
   that would hopefully lead naturally into "OK, so how do we group
   them".

  - OK, so how do we group them? ;) I think there are two concerns here.
    One is that traversals can only use a pseudo-merge bitmap if _every_
    commit in its group is included in the traversal. So we want to
    group the refs along logical boundaries (e.g., tags vs branches vs
    remotes). Or in the case of shared-object repositories (like
    GitHub's), by boundaries which only the user knows about.

    And two is that we want groups that don't become invalidated when a
    ref changes or is removed. So you want a bunch of old, stable tags
    together, and probably don't want recent branches grouped at all.

    And then when we describe the config knobs you can turn, it should
    be in the user's mind how they can use them to influence those two
    things. For "logical boundaries" part, I think the commit message
    for patch 9 does some of that with the "refs/virtual" example. But
    that's something I don't see as clearly in the config documentation
    added in patch 10.

    The knobs for handling age are more complicated and harder to
    explain. ;) You do mention the power-law decay thing in patch 10,
    but it's in the technical format docs. I think it should be
    somewhere more user-accessible.

So hopefully that kind of lays out how I'm thinking about it. Both where
the docs go, but what I think are the useful ways to be thinking about
the feature. And not just for users, but as we see if the design is
doing a good job of fulfilling those needs.

I think the name/pattern config you introduce does cover the logical
boundaries in a clean and easy-to-understand way. The "age" stuff is
much fuzzier in my mind. Your power-law decay makes sense to me, though
it does have a lot of knobs, and I don't think we'll really understand
how it performs without real-world experimentation.

I do wonder if something stupidly simple like "just make a single group
including tags older than 3 months, and ignore everything else" (where
"single" is "single per logical boundary defined by the user") would
perform OK in practice. The point is to help "--all" and "--not --all"
when you have a bunch of crufty old refs. So really, the challenge is
mostly just identifying crufty old refs. ;)

But I do think your power-law stuff should be a functional superset of
that. And while it's complicated to reason about where the knobs should
be set, I don't think the code is very complex. And the fact that it
_has_ knobs gives something to tweak and gather data with.

All of which is to say, I guess, that I think the code is going in a
reasonable direction. It's hard to say much more without spending a
bunch of time benchmarking real repositories, their traversal queries,
and so on.

-Peff
