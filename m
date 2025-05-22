Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D632AE7F
	for <git@vger.kernel.org>; Thu, 22 May 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893010; cv=none; b=Y5mgm10Lol+8Lsax5veWLQn8NSCOup9Wf65r8vMQOlyY95342upyZNd36GrsTbN6eXLhUh85zMgnykbI/BidCeqxpZAQIFy4WCoqhgTJ2g/Xo+0H76sKuBgdmFCMDQrZzG9kRgdcsXxszrX9CW9s3zBUugQt/fhSoEhBYbFR2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893010; c=relaxed/simple;
	bh=6nC1BVVix+YHKO3DO9rlvdkfARSNtSku6YmvPsWy4tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq2gDh1EeAJCf4VypvJ4Li88kKVt5cjYZUbo8ULY/e96rS/fZC62cR5mB6UAmuPgfTXQk66O1cJJDYap7kla7c0j7UuCv04YO618sYy5etpPBwJt1dVNHE3lk2RArNY9FqivsYFXohtInnDwPzjUjnFaOZss3dmWjMjy8Jqfag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cbxgj9q1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cbxgj9q1"
Received: (qmail 31402 invoked by uid 109); 22 May 2025 05:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6nC1BVVix+YHKO3DO9rlvdkfARSNtSku6YmvPsWy4tc=; b=cbxgj9q1lIV/JU/yLXU8f/Ua9VhGEitCnJvdUXwR18ZxqOwoeQK9tbV0oD+prD2XgRsH7M4MJiWuaCdSegGZKAghXHMKqYRj/tqFHXtzZCWcc5Tf0Q+xALAMUTIdKxNzdynOYPFcjTGpvC6VOntmb17W9CInnCjA2xAcGM7KFz+7NFjCN3ihYwe/omAfwK+i2wdGHQizeMPvqbY1aDwussdwzwoHfRe8jk6teJ8WDYaP78eYC4dT8w992LV1p1ilzuZc6+56pnqwdBVPtN6E6UoWKT5Yulapb6rIiIKdNrc4672yslIQsmLS/psJNuRFjJBCrnnC7i1yzwhnYv3SIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 05:50:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12462 invoked by uid 111); 22 May 2025 05:50:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 01:50:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 01:50:06 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/3] align the behavior when opening "packed-refs"
Message-ID: <20250522055006.GA1135327@coredump.intra.peff.net>
References: <aCMnrwkoJ2WyqGZT@ArchLinux>
 <aCS7O8tNekg_u9Wp@ArchLinux>
 <xmqq7c2aapte.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c2aapte.fsf@gitster.g>

On Wed, May 21, 2025 at 09:31:09AM -0700, Junio C Hamano wrote:

> > Change in v5:
> >
> > 1. Improve the commit message in the first patch to be more clear:
> >     1. Talk about the current behavior, what error we would report if
> >        "packed-refs" is empty.
> >     2. To align with the runtime behavior, we should skip checking the
> >        content of "packed-refs".
> >     3. Why do we need to report to the user when the "packed-refs" is
> >        empty
> > 2. Fix grammar issue in the last patch.
> 
> The thread has gone quiet on this topic.  Is everybody happy with
> this version?

Yep, it looks good to me. Thanks.

-Peff
