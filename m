Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FA21CD19
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353282; cv=none; b=nOZWPKcd0ZY2ksz4N+hsHWuaRtzduFmMQ5PmJyTh2Ygz5Scs2dzGiyZoi/h9SfXw7bsHsH4hmIH2pARc4Fy3Q8YmQHTIap0dQShohqvucz+PyubeoohCM/UcvpkxQOuk4kKbklW0/s9L8bHDfbqkqvMsdQdTZkD0S3TcO+0sHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353282; c=relaxed/simple;
	bh=tY9yKlePpc34Bt5cEbAVya5kAk93O7eqnAO3OQzdRb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCkYpVDLaqJjbSxC2LsHWINWyn964pFwSPKUK6R1hl3OyiBJZoq+dLY9Tiz+TcjzsSfp4x13sdwMRJJBeUwaU3Ad/yG0V3OXKEwbpCURoAPdVlXxDwDbr/7Ak7vnSiputrXWqmrQqkZhanXT3TdylXtER0fyB1WzkOGsx/iZsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13178 invoked by uid 109); 8 Feb 2024 00:47:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Feb 2024 00:47:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25469 invoked by uid 111); 8 Feb 2024 00:47:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Feb 2024 19:47:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 7 Feb 2024 19:47:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sergey Kosukhin <skosukhin@gmail.com>
Subject: Re: [PATCH] tag: fix sign_buffer() call to create a signed tag
Message-ID: <20240208004757.GA1059751@coredump.intra.peff.net>
References: <xmqq4jek9ko1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jek9ko1.fsf@gitster.g>

On Wed, Feb 07, 2024 at 10:46:54AM -0800, Junio C Hamano wrote:

> The command "git tag -s" internally calls sign_buffer() to make a
> cryptographic signature using the chosen backend like GPG and SSH.
> The internal helper functions used by "git tag" implementation seem
> to use a "negative return values are errors, zero or positive return
> values are not" convention, and there are places (e.g., verify_tag()
> that calls gpg_verify_tag()) that these internal helper functions
> translate return values that signal errors to conform to this
> convention, but do_sign() that calls sign_buffer() forgets to do so.
> 
> Fix it, so that a failed call to sign_buffer() that can return the
> exit status from pipe_command() will not be overlooked.
> 
> Reported-by: Sergey Kosukhin <skosukhin@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * We alternatively could fix individual sign_buffer() backend that
>    signals an error with a positive value (sign_buffer_ssh() in this
>    case) to return a negative value, but this would hopefully be
>    more future-proof.

FWIW, I would have gone the other way, and fixed sign_buffer_ssh(). Your
solution here is future-proofing the tag code against other
sign_buffer_*() functions behaving like ssh. But it is also leaving
other sign_buffer() callers to introduce the same bug.

Your documentation change at least makes that less likely. But given how
much of our code uses the "negative is error" convention, I wouldn't be
surprised to see it happen anyway.

-Peff
