Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74A278E4A
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734886; cv=none; b=U/9cdS/JrBSFjGDxU0i5FqedvxgVmGASB5j5vtHAU7tD75sr1KMnxDQ57JXDQlrdZWxvIKFGBRqyGriyPwC49rsLN36LjMbmnd7kn5j8+Uhf1VyG75fuXzZdMNZaeF0U77IImqmI9TaWmCwfuq+ecJ12xeamraoYnC4rBfwLBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734886; c=relaxed/simple;
	bh=MHbQimAKdmDNUZF8xie2SAJXour5boXaiAS3pPdtx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjtRdwlT657XKT1GO370R2GNp4UkS32d0ohT7xVXKUX2+WUqQvU14MfgTggnIsvDSy29TzBT7pyTbn8b2MQXuCww1LvqeXiWtPtTnECk8YnWopPkCKDa5p5TWMX37wn6ieo0thSgdAiXxZhnggo5450ZEqA2rR4AbplCjTYZpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZrMDUAXK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZrMDUAXK"
Received: (qmail 29215 invoked by uid 109); 8 May 2025 20:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MHbQimAKdmDNUZF8xie2SAJXour5boXaiAS3pPdtx3E=; b=ZrMDUAXKd0pDXNJCUvzFuN+3ZYrKsOa34Zy47u/7TpTuNo8bJUHOXoLgZ1w6vQzZY3YtAs7aFJst7n4krqwRYL5BxONTsLid00CeL7OEgiiezbmoFxEd0hpBWHBFD6oJYZNq2oRts93wxZgcdU/rzFK5RZ/KVu5H08khNqEtWDn3stYgjb2FkrsIMwE/QaPkQ781fZ0T8XK66fLAveFvX6CNt4dimYmrSW6qqiUcXx3rr2ePaXtZhhxV39TIMMpDiPFq0YETPR46kPUIYqY4VG0OZRTWHVb/LjrbroxWA6lc36lsxG9A24/oephmoo9E/1RsmxCN7cpkhwgALyvUnw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 20:08:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20103 invoked by uid 111); 8 May 2025 20:08:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 16:08:05 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 16:08:02 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/4] align the behavior when opening "packed-refs"
Message-ID: <20250508200802.GC18229@coredump.intra.peff.net>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBtzn4nwLsI9p5Cp@ArchLinux>
 <xmqqv7qc9grt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7qc9grt.fsf@gitster.g>

On Wed, May 07, 2025 at 03:51:02PM -0700, Junio C Hamano wrote:

> shejialuo <shejialuo@gmail.com> writes:
> 
> > Hi All:
> >
> > As discussed in [1], we need to use mmap mechanism to open large
> > "packed_refs" file to save the memory usage. This patch mainly does the
> > following things:
> >
> > 1: Fix an issue that we would report an error when the "packed-refs"
> > file is empty, which does not align with the runtime behavior.
> > 2-4: Extract some logic from the existing code and then use these
> > created helper functions to let fsck code to use mmap necessarily
> >
> > [1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net
> >
> > Really thank Peff and Patrick to suggest me to do above change.
> 
> This round looks good to me.  Others?

I left a few comments that I think bear addressing (or at least some
discussion).

-Peff
