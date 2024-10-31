Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4E19ABBF
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375255; cv=none; b=kokoD/u55s8UNxGBLgfOwSsDXTJMH+HdOVSSNOIQTCjOHZpHnaGMxH6d1OfE2Ap4VgwmnIeHXQhGG8g/COT3B3SpgBwBNTMBDl0hVabpYmenBZgEU/gay+0H2JmYmhidVlkzxlqMvP5Kql0rTiFE4BdrQrAObRu9H4pxI4vlZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375255; c=relaxed/simple;
	bh=G4eCeIJ+UOd1X/vsioLxzedbDP1Rj3/+/YxhGS1GzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDViXfp+YY6ZzplnUeFbYVSd2/2nnTaU24HN4DfeNW7024+1pzp0owEK6py9Nm0gFzglktLIspcORwE9I3aozbuEdYO94ivYi2p8wPFwSdjsixI15vayY41/5R/FyxEoP1J6xauyIthop7KnV3GG1mRn/WAbddsrmUyhR45DyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HWYGJCjK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HWYGJCjK"
Received: (qmail 18612 invoked by uid 109); 31 Oct 2024 11:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=G4eCeIJ+UOd1X/vsioLxzedbDP1Rj3/+/YxhGS1GzC0=; b=HWYGJCjKr+2PukrUstmXBdc4z6dg5woGnMSKBpYHboYCIkNJngiQOnszLF3yfP7r4v/cF0bgpWuGWjdaq7ZJNUZ4I4TDySx6aytX3uOpo13+RQC4Co7ahLOnMPhj7XQ5f0BQoPFV8AI+MEx78CBfPSs2XKzyakOiPdrkzuhBws6kDoun+Bsqip1gJEJ+VvFAdYJMTufDhTLrt9Ebago8OTa8DjIWBbD7berE4ZvOefRCwxP629RGx8olpnJg3omjBf4e7HrxMQvrEE5aMn38PTYbSKQ/kytK/GNSeciupnva0aDds4GIkoB5fHlflvcVzRzfU9GD/AgSOyaS8BhjJQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 11:47:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31803 invoked by uid 111); 31 Oct 2024 11:47:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 07:47:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 07:47:31 -0400
From: Jeff King <peff@peff.net>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031114731.GA608553@coredump.intra.peff.net>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>

On Tue, Oct 29, 2024 at 09:43:22PM -0700, Josh Poimboeuf wrote:

> $ time git describe --match=v6.10-rc7 --debug
> describe HEAD
> No exact match on refs or tags, searching to describe
> finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
>  annotated       1844 v6.10-rc7
> traversed 1282750 commits
> v6.10-rc7-1844-gc61e41121036
> 
> real	0m9.243s
> user	0m8.940s
> sys	0m0.268s
> 
> $ time git describe
> v6.10-rc7-1844-gc61e41121036
> 
> real	0m0.149s
> user	0m0.111s
> sys	0m0.036s

There's more discussion of the actual solution in the nearby thread from
Rasmus. But I did want to note one thing here: when I initially tried to
reproduce your problem, my "slow" case was a lot less bad.

The reason is that I had a commit graph file to speed up traversal. So
independent of the git-describe fix, you might want to try:

  git commit-graph write --reachable

That reduces the slow case for me by a factor of 10. And likewise other
traversal operations should get faster.

I think we'll build the commit graph file by default these days when you
run "git gc". But we don't build it immediately after cloning. Perhaps
we should change that.

-Peff
