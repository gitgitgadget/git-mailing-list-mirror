Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE643B3DE
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803161; cv=none; b=WLFAEcykRdCjzsCvw2l7U4G1Paey3C4OKra9jaNEXozNFA3Nu24Opi9FoyKQNPrznBSjMW1ZhetGJKx+mv3xQxq3U+HYdJT6k3gytqqISzmsaWWO+DVhT2hKBA28TBqE5Rx0SrzrAuczKyUlhh3PfEt7bYrcJL6GqZC7mz8i/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803161; c=relaxed/simple;
	bh=9r3nO39zFQPhauag2uJjRcqtOu3S5qER3JYe1nu7T6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb+/n+0azU5imNXPH0AdFQ6La2W8ZTsEm7QFvR70Vx2yg3kPCZGKgTaArGhZa4aWn8ZL1Ap19/thxHxWfGnsxpu/XLscWtrTPyTvuy7bh1l0UlvB7fxYxucgZcblXC1vV1tjY34QpoecA0b7cG4qKLP/i1hw0+wQSwCA0/bxKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GaXcORIL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GaXcORIL"
Received: (qmail 24666 invoked by uid 106); 23 Jul 2026 10:39:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9r3nO39zFQPhauag2uJjRcqtOu3S5qER3JYe1nu7T6k=; b=GaXcORIL2fZoC5nHelDIXu4VrMxY1YwUPXzxm5rgww44zVPKJzc41ALm1Ds0zdt6RY9HwG29NtM6Pm0MJNcBpS7INjWW91ENTO1hfqVjIvBpn0YETXsc4rgTPk2O2j8DL6Ah8Vx0dbfT/t2/JCbxSzZ6egTT1kUe3dG4STllQ0Me2WepKKkBr49SW7nioeQm3DxZfkn1ng7cCDVcRq9iUF+HWw4vP0FblsJPjuc4vs4GYu4d9kIZs4cHwjazNALm3QuVaGFenN6/fPnVir9IYpJ8ko8eiJeFnPlnhC6VR+HQo4zpiCZR0bGvYad8Xm5mm3dNUYmHLNZ79/glBw2+og==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2026 10:39:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19909 invoked by uid 111); 23 Jul 2026 10:39:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2026 06:39:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Jul 2026 06:39:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <20260723103911.GA604358@coredump.intra.peff.net>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtsps76f1.fsf@gitster.g>

On Tue, Jul 21, 2026 at 07:40:02AM -0700, Junio C Hamano wrote:

> Stepping back a bit, the 'rev-list' command used for the
> connectivity check is curious in multiple aspects.
> 
>  * On the surface, it looks as if the caller wants an enumeration of
>    all objects that appear in the range.  However, the caller is not
>    interested in the actual list of objects.  Instead, they are
>    interested only in a single bit: whether the traversal succeeds
>    or dies due to a missing object.  This is because the traversal
>    determines whether we need to fetch, or whether we are already up
>    to date, to decide whether the proposed 'fetch' is a no-op.  The
>    positive ends of the traversal represent what we are about to
>    fetch; if we already have all the objects needed to reach those
>    tips in our repository, we can do without actually downloading
>    anything [*].
> 
>  * A false positive answer to the question "does the traversal die
>    due to a missing object?" does not affect correctness, as this is
>    merely an optimization to save downloads (though a false negative
>    is unacceptable).
> 
> Given this non-standard use of the command, we can pass
> application-specific cues (such as "we are doing this traversal for
> a connectivity check") down to the machinery as a hint to help it
> optimize its operation, and I suspect that such a hint might have
> value.

Yeah, I think there may be some interesting opportunities for
optimization in check_connected(). But as you noted, it is sometimes
used for fetch asking "do we probably have all of these objects" but
also for strict connectivity checks for incoming objects. The quarantine
area triggers only for the latter (in this case receive-pack), so it
would not really help here.

IOW, I'd consider it a mostly orthogonal possible direction for
optimization (but still a potentially interesting one).

-Peff
