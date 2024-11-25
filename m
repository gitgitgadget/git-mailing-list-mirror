Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40C1ADFFE
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552548; cv=none; b=rgUaE2XQT7vC35aEGBDfaMj3TPXKB5tACSF7HZDTDfl2SXRZICrTfXmd1FDC5M7hXfVPY/JQKK0L8qfUtwG3ZLDYhtgLAiyXIVTCTfDauIhC8zQzuTrtus+Xmurah7nr3VcfSd3fi+xNyqhxGoJ3poNW5RPdi/cqN9PHLInsVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552548; c=relaxed/simple;
	bh=ht69AMVkRca2CCsC2Vb4lpilp68L7+v4a1s3LcxB03w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekXdTWsuC71MEJ0x34qan+tbEwd4vhQdI1B+pt5RkcZCvXfsBBFRloYC8YHFQ2AuHADx6biGaSVytuAkONeuW8waStk7O56VDoBhqq5TxCYlXz8FbWLvF+tW9qj/MHK+jowDCNS3Phz9JhKILD6tCUYgrLLaCrZGMh062v7pCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S4vzV7NJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S4vzV7NJ"
Received: (qmail 13395 invoked by uid 109); 25 Nov 2024 16:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ht69AMVkRca2CCsC2Vb4lpilp68L7+v4a1s3LcxB03w=; b=S4vzV7NJi7FGmbmtCdSapGfickU5WLLA/EozXGm1rUqL3iw2bPPAt6Iqeijdd+sBVxrn2Q5POuPrqNYzzEx8rmh6pDvCVRChH/M+Ec3UbLd/VA1AJsm2sGD/92Fa4Pn5YK9D3tmaxndWycnlxHIejJs2/lU8XiCO7Pt6o2flKoXm83pXM2HVzPIeuToCMhkwfllvnCPll4X/UG3N7sHH4gHDRJ7pHfz7EBLiqiG5HT8G80rLzNVx8idB7SU0cjyKEP1BwQAIHcwzUAL5bikQMB0tJWQZXeBVLxUwIjjUzTqsc3FLAA5lK1ume5UfEjuVzZGZZZ1rGbQLoI6U9RNDkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Nov 2024 16:35:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12447 invoked by uid 111); 25 Nov 2024 16:35:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2024 11:35:44 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Nov 2024 11:35:43 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bisect: address Coverity warning about potential double
 free
Message-ID: <20241125163543.GA13033@coredump.intra.peff.net>
References: <20241125-pks-leak-fixes-address-double-free-v1-1-d33fd8ebf55b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241125-pks-leak-fixes-address-double-free-v1-1-d33fd8ebf55b@pks.im>

On Mon, Nov 25, 2024 at 04:56:25PM +0100, Patrick Steinhardt wrote:

> Coverity has started to warn about a potential double-free in
> `find_bisection()`. This warning is triggered because we may modify the
> list head of the passed-in `commit_list` in case it is an UNINTERESTING
> commit, but still call `free_commit_list()` on the original variable
> that points to the now-freed head in case where `do_find_bisection()`
> returns a `NULL` pointer.
> 
> As far as I can see, this double free cannot happen in practice, as
> `do_find_bisection()` only returns a `NULL` pointer when it was passed a
> `NULL` input. So in order to trigger the double free we would have to
> call `find_bisection()` with a commit list that only consists of
> UNINTERESTING commits, but I have not been able to construct a case
> where that happens.
> 
> Drop the `else` branch entirely as it seems to be a no-op anyway.
> Another option might be to instead call `free_commit_list()` on `list`,
> which is the modified version of `commit_list` and thus wouldn't cause a
> double free. But as mentioned, I couldn't come up with any case where a
> passed-in non-NULL list becomes empty, so this shouldn't be necessary.
> And if it ever does become necessary we'd notice anyway via the leak
> sanitizer.

Nicely explained.

> Interestingly enough we did not have a single test exercising this
> branch: all tests pass just fine even when replacing it with a call to
> `BUG()`. Add a test that exercises it.

Seems reasonable. That test will end up passing an empty list into
find_bisection(), because everything is UNINTERESTING, and the revision
machinery's limit_list() removes the UNINTERESTING elements from the
revs->commits list.

I wondered if a topology more like this:

      one
      /
  base--two

could produce something interesting from "rev-list --bisect ^one two".
But no, we still end up removing all of the uninteresting commits before
we hit find_bisection(). And anyway, "two" is obviously going to be the
output, so we know "best" won't be NULL and it won't hit your new code.

So I agree there doesn't seem to be a way to trigger the new code that
isn't just a noop.

Thanks for fixing this!

-Peff
