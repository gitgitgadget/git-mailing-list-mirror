Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF02E8897
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361423; cv=none; b=JieLIqDYeNy7M6H7XBGJ5L7zIW95hS4Ql6vW2quqdNZtI15tzGp2cNA84CzkcnSPuMHIIJPImDMOGSu0Jb7iinOfhmtpeMGLLjS2K2uej+FeLdcH/cHoQm/7Li2d//f9Gqt19etapkn8BVo9tOZEqly90z66oFkjT2qWak7oBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361423; c=relaxed/simple;
	bh=Rk/Mh1zNJaxQYEO/9AtixD2/93mLf5bGNw7jCoxyklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D34zCdKulwoIwBmMgz5D6/8s5Kz8oUKz61EfQbI3CfVnmFj3OG8+A0LRDj7wVLqX8+aVI39KVraXWBJSraXIOJiF3s80ikbj1JmkYsb07tel+r0GQ4CXlvA0SXs2qsJogEQPbLxu634x2XzxzazYBxe9H5OJvBrppHW7QvklJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JbmTLXQr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JbmTLXQr"
Received: (qmail 60139 invoked by uid 106); 18 Jul 2026 07:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Rk/Mh1zNJaxQYEO/9AtixD2/93mLf5bGNw7jCoxyklY=; b=JbmTLXQrcXMihUNbGz31WTbeqB6SDOYXfh4SjKwk+MMgNLr2Ui1oGTbDZEoRcN8Sz1F3t4dbWuoq0i3bmqB5xUiMqhb7P0uEwBddbPEeLgacPZVqwuLaGOWGwLCRZql/NrZqQ87hocW45oCq1G5vZP1J4xVbjfmFFXJ4LJCXIvXLaUUrPIImEgHdRf4MSKAKbJzS1c8HFL/u7vbDk9tH5iYhefnweYqSD8f05edVfw4FI8Jed1/bFkZNXncthH1DwQow/MxU/K2XjHGopLo5jNfmkab6DJBjoWRqGCCpN5uWriL3zXWHw17Eh4c9p3v3R9bPP2+xpnotZ3Q6EsRtNw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 07:57:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 106677 invoked by uid 111); 18 Jul 2026 07:57:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 03:57:05 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 03:57:00 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 1/4] revision: move bloom keyvec precondition into
 function
Message-ID: <20260718075700.GB22588@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-1-410418f18614@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-toon-speed-up-last-modified-v1-1-410418f18614@iotcl.com>

On Fri, Jul 17, 2026 at 05:46:59PM +0200, Toon Claes wrote:

> There are currently two callsites calling
> check_maybe_different_in_bloom_filter(). They both check if
> revs->bloom_keyvecs_nr is not zero before they call that function.
> 
> Move bloom_keyvecs_nr precondition into
> check_maybe_different_in_bloom_filter() to simplify the code.

Makes sense, but...

> Note that this changes `bloom_ret` to become -1 when there are no Bloom
> key vectors, which results in `count_bloom_filter_false_positive` not
> being incremented. This is unobservable, as the Bloom statistics are
> only reported when key vectors were set up.

This "-1" return is kind of subtle. The function is really a tristate
returning one of:

  0: no, it's definitely not in the filter
  1: yes, it's (probably) in the filter
  -1: we could not even check the filter

But nobody ever cares about the difference between "1" and "-1", because
the probabilistic data structure means "we could not check" must err on
the side of "it might be in the filter". But that leads to code like:

  if (!bloom_ret)

that _looks_ wrong at first glance (as in "oops, we are not catching -1
and accidentally treating it the same as 1"). But it's is actually
correct for the reason above.

The "return -1" you are adding here is not the first (we'd do a similar
thing if the commit was not found in the graph file). So it is not
really adding to the confusion.

But as we prepare to make this function public, should we consider
changing that tristate to a boolean, like:

  false: no, the path is definitely not touched by this commit
  true: the path could be touched by this commit

It's a minor point, but I think this makes the interface much more
obvious.

-Peff
