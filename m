Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831337E2FF
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542230; cv=none; b=ORHWuAkIDm2E5RmQLpkFGcr73g1xxGLUtR3wD00fdqiu8lsgs71RRZtuhizxrDMzjQ9mT1G1BXg7+yQYsE/fP4+c0kyqHWKuuaHqDPz2bA8zjcLoknpFDYtMwfJCRfaFLmJOuPnIAHMjZcLgrQqYl9hgUKd8MZmlbTwOB9PEV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542230; c=relaxed/simple;
	bh=BcGDXLuWtZANefirnyYGqvxhpqlkN95QaKH17PvUJq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR+j88wo2JA7qWLef8OykHWfN5fgd9YROiPtC3eTTweYwO0G++ukL4GcmpwNUPwtjbUsLP7k5/Uz9S+y5SZT4QFHuWaQiWehL0aS+fdf2pnY3rkOG51jOCsezDQ12GnuF7IOZviSdls6KcRZsuooy/GCWE/zntcnxvA66byiA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ti2opqUd; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ti2opqUd"
Received: (qmail 269465 invoked by uid 106); 7 Apr 2026 06:10:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BcGDXLuWtZANefirnyYGqvxhpqlkN95QaKH17PvUJq0=; b=Ti2opqUdyyN2jB/FNX9kNTd2g7T7vpiZrBRu3C/O6J9jq2JqEtCmphxC9JeuWoA4IZww9cO4upu5K1bxMdQ1x8In+ElHt5H2WrazwzxJ55AozMO3OoYArLwyzSC7pUKvqENOm/uFHS8fHVdMgh6Sr0lPyoQXgYYIPtG3ZekI4jWM1H3w2vP7aIjC6NXrkp5IruW7AfYXRjUBQJnf4D3F1AtZfeoAiVxMO6tFddtZYhBnRRF35KZy3LPWc0bC59st3ON/TyudWnNZyQcwj9uv6s+73HsuswGGAQ3y4XYSOn5iaH982M4oHSvKsRQR1SJtxun86IVKMfGqLQDKYYCk7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:10:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441849 invoked by uid 111); 7 Apr 2026 06:10:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:10:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:10:24 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 11/16] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <20260407061024.GE714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:18PM -0400, Taylor Blau wrote:

> Teach `pack_geometry_init()` to optionally restrict the set of
> repacking candidates to only packs in the tip MIDX layer when a
> `midx_layer_threshold` is configured. If the tip layer has fewer packs
> than the threshold, those packs are excluded entirely; otherwise only
> packs in that layer participate in the geometric repack.

My first question of course is "so how do we set that threshold?". But
it looks like that is not done yet in this commit, so this is mostly
dead code preparing for later (and thus no tests). OK.

-Peff
