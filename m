Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A312B17B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494190; cv=none; b=lsQFDRXJMmaOsHQel3WLm0O2sYAXo2Km1sKwS/TNn2Vi3BSxLKD9le1D6WKEMRWyw3un+mUC1LdhcRfD5eYV+DEa/MIXmFhXOu87FbHYV4jrN+zM7SXsvsZ+bDmBJSsOldXVwlaL06ez31nWWzPglkBsr6yEhMOp8Ydb5b2KFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494190; c=relaxed/simple;
	bh=GqKmnjRBAcY/B88jjjqiFQR0BPRy1NJoNLS8SOno4Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqV/GZGvrhRbfu8rXOf6/N9EZgfJZyp6DQRUq4JJoZA3A2SS1HolTOqvbkDn4fsnRGfqbHe7DqG5a2ShKjBmzw2lL22PpmZz5PZ2kE9Ir7xujCQwcA/d7f/zTCakmrfX/qzBZuOOGiGWHQR3U+AmLsl9aDAHHBYmJT+gDNEZCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21059 invoked by uid 109); 4 Jun 2024 09:43:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 09:43:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18128 invoked by uid 111); 4 Jun 2024 09:43:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 05:43:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 05:43:06 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/13] sparse-checkout: pass string literals directly to
 add_pattern()
Message-ID: <20240604094306.GA1298378@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
 <20240531112613.GB428814@coredump.intra.peff.net>
 <xmqqr0digdqe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0digdqe.fsf@gitster.g>

On Fri, May 31, 2024 at 09:14:49AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The add_pattern() function takes a pattern string, but neither makes a
> > copy of it nor takes ownership of the memory. So it is the caller's
> > responsibility to make sure the string hangs around as long as the
> > pattern_list which references it.
> 
> Wow.  That's an extremely bad API.
> 
> I suspect that it long time ago did not aggressively "pre-parse" the
> given pattern string and kept the original copy in the struct (i.e.,
> taking ownership), and these copies of the literal strings were made
> at the calling sites with the expectation that the API takes
> ownership of them, as most of the strings fed to add_pattern() are
> what we read from the environment into heap.

Yeah, I actually dug into the history a bit but didn't find any real
smoking gun of when it crossed the line to "horrible". It was gradual. ;)

But yes, it was originally just an array of the pattern strings (in
2005!), and then grew more features, and then grew more of an interface
for adding patterns from other sources, and so on. I'm mildly surprised
nobody ran afoul of it before now.

-Peff
