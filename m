Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B72E2DCB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524403; cv=none; b=VyUsVZUZd9C+p11DyA562YlFdQ2s+ma5nJEiJq0hIdzyU2oIU9JDN/0Dctqk/JyU5fl5PXz0n6JHTmC8P5CyBYb9E2Mv5Eq1rKuRkRn7V4bDKAEmsOG3Xr2G/mBhCxQmgoiRYfb8lnBSqedq9WHcHCUfvRyk9hc1ff6zyvfFBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524403; c=relaxed/simple;
	bh=40bgYHtJwrthjWoZiO/k8O3Ivbdm1sfABwrqqrvsiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkHuSuhv7fcb8dgf8enlfOum951QTBaG0u+xf9wDRoBS5Al2gABEmZ4bZvWIM4tlqAOErSsFza4PSyTAnyTuauSbk5JZErY7WjHbah0673xLRh3hq2qTUIc0fBnkzHl4aCaA4BkCJd7/t30oSfyM4IYnnpo5bQ9j0skHtluIzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V/ZcoEG2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V/ZcoEG2"
Received: (qmail 226713 invoked by uid 109); 15 Oct 2025 10:26:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=40bgYHtJwrthjWoZiO/k8O3Ivbdm1sfABwrqqrvsiQY=; b=V/ZcoEG2LA4GJiuD25Bd10ikzvSOBIOg68KZgDJcZan/2K0NK1QrlP7F5dHjn9Q6/At97qSxOjlHCZUWT1KNXycA6AdyxSl9J7FJ+NZ8GsbQtte1P+R/0EBmajLQQ5VRNN/D2m7Ikyxu/iMsdD0mMcWktfBL+utzgxXQWc6salNIOGRDUcQwyYV2HESy5mgw5+KJu1lUWs+1x8sRbbwEBeaaZnjTB4DJnMZY3ZvwiM4vF6F0Z70iQ5rDCM4+13OvxZzwS0zKZ80IveDWu2p/GkBsxMi998fZctWHGKECInQxHL6l0rEJeT/ZN9hGoWDG1PNgLcZod24cdUfJvs8CXw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Oct 2025 10:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 362929 invoked by uid 111); 15 Oct 2025 10:26:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Oct 2025 06:26:36 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 Oct 2025 06:26:35 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 38/49] builtin/repack.c: inline packs within
 `write_midx_included_packs()`
Message-ID: <20251015102635.GA2250228@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2c7ca9f9e917392de3819ffffffcf78622972b4.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:09:40PM -0400, Taylor Blau wrote:

> The logic for computing which packs are supposed to appear in the
> resulting MIDX is within `midx_included_packs()`, where it is aware of
> details like which cruft pack(s) were written/combined, if/how we did a
> geometric repack, etc.
> 
> Computing this list ourselves before providing it to the sole function
> to make use of that list `write_midx_included_packs()` is somewhat
> awkward. In the future, repack will learn how to write incremental
> MIDXs, which will use a very different pack selection routine.
> 
> Instead of doing something like:
> 
>     struct string_list included_packs = STRING_LIST_INIT_DUP;
>     if (incremental) {
>         midx_incremental_included_packs(&included_packs, ...):
>         write_midx_incremental_included_packs(&included_packs, ...);
>     } else {
>         midx_included_packs(&included_packs, ...):
>         write_midx_included_packs(&included_packs, ...);
>     }
> 
> in the future, let's have each function which writes a MIDX be
> responsible for itself computing the list of included packs. Inline the
> declaration and initialization of `included_packs` into the
> `write_midx_included_packs()` function itself, and repeat that pattern
> in the future when we introduce new ways to write MIDXs.

OK. I thought at first this was doing something complicated, but it
really is just: move the call to midx_included_packs() down into the
function which uses it, rather than doing it in the caller.

Without another caller we can't judge this, but I'll take your word that
it helps eventually.

The patch itself looks like it should be a noop with respect to
behavior.

-Peff
