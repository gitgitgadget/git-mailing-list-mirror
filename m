Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B342D060B
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611361; cv=none; b=IVP4Yn7xTcDCCHgpu7QNWbYGfLRooA22TeUmQ3mVaPuFKkNokp6rxX2lRZr8yDggJDVpNOcH/npo/A7tgHAU/U4Jt0O2fb0jum4R/wui8szSLdW5kuG97DunlVSJ5o18l+a12g+uy4XuAljgyOJLIgenx6djL9ZdfFm6CHS/aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611361; c=relaxed/simple;
	bh=8JUm2e4XGe2c6ckI4SckSR+l24xDyb4WChvVveSuIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJW+rA7d21QM4CkAa2LnbvwKjKz7WcGRWD0zAAaVNSigeYT7e5pKN0mGlr8SPrw46FRKVAIPmtNLJCvTltxGpr9lzBneV+LCraEyO+8mtvU3UPjzBz1NAJjSwle7Ijw0K54IU2Vf2yp12Nbb8MPD/yvcciJk2Hf7kAzeaD6tXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PNpkZUS8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PNpkZUS8"
Received: (qmail 28931 invoked by uid 106); 12 May 2026 18:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=8JUm2e4XGe2c6ckI4SckSR+l24xDyb4WChvVveSuIDM=; b=PNpkZUS8t/7NXmO/c9uQz5CHzEl2AjGRf3wrHA44iGsP19namT4SqG3CIygnJXZm9ERke9ohVWfQXX97JBYVSVJrGxPvPXGONfMFd/BFKZJi3lCsL4n3nb8BG9/YVDI6ovYetDxq4GUX6naNRwemKL7wyHDC2BjDD/8yFTkGz9wQjwaiFbdEO6GbAcYMNFu6Uqm+jX/J3CqFgEjKBrRNm6kNSfzjbxugJQzPGABg0K3EQoqQi1XTgWetqAKDkHvCLIxsmq+nCQN1R0JRCY9DxTLJDVATme8oa4ZgkTvOSUTh7uld6Pv31shHQ3X76VWaBEzKhYPMI2haswoQ7y3U5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 18:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52422 invoked by uid 111); 12 May 2026 18:42:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 14:42:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 14:42:38 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
Message-ID: <20260512184238.GC70851@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512115603.80780-2-l.s.r@web.de>

On Tue, May 12, 2026 at 01:56:00PM +0200, René Scharfe wrote:

> Prepare the number string in a temporary buffer.  Make it big enough for
> any unsigned integer value: A decimal digit can represent ln(10)/ln(2) ≈
> 3.32 bits; dividing the number of bits of uintmax_t by 3.3 and rounding
> up gives a sufficiently close conservative size estimate.

Cute. The naive obvious question here is: why not just grow the strbuf
and format it there directly?

And the answer is that it's much easier to format numbers right-to-left,
and then you know how many digits you need. ;)

You can compute the number of digits needed up front, of course, but
it's log-10. You might be able to do it quickly based on the size of the
leading bit, but there are a lot of off-by-one gotchas.

So probably the extra memcpy() is not that big a deal.

-Peff
