Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762373BB22
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754027; cv=none; b=WJIiR9ran4ynQ1d6l/94PuZseh1+RD5T+0wYJUphtMJhVwZJ/xi8hiXkeKSepmEAS5y5V5xLkG8eoZE9LGmDzHclK/bIRrF53Pdv8upcWQKzasfBSCRBTEp59MacUIurCb3OX5Z4JGbUhu2j6uYPwlJMYgzMQknk1n9rc71GTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754027; c=relaxed/simple;
	bh=Rb/8hAe9fIvyy7voSiK0SVnff432Pie6/zD+Kp3i1QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEb+JSJKXs4Rs0014K0QMj28buP+WjTUF2voxdkJ10dJfoeBqxDXSCh2S1Edu+rRC7dd+2BKQRPRX2+1d9BkzR6e8zM8rmhQpAWusw4jo+8xVaSPOH0b/dMX2moStUW0bTt3+hEUjeEWxApptMZOmCGGlOe2yOZNUZSE8V9WFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15011 invoked by uid 109); 15 May 2024 06:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30704 invoked by uid 111); 15 May 2024 06:20:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:20:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:20:23 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <20240515062023.GB110841@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkQ3EiL1OY10Y2JP@tanuki>

On Wed, May 15, 2024 at 06:16:18AM +0200, Patrick Steinhardt wrote:

> > Making the classification purely syntactic based on the name feels
> > simpler to me to reason about. You'll never run into confusing cases
> > where repo state changes how commands may behave.
> 
> I certainly agree and have been complaining about that in the past, too.
> I didn't dare to change the semantics this far yet. Let's have a look at
> the callers:
> 
>   - "ref-filter.c:ref_kind_from_refname()" uses it to classify refs.
>     It's clear that the intent is to classify based on the ref name,
>     only.
> 
>   - "refs/files_backend.c:add_pseudoref_and_head_entries()" uses it to
>     determine whether it should add a ref to the root directory. It
>     feels fishy that this uses ref existence checks to do that.
> 
>   - "refs/reftable_backend.c:reftable_ref_iterator_advance()" uses it to
>     filter root refs. Again, using existence checks is pointless here as
>     the iterator has just surfaced the ref, so it does exist.
> 
>   - "refs.c:is_current_worktree_ref()" uses it. Fishy as well, as the
>     call to `is_per_worktree_ref()` also only checks for the refname.
> 
> So let's remove these existence checks altogether and make this a check
> that purely checks semantics.

Thanks for doing the digging on the callers. That matches my intuition /
light analysis, which is good. ;)

> > And arguably is_pseudoref_syntax() should be taking into account the
> > "_HEAD" restriction and special names anyway. It is a bit weird that
> > even if we tighten up the refname checking to use is_pseudoref_syntax(),
> > you'd still be able to "git update-ref FOO" but then not see it as a
> > root ref!
> 
> True, as well. I'm less comfortable with doing that change in this
> series though as it does impose a major restriction that did not exist
> previously. We probably want some escape hatches so that it would still
> be possible to modify those refs when really required, for example to
> delete such broken refs.
> 
> I would thus like to defer this to a follow up patch series, if you
> don't mind.

I don't mind deferring. I thought it might make the simplifications
you're doing in this series easier to reason about. But TBH I haven't
had the chance to look through your series very carefully yet (and I'm
still a bit back-logged), so I'm happy to go with your judgement on how
to split it up.

-Peff
