Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2E212557
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910198; cv=none; b=Nc4L4rZjacYGJV7cjpmCp/QpULgFDEJTiLy/YXjYzhEc2fPKj5w7LHuLUoZcSYiUFQUc7OXSIyb1lZFg6y11EgfoRxQBP1mMHP7S6tsDela48qFrqkIBUVnT6HHjJyZqycjqYH6y2xpej/FgqsGHRo/a9C408+dlvf6I9Mr02Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910198; c=relaxed/simple;
	bh=tJJwfWAkB4c7O9SJzExl/m2+1kF7cyWTxsARnjZA7Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyAAlHYNM8BxHnMuumPtCBR3i61ZJnSdh9EyNixFrRBcrhiRsGnlfD/ls2bkvvxjyROpCv7vhvJlWOONAhqiHmTFySzOwu1EAPUVE5+owo88djmjK6DOh5+/BkGDblhyctHjOHfOOLPOxlIpIDNjtnztHKOzdYO0cp7XNu1ZTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Tk2elqHs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Tk2elqHs"
Received: (qmail 194091 invoked by uid 109); 3 Sep 2025 14:36:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=tJJwfWAkB4c7O9SJzExl/m2+1kF7cyWTxsARnjZA7Tc=; b=Tk2elqHsz5widhnXAOFC/mvo30h4mBDS7oHPR76jBiJh4TUteili0BYOwyj0DKQfUa7eluWirKQ3OTJXWYm0HgkCg52CD5D8x/sSHTth8+WZMBbbosq7uyxh0hODqQwdGk85n8nhG0wHGMUJ9HI0TH1Np6+l47YNzzcRMDsrUhhNVro2htIfnWwZFzXshY/kQY2dmCMAIAaaK7wMHGqICMaEFOhQCmrxRkxlkHjYmO+x+n/EZS+LoDvlkEfF1uYQvpPXvGEetjMaBPAb1ETS5yqW2bqSQl2U8CQjksrAsdaNWDMArNsiLyMZrA/1LenJRpEHV9Jaq8i6bqO0UXyzPg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Sep 2025 14:36:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 341906 invoked by uid 111); 3 Sep 2025 14:36:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Sep 2025 10:36:35 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Sep 2025 10:36:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] describe: use oidset in finish_depth_computation()
Message-ID: <20250903143634.GB1884731@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <b16aa099-b683-4a66-acd9-603cc9f0935c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b16aa099-b683-4a66-acd9-603cc9f0935c@web.de>

On Tue, Sep 02, 2025 at 08:24:52PM +0200, René Scharfe wrote:

> Changes:
> - Use oidset instead of a custom khash set for simplicity.
> - Removed spurious whitespace changes.
> - Formatted with --patience to better see the function removal.

Thanks, this version looks good to me.

-Peff
