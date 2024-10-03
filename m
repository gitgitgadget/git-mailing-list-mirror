Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCC6A33F
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991033; cv=none; b=SmoWEKNKZZB/8GpX11m5zk8MzulO0ejH2Z4UEKxZ9OWe+3+C+845UoPuLtbWrLQ0jaZzgVnS7NfBgzeMdOfHLxOtnbIsEPN50PR2sGOtavKKuVuHdPyWIVst/m/YWFlTrNUFwBec/TTpHTYxGV/K0S4PvFimQ+8g01vlGAbyYMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991033; c=relaxed/simple;
	bh=eGa72HPaA31Xq9tkfWK/FfTbue2Vj5PAOsO1FU37WAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkw+6PJScDjASlbkj/Yuk68kcq5fhbYvs2NHW7/Td0UH/CM/Fq8yqNsWyDRCnBE549HVCPKNiBRPMx0ZRnKg7ybaQPW3ADoofBrF3op2U4QjY27RBEXDNjJwtRcGRJ0UzQscxsq+vCQTRj92QP4+rFwaVJT5bDtmE9jtWCtEFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KvYYobZ5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KvYYobZ5"
Received: (qmail 19445 invoked by uid 109); 3 Oct 2024 21:30:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eGa72HPaA31Xq9tkfWK/FfTbue2Vj5PAOsO1FU37WAY=; b=KvYYobZ5gD7XiJQT7kNERfwvJPFJs1yFnyU8zNjfaGUr6OOJ7mET91mLqgHuQ0WUQdB0YENTGmDFK3N09/Xi3veyxDUKKFRplCjMxhQPKM0L+W4zljXM5LU9+y0DFfZtsVqdfPpnsmBKfBDuPfi6XcKaGjBUelsccZUnXjiPLteYN+WQcbFALY75oVX8k6/1gjXTcJdNY7rFZD0jyLlDHHBDinDYG48yZ2lmnpq9Pu9N6V8JcAJPIQu9VsOJLk1sozSlNAU9PsZdeHmzcogaM7z9ZFJj4TfmaQHyFj3TI2Hpoaa0QuxygHr4YWqSomYdaLZFLw5NrDdf9sh5fPm5IQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:30:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22033 invoked by uid 111); 3 Oct 2024 21:30:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:30:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:30:29 -0400
From: Jeff King <peff@peff.net>
To: Alireza <rezaxm@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Request for adding a "one-shot" rebase strategy where conflicts
 are only resolved once
Message-ID: <20241003213029.GB12763@coredump.intra.peff.net>
References: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD9n_qgBPDQKF=ZEQ6SWvDCmcUXZvz33zSoHFQSwHmQPWS4z_Q@mail.gmail.com>

On Thu, Oct 03, 2024 at 10:36:28PM +0330, Alireza wrote:

> Sometimes a clean merge is possible but with a rebase, in-between
> commits may raise conflicts in which case a conflict must be resolved
> for each commit individually, which is not quite productive and at the
> end wouldn't add so much in how the resulting history looks like.
> 
> With a "one-shot" rebase, a conflict (if any) is made based on the
> latest revision, then in-between commits approximated based on that
> resolution. This way the history can be roughly preserved with the
> same amount of effort while still using a rebase rather than merge.

I'm not quite sure how you'd approximate those fixes in the general
case. You could leave the conflict markers in place, making it obvious
that the intermediate state is broken, and then replace it all at the
end.

That does make me question what the value is in rebasing instead of
simply merging, though.

You might want to peek at git-imerge (which also does rebasing, despite
the name):

  https://github.com/mhagger/git-imerge

I think in a sense it is the _opposite_ of what you are asking for, in
that it breaks the merge down into its smallest parts by finding the
conflicting pairs. But I wonder if you'd find the conflicts it produces
more pleasant to work with, or more tedious.

-Peff
