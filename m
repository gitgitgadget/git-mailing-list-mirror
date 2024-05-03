Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5B158210
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758956; cv=none; b=pZNcRXuHpn65Nuacs/tt8yC8dCw9zuGB1AkwQlZv72sxBgGUf5fasoXbMt7c/6X0jnwluboVK+v9Vqd0AcCO5y1RE+b0kRUZ68xgRPVTILYRV7dMid28YO9l3jOuEIO++5emyEiY9cfVfW09x/dYUzgzA64TnJm7jIi9Zn9dHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758956; c=relaxed/simple;
	bh=5z3evamDKnfYDUjoun4NFH3NXy3s60eDLDxhW/fuQmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW7qhPBOXHknpYTBidJBtP+hgyQ3QD6QDVwUvU/1TiuaI1pEX4mPVKO2dwUWUAMnq7ohif9Vm0WbgMFHOz7Mt3AiCh0RPwOiDEB2JuA9k85UD4G3TUFX+5NiqOU6Im29YVS+a8JbUa2+iosiGxFdnZxDz8ijXVgnsMLSw8pSug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11874 invoked by uid 109); 3 May 2024 17:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 17:55:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17642 invoked by uid 111); 3 May 2024 17:55:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 13:55:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 13:55:53 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: check refnames as fully qualified when
 resolving
Message-ID: <20240503175553.GG3631237@coredump.intra.peff.net>
References: <20240429083533.GG233423@coredump.intra.peff.net>
 <ZjB5dPoEoq8D6qzJ@tanuki>
 <20240430104152.GF1279403@coredump.intra.peff.net>
 <ZjDVLAKA0_4pTAS7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjDVLAKA0_4pTAS7@tanuki>

On Tue, Apr 30, 2024 at 01:25:32PM +0200, Patrick Steinhardt wrote:

> > So this is where I will show my ignorance of reftables. I assume it
> > still has to implement FETCH_HEAD as a file (since it holds extra data).
> > But does it do the same for other names outside of "refs/"? I am
> > assuming not in the paragraph below.
> 
> No, that's why we originally introduced the "special refs" syntax, as
> defined in gitglossary(7). There are only two files that behave like
> refs, but circumvent the ref backend: FETCH_HEAD and MERGE_HEAD. Both of
> these have special syntax and carry additional metadata, and as such
> they cannot be stored generically in a ref backend.
> 
> All other root refs are stored via the ref backend.

OK, that matches what I guessed based on the existence of special refs. ;)
Thanks for confirming.

Part of me does wonder if things would be simpler if ref backends only
handled refs/*, and pseudo/special/root refs remained as their own thing
in the filesystem. They're a limited set, so we don't really care about
scaling in the same way. And their point is to be somewhat ephemeral, so
even if you wanted to be clever with a replicated database-backed refs
store, you probably don't care if CHERRY_PICK_HEAD goes away.

And it's not clear to me what the path forward is for scripts which poke
at .git/* to determine repo state. For example, I think git-prompt.sh
looks at CHERRY_PICK_HEAD and REVERT_HEAD to decide what we're doing.
Maybe we just roll all of that into a command which returns all details
of the repo state?

> > So I think dropping REFFILES it would still pass, but we are not really
> > testing anything that interesting for reftables. That said, I would be
> > OK dropping the REFFILES in the name of simplicity and just documenting
> > it in the commit message.
> 
> Yeah, I'd prefer to drop it. We should only specify the REFFILES prereq
> as sparingly as possible to ensure that behaviour is as consistent as
> possible across the implementations.

Makes sense. I'll change that for my next re-roll (which probably won't
be until next week, as I'll be offline for a bit).

-Peff
