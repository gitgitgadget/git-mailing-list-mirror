Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C257584D3B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494831; cv=none; b=fUUE+dHtSY6i6BxoR6r1siDa/l+CZc4yUBSbCwWoqzIbph/NyTKOmkIXCIekGGeOxjc9pfw5VwgEHQoz2jqihJBNJjw9Q8RvyqHcuQKADonp+fSX00Ta50h7O2E4hRX45CYgTTv7ZjGdMwDvq3KzbKDMtBEilgGuXMfiYlfjmRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494831; c=relaxed/simple;
	bh=5tvl6CRBvpV+o49GFEcU0G5eEZMQlH6nFSwODIeL/cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt52HC7aoej8i12YKOb/SSlgrlHz0bBu2MMztmxMs2y5znQV6WwdG6F5BRrLJTfdjicgpWXjEjMtewt5I7tDQ7VArG7Cwd+Q6CtCCGSt71cnPiN9h7D/UDyeE1aN0wkCPmL00FcXH8KKiC9Nk2N95N8z5cmOQIC3Ru4oAPsetUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21188 invoked by uid 109); 4 Jun 2024 09:53:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 09:53:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18182 invoked by uid 111); 4 Jun 2024 09:53:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 05:53:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 05:53:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] sparse-checkout: refactor temporary
 sparse_checkout_patterns
Message-ID: <20240604095348.GB1298378@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531113530.GI428814@coredump.intra.peff.net>
 <Zl7Fe6132gy1JclD@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl7Fe6132gy1JclD@framework>

On Tue, Jun 04, 2024 at 09:42:51AM +0200, Patrick Steinhardt wrote:

> > But there are two possible leaks here:
> > 
> >   1. If the index already had a populated sparse_checkout_patterns,
> >      we've obliterated it. We can fix this by saving and restoring it,
> >      rather than always setting it back to NULL.
> 
> So this isn't only a leak, but also a potential bug because we did not
> restore the old pattern list?

That's a good question, but I think in practice, it's not possible to
trigger the bug. Within a run that calls this function, we only care
about index->sparse_checkout_patterns in the context of this function
itself (that is, we do not otherwise try to read the sparse index). And
in this function, we always want to use the pattern_list that the caller
hands us.

So nobody actually cares about the "restored" pattern list at all
(except that in the lazy-load case, we leak it). Every call will
overwrite it anyway.

> > @@ -241,7 +243,12 @@ static int update_working_directory(struct pattern_list *pl)
> >  
> >  	clean_tracked_sparse_directories(r);
> >  
> > -	r->index->sparse_checkout_patterns = NULL;
> > +	if (r->index->sparse_checkout_patterns != pl) {
> > +		clear_pattern_list(r->index->sparse_checkout_patterns);
> > +		FREE_AND_NULL(r->index->sparse_checkout_patterns);
> > +	} else {
> > +		r->index->sparse_checkout_patterns = old_pl;
> > +	}
> >  	return result;
> >  }
> 
> What I find weird is that we sometimes restore the old value, and
> sometimes we don't. I get that it makes sense to conditionally free only
> the lazy-loaded list. But shouldn't we then unconditionally assign
> `old_pl`?

Yes, I think it would be more correct to do so (otherwise we risk
leaking old_pl). In practice, as I mentioned above, this is the only
function that actually assigns to the index list. So after this hunk, I
think we'd always come in to the function with a NULL value in the
index (it starts NULL, we restore NULL after using a passed-in value,
and we restore free-and-NULL after lazy-loading).

So we _could_ actually drop the "save old_pl" hunk from the beginning of
the function entirely. I only hit that case after trying something like:

  /* only throw away patterns if they were the ones we own */
  if (r->index->sparse_checkout_patterns == pl)
	r->index->sparse_checkout_patterns = NULL;

at the end of the function to fix the leak. And with that code, we _do_
see the lazy-loaded entries in subsequent calls. If we instead do:

  /* throw away lazy-loaded ones */
  if (r->index->sparse_checkout_patterns != pl) {
	clear_pattern_list(r->index->sparse_checkout_patterns);
	FREE_AND_NULL(r->index->sparse_checkout_patterns);
  }

Then I think you don't really need the else clause at all. But I was
trying to be defensive and not make too many assumptions. I think in
that spirit, just restoring old_pl always is the right thing, even
though I don't think we'd ever trigger that.

-Peff
