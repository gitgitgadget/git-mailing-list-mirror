Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD87322B9F
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003285; cv=none; b=lQ+cN1CKJLXfPYGkqECrBKg8TpZHCrtbOB28nAgot4imJFm6QyLpLhQ0YxR/d3xrv5OqUrxifMWiafTkFFFyY6A4XWALlDW3bn30w87JGxWfsbp8OmBBAt9Q2xcu2e+91hQasG6uNla/ADAgF+YnMHsj+qxhTT4u59kP+70fXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003285; c=relaxed/simple;
	bh=15JpPqFMSy/uSLReBF+Cw0C1huVnx2YS1ViQn7uslXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szJVQDt/UGOfzkBLcNk/VetO83b7Se2I56ds1PSsuCZTM5aFTceXkXj5fQ8lF9WABaCl+0nogeIKstqFyC8IrpTAVN7b/OY4+SSvYvdq4mmtM+nUNEcR3lZ5E95jvTlV4lyrbckqVII8loiFMy1Nko+O1APU3I8BYnkQEKo10/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CKZdo8cQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CKZdo8cQ"
Received: (qmail 46811 invoked by uid 106); 29 Aug 2026 11:34:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=15JpPqFMSy/uSLReBF+Cw0C1huVnx2YS1ViQn7uslXc=; b=CKZdo8cQ/ASy92rlCqfJDDKA0If6yujtOQ30/ToZGS8GEvRmiXdS5fpCaEShZDOyflg+jHb4msuHPlCjEo5zfI4n8KQiW6RyL4ODK/DB5q312nXKRbfxrXsE31qaru7t6rbBA/TR4EjCNEm5KYLc39upv+l6+LSNWp5Km2xbIKpOsH2QPXqNeQDOypXCvnluNO55KXYuJM05MEYcE8zaRw12jfY7ZzFS4pX3H+Ay6nlgomE0/fmoC98zwLvUIuagkyaIa7Bs3Ua82O45SXSbsLICAgFRMnSJGv8C+Do/1G4peGFw0BzeatWQsgT214Q1gDUxSKf79W6PBQKj+iYxXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 11:34:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83752 invoked by uid 111); 29 Aug 2026 11:34:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 07:34:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 07:34:41 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/4] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260829113441.GD40814@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
 <eacf6ba4b11e366466da18b7b668e65793c532a9.1787684429.git.gitgitgadget@gmail.com>
 <20260827060622.GC189659@coredump.intra.peff.net>
 <CABPp-BFhPONjNuVZQfgwKuYdgbm5Fjjttz5q5wSYX6j1Zdwdww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFhPONjNuVZQfgwKuYdgbm5Fjjttz5q5wSYX6j1Zdwdww@mail.gmail.com>

On Fri, Aug 28, 2026 at 12:29:49AM -0700, Elijah Newren wrote:

> > We've changed the return value semantics without changing the signature
> > (or name). So we need to make sure we adjust all callers, as here.
> > That's _probably_ OK in practice for such a specialized function. But we
> > could also rename it if we wanted to be paranoid (especially about
> > new callers added on parallel branches).
> 
> Any suggestions for alternate names?  fill_midx_entry_result?  midx_fill_entry?

I did not have a good suggestion, but midx_fill_entry (which it looks
like your new series uses) seems reasonable. It is probably the better
name anyway, as it fits the subsystem_verb_the_thing() ordering.

I'll take a look at the new series and comment further there (if needed;
my fingers are crossed for perfection).

-Peff
