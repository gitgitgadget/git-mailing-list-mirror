Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B127482
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608840; cv=none; b=EarfeB0iZF42HUtKL4QyjjwBIQyDcsXYNM40uVuAbIInbEKwy49L/O9D7cljFz062DZDMAyB073JPCWFoTQ6RArus3Y/01BK/nETQkc9tfmU+OkXHUdTpctRnOifoYC7TI3RD3frJgM9SXwS+8OUd6kj/+eROfdAZZFzqfntJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608840; c=relaxed/simple;
	bh=2Rhf67hcbG1yEFCNpAiBik6GPnnRo32i6+Q9mgHrV/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aicebaA/MkqiWafWnDu1pz+FPC9uGki0cg9yGQXA2ROYXwOlV0FVvwbe9KkcjzRxbKlUjD2bhE8QNmPlwCxuz/hNV8w1KAGZWyvfv2Xu5EgjoL180oqNsUwlakXdAWE36/Z+eP9NRQv2Ls1VVgeD5KaEjjv3GabQMYMsosEIiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31418 invoked by uid 109); 8 Apr 2024 20:40:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Apr 2024 20:40:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28965 invoked by uid 111); 8 Apr 2024 20:40:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 16:40:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 16:40:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] t: teach lint that RHS of 'local VAR=VAL' needs to
 be quoted
Message-ID: <20240408204036.GA1639295@coredump.intra.peff.net>
References: <20240406000902.3082301-1-gitster@pobox.com>
 <20240406000902.3082301-7-gitster@pobox.com>
 <20240407014344.GF1085004@coredump.intra.peff.net>
 <xmqqa5m3damh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5m3damh.fsf@gitster.g>

On Mon, Apr 08, 2024 at 10:31:34AM -0700, Junio C Hamano wrote:

> > Hmm. Just porting over my comment from the other thread (before I
> > realized you'd written this series), this misses:
> >
> >   local foo=bar/$1
> >
> > etc. Should we look for the "$" anywhere on the line? I doubt we can get
> > things foolproof, but requiring somebody to quote:
> >
> >   local foo=$((1+2))
> >
> > does not seem like the worst outcome. I dunno.
> 
> Looking at the output from
> 
>     $ git grep -E -e 'local [a-zA-Z0-9_]+=[^"]*[$]' t/
> 
> the listed ones in the proposed commit log message are the false
> positives.  Luckily we didn't have anything that tries to
> concatenate parameter reference to something else.
> 
> But with the pattern we do miss
> 
>     local var=$*
> 
> and possibly many others.  So I am not sure.  The false positives
> do look moderately bad, so I'd rather start with the simplest one
> proposed in the patch.

Yeah, I think a regex is probably going to end up with either false
positives or false negatives. It probably does not matter too much which
way we err, if we expect them to be rare on either side.

My thinking was mostly that false negatives are worse, because they only
matter on old buggy versions of dash (and only if the tests actually
pass a value with spaces). And so most developers will not notice them
immediately. Whereas false positives, while annoying, are reported to
them immediately by the linter. And generally, dealing with problems
closer to the time of writing means less work overall.

But I am happy to take your series as-is and we can see which cases (if
any!) we miss in practice.

I do hope that eventually we could just say "that buggy version of dash
does not matter anymore", but I think it is too soon for that (it sounds
like it is still being used in CI).

-Peff
