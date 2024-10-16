Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139954F95
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091366; cv=none; b=A3W3R8dGkqNIlOTsJCn1g4DqiVz1gY5QG0k2Bl64JKXBp8fNBGIlhQMtfgTsxILUMFOPaJ8niAcSiyGz31JvbX6LrAwIKDrcIsT/7rm7DIBGx6jFS25I3cQMRuiWWHQd6dVzP9HHH0K6Fe1rY3Glnnx8QSCj58u0QIv8LfqXrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091366; c=relaxed/simple;
	bh=Ii3u7f9TiWB9mj6WeyQNOln8KH0gjDj1zs7tC0sqe3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEF1xlawDIaknVAYkKVEMvEeJmj8TRNOQo7U8KwvvkCqyAnmDtu2u1OfVwmrRRaxbZhyRYMNuVBtPcxrEREOHJZp7/B/CakFGTWhAYsNV1WJbDOeiGC5v5cFyXigGeLJKjrYdzailEdXv5czkwWm76ymNcRofFpTNgiObTzriB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZhJX8CTE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZhJX8CTE"
Received: (qmail 20684 invoked by uid 109); 16 Oct 2024 15:09:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ii3u7f9TiWB9mj6WeyQNOln8KH0gjDj1zs7tC0sqe3w=; b=ZhJX8CTEkcnBvl6fizWS1DAsQLeGS5CB3UR0Rf9PsZwHtD18906QBOZZZapf1Qo5OukwGNErTTJrDHfFMT6ckK18IstdbGdf46WdJKfgmMcIVALxYYyvIhMuiJjqzk4W8qjkimKlnBFG2DIRMUz+nO6rhOermVW+RxcRgyFb1R0wgkynmpKwD7CIjwvUCs3LV8r71SY4XQPJzNtF8hI309hYMNephd07ct0Cw91xsh2h8WjTls6TzNtiAiPgf4sntvo2jXh2B0PGptmFKeSmelajsErnCGcxY1+4VKcBkRWXOjOr1iwH0VtYAwco6wPAzDfnawMcnX4r3+DwdFSQeg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Oct 2024 15:09:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19928 invoked by uid 111); 16 Oct 2024 15:09:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2024 11:09:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Oct 2024 11:09:22 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <20241016150922.GA1848210@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <20241016145539.GA703747@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016145539.GA703747@coredump.intra.peff.net>

On Wed, Oct 16, 2024 at 10:55:40AM -0400, Jeff King wrote:

> > The logic is broken on Cygwin though: when a client asks the daemon to
> > exit, they won't see the EOF and will instead get an error message:
> > 
> >   fatal: read error from cache daemon: Software caused connection abort
> > 
> > This issue is known in Cygwin, see for example [1], but the exact root
> > cause is not known.
> > [...]
> > [1]: https://github.com/cygporter/git/issues/51
> 
> I don't see any details at that issue, but I'm not sure how it would fix
> things. From the client's perspective, they are going to see the
> descriptor either way. Unless there is some magic that fclose() does
> that a normal descriptor-close-on-exit does not do.
> 
> That "Software caused connection abort" thing seems like a weird
> not-standard-Unix errno value. Searching for it mostly yields people
> complaining about getting it from ssh under cygwin. :)
> 
> If the magic that cygwin needs is actually "fclose before unlink", then
> that is in opposition to other platforms (and I suspect would make t0301
> racy there).

This all seemed eerily familiar. Try this thread:

  https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/

It looks like the conclusion was that we should adjust errno handling on
the client side, but nobody ever followed up with an actual patch.

-Peff
