Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349B1494AF
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724951405; cv=none; b=idtvDCddInHsDdu7MRqNVpMPaYYoJr47fuNIHCfNY90XlsjB/cYInZ359drSSB/r2jWDGBhYbiIU/p42pYkYToaUkWwHNou6a5HbJ2TeDrxwzqMIsni9pH4bDWZsj9zficlPtWywR3CPChP/LPYOjBqQoe+drirSVSyFGyja+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724951405; c=relaxed/simple;
	bh=/Htx1wlvIeNxIkd+pEbH2Uiwin01hydZTldwmkviOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj2q1syKlT4Ecgd46xF0HdiIXMcBXuJAf9tngWd98yuHCQmMcjiQuWbgg/dkfF0C73ijV0dU7REWYQn97UoqIK528rsrKUNBYiFDjG0qh8jWaaJ6UJG/kfYDsZmZ7KezMPtb+eILIxunps4GQjVoVmOdMPgmBF7qGu0pLELRnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4668 invoked by uid 109); 29 Aug 2024 17:10:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 17:10:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8333 invoked by uid 111); 29 Aug 2024 17:10:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 13:10:03 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 13:10:01 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
Message-ID: <20240829171001.GB405209@coredump.intra.peff.net>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-3-ericsunshine@charter.net>
 <ZtBHecRkFQkSAF6C@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtBHecRkFQkSAF6C@tanuki>

On Thu, Aug 29, 2024 at 12:03:37PM +0200, Patrick Steinhardt wrote:

> Okay, now the "ERR" prefix becomes a bit more important because we drop
> the other punctuation. I'm still not much of a fan of it, though. Makes
> me wonder whether we want to take a clue from how compilers nowadays
> format this, e.g. by using "pointers".
> 
> So this:
> 
>     2 (
>     3 	foo |
>     4 	bar |
>     5 	baz &&
>     6 
>     7 	fish |
>     8 	cow ?!AMP?!
>     9 
>     10 	sunder
>     11 )
> 
> Would become this:
> 
>     t/chainlint/pipe.actual:8: error: expected ampersands (&&)
>     7 	fish |
>     8 	cow 
>             ^
>     9
> 
> While this would be neat, I guess it would also be way more work than
> the current series you have posted. And whether that work is ultimately
> really worth it may be another question. Probably not.

I think that output is quite readable. One bonus is that it follows the
usual "quickfix" format, so there's editor support for jumping to the
problematic spot.

It probably is more verbose if you have multiple errors right next to
each other (since now we just show the annotated source text). But that
is going to be relatively rare compared to single mistakes, I'd think.

-Peff
