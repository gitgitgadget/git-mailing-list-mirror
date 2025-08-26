Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1F33EAF2
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207196; cv=none; b=mdWekVUYb7YARHRX+sQ7DWobabDAxpg+XPe3UfMwUB8LzlBdTxJ/l2IikZGJoEVBDZa0/7Z9N8oEzx5nIYEXwpX9PmKI5PCZ5SwNFc8UXXE5ssz4bUyksbv7RvgY0gTwwNGKbqc+XDa9kGydgfbSHUKf7aJbRZNVOExJEhtjB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207196; c=relaxed/simple;
	bh=ZumM1uihNBDIv12UrXasX0qLZcNAv6thuDrW4KrQPrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZG8IOK5Tmd7gpsZg/MZhsndRU1Rw13UQAJvpvAdOhQ+JgtRxHMgartsOf/7cbmjYDru8P2rs+9kXuhbDpGo7ypDv/CHl1N7UiY3kCxysH08gmX8emGd/8isFzFoR3hxHZpzjRw6VX18HIGup7Wft8MB5AyviaXam/J8vwWkhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YabRB2wl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YabRB2wl"
Received: (qmail 116753 invoked by uid 109); 26 Aug 2025 11:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZumM1uihNBDIv12UrXasX0qLZcNAv6thuDrW4KrQPrg=; b=YabRB2wlx995EJ3kPlatsD7PhZAN6J9k/OK9tBfnEp/BocYeefhWKTeqQNxYY5ivVVKhjgx7T5iMLSDEytufTQUGrvcVUpj4kezP7ApgcwHftzzTsxm/t56SS4fvzcZT8ceeOR/9fedgneJQth2axrlmKkXUWeqePS+x2hlvxdtyTf0eRQG2qEW3IQM5EspShOw7KY4VLMHXFwCHEPDhgw6zcXbj9pXY107rbcIUvZTAPmxL74MnI0Nad3L5fsKfpMg3EacaeDpcR7bOEj00Zzf4pXfhZaqvV3en+4WcnA3QNzP8aGzTzSZ8wqHOm3hpDYcfFNHtLZgq0OMrPYqR5A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 11:19:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 172473 invoked by uid 111); 26 Aug 2025 11:19:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Aug 2025 07:19:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 26 Aug 2025 07:19:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Joe Drew <joe.drew@indexexchange.com>,
	Dave Evans <dave.evans55@googlemail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <20250826111952.GA1926324@coredump.intra.peff.net>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820213323.GA1667633@coredump.intra.peff.net>

On Wed, Aug 20, 2025 at 05:33:23PM -0400, Jeff King wrote:

> If so, and assuming you're on a case-insensitive filesystem, then the
> lock files would collide. You wouldn't see anything after the fact
> because git-fetch itself would create the colliding lockfile, and then
> clean it up after hitting the fatal error.
> 
> If that is the case, you can try using the reftables backend in v2.51.0.
> It doesn't use the filesystem for its ref storage or locking. Something
> like:
> 
>   git init --bare --ref-format=reftable

The response below came to me off-list. Here it is quoted with my reply:

On Sun, Aug 24, 2025 at 05:03:20PM +0100, Dave Evans wrote:

> I'm sorry but I do not have an email client I could use to post to the
> git mailing list.
> Please could you post my thoughts on this to the list.
>
> https://lore.kernel.org/git/20250820213323.GA1667633@coredump.intra.peff.net/
>
> I use git 2.51.0 built using Macports on a very old version of macOS
>
> There are a couple of repos on github that were showing this problem:
> vectorgraphics/asymptote
> ghc/ghc
>
> Both of them were bare clones.
>
> I applied  --ref-format=reftable to the vectorgraphics/asymptote repo
> and a fetch
> went through to the end successfully
>
> The only snag I can see is that cgit no longer works. It says :
> Failed to open github/vectorgraphics/asymptote: No such file or directory
>
> The version of cgit is about 5 years old

I think that's all expected. Unlike most systems which call Git commands
like for-each-ref, etc, to access the ref store, cgit is linked directly
against Git's C code (something we don't support, but the cgit authors
accepted as a risk). So an old version of cgit will link against an old
version of Git, and won't know about reftable at all.

It _might_ not even be able to detect the directory as a git repo,
though I thought the reftable format was designed to let even old
versions of Git see the repo (e.g., the dummy value in HEAD).

-Peff
