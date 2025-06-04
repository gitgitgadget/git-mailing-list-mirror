Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2F111BF
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067024; cv=none; b=I35GkHMnZHv0nBH5tROGUQ3kJZTjWEehxXh8uRPVy+Wr7ARC1mbgT9QHtvNLluK8LXZ7Z7hSFYzz644GgwsiLF3MGxKdBP3bFwuYB/nyq36GOXoIFaJ6siKXlTSMQCajKqEIdlwfksT/qL3F/2MGXg0lHVm4BpFc+xVlPtbj+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067024; c=relaxed/simple;
	bh=VEq9c6nfOWJwN2tSOmpWbYzK79laMoRuvQvhNj/7+W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdqtzt/c/BRW/ElNZnnBfF08cm6lzsXqZfBGANrBQhFBsKg0t+kibJFOuei4KSmZJ4Kx0I6VtcmI1R1qcq85ERSaMydk1+/D8vQagpArXHbDpqMIv9Vwjaz9ISR3ifF6YH3vKwCIdO6sYFW4dluDtOQVED7rj6Qzx5aPSJ/dc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HfUER23Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HfUER23Z"
Received: (qmail 13979 invoked by uid 109); 4 Jun 2025 19:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VEq9c6nfOWJwN2tSOmpWbYzK79laMoRuvQvhNj/7+W8=; b=HfUER23ZEay6O9iY87FsFUk5lzkyW7CGuH4llVr/YVbKXCj4KYz2IeFrOaC5LQcx+QiIDOSSwidYzH1nej232dC6w7IZ+mOyDQVGgM3y0F8dF6I+mU7Hg71QPa13/Hwo5c26WBbc93SMWh3sbK5Cz5Arzu2ynM5JoDTB270HJLKK7T7o6glr/AzP08GCEWeuR2jVYM0rkiLfu03U0Y4co0DrOvwsW0Eicr3KLEt4W18XPWM8OyEXAM9FIzrcti6CtyS6KtC4SKnVJGClPKez6pUkqu7TjiZjMeJUlYFfUtJYnv/LAsCYD8Yi70LlaCBhjtTaX/jgF2F3eN4MhZbFMA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 19:57:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13134 invoked by uid 111); 4 Jun 2025 19:57:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 15:57:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 15:57:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) and submodule message to
 batch commands
Message-ID: <20250604195701.GC1500045@coredump.intra.peff.net>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
 <xmqqh60vefee.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh60vefee.fsf@gitster.g>

On Wed, Jun 04, 2025 at 07:43:21AM -0700, Junio C Hamano wrote:

> > The final patch takes a different approach to submodule resolution than the
> > initial submission; rather than treat the entry as a "regular" commit object
> > with empty content, we now print an error message similar to the "missing",
> > "ambiguous", etc. cases, but with the tree entry's OID rather than the input
> > object name.
> 
> I did not send any line-by-line reviews, but after reading these
> patches I didn't see anything questionable.  Unless we see others
> comments that need to be addressed, let's merge it to 'next' in
> preparation for the next cycle.

I left a more detailed review. But it's mostly musing and self-answering
questions. I'd be OK to see this progress as-is.

-Peff
