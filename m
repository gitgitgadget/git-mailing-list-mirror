Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58C153BC1
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153936; cv=none; b=C6eQ0ROafuNxiYeTiADdvdWFRfiPbZxkwadRPcJzoAhpmukJYhMqnCCIEXSnWLDLqFrWe0/rGKqB5kOtZWkaDpUNqakEREqOx+2BenQwmiha3Itr98m1eYR8vLr6uDFbUGPv/6TeAvWvrC+xFHp+MFe3Z0ojLc+KgIVRcw2RopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153936; c=relaxed/simple;
	bh=evoOCiHGkBQu5D10fpxusdyJk9AZx5clmOE1GaEy0yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYnPvlRvBy/T9mwMMRBdngQiMNqMmv15TFqwQnoOHE9GHck14PPnGc6oVV6REOmw1gBUdGB+xhtHQYdyvwePsyqhuq3GUGGiI4vprAf1yF2obp9GED68uwUWltMm4c1OWTrGrcKHNKc8AEXaV4/TPQnvULtlVY1djNy0wHMOjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22671 invoked by uid 109); 31 May 2024 11:12:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:12:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9118 invoked by uid 111); 31 May 2024 11:12:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:12:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:12:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 5/5] mv: replace src_dir with a strvec
Message-ID: <20240531111205.GA3608259@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064638.GE1949704@coredump.intra.peff.net>
 <xmqqo78nqpl2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo78nqpl2.fsf@gitster.g>

On Thu, May 30, 2024 at 08:36:25AM -0700, Junio C Hamano wrote:

> Hmph, the rationale given by 9fcd9e4e (builtin/mv duplicate string
> list memory, 2024-05-27) essentially is "the number of elements are
> the same as the number of command line parameters", but I do not
> think that is quite correct.
> 
> When you do "mv srcA srcB ... dst", you'd inspect the command line
> arguments from left to right, notice that srcA is a directory, find
> the cache entries for paths that are inside srcA, append the paths
> in that directory to source[] and destination[] array, and extend
> argc.  "for (i = 0; i < argc; i++)" loop that appends one element to
> src_for_dst per iteration ends up running the number of paths being
> moved, which can be order of magnitude more than the command line
> parameters.
> 
> Of course, if we needed to make copies for correctness reasons (or
> to clarify memory ownership semantics), that alone may be a good
> justification and we do not need an excuse "it's just a handful of
> elements anyway" to begin with.
> 
> Anyway, that is about somebody else's patch, not this one ;-).

Heh, good digging. I actually wondered if I was making the same mistake
while writing mine, but double-checked that src_dir is not expanded in
that way. But I didn't think to check Patrick's original. ;)

IMHO it is probably still OK. We are bounded by the number of entries in
the index (and we already use proportional memory for other parts of the
operation).

-Peff
