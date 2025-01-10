Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC218FC80
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505670; cv=none; b=lKdElheZSnQO14/GT5W1u0j/Lbi8gH6PePXYbgHNL/ufCrarIs7Zbe8YMbwaog6NosiNpPS38CnnJ3LgOoIG3NQ/8tZ2MVCvwqM/v9XGOAPYmuoTLFyktMsKyfHWDHu2m1CaG3fMydKLslZZ/eXFG2GaHNuCiT/nlwmD8z7WecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505670; c=relaxed/simple;
	bh=iQxjlrbYKSzKAEUTHZ7/JJb6Ms5f/FCXbgOnKvv4Wc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qar3zKEfijRWwu8nIdIR8I7Mvx5MfCidviOO6SDw9VduyQSd/ruJrFhNpQVcz9/frZdHvvPioCyEcfcAIe6FSUs1urfcFxLkLNqtU44udzplJTjRSMJEsTReEODC0sO++SjeSPbSf7YEmdKb8AQjUo07LGwJlCgKwl2+vcTpEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TAshP86D; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TAshP86D"
Received: (qmail 3671 invoked by uid 109); 10 Jan 2025 10:41:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iQxjlrbYKSzKAEUTHZ7/JJb6Ms5f/FCXbgOnKvv4Wc8=; b=TAshP86DTVP6gwVJ40dRHI7VzNhq0CPll+IMXo/4mxPjptMNKOO5Rs0lGNRHs00KL4XkRVS1aABfTax0nk5S+Au6xtZOZg9Sqq0xWKuVrctkxKvlVhA7f74Tokl+rHaJl5kLIztx4fbTLqHUAlfQM27HYMfYmLTCPACIuNUN8eSp6CxyEWgC1Y+ATdmDtnGRdlwZW3JXyiU0LyulzJ6tIDreKwBAPENKSnc+3voanydrMMYIO5Y+pRVoeYGCTYTxyLdr0kxcFvjliSBlm1Mqs9SQwITrCIsAc/H5FyNGZ58oEQW+mpDxmdg3Pg0mUnZUoV42hlrflQ+c5Gwwx8ovIQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 10:41:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3971 invoked by uid 111); 10 Jan 2025 10:41:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 05:41:07 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 05:41:06 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <20250110104106.GB1014709@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

On Wed, Jan 08, 2025 at 02:14:29PM -0500, Taylor Blau wrote:

> (This series is rebased on 'master', which is 14650065b7
> (RelNotes/2.48.0: fix typos etc., 2025-01-07) at the time of writing).
> 
> The bulk of this series is unchanged since last time, but a new seventh
> patch that further hardens the hashfile_checkpoint callers on top of
> Patrick's recent series[1].

I think that new patch is a definite improvement, though I left some
comments there.

The changes in patch 1 look fine to me (I still think a generic
"test-tool hash" would make more sense, but I'm OK punting on that for
now).

I didn't see any response to the review in round 1 about the pointer
dangers in patch 3. What do you think of using a separate
git_hash_algo_fns struct, with the one-time conversion I showed in the
subthread of:

  https://lore.kernel.org/git/20241121093731.GD602681@coredump.intra.peff.net/

?

-Peff
