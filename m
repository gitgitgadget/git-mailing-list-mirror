Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A606376F1
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088892; cv=none; b=VP7qG1gI5ungfU2jxAZcr5zam0VRKJJaTIEhLCBfVubsnLuLIc34tdMXvsbZCTB0rcwghkGXvNLDz+uVXTbhL9tz/XLwhZeGqN9Vjh0EnudYcKsR/bsr3+vMxU54Q9orswIIT0D96n9gaskuB+v+kH387Ouf3G0e+2EFV/cpOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088892; c=relaxed/simple;
	bh=L7ob+QbzICeurCs5cazlxgJr2K3mDEMIQmUN/lRX2tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYnEMFeAtj4Xh7Of4Sl7rJAwXuC8FssY4KtBAFw78fj/naqMVcIhPDR9XRbh9krr5rFrVqLR6ARB6pynLUwtmV+si56+9ieOAsOx1R32K0qozm6ECTD9csbjp/urI3/nejftyputiPIXpFkTIArKIz96YlVTd2AsaOG3sV2VM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a+pI5SXM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a+pI5SXM"
Received: (qmail 3586 invoked by uid 109); 1 Dec 2024 21:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L7ob+QbzICeurCs5cazlxgJr2K3mDEMIQmUN/lRX2tI=; b=a+pI5SXMZVgcFwJ53Qc+PUeRWyvg1E43bISrKU/w87SE3dAp7Ep0ZOcXIiq3zzZ7BDN3m38WBFXLQ9SEveaj16qds9rXR+4GIKclW4RaePtrCKQC7flcmPJxx5kV3wdthTJhbNDedjetHPH8qTH8Ow7i74qITeJLxZUnmeHyNygQwy2czr9wjD8DKRTT2ds3WWP8lixyoToxi2ULAddoi+tEszYb/d+Owd5bDyBIwtINFtue/ldhh7hRC5bIbow3PhbapwkOmRzFt2Lgm9zQlC99macjOY+Iu2By6rypp2so1fg7N7WQI8bWGDK2KDzMl4hky5fNiz5xuZeNIvpLcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 21:34:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13837 invoked by uid 111); 1 Dec 2024 21:34:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 16:34:39 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 16:34:39 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/repack.c: prune unreachable objects with
 `--expire-to`
Message-ID: <20241201213439.GA145938@coredump.intra.peff.net>
References: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48438876fb42a889110e100a6c42ca84e93aac49.1733011259.git.me@ttaylorr.com>

On Sat, Nov 30, 2024 at 07:01:03PM -0500, Taylor Blau wrote:

> When invoked with '--expire-to', 'git repack' will move unreachable
> objects beyond the grace period to a separate repository outside of the
> main object store.
> 
> Later on, 'git repack' will remove any existing packs which were made
> redundant by the 'repack' operation, before then pruning loose objects
> which were packed. Ordinarily, unreachable objects which have expired
> were already packed via some earlier 'repack' operation, and so are
> removed from the main repository in the first step.
> 
> But if a repository has unreachable objects which:
> 
>   - have an mtime earlier than the --cruft-expiration period,
>   - are loose, and
>   - have never been packed
> 
> Then we'll create a pack containing those objects to store in the
> repository specified by the '--expire-to' option, but never prune the
> loose copies of those objects from the main repository. That's because
> we don't have a pack in the main repository which contains those
> objects, so prune_packed_objects() skips over them.
> 
> (As an aside, for repositories that have a large number of unreachable
> objects which were never packed, and are old enough to be expired, this
> can be quite painful. That's because even though we expect the repack to
> prune those objects which were GC'd, we don't per the above).
> 
> Teach repack to add the repository specified by '--expire-to' as an
> alternate of the main object store so that 'prune_packed_objects()' can
> "see" the packed copy of those objects, and remove them appropriately.

I think the solution you came up with makes sense in the confines of
what "repack --cruft" and "--expire-to" do. But I can't help but feel
that we may have taken a wrong (or at least somewhat confusing) turn
before this.

That is, why are we expecting "repack" to prune those loose objects at
all? In a traditional "repack -ad" they would not be removed, because
they are not packed and not reachable. It is the responsibility of a
follow-up "git prune" to get rid of them, and that is run automatically
by "git gc".

When we added in cruft packs, now those objects are "packed" in the
sense that we are storing them in a cruft pack instead of loose. But
they are not really "packed" in the sense that the original "repack"
would do. They're not in a pack we intend to keep, and the storage in a
cruft pack is mostly an incidental optimization over the loose format.
But "repack" started deleting them (because it knew they were moved into
a cruft pack), rather than waiting for "git prune" to do so. Which is a
little weird, but OK.

But then --expire-to adds extra confusion because we are _really_ not
packing them in the repository now. They are going to some magical
out-of-repo spot. Which yes, happens to be a pack. But I think one could
argue that they are not packed in the repo at that point, and it the
responsibility of "git prune" to get rid of them.


Now all of that is fairly philosophical. Is there a real-world benefit
to trying to retain this more purist view-point? I don't know. Certainly
I can think of some downsides, one of which is that running a follow-up
git-prune requires computing the full reachability again. That's both
expensive and racy with respect to what we saved in the cruft pack.

So I think there's some argument there that the pruning _has_ to be part
of the repack process for atomicity, and therefore --expire-to has to do
the same.

> @@ -1553,6 +1553,21 @@ int cmd_repack(int argc,
>  							&existing);
>  		if (show_progress)
>  			opts |= PRUNE_PACKED_VERBOSE;
> +
> +		if (expire_to && *expire_to) {
> +			char *alt = dirname(xstrdup(expire_to));
> +			size_t len = strlen(alt);
> +
> +			if (strip_suffix(alt, "pack", &len) &&
> +			    is_dir_sep(alt[len - 1])) {
> +				alt[len - 1] = '\0';
> +
> +				add_to_alternates_memory(alt);
> +				reprepare_packed_git(the_repository);
> +			}
> +
> +			free(alt);
> +		}

OK, so we are adding the containing directory as an alternate. That
gives me two concerns:

  1. The expire-to string is something like "path/to/objects/pack/pack",
     and we'll have created "path/to/objects/pack/pack-<hash>.pack"
     Using dirname() strips that down to "path/to/objects/pack". OK. And
     then we manually strip "pack/" off the end, which we have to do to
     get the "base" objects/ directory.

     But what if the path given by the user via --expire-to doesn't look
     like an object directory? I.e., does not end in "pack/"? Then this
     feature would not work at all.

     Should we be mentioning this in the git-repack docs?

     As an aside, I think the current --expire-to docs are misleading.
     They say:

       --expire-to=<dir>
	   Write a cruft pack containing pruned objects (if any) to the
	   directory <dir>. [...]

     But that isn't right. It is not a <dir> but a <base-name> similar
     to the one that pack-objects takes. If you do --expire-to=some/dir,
     then you'll get some/dir-<hash>.pack.

  2. Since we're adding the whole directory, that reprepare_packed_git()
     will also find any existing packs that were sitting in the
     --expire-to directory. If you are repeatedly stuffing cruft packs
     into the same directory every time you repack, then you'll see
     those older packs, and we'll prune objects that they mention. I'm
     not sure it's too bad from a correctness perspective to allow that
     (and I think they'd have ended up in the most recent cruft pack
     anyway). But I wonder if the expense of checking those packs
     eventually adds up.

One thing that could perhaps deal with both issues is to add the single
cruft pack itself, rather than the surrounding directory. I.e., would it
work to add_packed_git() and install_packed_git() each cruft pack
(should just be one, but I think in theory there may be multiple if
maxPackSize is enabled)?

It's maybe a little weird to have an entry in packed_git that doesn't
come from an object database that we're using. But I don't think there
are any problems with that (I'd probably pass "0" for the "local" flag
;) ).

The only other gotcha I see is that you probably need to
reprepare_packed_git() afterwards to make sure the packed_git_mru list
is refreshed.

-Peff
