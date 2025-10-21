Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3DF1FC8
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034825; cv=none; b=nJuKYzP2R8vc5hT/R8rE6xoUBghUWs6iJ//FtixD29g/1nALjQp06WiRjZLpPEo9MS6u0gRKhi6tBeQHulsohaV6LqtVk5DdRlRXHz9PksqanhcVUFR2y4lTIALW4GBNAG+eK4TXjKjnjV6bblSkZUrQRiJc0qa16u/zGkvJILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034825; c=relaxed/simple;
	bh=Nf2OFeio3L4ThMckB4ikgrepkt9Tieev/qhT6tQV3/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUaalGLfN/vdRSZx3uGCRP5Tvht82Zb1KSNTjBzsQPbnwCwuOvc2RZ+ov4YtfHlkX0YyHKYONdTxIVDZp8/gvaUeZMFiPE78o/lewI/8Vz8WrAJYCawJegX3/XsYWb6nj1TnGBZsRK+pfu0EjX9wWiVG+yaR4wwGjS4A3vVxrYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gJVIqhDU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gJVIqhDU"
Received: (qmail 292119 invoked by uid 109); 21 Oct 2025 08:20:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Nf2OFeio3L4ThMckB4ikgrepkt9Tieev/qhT6tQV3/E=; b=gJVIqhDUXB2UNpUMU4QlGchbuFR0fdW0vOiQhA6TkWbFOPhsSqTHWsCmuA7hYlAkMZzEyS1/nNoC69/sqqB394tztvVfoS0GU3svFa4sXFSufj3Aq+0iq9JJk8UFTu91TuuTjPTU6P69Oj/byWYg5ZX88GPkKNPzFXGSJgYrdGudwpPMZbzLB/YPmhoUcWyQZTFGvzoPHDJwsVPcdsi21yTFeQe8SbhBqNBQ7rhnP/G8pzcLgATtg5wTTWzkHL13ymebN/PjAGwHCVh2JW0obHX7MhHP1DsYU6ahL4MOoqrD2DAmJnkTfFvfvVkMIFbEV+Xqlbws3tpq90WHlEgllg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Oct 2025 08:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 455191 invoked by uid 111); 21 Oct 2025 08:20:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Oct 2025 04:20:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Oct 2025 04:20:21 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <20251021082021.GF259661@coredump.intra.peff.net>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
 <20251017063039.GA3074253@coredump.intra.peff.net>
 <aPJYvYs8W6LrV+0Q@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPJYvYs8W6LrV+0Q@nand.local>

On Fri, Oct 17, 2025 at 10:54:53AM -0400, Taylor Blau wrote:

> > Hmm, sounds like the mark_path() discussion from:
> >
> >   https://lore.kernel.org/git/aHmPHcNQYlhGo8JB@nand.local/
> >
> > coming home to roost. I'm sure you already knew that, but there's maybe
> > an interesting process observation here: in pulling a battle-tested
> > implementation apart into patches to be applied in chunks, we ended up
> > missing a critical part of that original implementation and getting a
> > bug.
> 
> Hmm. Is that what happened in this case, though?
> [...]
> I was wondering if perhaps I had made an error when pulling these
> patches out of GitHub's fork, but even in my b0ae8b3cc0 (blame-tree:
> introduce '--go-faster' mode, 2025-03-27) from my fork, you can see the
> same diff in mark_path() as above.

Yeah, I think the patches in your fork are correct, and it got lost in
Toon's rewrite. It is probably naive to think we could diff the endpoint
(your fork vs Toon's patches) to find such changes, though. There have
been too many other cleanups and changes as it was upstreamed. So you
can ignore most of my other email as philosophical musing.

> [...some more clever optimizations...]

All of that looked plausibly correct to me. ;) I'll leave it to Toon to
experiment with it for correctness and performance improvements.

-Peff
