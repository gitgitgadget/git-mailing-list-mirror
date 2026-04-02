Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E421DE2D3
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109683; cv=none; b=LNFWHHggB5V+Qp3dgvKD4v6zkU3kZcoeM9h7r96WF+YE1Xs22+wO5AO/rNpZqzyMvncud0ZcBkt07tWS/Vz3kgQFebxS5J7oTGS8AjBLhvXLa7NyB1urk4bWsZmtvU+0/nQAeRTVlR513/g8OP/URpKtIxozcmzRSLouSHlIYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109683; c=relaxed/simple;
	bh=O/e03fTQwDeaTBAnzcLBaZCj2nJ8Np2Qb5bG4Ciim7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2qN9NznTfV8I8oeU1jKpveWfMENbFFLU5gQ8mwcEEdqeKnuw50Ik60iYNRJ7aynNfNBFPvUUsWP/Dml8gsUUuzslW5A8eXE+uh0TJg0gzE1X4Edhgu/2War9cUqeOiPyIt91qkAokyVMDt9oflP2Pui0i/2DigMSmooVpjCa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KbtUo2HQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KbtUo2HQ"
Received: (qmail 219456 invoked by uid 106); 2 Apr 2026 06:01:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=O/e03fTQwDeaTBAnzcLBaZCj2nJ8Np2Qb5bG4Ciim7A=; b=KbtUo2HQjksYo1ssy1X7ndB/HODqPR+KZJYzCNlwAkc7qhVIvy13JdIgAO68ZaMYMDw3YNZjSsgXnXCAjdPvFjPjAxHR3UGfQ7bvzYUtWDqrhOIjVC5ecmToneNYyLYmVY9Ov0tPrv07Ws8sGP/sQtut12bIguJmWJCbGtUsMO5qJtK16IMQ8d3V8xyy3WI50vP0qLa0Vny0ltGPGNmiApzH+g73H4bpcgam4y/7f6TFZLmHnKd+HYt+skVI9XJ+p12GzWdnDdIS/DxlWJF6o0V4b2QC9rRo0zadvU+rSdoUKQbSWjIqGA/PuN/RG6eO6GYzwpNOPyIjs9PqYlbWzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 06:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 350849 invoked by uid 111); 2 Apr 2026 06:01:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 02:01:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 02:01:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 08/12] skip_prefix(): check const match between in and
 out params
Message-ID: <20260402060119.GA3504521@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
 <20260402041507.GH3501239@coredump.intra.peff.net>
 <xmqqeckyt08e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeckyt08e.fsf@gitster.g>

On Wed, Apr 01, 2026 at 10:11:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +/*
> > + * Check that an out-parameter that is "at least as const as" a matching
> > + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> > + * of "str". So:
> 
> Sorry for not mentioning earlier, but I couldn't quite parse the
> above with "that" immediately after "out-parameter".  I am guessing
> that you wanted to say an equivalent of
> 
>     Check that an out-parameter "out" is at least as const as a
>     matching in-parameter "in".

Yes, it's just a typo. What you wrote is what I meant. Can you fix it up
while applying?

-Peff
