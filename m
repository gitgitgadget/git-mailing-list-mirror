Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583224A07C
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450233; cv=none; b=Ys1qiXd84/p9JVs/9baS0RhOKn2gBFVtvibdknEXi2R0khO5YLBDRPiazwJuyPztGnBBW7uKPPPBnjDTQLHqyYOLJm0t03l6DtCdYa7XkCbZ/bOPsBOld6I4GOXnYtDG4dmAHY9lFzVRevw4NmeXlKdbr0fbaQRLhyY6FoQ7K3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450233; c=relaxed/simple;
	bh=XFJ1aKi1jgl9k4Pj8uVu7SobOC2+U8FNkT6KKcsjcm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9zKTEECAs0S3g99FeBMbUud0WUHl1L7lJbVk9KJ1zl92vBdvTRKlzfXDkuwVJme4Ge9Q6Ln7RxcK8i7iCezjpJB0S40mpFvVdJqVT/a5UijAtGPPPH8tmc/chLzJ+GdYINyeBXtfHmSJfelShnYA853JputlAOlz4aMPQQWaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hwivdIAl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hwivdIAl"
Received: (qmail 485892 invoked by uid 106); 29 Apr 2026 08:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XFJ1aKi1jgl9k4Pj8uVu7SobOC2+U8FNkT6KKcsjcm4=; b=hwivdIAlgzZ3tRNiVeKvmomLa7gGMSYswZvwgSPk356H8yG2uOXh2DRPo2CgDkbk4DurjdzWSLoBF3ifLLltu0xwD9asZJ5NMgFuieJpJvxtci1XdoW2NHbwig9tQY4q6xoeoYreCNZDL7g1tJ+dBpJwHD4YkK5TpTh8RfCtnbfMF3A91zFLFaTuhfcvWuy05hfGIbsev82TaUNB80rjLVmiDDTRBxZaJpHYdat0jJo8ahFEAaUPLMu8qpUsZ8QXhQ5bFqqoWbDdoeCNaanSBpWyjYjRu7kUH7+hW10d5bPYv+KJ5219nYZP7HKPAXowenQq+Rky2RovFW41y/ZHsA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Apr 2026 08:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099812 invoked by uid 111); 29 Apr 2026 08:10:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2026 04:10:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Apr 2026 04:10:30 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <20260429081030.GA1268740@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

On Tue, Apr 21, 2026 at 04:37:08PM -0400, Taylor Blau wrote:

> The main changes since last time are described in [1], which I sent to
> the list last week just before the 2.54 release was tagged. For
> convenience, a copy of the main changes are below:
> 
>  - Use a strset instead of a string_list for keeping track of the MIDX
>    layers to retain when calling `either clear_midx_files_ext()` or
>    `clear_incremental_midx_files_ext()`.
> 
>  - A new patch to rewrite the logic for determining which MIDX layers
>    comprise the new chain via keep_hashes to build the array in order.
>    The subsequent patch converts that into a strvec, which no longer
>    requires direct manipulation.
> 
>  - The new "--checksum-only" option has been renamed to
>    "--no-write-chain-file", and various small implementation tweaks
>    (e.g., relying on `is_lock_file_locked()` to determine whether we
>    should update the chain file as opposed to reading the flags).

Thanks, I think that addresses my review from the previous round.

I looked over the final few patches. Aside from a small nit about a
possible leak, I didn't notice anything obviously wrong. There's enough
new and tricky concepts that I wouldn't guarantee there's not a subtle
corner case lurking, but I don't think me staring at it any longer is
going to yield any further insight.

-Peff
