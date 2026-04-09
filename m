Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917C38AC79
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773300; cv=none; b=WcndNzog75P4R2gnosNJiNZAub6P/qVUv/NNw3cD+z6XbfvOfd8I2e72Of1GjxZVj0Y+WXrzOKqGJp4QwZg+YH7hT403E82xjKP/8/8ahw3EPlfgQwX7MwmqrRWfrju1mM5HcEgijh7B8Ltq+fome5TS3WdbkW0CHhbMe+wmn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773300; c=relaxed/simple;
	bh=5gLqtzIrx3/Uir1PZJmLD7ERREGA2riMagE/OF8YdgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovCYtdmXW+04niQkHW4gJy3xcvHIDMILKOFfcTX7fCoD/wj4GPExlbbjAe5ErHdFDxlYZLy5skFTsAKciVuWlu9/DVTJkpmbiPRM2ph4WhdHNEwnHx1rxPpGOvzQQKMEyapHnn6jLnN+SNmGOdnwxrU9ZevvhoUMsqD3MznHLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OksBWkX3; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OksBWkX3"
Received: (qmail 295486 invoked by uid 106); 9 Apr 2026 22:21:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5gLqtzIrx3/Uir1PZJmLD7ERREGA2riMagE/OF8YdgQ=; b=OksBWkX3H0hw23PDSTG0uhzdDWkzXUwwDIf0ahJZMkjNPLuJFY/uaFS6ulW3wPHTYy2QjuRs4s1rtqwBY8849x+LmUJAKUADH2EcA3J51/4iT0SuW84hkg5y71QiGjBd7i/lX+mxL+F+7fpx9feRURiCgzv/SPgat8mg7mJ4Vjtv9wsQKx6QKjkz5kCXrTLxg+zz1hIfFk329ASTyOxkpRPwksM5ut7ZzjuRfN1CT5bAD2fSZ8Ox/V1OdWWnnvHLvWu3GCHJr7VaRqV4TgQYmSOS2m42xSpAMiL+f0alQo9R9WDkyCQLLLlVukgEKsgyPEYmXahHm57WuQigNIweWA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 22:21:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 489207 invoked by uid 111); 9 Apr 2026 22:21:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 18:21:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 18:21:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: Re* 2.54.0-rc1 NO_WRITEV=Nope  does not work
Message-ID: <20260409222131.GA3130242@coredump.intra.peff.net>
References: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
 <20260409211049.GA3119065@coredump.intra.peff.net>
 <xmqqmrzbreav.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmrzbreav.fsf_-_@gitster.g>

On Thu, Apr 09, 2026 at 02:53:28PM -0700, Junio C Hamano wrote:

> > Yuck. I think for 2.54 we either have to truly implement MAX_IO_SIZE
> > support, or we have to revert the use of writev() in send_sideband()
> > until we do.
> 
> Sigh again.

Yeah, I feel the same way. :(

I would be happy if somebody could prove me wrong, though.

> $ git log -Swritev --oneline 8023abc632^..
> 89152af176 cmake: use writev(3p) wrapper as needed
> 26986f4cba sideband: use writev(3p) to send pktlines
> 1970fcef93 wrapper: introduce writev(3p) wrappers
> 3b9b2c2a29 compat/posix: introduce writev(3p) wrapper
> 
> Reverting them gave us the following patch relative to the tip of
> 'master'.

If we are planning to improve the topic post-release (and I think that
is a good idea), then we can do a much smaller revert. If we just revert
26986f4cba (sideband: use writev(3p) to send pktlines, 2026-03-13), then
nobody calls writev (neither the real one nor our fallback). The
wrappers are dead code until we bring it back, but it may make things
easier for fixing post-2.54.

-Peff
