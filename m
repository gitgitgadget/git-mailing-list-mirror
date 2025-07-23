Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20994271442
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315173; cv=none; b=TnILQ12qenIk6GGRWpq9Tco0IUgteu+5g1P/oTIRl63lnsE58Hl152/yDKflLFk3RHKxp4g8rM65c+ZcnNmPMnZgQU74cdphpJPtXR5FcosW3CsIGSMbhoEGmxncVOqe9ogazyy6N1LJqh5lSBPHv9ZtLw4puj7/rFISpgg3Urg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315173; c=relaxed/simple;
	bh=bh3VEx93NSC67OuQ/+YFkqvxVwpABEmb3vzWqs1Gqs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8/fVgsAROYKBA2t0usDxM7rLI3E2mLMJ+EyIJTR1BPoU+8X8vDB/zrcceVJ+vsWdmoeppXGbP6XHuJv2QCPncbD9jIOdT0EDZTpW3YI8rfzjhoIO1RdRKPWP4Le16Df6joOsL+GCIPTlAOhEFypeg1zY90o17QPc8I6cUvqoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=II+5hUCY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="II+5hUCY"
Received: (qmail 11956 invoked by uid 109); 23 Jul 2025 23:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bh3VEx93NSC67OuQ/+YFkqvxVwpABEmb3vzWqs1Gqs0=; b=II+5hUCYT4cn6RYalNkSL/WJ+34mjJv2iGXxKbnw63Zo22T9NkW38l1wlPO7Mf16OsC40u4EH3Ogv1h10hUNygYKQYimAXhpTDpW6LIZTj2l+ZnDaEgg6mXK2OQhtALA3pLKP7G+4/Eokm+ZBIRzXrDPj0YBovMRvMZX5lxRyBSenbMnBiNddJJDeS024tGtZhuFGwArwMNuyfl7SKWkUyeDCWEkZmWQBKLZIyrW5dlqzl2ni6UtJS7h9kE1IvaH6ZlYOSOdS8n8fkszIvvoWGs6CbmJjU6XAvTk4Yh8xKUiJJsP938RIyYX8Lu3NBU/Wt3G12u/GQjOk9MQVOjKdw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 23:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25764 invoked by uid 111); 23 Jul 2025 23:59:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 19:59:32 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 19:59:29 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
Message-ID: <20250723235929.GB592873@coredump.intra.peff.net>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
 <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
 <20250723075513.GA570540@coredump.intra.peff.net>
 <20250723080639.GA570920@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723080639.GA570920@coredump.intra.peff.net>

On Wed, Jul 23, 2025 at 04:06:39AM -0400, Jeff King wrote:

> On Wed, Jul 23, 2025 at 03:55:13AM -0400, Jeff King wrote:
> 
> > I dunno. We are reaching diminishing returns spending brainpower on a
> > function that is meant to be somewhat quick-and-dirty.
> 
> OK, I clearly could not resist spending more brainpower on it. If we are
> doing quick-and-dirty, why not just die()? The end result is the same,
> but per my argument in the earlier iteration of the series, that means
> we do not have to worry about cleaning up at all.

So...I feel a little bad about hijacking Hoyoung's thread. But after all
of the discussion, it seemed simplest to just stick it all into patches.
So here is a potential replacement for patch 2.

  [1/3]: test-delta: handle errors with die()
  [2/3]: test-delta: use strbufs to hold input files
  [3/3]: test-delta: close output descriptor after use

 t/helper/test-delta.c | 77 ++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 53 deletions(-)

-Peff
