Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3601DED4C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771753330; cv=none; b=u20/2asjQVpZCi3nCkczQy9rLdRAFiC9rjOU4txWhOu0PJwG2wwQ676mvHp/zh2cq5XIMFFVPTm6QGFs5H87nvUApitA6sLLYQE/CnVjUgYL4L8O60hz/NUVpSSxATLYD0j5lykP3LzbcXVxZmTRSsAXgnPbt45any4r1ppxYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771753330; c=relaxed/simple;
	bh=1fBYUoTgGLqicl36r/OwLZNnb5d83Zv7Tq5a1Xe38pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbc0dVWUGT0J/nw50AD3miCZHu6RHiIF5gb6Bc4WJzA0qV8rNVMpDIUG0sXr/2UWP6j87Ap9SBlKnA6eTPzEVXxfyfr7otRlbdfETms4V2kqVTutiJtrvmbTR3ToSk3ZfjPHvbfTlK1/UOrghX2spCdFiDDaYZoSlxfh0USyn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MKlPreEm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MKlPreEm"
Received: (qmail 33096 invoked by uid 109); 22 Feb 2026 09:42:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1fBYUoTgGLqicl36r/OwLZNnb5d83Zv7Tq5a1Xe38pY=; b=MKlPreEmrbfBUDzKWozDiI+5jbHitsT8y0YEAiLKmfyWIyMh8aWMeppaOmbokHpMGeI7fJ48Mdp3R7Hb+agEqLnMWPCLx5XNdSOhT01RyCfZP52W7hnZFimNQ1vIgi3ifkADln/1EMOfA4r5e3IMGVnH4d+vHUWBr4tC3dvX+rL314xYTsZ1YTzy4LGsARdFb5kp0uR9fj+GSPeiT6Lb+gykZCpyXm66bkk+kigJsM0s4ftXpPL0fvUrXuI6bACKGZRGsyco910Vml8JXyQLNZD9w9j8MKmB0T0QUiASIum0ixW9xcnfpcgLEMFU5XS497QyDVDVq8GVAEy3ROgcMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Feb 2026 09:42:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57246 invoked by uid 111); 22 Feb 2026 09:42:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Feb 2026 04:42:03 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 22 Feb 2026 04:41:58 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
Message-ID: <20260222094158.GA1319383@coredump.intra.peff.net>
References: <20260218210120.1146078-1-jltobler@gmail.com>
 <xmqqms11qmsj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms11qmsj.fsf@gitster.g>

On Sat, Feb 21, 2026 at 11:07:08PM -0800, Junio C Hamano wrote:

> Perhaps a fix-up patch on top of the topic branch like this?
> 
> ----- >8 -----
> Subject: [PATCH] object-file.c: avoid container_of() of a NULL container
> [...]
>  static void prepare_loose_object_transaction(struct odb_transaction *base)
>  {
> -	struct odb_transaction_files *transaction =
> -		container_of(base, struct odb_transaction_files, base);
> +	struct odb_transaction_files *transaction = NULL;
> +
> +	if (base)
> +		transaction =
> +			container_of(base, struct odb_transaction_files, base);

That works, but you can also use container_of_or_null() in the
initializer. IMHO the result is easier to read.

-Peff
