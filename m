Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008891E47C5
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611118; cv=none; b=V2vjN92w5y17tM6KW1yPwFirX0kHrX9EsBCpoYqfXnwwHcMt6bIpVHrila9IojbAJ3cRLrAz2NQogdOR/YYiKPR/pZHvHJwsqvo8FFEk8XeyviEO6ZLzR8ZC04Ll0XGfZbDxxhv5J4aNFSWyE84st1/ER5sXZBmDc4mOZDOpZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611118; c=relaxed/simple;
	bh=XiQJ62IdPwAN3Xp2yCJz10kzcmDqN47/f2oSHqXmDBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJoET6ghyBkTe71OY2ra0J6D/qe+yq3dn+VfOydp9ILjQe7aa4SRmL/jBD9PXlXJUub+HGyDyF//wfLVSMArUCyFT8oGoFQcTaxHoQFQBLcIczDZ2IWxvRDEGm9g2VWqs9ofd1KmQun4IuC13l4VPCmZ/ZmfB2hMzIafd8bUySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VbcRkszf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VbcRkszf"
Received: (qmail 28911 invoked by uid 106); 12 May 2026 18:38:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XiQJ62IdPwAN3Xp2yCJz10kzcmDqN47/f2oSHqXmDBU=; b=VbcRkszfekvYpxr9LH/XjVV0YLG7w+LMAW/X5Ncdm7+iz6NhvnCMbdEoAVVSs/qVUgeIV3XZJdKC7P0i3AqLBWIN6l6jB/IpfBUJiSHYRp/rA424JGX/oLG3ShNs7tk5JLLDay+Vj+++QzLou78fdoA2KCKz7Xv6KVt/RLhf43blglEHN8Z3XIXHGGCbAjKDytaDM2S6XjrYWJRW8HiUpFLDYytgwfZKOD/6FUmjGomGcMPcdtoPYTx0P5iTCeRbHv+SnSdmu3XLaRaIaa8ksblSPnOwliyh+gzBLnSwCRdV6GFn+X07AJOmYmEa+l4gP/Wi2JYFsSx2+MYqFi08kg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 18:38:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52368 invoked by uid 111); 12 May 2026 18:38:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 14:38:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 14:38:35 -0400
From: Jeff King <peff@peff.net>
To: Daniel Mach <daniel.mach@suse.com>
Cc: git@vger.kernel.org
Subject: Re: git clone fails when using --dissociate together with a
 reference repository that contains a commit-graph
Message-ID: <20260512183835.GB70851@coredump.intra.peff.net>
References: <6ae85515-9373-4c9e-90d2-5e4176590c5b@suse.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ae85515-9373-4c9e-90d2-5e4176590c5b@suse.com>

On Tue, May 12, 2026 at 09:35:49AM +0200, Daniel Mach wrote:

> I've stumbled upon a bug that the following command failed:
> 
> $ git clone <url> <dir> --reference <old-dir> --dissociate
> fatal: unable to parse commit <SHA>
> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry with 'git restore --source=HEAD :/'
> 
> Omitting --dissociate fixed the error, but it wasn't clear to me what might
> be the root cause.

I think this is the same bug discussed here:

  https://lore.kernel.org/git/20260504095110.GA599780@coredump.intra.peff.net/

I haven't worked up a more polished patch yet because I was trying to
decide between the approach given there (to lazily fall back to manual
parsing) versus filling in all of the dependent tree fields when closing
the commit-graph. Which one is cheaper depends on the access patterns
(how many commits will actually be looked at post-close, versus how many
were ever loaded).

-Peff
