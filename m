Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725043D300F
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961980; cv=none; b=TaA9FB+t9scDktq54R8KCN5x/bm/f3z0TuXYC9KaOYcbzfu1Zf85YLsE6ZS8os+NWgfUrxXuBh8+ZJvuqiGk9AuULruEVV986Z57iLi1ERUdOVijT4lwi8eWZoqrCZoUkpYlm3/LiuH+WgTYI9dwhJ62Utzjbw/3pC2dwCrsP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961980; c=relaxed/simple;
	bh=GRT9VBba1xOZBVUeTXOkDvqi8xbbaWzHWeogjWKDbNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU2f5d7oKoMTaYCAM2mBTao+wpmd32av4+azHQ/VcCcKy6b7r9za3Ur16vhj7GKqQzS4b85nYBh7AUI/NfAFOXvqTm8/Nwat3F89hCvstr+Hm8kM5u8DyWOYHc7pau4lrVOX1C2FXYdu+XECT3QuBtx5OT6IZhg5hxhJ6Og2YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aEcVchud; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aEcVchud"
Received: (qmail 54414 invoked by uid 106); 5 Aug 2026 20:32:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GRT9VBba1xOZBVUeTXOkDvqi8xbbaWzHWeogjWKDbNg=; b=aEcVchudmmFwGFGaXcdSMST6srEsf9z8V1KZ1NUWwFIDsLjHz7Iz5SwntQff64+Ld1hiNdEqyVURHZBmrpT45g0SxhxIrHa/HQeoR73pWooh1BmMvIr2C800eufEgRD3J/EqQAZudbnCeTqHTcLOTb55zeOp+URmAcEQLwqOLqpBtDgC9mGSde+NRwTRRZ/70uqVXQTpB5ZlLRGyf6HXiCzw+/EZjRCEj8e0VysPuSmQh53GWsrhxojvka/3C+jXYAnzbCkOWoBDnWVPCor7NjxfsR5zTafMxIp9jsziCxWwE97TXQzp9rON0X5SzgdN+jSKVY/q3CsjPI9YQN8Quw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2026 20:32:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 81762 invoked by uid 111); 5 Aug 2026 20:32:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2026 16:32:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Aug 2026 16:32:55 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 1/4] revision: move bloom keyvec precondition into
 function
Message-ID: <20260805203255.GA1010713@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-1-410418f18614@iotcl.com>
 <20260718075700.GB22588@coredump.intra.peff.net>
 <87wlu44bv3.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wlu44bv3.fsf@emacs.iotcl.com>

On Wed, Aug 05, 2026 at 09:16:00PM +0200, Toon Claes wrote:

> > But nobody ever cares about the difference between "1" and "-1", because
> > the probabilistic data structure means "we could not check" must err on
> > the side of "it might be in the filter".
> 
> That's not entirely true. The `count_bloom_filter_false_positive`
> depends on knowing whether the filter said "maybe" or if no filter was
> used at all.

Ah, yeah, you're right. I saw the "== 0" comparison there, but didn't
notice that we later checked it against "== 1".

> That said, the public function might have a boolean interface, while
> the private wrapper still uses the tristate. I'll address in the next
> version.

Yeah, I'd be OK with that. Or leaving it as-is, given that there is a
caller who cares. It might be less subtle if we used symbolic constants,
but that could be done separately (later or never if nobody cares
enough).

-Peff
