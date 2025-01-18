Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5818E37D
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737204227; cv=none; b=sl+FBTNrq8ngC7d4X8juj079GdOC6NbN2pwe6nwwIIXhTMKsFD5oW3EC8FSNqAqL/8OI9nO+HEtzk4pn4QtBFe7kW8rKNmirHVhn29irjhrCW7ETASLf8PeuM2p2hEts5xXlTHwRgqfSSsGJ5L2BdIm0UdtSuTF4WJkwCakv50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737204227; c=relaxed/simple;
	bh=WjETbZFin80TUBihDEdo/ZlZyZ97QLqmBka0V7gjb6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/6x+l2YPK/9xQVz3ODpIcZ6H6fQXgE5tLAW323euseYsNRvKRwGnerPizt7khisTvU1QgxYrDjPED7xZTPRy6L/n8HOkBVM2lJfChBfrPFoBaEvSYU81Lp+Wov5txiqHmsf0NaATgtwYCViS47fJtydRDQPocCP3otLdVWkB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L+JJK6O4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L+JJK6O4"
Received: (qmail 31406 invoked by uid 109); 18 Jan 2025 12:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WjETbZFin80TUBihDEdo/ZlZyZ97QLqmBka0V7gjb6A=; b=L+JJK6O4qUb6KPZm693sJ/wYjOXJp/GFwcG7Kft2SkA2DLpS44GcYL13241QTIi1ugeEpwkKRsgO+yaONWgGF53s0EZelNEL9p0BHjCNyu5Iw/47J8OAYADZHwZDI6ZTsdSZmk9P3pkoXxjRG6hGru4XFDCfNqsq7K0/8+BkIXUKWee2b0iWkFcf2y0Cow2pK4N/aMwBmPSGnSJdJaI2zFAreG1UFqJWI0j1PAqEebybE8D2ncNyRWlKjBWLpNQuu6vWTIffft8yP8Yi27/dqYNX8Y9RX17Chp5hNIzrl3zPV64Ffwyx8vIiyvuXEjXFCR6hdvPtntzUSioPuRPJoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jan 2025 12:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20426 invoked by uid 111); 18 Jan 2025 12:43:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jan 2025 07:43:43 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jan 2025 07:43:43 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <20250118124343.GA3828177@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
 <20250118122831.GC3510721@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250118122831.GC3510721@coredump.intra.peff.net>

On Sat, Jan 18, 2025 at 07:28:31AM -0500, Jeff King wrote:

> It does make me wonder if hash_algo_by_ptr() should just return UNKNOWN
> for the unsafe variant. Then we'd at least get a loud error from the
> caller (as opposed to the code before your patch, which is undefined
> behavior). I dunno.

Doing this:

diff --git a/hash.h b/hash.h
index 68d4292e6d..ad2c919991 100644
--- a/hash.h
+++ b/hash.h
@@ -311,7 +311,7 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	size_t i;
 	for (i = 0; i < GIT_HASH_NALGOS; i++) {
 		const struct git_hash_algo *algop = &hash_algos[i];
-		if (p == algop || (algop->unsafe && p == algop->unsafe))
+		if (p == algop)
 			return i;
 	}
 	return GIT_HASH_UNKNOWN;

on top of your series doesn't trigger any issues in the test suite.
Which I think shows that we would never have triggered the UB from the
original implementation, either[1]. Still, I think I prefer your loop to
being one errant function call away from undefined behavior. But maybe
returning UNKNOWN (as above) is a safer bet than losing the inverse
nature of the by_ptr() and by_id() functions, which could otherwise
cause hard-to-find interactions?

-Peff

[1] One thing that still puzzles me. If you further add a BUG() to that
    function when we'd return UNKNOWN, you can see that we trigger a few
    cases in the test suite where we pass in NULL (e.g., because we're
    not in a repo). I think these are already UB with the existing
    "p - hash_algos" implementation! We'll return what is effectively
    "p" cast to an int.

    E.g. if I do this:

    diff --git a/hash.h b/hash.h
    index 756166ce5e..ff31156416 100644
    --- a/hash.h
    +++ b/hash.h
    @@ -320,6 +320,8 @@ int hash_algo_by_length(int len);
     /* Identical, except for a pointer to struct git_hash_algo. */
     static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
     {
    +	if (!p)
    +		BUG("null hash, return is %d", (int)(p - hash_algos));
     	return p - hash_algos;
     }

     then t1517 shows grep dying with:

       BUG: hash.h:324: null hash, return is -1646754892

     I think it "works" because the backtrace is:

      [...]
      #5  0x0000556d436f6b71 in BUG_fl (file=0x556d43790e8b "hash.h", line=324,
          fmt=0x556d43790e73 "null hash, return is %d") at usage.c:335
      #6  0x0000556d4357c2f9 in hash_algo_by_ptr (p=0x0) at /home/peff/compile/git/hash.h:324
      #7  0x0000556d4357c437 in oidclr (oid=0x7ffdf5810ea4, algop=0x0) at /home/peff/compile/git/hash.h:392
      #8  0x0000556d435801c7 in prep_exclude (dir=0x7ffdf5811190, istate=0x556d608959c0, base=0x556d6089da50 "nums",
          baselen=0) at dir.c:1699
      [...]
      #16 0x0000556d4344dd4a in cmd_grep (argc=0, argv=0x556d60895ee8, prefix=0x0, repo=0x0) at builtin/grep.c:1257

     So we probably write a totally garbage algo field into the
     object_id, but nobody ever ends up looking at it. Probably
     something we should clean up, but way out of scope for your series.
     But I do think it reinforces that returning UNKNOWN is an
     improvement; it avoids undefined behavior and anybody who tried to
     use it should get a BUG() from calling git_hash_unknown_*()
     functions.

