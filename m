Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A24908D7
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727848; cv=none; b=owbM21PhWUE/iWSGLoj6sgMLs/7KjoLyO5mbu/vEHfhtPVaeS0D7rJWQy2oNkSd0g058bygH+F3UrKSQKAoouP34idsF8a1L+OblJA6FO1Biu5z+0wI135cLgCQvR099BTMWHVZo3wrWCxNkJFMpsWvMSv4Vhiuq714ki9eNJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727848; c=relaxed/simple;
	bh=8X2gFzBNqFq0tY+QN0nkvuofqkCBnm83Il7q/6SUCdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFS2Z+IlJwIQj3cXW+SDjghwtXyUXFgvZXnDgKbuOknt+/tcob5S4+E2Mi3rnGTTJgguMulUYmHkHTJOX06J4GxL81M7qK8Skh3O3YmdsmHCZvtFF/Y0zZHs5t9ceW1rw9+BPsiiqWWB83yJb8oEvj2Kuzd0Q+1091i3frgr4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K3S9t+fp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K3S9t+fp"
Received: (qmail 60752 invoked by uid 106); 14 Aug 2026 17:17:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8X2gFzBNqFq0tY+QN0nkvuofqkCBnm83Il7q/6SUCdQ=; b=K3S9t+fp06NH2NImhDQROcIFfqS3dSDhIIzrCd46LrCe9mvFISIhcV6LzMLm8ybwjXylwJYytLOIeuB2Ff55Ud/0JonpOZn0cdLsVmxmoOG/qPmGqTgzoS4oGvyBXzrvAHeIQy2JOkJYI87TAx61Dc9vMt4wG3bvssXvQM/NAmsgRBzh9xDHtFXectGsKiS0+xoORQSnp+M4j6p8wwXNtZsjoqEPCn86dVmlcWbweB9+okaixYCdvUFeoYhH4SJO/GJQiIWrwSJtNrMZD3mVSrO3ZzdAGRDgudQ5Y9ml6eV20dpG0l7c93t9keR464/+gyYte2KPilvkCD5uApMkHA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2026 17:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 59212 invoked by uid 111); 14 Aug 2026 17:17:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2026 13:17:24 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Aug 2026 13:17:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260814171724.GB2563235@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>

On Wed, Aug 12, 2026 at 11:13:57AM +0200, Patrick Steinhardt wrote:

> When registering alternates we deduplicate object database sources by
> their path so that the same source won't be added twice. Ever since
> cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> this duplicate check is backed by a map keyed by the source's path,
> using `fspathhash()` and `fspatheq()` as hash and equality functions,
> respectively.
> 
> These functions are problematic in this context for two reasons:
> 
>   - They implicitly depend on `the_repository` instead of the
>     repository that owns the object database.

I'm not even sure that using core.ignorecase here is strictly correct.
It is a property of the containing repository, and the filesystem in
which it's stored. But there is no guarantee that the alternate
directories are in the same repository, or even the same filesystem!

So it is really just a best guess proxy for "this system tends to use or
not use case insensitive filesystems[1]". It can be wrong in both
directions (failing to suppress duplicates, and suppressing them when
they are not actually duplicates).

I wonder how bad it would be if we just always did case-sensitive
comparisons and made it the caller's responsibility to spell things
consistently.  I guess some names ultimately come from things like
"--reference" command-line arguments, so that would depend on user
spelling. But having duplicates at all is kind of unlikely (you can't
get it from one --reference clone, but rather a complex tree of
interwoven repos with shared roots).

How bad is a duplicate alternate? It's a minor performance issue, I'd
think. We would add its packs to the list (though hardly ever look
through them, as the "first" copy would satisfy most requests, and the
unused second copies end up at the back of the MRU list). You'd only pay
the extra lookup cost for an object which we fail to find entirely,
which is rare-ish (mostly speculative lookups for fetches).

And it would fix the unlikely-but-possible opposite case of suppressing
a non-duplicate. If you have a repo on a case-insensitive filesystem
with two alternates on a case-sensitive system that differ only in case,
we erroneously suppress one of them, and commands may fail to find
objects we should have. Of course that's super unlikely, which is why
nobody has run into it before.

So I kind of wonder if we could just do away with considering case
insensitivity here at all. We'd err on the side of correctness in the
ambiguous cases, and this code complexity can just go away.

Alternatively, I think we could probably make the check more thorough in
a similar way. Always consider a pair of case-insensitive matches as
possible duplicates, and then for each possible duplicate use stat() to
check their st_dev and st_ino values. That keeps things cheap for normal
cases, and we pay only the stat() before de-duping. It's correct and
doesn't rely on the repo, though it is a bit more somewhat complicated
code.

-Peff

[1] Even on a single filesystem I think case-sensitivity check is not
    completely sufficient either. We know that filesystems do more
    complicated one-way transformations than just case folding, like
    unicode normalization or even removing some funky code points.
    We'd miss those "equivalent" spellings.
