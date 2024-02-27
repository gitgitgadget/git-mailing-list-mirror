Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090051332A9
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024750; cv=none; b=AAIYUiJFCnznGrg2ZiEGuvTsBNzkUcrgJywmzIFVL0flxvZALlkr30DlmcX3pvLad1SNdHDr0/CgRUm+BUI8akdv2lq0kAg7LcOeX4o89gns1jSFoOjnmuuOi34034/yoYjuk8ZFlaQzYiynbkxX1fjfHswctFuoN/xjyyk+ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024750; c=relaxed/simple;
	bh=z7x50ebCEZ31LFdPC5Dfiet3A3B5Xl881ATH89g4fFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN4Gb/OLTPO3vZ2yzVNDPRghM+0qazofcyTVsIitBb9ufrzNou3IISU/L5WRuJlkZp/CP6V+XWT9APdlwDXqLp3P9uIGh53WTk44fpV46ASVoST092w0yQFrNwTvFuX6eEXz4xCZVtjiYS4DMrusW6FA9nvnD8XJNKQjhEwTsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12086 invoked by uid 109); 27 Feb 2024 09:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 09:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7838 invoked by uid 111); 27 Feb 2024 09:05:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 04:05:52 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 04:05:47 -0500
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Sven Strickroth <sven@cs-ware.de>, Junio C Hamano <gitster@pobox.com>,
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
Message-ID: <20240227090547.GK3263678@coredump.intra.peff.net>
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com>
 <xmqqh6i0cgyo.fsf@gitster.g>
 <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
 <xmqqle76iwqw.fsf@gitster.g>
 <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
 <20240227084529.GJ3263678@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227084529.GJ3263678@coredump.intra.peff.net>

On Tue, Feb 27, 2024 at 03:45:29AM -0500, Jeff King wrote:

> It is good to clean up old conditionals if they are no longer
> applicable, as they are a burden to reason about later (as this
> discussion shows). But I am not sure about your "just to demonstrate we
> can". It is good to try it out, but it looks like there is a non-zero
> chance that MSVC on Windows might break. It is probably better to try
> building there or looping in folks who can, rather than just making a
> change and seeing if anybody screams.
> 
> I think the "win+VS" test in the GitHub Actions CI job might cover this
> case. It is not run by default (because it was considered be mostly
> redundant with the mingw build), but it shouldn't be too hard to enable
> it for a one-off test.

Here's a successful run with the NO_INTTYPES_H line removed:

  https://github.com/peff/git/actions/runs/8062063219

Blaming the code around the inttypes.h reference in compat/mingw.h
turned up 0ef60afdd4 (MSVC: use shipped headers instead of fallback
definitions, 2016-03-30), which claims that inttypes.h was added to
VS2013.

That sounds old-ish in 2024, but I don't know how old is normal in the
Windows world.

All of which to me says that cleaning this up is something that should
involve Windows folks, who can make the judgement for their platform.

-Peff
