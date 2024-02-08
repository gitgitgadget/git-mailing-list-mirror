Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431E4EB5F
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427635; cv=none; b=ccsKasF1ieGrgMx8QaIoFE1yEU92IJ8hVRbppeL4i8OkX07VWKzhj/vpCgSJkxg7yGbwLcYicT9/nduxXMjwxDIiEvCw4SZCjIeDEzhwdOGRMssKfaHD9ATYs+7raEja23C7YMGfcMfjtOAf5/F2q0SoEjZHkUMGLDF6ZMeFm0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427635; c=relaxed/simple;
	bh=VdkcBOWg6GhGM8C0D7aR8QSoPOED9yEGAncqyh1DkFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvE9O9L16KNbZRaJPnVTm03zVf9BB5Zg1Z/EYVWeKSePxGVyNTQYug8nF8O3TttAar40F9qUpajKYVLM+DSBFXxkVhcuIJpQ+wBp/b4wy1jgeNz3UiUGVw+tc/QDKo4PplbQxNCgVMRffhWFCIRb3z7qLJpU9aJLr9fZaezws6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25068 invoked by uid 109); 8 Feb 2024 21:27:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Feb 2024 21:27:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3747 invoked by uid 111); 8 Feb 2024 21:27:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Feb 2024 16:27:11 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 8 Feb 2024 16:27:10 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sergey Kosukhin <skosukhin@gmail.com>
Subject: Re: [PATCH] tag: fix sign_buffer() call to create a signed tag
Message-ID: <20240208212710.GA1095331@coredump.intra.peff.net>
References: <xmqq4jek9ko1.fsf@gitster.g>
 <20240208004757.GA1059751@coredump.intra.peff.net>
 <xmqq5xyzr6tm.fsf@gitster.g>
 <xmqqv86zplr7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv86zplr7.fsf@gitster.g>

On Wed, Feb 07, 2024 at 09:29:00PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > We could do belt and suspenders by tightening the other callers to
> > only expect negative for errors (but then what should they do when
> > they receive non-zero positive?  Should they BUG() out???) while
> > teaching sign_buffer_ssh() that our convention is to return negative
> > for an error, of course, but I am not sure if it that is worth it.
> 
> Actually, we could loosen the caller(s) while tightening the
> callee(s), which is the more usual approach we would take in a
> situation like this.  Here is what I am tempted to pile on top of
> the patch.
> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] ssh signing: signal an error with a negative return value
> 
> The other backend for the sign_buffer() function followed our usual
> "an error is signalled with a negative return" convention, but the
> SSH signer did not.  Even though we already fixed the caller that
> assumed only a negative return value is an error, tighten the callee
> to signal an error with a negative return as well.  This way, the
> callees will be strict on what they produce, while the callers will
> be lenient in what they accept.

Yeah, I think that would possibly lead to fewer surprises and is worth
doing.

-Peff
