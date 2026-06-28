Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0982882CD
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782637581; cv=none; b=G/ORc+kZ4VCZaP6apHwhoELM6nH98hkVy3emJTM/5g5QkHqft/MxUmmPNlkBv8LMT3ndrTOnpHQAyRU+5HDWdO6hcdpcaxVTnXYLoa3PAXR7Wk94RHmxUywcKvhaRlUDvflANa7W0gVsX3eQ1UEB7R87HzsWvvx5y+l8Iv+hpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782637581; c=relaxed/simple;
	bh=TlGiRcIkOWIMP+TyEjb9Dh3oHpamhJHvaeZxjRZ2XN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAOQfblhZNuuGkgcP9FCnpLtCmNrUC3IaQOIFf3/pn83wiXiN8WGy8nR6cboqax9gF650WtFiejVbDe5WgKnyHGkFqk5RkhWZ6K9KbEo51Ra9fSbV/8OM1OJzrOnEuD6UjDRsfq/GOsp1R9+sHT24osvyUKLLzS5Imxim/gAJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KgcxrCyt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KgcxrCyt"
Received: (qmail 52632 invoked by uid 106); 28 Jun 2026 09:06:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TlGiRcIkOWIMP+TyEjb9Dh3oHpamhJHvaeZxjRZ2XN8=; b=KgcxrCytgRuYfK7tNexabMWXeKp+oXvXSbCKxVwqtjnE9VCS9iTolhsXNER5nR6y9JhthkKwm7sUPFWNIYNL3APls1rxF3HAjOkCYdkilQunLSepIV4Y975mKApIqHGKugcwGzUo/DcUeagswTHhM0/gEtPpkO2QKfwdMIz+I3VjBd8422fYWxgkKnujZvY1WW6LjvnAduyG9jcBLnMd22eWG0PNQR4A1XrqBjEwpmsBLWB/pXVcPJOSNHQSphI7yn8wUF2x3w7ZR4jriwUAuJsVtoA1xPBi7Uc6uVJ7Lg+YHVQb6L/b0Sxj5falfA6QwaGVn29uP7u9VUV9fTywIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 09:06:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 112069 invoked by uid 111); 28 Jun 2026 09:06:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 05:06:19 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 05:06:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] reftable: fix unlikely leak on API error
Message-ID: <20260628090619.GA699336@coredump.intra.peff.net>
References: <20260628090314.GA661068@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628090314.GA661068@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 05:03:14AM -0400, Jeff King wrote:

> Noticed by Coverity as a "new" problem, though it has been there for
> over a year.  Presumably the nearby changes from 44f46f2be5 (reftable:
> split up write options, 2026-06-25) confused it. There's a backlog of
> hundreds of Coverity problems, most of which are garbage, so I tend to
> only look at the ones it marks as new.

This does conflict textually with 44f46f2be5, which adds a new line
nearby. Resolving like:

diff --cc reftable/writer.c
index f850e9d599,1bd4aa388b..d969a6a021
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@@ -161,9 -158,10 +157,13 @@@ int reftable_writer_new(struct reftable
  	if (opts.block_size >= (1 << 24))
  		return REFTABLE_API_ERROR;
  
 +	if (!hash_id)
 +		hash_id = REFTABLE_HASH_SHA1;
 +
+ 	wp = reftable_calloc(1, sizeof(*wp));
+ 	if (!wp)
+ 		return REFTABLE_OUT_OF_MEMORY_ERROR;
+ 
  	reftable_buf_init(&wp->block_writer_data.last_key);
  	reftable_buf_init(&wp->last_key);
  	reftable_buf_init(&wp->scratch);

makes sense to me, as it keeps the hash_id setting with the "opts"
setup.

-Peff
