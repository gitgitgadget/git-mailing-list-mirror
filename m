Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720D36C0AC
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611926; cv=none; b=U7CTY8RZGxUUX154b4ipne5eqB+g9fGMDkCYeTjR8AdI4xnwuHVBLJRJSmkncrK7266qWtxLod7LBoPAkuyUBRDcrjtyi1uywfzJbVmMqOu7jLjvs1Xk7ZAMWH4fCMh6Ty3moMdtPfVccDdoEYDMPR2VTzUmPD7RwMI67bmjVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611926; c=relaxed/simple;
	bh=uNTHI7qIubf+IgvwfGdkB8YyTrqKmw2qOqmtOsDB4BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm0lEv6VbY+RR5o+evt4gul0QtAjz21nIoURwbKi07Hu+zlGSl40lAboAFiREfzKaQEGL5GzFZvz8DDO+ywFLvj/BBpJJyGIMyJ1alAjsakuaz+PNdWBS2/crFSNNdfcOzdtVEvp4Nw3EjYMYoyseYhqkpWnkLalbpOf24wzHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OUTJ8258; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OUTJ8258"
Received: (qmail 119497 invoked by uid 106); 24 Aug 2026 22:52:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uNTHI7qIubf+IgvwfGdkB8YyTrqKmw2qOqmtOsDB4BA=; b=OUTJ82583BGwsUgjuSfmuRwykGRZcfEu9vaLrJiTXFWAEX0TO/K627PM0IEeTClAkXnLxbxgmqK7a9M9BODPqoCIwhAw3eUQ9U0mq1/KBqySRSRMygi8bhrAU5se48r22qNyZaCSNPnHjYJocOo2RiQgy9GdHc0Ph6TWmbgMuDyqpsCs4x+5qnOC3g6leoT5aBITYSA/2y4QWJepm66dIWQjojS1UZiNBPJmN0CMSsmWTapHAnsvy+8C6sOpVY3/EbArALm9wY4j1CWQhqOiESqyOyvqDwQd+BmljYxSwm3Yje1d8ofSZnq951hd1WOGvFGzRLvR+kzbUMUh9/wP7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 22:52:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 151915 invoked by uid 111); 24 Aug 2026 22:52:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 18:52:05 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 18:52:02 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v2 4/4] reftable/stack: avoid reloading the stack when
 already locked
Message-ID: <20260824225202.GA190620@coredump.intra.peff.net>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
 <20260824-740-optimize-reloading-the-reftable-stack-v2-4-9c9de2eb0af7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824-740-optimize-reloading-the-reftable-stack-v2-4-9c9de2eb0af7@gmail.com>

On Mon, Aug 24, 2026 at 11:31:02AM +0200, Karthik Nayak wrote:

> Benchmarking with a fixed, non-symbolic target OID in the 'refs/tags/'
> namespace (since it triggers a stack reload when checking if reflog
> exists for the given tag name), shows a consistent 15-20% improvement
> with these patches:
> 
>   refcount   master     patch     speedup
>   --------   -------    -------   -------
>   2,000       18.5 ms    16.6 ms   1.11x
>   20,000     120.7 ms   102.8 ms   1.17x
>   50,000     296.5 ms   247.1 ms   1.20x

Much nicer. :)

I'm not very familiar with the reftable code, so you can take my review
with a huge grain of salt. But I think the idea is sound, and I didn't
see anything obviously wrong. Thanks for working on this.

-Peff
