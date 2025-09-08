Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E51FF603
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348270; cv=none; b=RAUHeMWbkc+OnRBl1SgXg7wIH0kXG7kWuo8CVqsZb9QuzijYBsAH40IVewmssyKx0EoyJpigd5L0dqGqkqGMpo3hxYCz19TB+Sbamf/8KxtAi1RjxsGLwxiEZ9CyaaXZzxo9izD3vBm4xCndyXiWWmJaznHuJLpNLFhfzXh0QL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348270; c=relaxed/simple;
	bh=t7Gz2UCrK7pWHmyy+WLvy1q8gKtMyTtZ1c7wiHoXdeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk7YV6TV74HXX+wDULZ8wYW/cZl5O43+Q9IL+I2Fff5Y6eLYBZyIXyArCtnZ+9CnxVXP3TUvUoVviUMJfTjKX4Lck8vRwSVhKNIyLTsaD/MFDS5xT4qvEKfB7ZOQdnw2pJhex57xYpHrJeMxJUf3lveEEo4zsJq/1zgffrqC6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RVj5A0ki; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RVj5A0ki"
Received: (qmail 21429 invoked by uid 109); 8 Sep 2025 16:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=t7Gz2UCrK7pWHmyy+WLvy1q8gKtMyTtZ1c7wiHoXdeE=; b=RVj5A0kiZ1XQ+NcmM3K9dMMA5zaND8o79PGhwEy8sTA+xW2yCt99HwqjYO7DaDeFssEtA6apfgWoSihsYu6ozyO26ft6WdhbMSVzsosutnWN4aPMeUzyXwAoxRc5/JUg1JAkeZHJnh7GC5kwwfCcMHfCFDm/rlv2kgF3NwsyyKeAFtm/VEk+MtLFU92SwIs0QM6P0y7JEmJoqZpwS6T3Ni78mDNGx8BAHSGhkgpJFhuGagoe2WchGuvue6CjnmimMBpwIADnGWFpE3YDEZR7lVYQPjVpwBxVsUvw7Ml/WyYt9nEZ2U848cXLnN/p+44gZhoiFE0+N2WQQFv1tHJcZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:17:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34764 invoked by uid 111); 8 Sep 2025 16:17:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:17:47 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:17:47 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] add-interactive: manually fall back color config to
 color.ui
Message-ID: <20250908161747.GD1308482@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821072224.GC1839835@coredump.intra.peff.net>
 <aLfs9ZbAxHnsqluw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLfs9ZbAxHnsqluw@pks.im>

On Wed, Sep 03, 2025 at 09:23:33AM +0200, Patrick Steinhardt wrote:

> > It is tempting to teach want_color() to look up the value of
> > repo_config_get_value("color.ui") itself. But I think that would have
> > disastrous consequences. Plumbing commands, especially older ones, avoid
> > porcelain config like color. by simply not parsing it in their config
> 
> Is the "color." intended to refer to config keys starting with that
> string? If so it would help to quote it and maybe say "color.*".

I'm not sure if I meant "config like color" in the general sense, or
typo'd "color.*". Either way, what is there is indeed confusing. ;) I'll
fix it.

-Peff
