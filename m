Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95096299929
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931815; cv=none; b=ToNxHwydn8NNncygOfh7RID8BEpy8FtGQJB+9+6TMaZV7sGnrEYe2UrnQZazhYuYmGUOg1+IMFxAsNcBmBFeSl2jovBkBBX4FT7oAcL36k8/VN+Vxypi0XFtnC/rv/Od+RNZMr0zIExhMXxfr4ip5SqPDqZ+/wenid5Rhik5fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931815; c=relaxed/simple;
	bh=syIaJSPuMo6C7XriLvxcM7K0+8S33qS7qjDVBC04wWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TezTjJgKMJvFEVkSsVgCVbWYQWFzgbMp42x+M472VHZdXg0SNKkmDeskWa6yUzst/s4GctudTc2Ze/Y6XO8RdNO4mzwFmMKHRDVbrtOfVSjjt/c8wJT5/mK4pELQ/UZ0wxIr933cdgZsG7Pd0Yl0SjZGHxgm5Ff7UIgtw98m6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d43VzwnQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d43VzwnQ"
Received: (qmail 494955 invoked by uid 109); 12 Nov 2025 07:16:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=syIaJSPuMo6C7XriLvxcM7K0+8S33qS7qjDVBC04wWY=; b=d43VzwnQn0qDgLgcibBxfHf2HpgqavoCcl2KXVSMlpaaEtO7X38Vj8i0r0+xkNf94k3qqAbrLo0mNolFqqfE+F3GVBNKrlyLmjqm2BxfdOsCXXRxNq8PfOxAf8YsEhpmx7uZgv+AxBnzU/5oUDdhzsWjc1e5gxSMoqi9Z6w3NvFBOI1ZiEBFbwLN8MAeYjRDRUDVmRC30gMNlxdC+DIx3lvrgPFcEfAw7ZeUjhkDsjQiM4Q9Q5y/qzoluluutiL5rccN0oPmRW6eoPeeGcMWxoSplzMj6ghWDn/T+sjyD69V4BG7vF1chHLLE0VEUG64LjV0DRT9/ANtJVfI8gCM4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 07:16:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 785870 invoked by uid 111); 12 Nov 2025 07:16:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 02:16:52 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 02:16:51 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <20251112071651.GB431661@coredump.intra.peff.net>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
 <aRQvyvMq61syGT7_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRQvyvMq61syGT7_@pks.im>

On Wed, Nov 12, 2025 at 07:57:14AM +0100, Patrick Steinhardt wrote:

> So personally I would've probably leaned into the direction of enforcing
> a hard limit. I don't see a reason why anybody would need more than a
> couple of recursions, it culls both compute and memory growth, and it
> allows us to have a proper error message in case the limit is busted.
> Furthermore, we can demonstrate right now that it wasn't possible to
> have unlimited recursion anyway, which makes it easier to put a new
> limit into place.
> 
> But following my above reasoning I think it's okay to turn this into
> iteration, as well, though, but I'd like to hear whether my train of
> thought matches yours.

Yeah, it does match mine. If I wanted to waste a bunch of CPU and memory
on a hosting site, there are a lot easier ways to do that than with
really long gitattributes.

I'm not at all opposed to putting in a hard limit on top. My general
feeling is that it never hurts to convert recursion to iteration; it
only gives us more options. I'm not planning to work on a hard limit
myself, but if you want to, be my guest. :)

I think if we do (or even if we don't), it may also be reasonable to
shrink the max attribute file size to 10MB or even smaller.

-Peff
