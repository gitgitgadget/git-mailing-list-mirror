Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95F7082D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783298644; cv=none; b=bKXgqNM+fTMJdJyBrnMQouCDSsvyoSEp8o0x//cBqttQvD4mjJIdV/QER39/SLtlzz4apBEoeHkfift+jNuGMi8s5WOwmLVtLFiVHqPdglQI/trbvvgWgQ4gJxA0vco5/dsrYjeaBlHp5i1FurgCm74y3pchnYTFf4XZqtV0jlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783298644; c=relaxed/simple;
	bh=Tje2JXr5ypf2DJV+Ywxd/IosKE2vVF9rw+jTC72s710=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtz8mbCpuhv9sqPNP0frp7J4p2j0c/MOiR9ah7kOfGR0TLyJwJACj364xcMpYJwn3Kdq25Y1wP3OW/uSSPsaKYbLUI1LpuyRYFwUKioFQvbnfZm/yjClwpoyIGBx1sbc3Q75nLIQE/UBijSo+9kVnhwyAQlZvE8d+c3a7aiaF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JFcxMX2E; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JFcxMX2E"
Received: (qmail 2521 invoked by uid 106); 6 Jul 2026 00:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Tje2JXr5ypf2DJV+Ywxd/IosKE2vVF9rw+jTC72s710=; b=JFcxMX2EcOixUFuVXLirkq3DxDi0gTt8ea+An/DuT58te10MP+lTV6gxQk2fXEf6+0/96gbPjc1UZVQg9cWyKl/vmePjdxEhCr6HXY8J6YgNopyHPaRr6WqrEoUmmJ5edwgGFbQNHuza6Utu5TOuNNg3vgHWZSjCXM9s/hntAwVKetU6+0r0j7+10PK5fuCXywR2Bb9ile8MZbE0skg/avPjSFQ9y2/ZJEPP8kbUfbZMXySZlJ11BibR/lRUyQID+0Xli0X7sSQ6+9SkmeLCw6tP0EZw88j4SSsEdbgtsluDFB/mSKKEv9nOrnHAxvwX6gtAcErA+/eNzD+81t+ecQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2026 00:44:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4011 invoked by uid 111); 6 Jul 2026 00:44:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Jul 2026 20:44:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Jul 2026 20:44:01 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <20260706004401.GA2308672@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080707.GG2029434@coredump.intra.peff.net>
 <akecqPq4F702E8Cq@pks.im>
 <20260706000105.GA2301945@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706000105.GA2301945@coredump.intra.peff.net>

On Sun, Jul 05, 2026 at 08:01:05PM -0400, Jeff King wrote:

> That by itself is enough to make:
> 
>   algo->init_fn(&ctx);
>   git_hash_update(&ctx, ...);
>   git_hash_final(out, &ctx);
>   ...
>   git_hash_discard(&ctx);
> 
> safe.

Actually, that's not quite true. Setting the active flag happens in
git_hash_init() in that model. But many callers use algo->init_fn()
directly instead. They'd all need to be adjusted to use git_hash_init().
I don't think there's any reason they should avoid it, and it's mostly
from inertia that they use the bare function pointer.

-Peff
