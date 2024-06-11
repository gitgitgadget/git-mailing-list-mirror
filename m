Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533617333C
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093858; cv=none; b=ojF555H+Wc4tRXDxAXXFb89CVDlgAjsbTOfQq6BTPA4aL8i1hx5mcUmfVO7x0+JYavQgvMr3xVud9gfOtJR4vRO9X/xe4qsKcqKBD6PDUWKt4rGJpRJ6p0XrGclSkl+oqOuMzu30lHttx2IsVJwRXnlQOfYNR5UNXQ2OXDRfaiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093858; c=relaxed/simple;
	bh=Us4Kq1ncZ43S2OHkShgUf2mNjAndKLRemOR+SebIP/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUofIE1/jUI3ZL7s9SDX1e8WznhvqHhPX8Bwqk3aQ6oFetsTwWIQEhCh+R66xHPzAV1dnPCbA1e+l4m7Td2YSuiyRJo4IqkrKdpSCyiaJhho919bs4lV8KuI9HAdXmSFDT0pVIx4nD5yUpl+6toNIVzB565ncAQqBxE7AMJBJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18542 invoked by uid 109); 11 Jun 2024 08:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 08:17:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24682 invoked by uid 111); 11 Jun 2024 08:17:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 04:17:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 04:17:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] varargs functions with __attributes__(())
Message-ID: <20240611081735.GI3248245@coredump.intra.peff.net>
References: <20240608183747.2084294-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240608183747.2084294-1-gitster@pobox.com>

On Sat, Jun 08, 2024 at 11:37:43AM -0700, Junio C Hamano wrote:

> There are several varargs functions that take either NULL-terminated
> list of parameters, or printf-like format followed by list of
> parameters, that are not declared as such with __attributes__(()).
> 
> Adding such a missing attribute to trace2_region_enter_printf()
> revealed that an existing call to it was trying to format a value of
> type size_t using "%d", which is not such an excellent idea.  Other
> functions that were lacking attributes fortunately did not have any
> broken existing callers.

Great, I am happy to see these. I assume you found them all by grepping?

I wonder if there is a way to convince the compiler (or coccinelle) to
complain about any varargs function that does not have one of our
usual annotations. It's possible to have other conventions (e.g., an
"int" up front specifying the number of entries) but in practice I doubt
we would ever use one.

Still, I suspect the answer is probably "no", there is not an easy way
to do it.

-Peff
