Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89B17BB3
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528192; cv=none; b=AdLrBsB2oOVGExZlxg4L4O8kKFzGZt60keuBV/NfCUR/titdVc0gyWJq1TyudepU3cFBn12+FxldbFXEFIMrd5wFcPSwBQFxCBrxyTiq4pZR8v85KKUQ1tzQFXxdfC+O5b7QIIQI91ZE8d4/ZuBS0aCK4PVsZgBatOCTvMwG6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528192; c=relaxed/simple;
	bh=ECrjN8WFHAzv6nSp8iJd9rJEr6+BffFn32joGn9AGMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUu/z6MtczDcJLviUoMQCzi1L86aij+n0r+eKJbABGGeBrTKBaWRditUVHE/73woJKY68s5mL9bgbc6p9wAlU2Rn7txMOlgBUWXPI5Rc6ucwQgxINj6uW6RrAZEf8ttFiO428LgEUTTXjjzwDAzyigCxPdFXIr3jA4eAaqWhWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21529 invoked by uid 109); 27 Mar 2024 08:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24358 invoked by uid 111); 27 Mar 2024 08:29:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:29:54 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:29:49 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] midx-write.c: factor out common
 want_included_pack() routine
Message-ID: <20240327082949.GB830163@coredump.intra.peff.net>
References: <cover.1711387439.git.me@ttaylorr.com>
 <5475b09a7afc4d55a8e1a1a72f20fa9109447cec.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5475b09a7afc4d55a8e1a1a72f20fa9109447cec.1711387439.git.me@ttaylorr.com>

On Mon, Mar 25, 2024 at 01:24:44PM -0400, Taylor Blau wrote:

> We could extract two functions (say, `want_included_pack()` and a
> `_nonempty()` variant), but this is not necessary. For the case in
> `fill_included_packs_all()` which does not check the pack size, we add
> all of the pack's objects assuming that the pack meets all other
> criteria. But if the pack is empty in the first place, we add all of its
> zero objects, so whether or not we "accept" or "reject" it in the first
> place is irrelevant.

OK, that makes sense. It does mean that we call the expensive-ish
open_pack_index() just to find out that it has 0 objects. But I guess if
we didn't reject it at this point, we'd soon open it anyway, so it's
probably not a big deal.

> +static int want_included_pack(struct repository *r,
> +			      struct multi_pack_index *m,
> +			      int pack_kept_objects,
> +			      uint32_t pack_int_id)

I wondered about this funky pack_int_id interface, rather than just
having the caller pass in the pack struct. But we need it because
one of the callers needs to load the pack struct by calling
prepare_midx_pack().

That should be a quick noop for the other caller, since the entry in
m->packs[] will already be filled in (and if it's not, then you've just
fixed a bug!).

So this all looks good to me.

-Peff
