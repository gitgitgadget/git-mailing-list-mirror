Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF9330B30
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547332; cv=none; b=eF6a1d6Qjt8Sk/4GvRvs6Jb+qRBvUkTTgeX6eYP5Ji9N034QAivmEeF0bcEdwA3A3VhZckIqmIP3WAq+LSfQqdg2SR7LdF2TECRzxJRU5S6TDcg2EjuM/ls4YPRCo2FqEfWe2YtE3LX9LNX3XdAsK2FWq/riazVotHwD5igjyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547332; c=relaxed/simple;
	bh=7usyK16b7Krub2OB0lpXcZZK1st37xdqbxC5qccrORA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGcoPwEjB077yNjUOP+grlM/MVwS3CsHPP0fKqTT6Aep22Irp8gKzGR0eLeaWHcQOP4jOWitqCaG/Q2PsDE6UhbHV20yk20MOtTwf2RvgpRCriXA6YFuQl1oBxNGalzLMw8LiaCQYTMNxh6pP/EQ24rB4jfoppYNkNp1pjSKTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V8GmWh0I; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V8GmWh0I"
Received: (qmail 104131 invoked by uid 106); 24 Aug 2026 04:55:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7usyK16b7Krub2OB0lpXcZZK1st37xdqbxC5qccrORA=; b=V8GmWh0IfYv+roq9Ew6Td5eoCLne0C1uZIVsK7EOiU/FMekVMCev2ladja0rAI1mhe173sSmWAsXt7hQMs/o1YUcLdfT9PqDi2MJD9ky4UI9K294xgxwCuk8gLws2G0XAqsuikQ/kyDJaUTF+ZM15xSBYC2ry/d39oR2HFZzmsTyGb1iJJYYfCwbH2fVPYt9KWxIID8FQDjeIuhQQ2WFwagR6apIL5T2N4k1OPeS2qcLasN51rXUcNCMrAxewmc5E79ZH4GUo005WZzPRTCX1RZ/5o8kTEt/c5mVLhLvATsQrcy4vGyDgxg1q6OlwNAMRxHKYPnlD0pV0u/wAGKlfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 04:55:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 127438 invoked by uid 111); 24 Aug 2026 04:55:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 00:55:34 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 00:55:29 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260824045529.GB142844@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>

On Tue, Aug 18, 2026 at 10:34:06PM +0000, Elijah Newren via GitGitGadget wrote:

> Teach find_pack_entry() to recover.  After the normal multi-pack-index
> lookup and the regular pack fallback both miss, check whether the object
> is nonetheless present in a covered multi-pack-index (bsearch_midx()).
> If it is, its recorded owner must have become unavailable, so scan that
> index's packs directly for a surviving copy.  The bsearch gate keeps
> genuine misses (i.e. objects absent from the index) on the fast path, and
> because the recovery lives in find_pack_entry() itself it also fixes the
> OBJECT_INFO_QUICK callers that never reprepare.

You don't even have to pay the bsearch() again. We'd already have looked
in the midx earlier in the function. We just need to distinguish three
cases:

  1. it was not in the midx (or there is no midx)

  2. it was in the midx but we could not load it (pack invalid, or
     object in the bad_objects list)

  3. it was in the midx and is available

In fill_midx_entry() we return a boolean that lumps cases 1+2 together,
versus case 3. It could return a tri-state that would let us distinguish
all three. And then your fallback would kick in only for case 2 (case 3
already returned with success, and case 1 means the midx does not even
mention the object).

This is all assuming the fallback is worth pursuing. I'm still puzzled
why this specific case would matter when we have the same (already
solved) problem of reading a regular .idx whose .pack has gone away.

-Peff
