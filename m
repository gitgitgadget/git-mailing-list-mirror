Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4337DE89
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566860; cv=none; b=NcRv3HKsxHwhHkrkoeSgYDJ7yxWEh4rkIWKeRHQ4wxso4bX3LmbtdhEmYHKujNhw6+KBGTWgA0+mYwvwKsMQkILqcZIHTOGs8toDRMI57SvkWsc1zaOj2UkVKQil77Ja7wPE91EmYRFc2dO0bR08HONFj1X8Srly4gJWCXX5igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566860; c=relaxed/simple;
	bh=VJU9OgjZdke890r37DU3AJpMrc0XenbGEMax/8+ER/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=La8ufpqxr/5Vu4EZ76r8POFTVDl8VAcbzRi2JvAgnfUgdcIWarZP+S+vHfGA3Ea/3IAC30EDAQirDdmsqBhWhMx63jcUCdeHKGIFgktsyYdEk9zZvtpaob9e2n+s1hsfDlnrixJtpOPf2Lh3/uK1eYH53z7TpZhd7oD4YxNnFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sxu7xIg6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sxu7xIg6"
Received: (qmail 158271 invoked by uid 106); 26 Mar 2026 23:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VJU9OgjZdke890r37DU3AJpMrc0XenbGEMax/8+ER/U=; b=Sxu7xIg6sRblPcPlO6YQpTpRmdW6uwQMUhvkNKbBq/OJke+H5Vlt4QYlWYMLxREuwmYZK0DXWxU1m86UfpCOMHE2Jo0VUmrSoXk4NLDeGDtfTaGcPpdLY1N+/+T9B09am97p1XveC1mLHKCkW3c+VoTEliwGmIyt2FQfJMilyS5E5abRf7IuqjjubXeMK1iV+Xp6lXC2vYz70d4i2S8sXG+yPVMNJbHOozFYJDKqpUudRW9O4p1gSZGTme6n4mEm6RbworXdGHu+a1ilEy0gPZTjLT80EbklJ73pd8GRluQGu2iI5KLMoHloCv3NPk9XFgMvE8YFP8Qu9Fd+ntGMAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 23:14:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 221090 invoked by uid 111); 26 Mar 2026 23:14:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 19:14:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 19:14:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] revision: make handle_dotdot() interface less
 confusing
Message-ID: <20260326231415.GA420281@coredump.intra.peff.net>
References: <20260326190243.GA412983@coredump.intra.peff.net>
 <20260326190444.GA415796@coredump.intra.peff.net>
 <xmqqikaipf00.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikaipf00.fsf@gitster.g>

On Thu, Mar 26, 2026 at 12:28:15PM -0700, Junio C Hamano wrote:

> > There are two very subtle bits to the way we parse ".." (and "...")
> > range operators:
> >
> >  1. In handle_dotdot_1(), we assume that the incoming arguments "dotdot"
> >     and "arg" are part of the same string, with the first digit of the
> 
> "digit" -> "dot".

Oops, yeah.

> OK.  I was hoping if we can do without a temporary allocation, but
> the const-string "..HEAD" example does make it clear that it is not
> something we can achieve easily.
> 
> And once we accept that it is inevitable to make a copy, everything
> else falls into the right place.

Yeah, I don't think there is another good option. We can drop the
"const" from the interface, which would be more honest, but then callers
that use string literals have to either make their own copy, or cast
away the constness and pray.

The only "right" solution that avoids copying is if all of the
lower-level functions learned to work with ptr/len pairs instead of
NUL-terminated strings. But having done that sort of conversion before,
it ends up quite messy and is prone to errors. Somebody is welcome to
try tackling that if they want, but I don't. :)

-Peff
