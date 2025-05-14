Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDF194A44
	for <git@vger.kernel.org>; Wed, 14 May 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245588; cv=none; b=oC375+ElEw9WDEsOxyO7CZYmA4FTsszbNkMvUGxZ02Tp78FFqD+Ohn+ZzdcVyJc4FzjOwqxtPchLXoN8lJwAeOFT1NAug4U724L+9LRqQ5xTf/GWOos2lDZLCdHeSMkmKnzJh/LgUOqEasU6YXYk5V403ZzhMDio/S0riwyRhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245588; c=relaxed/simple;
	bh=4PysUAoAnmRFsY+GIt7ZmLseGwGWblH1GkpUchYXEx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH+sWMyDHFEgN0Xr7StPbLw52CkwM6GNm6QTyDTpUclpuG2owFVMoFrUil4q1S/ZklFl/MMU3JJ6N+hmDikqE4wo+mYrhjAjeDXmPsYRbuW9uFn7WqVyOTJ/yXx8nGEuIZJ5KGdyUzp+XblS3pV/mZ9tM67SBIwVZtsPPQ6Q3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dOboGYYU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dOboGYYU"
Received: (qmail 22785 invoked by uid 109); 14 May 2025 17:59:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4PysUAoAnmRFsY+GIt7ZmLseGwGWblH1GkpUchYXEx0=; b=dOboGYYUO3mPGVsYBAJtZTRoOG+9JZB5FcRhn/Rc0+OcZAIBanJFL25LW3xbaiXC9j1pCBR9e5+l2BQdk1D3RtmXo6AlVRAS+U9+ngGerD6JBAgff21aMvH/20zzPeHx+FlgqO5lxlMjyGw7+VEluLXpiVuy+64HW3ttZ69/zhMGYGermWYL4XbRrUEc2tE3jhaDz0Th1XS0Ol5iTXBno18CiaC6WYcgUZkdUUTdIs1FvHAvPyHCxfI1vbm2+jRDOe8FJLCihAIVOfGjGDNwxpixme+Upt32K+LX+mert3jHzR9C/9ZMawsT0WyULRoAEqUTLJNdo2vzpC6iaqcljA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 May 2025 17:59:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12528 invoked by uid 111); 14 May 2025 17:59:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 May 2025 13:59:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 May 2025 13:59:36 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] oidmap: add size function
Message-ID: <20250514175936.GA2196784@coredump.intra.peff.net>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
 <20250512185130.GB1276214@coredump.intra.peff.net>
 <aCMVdEg8d6BHo7AA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCMVdEg8d6BHo7AA@pks.im>

On Tue, May 13, 2025 at 11:48:36AM +0200, Patrick Steinhardt wrote:

> On Mon, May 12, 2025 at 02:51:30PM -0400, Jeff King wrote:
> > Callers which want to know how many items are in an oidmap have to look
> > at the underlying hashmap struct, leaking an implementation detail.
> > Let's provide a type-appropriate wrapper and use it.
> > 
> > Note in the call from lookup_replace_object(), the caller was actually
> > looking at the hashmap's tablesize parameter (the allocated size of the
> > table) rather than hashmap_get_size(), the number of items in the table.
> > This probably should have been checking the number of items all along,
> > but the two are functionally equivalent here since we only add to the
> > map and never remove anything. Thus if there was any allocation, it was
> > because there is at least one item.
> 
> I was a bit puzzled by this explanation initially. The two sizes aren't
> functioally equivalent -- the table size will typically be larger than
> the number of contained entries. But the thing is that we don't care for
> the actual size, we only care whether the map is empty or not. And for
> that those are indeed equivalent in this specific case.

Yep, exactly. Probably replacing "looking at X" with "checking whether X
is empty" would have been more clear. I of course was looking at the
diff while writing this, so took it for granted. ;)

I don't think it's worth a re-roll, though, especially since this is in
next already. Thanks for the review.

-Peff
