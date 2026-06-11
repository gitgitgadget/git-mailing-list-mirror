Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E372E0902
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166803; cv=none; b=GKrUzB6BEc/Dn43XZKnj5acUhi+aY8FQC0lWQt2sCSRVz3ypvDTn28PqS4SjJ2yCF3COy4d6Sm+JGtFqO1egko+tRqgeMrzyPXqHchkdqggqTGVpRnAGxLODivECMTJAUYiyYJFZO5hxEctFH3o1I2TOwdEf3lruKTWlbammQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166803; c=relaxed/simple;
	bh=fKvTDSA5FaePaUx8Gq36YGtmsha9IVgzByjmD9MYLYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI3HCO/dgcZCB92ggBc1ceJAdxFjyV4gVtcGDc+XONtB8YeqHKxxPsYIunazmmfbXSXzijF6aaHuXrCYVm/Yc07ZNhdBTqWAFktu7cRv8axqYPSHFrHhbEJRcPADeEtUajq4DpctD7SKvdRrXN2gbcxVaTGpU3m6v+g57/Lmv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DksAoRcD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DksAoRcD"
Received: (qmail 106969 invoked by uid 106); 11 Jun 2026 08:33:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fKvTDSA5FaePaUx8Gq36YGtmsha9IVgzByjmD9MYLYM=; b=DksAoRcDUj1arzO2DETyzdQj/spRivay2B44TczTuWM8/NstbX9tc0DJO8/rQyzAY3uCW3msmo355WrlOZjQ3kGTDbGyAvm+1NVzw5ZFVOGGoxwQYkSnL7iFi0LTxJonebAAK6Tqa+B+CaDFlzhgbAjzqQSrlYqova9lrsHW9cSlaPNHyvAY8zweiwVrNhPkHMTp8G66Y4DxfIw7D1dNB8tzXVpzkX2cZgJF5hCzkXNLchCXG+yPSqGCwGmbyRtKSZhfKLlKU4/pfzB91sFV0IQ/tB0uoKhS8EJRXvJxz/Mf8XXDVaDjSXHr3P8Ihgbw8YML7WtgTJIrH289Ed1Vfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315128 invoked by uid 111); 11 Jun 2026 08:33:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:33:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:33:20 -0400
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3] transport-helper: fix TSAN race in transfer_debug()
Message-ID: <20260611083320.GI2191159@coredump.intra.peff.net>
References: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>
 <20260609134741.4727-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609134741.4727-2-pushkarkumarsingh1970@gmail.com>

On Tue, Jun 09, 2026 at 01:47:42PM +0000, Pushkar Singh wrote:

> Changes since v2:
> - Treat an uninitialized transfer_debug_enabled as a BUG()
>   instead of silently treating it as disabled.
> - Follow Jeff King's suggestion to distinguish an
>   uninitialized state from a disabled state.

Thanks, this looks OK to me.

> +	if (transfer_debug_enabled < 0)
> +		BUG("somebody forgot to check GIT_TRANSLOOP_DEBUG!");

That is a somewhat silly message, but the point is that nobody is
supposed to see it ever. And it does lead them to roughly the right
spot, so I think it's sufficient. (Yes, I know it came from my earlier
response).

-Peff
