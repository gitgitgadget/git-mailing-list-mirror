Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB263207A0C
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635749; cv=none; b=iizirSBdjQkjJYRapP1GzORncBai3BnT+U+wpnArnYgQgCk491cgpLbVq3lulIdHr2GURNMESzbLXtdCeN3QQPpqQ8c4nRNzSj5hDKD0kFXkhEoAlNOq3Bm+9tTt1u3c1vt0Rt5wyKozMhlcfowrzbjnpYzpE86FukCjhBdzysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635749; c=relaxed/simple;
	bh=bIpFsJaKEJGMes+7Yy6vtk5Mcx+y4pb4TOKC35/d8nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNDCK3r/x2bYo/lVXW4Kc7kUlATmkRwut4HmdCmpMA6Vl9EtDj0JFNJIXYmqnCqbv745uFlRWX0+vsrwfDcjYE9hVQ6YHPJxpcjO2h5CgL1Bxlt4/bIl/k8BIdRlGnm5T3VBcnAOEjSe/fLhOietKQY7grfk7Dil6oVIrtgAeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CpKTzMct; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CpKTzMct"
Received: (qmail 5927 invoked by uid 109); 11 Oct 2024 08:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bIpFsJaKEJGMes+7Yy6vtk5Mcx+y4pb4TOKC35/d8nE=; b=CpKTzMctVI3bKbpDxY7v5oI1YdAXuPPv2jpkxNTKdECszQwEcoMkSBzuKqBVyv1UFI9qi5xhWcmCkDF3FinLGcWoVkqBJAVbxg+qzgSREqT05bUV2PvtJDXLPgyHvIMOfzbgP1rTBz66F/zrSMEP3yNq5iurLWonSMQI/M5klRc60qvXRkLnKsbl9tph+C7tFCJ7OMIwPInhTde2mJnh5AoF0isgY0cj4DsJvtEm6L/CYjqUk6tCCZdZzblPTM9QMY0DKicldlPLmwNEj5qKFUdWRAlgNWGA9TMNjBavJP2OmNgGjiF4wRoNxGk+1L58LknLzcXPkD2Nl+GaHfPnrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:35:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17815 invoked by uid 111); 11 Oct 2024 08:35:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:35:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:35:45 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/11] pack-bitmap.c: record whether the result was
 filtered
Message-ID: <20241011083545.GH18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <dffdd794de3255719028a5f2c64d43048a5a5f60.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dffdd794de3255719028a5f2c64d43048a5a5f60.1728505840.git.me@ttaylorr.com>

On Wed, Oct 09, 2024 at 04:31:31PM -0400, Taylor Blau wrote:

> In a following commit, we will prepare to mark objects for reuse which
> are stored as deltas, but whose base object wasn't included in the
> output pack (e.g., because the client already has it).
> 
> We can't, however, take advantage of that optimization when the
> traversal removed objects from the result due to either (a) object
> filtering, or (b) --unpacked.
> 
> That's because in either case, we can't rely on the principle that "if
> an object appears in the 'haves' bitmap, that the client already has
> that object", since they may not have it as a result of filtering.

I think this is a reasonable precaution, though it does make me wonder
if the non-reuse code paths are so careful. That is, if we have object Y
which is a delta against object X, but we know the other side _could_
have X (because it's reachable from some commit they claim to have),
would we ever send a thin delta against X?

I don't recall seeing any protections for that, though I also wouldn't
be too surprised if it somehow just works out because we never figure
out whether they have X or not. :-/

I wonder, though: should thin deltas just be turned off entirely when
filtering is in play?

Likewise for --unpacked (though in practice I think it would never be
used with --thin, as it is about generating new on-disk packs).

-Peff
