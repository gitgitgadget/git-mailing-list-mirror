Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97530569F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982964; cv=none; b=WwXvDeVtCWOJyGP1w5K/Q+hOk75ZcvaVpNK7UrKOir/qMCmpdruIyqYvJcdmosXRIuIUZWrCjBAA7xXbLftIb2z2E3hAXZsMBIXohJzdelhxb0XIafqVNPge1ELObxFJzRrdP+LtQg6xeToeMlREpyxG22DcOIFcc+6Z0cyqZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982964; c=relaxed/simple;
	bh=HAs0ZUu6Ks7DT5uvS7hrP6VrxnKDpHtcRLcMJYdKxRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW8AaAQ4y0GqCLEfzp0MPbBpQLtZtAC35ix2pQpyZiGfTY37ThIQT2IIxGinsnZ6JPmkhqYNr+6usVI1ftgJsQNfygl0LKvnSivYiJtukkizcwV8kmZ2y438y/QaivIcZ8/4SZSILAPXXimx99xla6HRshgsoBKaTJam4WvjZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zw7uZOJF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zw7uZOJF"
Received: (qmail 16806 invoked by uid 106); 2 Oct 2026 23:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HAs0ZUu6Ks7DT5uvS7hrP6VrxnKDpHtcRLcMJYdKxRU=; b=Zw7uZOJFrzggSdMGncNk4MCrKNwxv4+2px4ChgJXf8ohSniCfn3AVE2YKoCqFj1DHLilEh9SMUJ+Tyy53G05Y2dZEk8NHEi/EsA28XLTxp2X2UIbaPX2Bza1xK02FmTFAx9xz7dOMKXHQTXXlHM4VcIGrokXWb3EYZ2Gk9hrlts4q6er4VWM77NhiQbHSMAZqGNwNQlSsh4ayfN/HwElo/OLaBgVqkMCU+RyZxbahSx2X2qmRhoYO2FGy2Ju++QoCiXU0pCKQ5FSqJCFlse4cPejbz92Pgjz2jPC/j7KVC+HVBialp/zw7Ds6knvk0E0JpjubUYOukrTa9+vxOalvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49220 invoked by uid 111); 2 Oct 2026 23:16:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:16:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:16:01 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 4/8] repack: use a sorted list for explicitly kept
 packs
Message-ID: <20261002231601.GC834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <c1ff18bf91363c638536265c600a7ce5ac4e1218.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1ff18bf91363c638536265c600a7ce5ac4e1218.1790827875.git.me@ttaylorr.com>

On Wed, Sep 30, 2026 at 11:11:47PM -0500, Taylor Blau wrote:

> `existing_packs_collect()` performs a linear search through the
> '--keep-pack' arguments for each local pack. Typically the number of
> such arguments is small enough that the difference between a linear and
> binary search is just noise (especially compared with the amount of work
> that 'repack' is about to perform).
> 
> However, an additional caller will wish to search through the same list.
> To prevent that caller from having to duplicate the clunky for-loop in
> `existing_packs_collect()`, sort the list using `fspathcmp()` and
> replace the existing caller's loop with `string_list_has_string()`.
> 
> This does not change the overall behavior of '--keep-pack' arguments.

OK, makes sense, and the patch looks correct.

-Peff
