Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BB3C3450
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801133; cv=none; b=sSDhRKy0NGDGEKglR8tatOJyvZiI9CO5y0N9lI28QD2PfjUDW3EM58wTGiePrzuJGF143JEkWUgzXzR3sAHsreF2ZfRtXh8cPU5GUJzd43ErxJf3Qrzc3ppnp8vgbSuM2ukbLKT+VltuCUACXAtfV8lQtWMA2LUvNzWAZrBI4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801133; c=relaxed/simple;
	bh=cjMeU2L/TS3deDFoAicUu7CC9U6zPshLvrg7VTjQoFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8iPpRScW0aUYyB8mGT1je2yjStjG3/CE342aJsWTixNw2vVhXT/ItMVoo21stL4eVYolc9SgLtV3YTS+emn7P+EfcFtfEaIQqIxANH/04d0Yu4x30oddUWtZiBkbnVu8J8CUGoR5naFrAfbZ3uYNWOLZegkKGsOmp18N80skwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H/dE3a6O; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H/dE3a6O"
Received: (qmail 7544 invoked by uid 106); 30 Sep 2026 20:45:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cjMeU2L/TS3deDFoAicUu7CC9U6zPshLvrg7VTjQoFs=; b=H/dE3a6OiMecMK+k80Gi8nqm0o4J04vHyWSlaB2M+eu4LMySdQ3CUkTn7BinrGfiwkM1XqeO2QmkkSFDETEbhsZArUKbdSjLykkccABobxbk6BiLrpLMXNNc3tv3FKJTXM+R6mhqNpBy6fLuQohwpWmt89PmjAFNc24+LtiwF5fiXmI74F1+0j3JxwBWPgGTo8zr5UXen/7ZmJ00veZZI0H+p9vM4LIQZejxkftZGXoIj4O2GeLf+DurVx+3vEJNRQJTENckA/+UiAwEC/GIdkPWTYalsk6USV7qcHPMgCkArQAg8LmKa0cpT/GKL9tY1WziipGg3C2bsOQ7PM84AA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 20:45:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18781 invoked by uid 111); 30 Sep 2026 20:45:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 16:45:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 16:45:29 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 3/4] repack: retain cruft packs in MIDXs after
 incremental repacks
Message-ID: <20260930204529.GB747209@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <1774fed77be11b37ce9eb4b7806f5f14539503fb.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1774fed77be11b37ce9eb4b7806f5f14539503fb.1790731662.git.me@ttaylorr.com>

On Tue, Sep 29, 2026 at 08:28:53PM -0500, Taylor Blau wrote:

> When the 'repack.midxMustContainCruft' configuration is set to "false",
> writing the first MIDX after such a repack may omit that cruft pack. The
> new pack bypasses the `!names.nr` fallback, and there are no previous
> MIDX packs for `midx_has_unknown_packs()` to check. Selecting the new
> commit for bitmap coverage then fails because its reachable objects are
> not all in the MIDX.
> 
> The omission dates all the way back to 5ee86c273bf (repack: exclude
> cruft pack(s) from the MIDX where possible, 2025-06-23). It relies on
> geometric repacking to copy once-cruft objects with
> '--stdin-packs=follow'. However, an ordinary incremental repack makes no
> such guarantee. Require the MIDX to include cruft packs in that case,
> even when a new pack was written.

OK. So this is a problem with just incremental repacks, but _not_
geometric repacks? And only when those incremental repacks write a midx?

If so, that makes sense to me (and the fix seems reasonable).

BTW, write_midx_incremental() does not check midx_must_contain_cruft. So
I think you'd have the same problem with --write-midx=incremental.
Adding that to the tests causes them to fail. I thought it might also
fail with GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1, but doesn't
seem to.

That's not a new problem, but just a spot where the fix doesn't extend.
Not sure how important it is to do now, or if it can wait for future
work.

-Peff
