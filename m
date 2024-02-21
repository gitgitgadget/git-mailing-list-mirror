Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3761C20
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537917; cv=none; b=uMEUOHBG4fiVQ1Mayw0Zt/j+IHxV5GiP6v6aK/fe7j8JBR0jlozZKpbratWlqr/BSgcnN6s5sfDJVrAk5w+AsI3KxBxyhtEEsL915qp1pN3D0zT1ZVIa8EVpG6KVLbg8KOzbbjiLyk3YjltxwQZCcUnJv6+1cZG5EDGGZN+aiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537917; c=relaxed/simple;
	bh=KG6fqZu5WY4k+cvfVm2uT3ud1+U986hn9AqvUXhFGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNk/Og6Si9tq2k7VQN9Yx8khELi8w0dGUpqsqE/EsJc7TDTYhhXBHXPGTDRcLA3fwohzE6pCOo3a1+WPgRlVUd32gDKfyyzXU6Jlm7bS33uMNAkgTgLNs2h8V+h4ZOS0gSBf5w0R6pWksaCHgCMwEUId0efZjtVGE2MBV2UKil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7607 invoked by uid 109); 21 Feb 2024 17:51:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 17:51:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6402 invoked by uid 111); 21 Feb 2024 17:51:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 12:51:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 12:51:53 -0500
From: Jeff King <peff@peff.net>
To: Maarten Ackermans <maarten.ackermans@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Breaking change with "git log -n" since 2.43
Message-ID: <20240221175153.GD634809@coredump.intra.peff.net>
References: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=tB2vB0LbP=DznSqTFYHCRxDxd6U=Q+P33yeBzGssq2eK1vA@mail.gmail.com>

On Wed, Feb 21, 2024 at 08:32:46PM +0700, Maarten Ackermans wrote:

> To reproduce, the command `git log -n 9007199254740991` fails on
> 2.43.2, whereas it didn't on 2.42.0. This specific number corresponds
> to the Number.MAX_SAFE_INTEGER (2^53 - 1) in JavaScript (docs:
> https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/MAX_SAFE_INTEGER).
> The max value that is supported now is a signed 32-bit integer (2^31 -
> 1).
> 
> I suppose git simply ignored the extra digits of the number, as the
> commit message describes.

The max value was always a signed 32-bit integer. The extra digits
weren't ignored, but rather there was integer truncation at the C level.
I believe that is technically implementation defined by the compiler,
though in practice your value would generally become -1.

But passing, say, 9007199254740993 would give quite unexpected results
(the truncated value is "1" and we'd show only a single commit).

So I'm sympathetic that your specific number used to work and now
doesn't, but it feels like going back to the truncating behavior is a
step in the wrong direction.

If the goal is to have no limit at all, then passing an explicit "-1"
works, though I don't think that's a documented outcome. I do suspect
that we _would_ try to keep that historical behavior, as there is no
other way to cancel a previous "-n" or otherwise say "no limit". It
might be worth formalizing that with documentation and a test.

-Peff
