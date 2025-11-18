Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B88268C42
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459838; cv=none; b=YuyAKWFVrAdZVj+EYWa+2Gn1tinE/NDiFXTRLVZrxigvCkR/AAFLarfzXVAIEpXzp5GSo3uKyaonL4cyi6y+kxXOtJb8d2pBQNxr/qW+f/neQBSsSOuaSGW7qNTbW7hzRi7iRfqnDH/cozSqQTDxiQL+Y+Y0gxlc7gSJx94Ycwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459838; c=relaxed/simple;
	bh=KM6tzCwbKEctiWt9rhFcZp2XQbgR/b8uGYqkjg7QZ7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g19HdgitSgqs478aBsOPnvfGNIga4lpKLTH5v0tR1rSnmFAkKWJ3upfOI+y2TfTcsD12svJYLA3c4LB15Cre2/Q4peyihHfbOcsC1o72DitjoUyuK1WZUrA4dIu1teQyeg77VUgXfmuiDIEuQRD3OMoRnwpMDFMG5CWhoTMMgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=byLSHNxN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="byLSHNxN"
Received: (qmail 20307 invoked by uid 109); 18 Nov 2025 09:57:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KM6tzCwbKEctiWt9rhFcZp2XQbgR/b8uGYqkjg7QZ7A=; b=byLSHNxNoDLLoteGUtB8laci2jQimJV+OTIz3HZJSYFkkifQUpp3hKAuQDb3xqhxuPfMQErXbTs72jUa6kDJ5h+Epi2JGeRX8NTFbq4wTwtwoxAKHiani19nM+szLUiFOf6wuVUgJoFebB7mkGcqkm2zdmApOnE3RCMGH0+HMPj4MY5mUx6BWRwxuq5CCpEiRrols6PjxOGtL721AfRQgOxHGCtVNHgd5YzRpxrj4TK8eieIgLT48dX8+X1AE6F+fpEGmr0MrdCcxnhC63CjzGtVDljxRp7Jt0ro+mYnocFnPKNSPnLtOJuw7hCmRtYKTMmMpH2ga4V87ersDu4hiA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:57:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27928 invoked by uid 111); 18 Nov 2025 09:57:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:57:19 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:57:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] osxkeychain: avoid incorrectly skipping store operation
Message-ID: <20251118095714.GD530545@coredump.intra.peff.net>
References: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
 <xmqqo6p5llsw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6p5llsw.fsf@gitster.g>

On Thu, Nov 13, 2025 at 12:28:15PM -0800, Junio C Hamano wrote:

> "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +/*
> > + * NOTE: We could use functions in strbuf.h and/or wrapper.h, but those
> > + * introduce significant dependencies. Therefore, we define simplified
> > + * versions here to keep this code self-contained.
> > + */
> 
> Sorry, but I do not quite understand this comment.  The program is
> shipped as a part of Git, and using these functions and linking with
> libgit.a may pull strbuf.o and some other *.o files out of libgit.a
> to link with git-credential-osxkeychain.o to produce the executable,
> but how can that be "significant dependencies"?  For anybody who is
> building git-credential-osxkeychain, the necessary sources come for
> free.

Back when we added the contrib/credential helpers, I tried to avoid
linking with Git for two reasons:

  1. The idea was that these _could_ be independent projects, and we
     would not be on the hook for writing or maintaining everyone's pet
     platform helper. So even though they are in our tree, the hope was
     that they'd be simple enough to be totally independent programs
     (and would not even have to be written in C). And avoiding any
     dependencies kept us honest there.

     It may be that the cost of not being able to re-use our usual code
     is too high for the philosophical benefit, though.

  2. If stuff in contrib/ depends on code in libgit.a, then changes in
     the latter can break them. And I don't think we have a great flow
     for detecting such breakage. Maybe one of the CI jobs builds
     osxkeychain now? I'm not even sure.

     The xmalloc and strbuf interfaces are pretty stable, so it may be
     that the right rule is "you can depend on libgit.a, but only
     lightly".

Mostly just offering my two cents (and a little backstory). I'm not
terribly opposed to loosening the rule, but we may expect some breakage
via (2) from time to time.

-Peff
