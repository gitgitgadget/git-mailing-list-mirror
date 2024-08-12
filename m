Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5655183CBA
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473434; cv=none; b=O1lU8Ipzq00hFYIhs/DuIArvP3/s9z1DO8LyA8B2LxVslcC4lBZeOaq7MSRvtZi3GK6LR/bgtrFg5XHzmlKkanCKH2foQ3nV21zLQ98NfPq6RlgqlSN6lP6LIqladUtknmgP3LMhWuzfIIyU0h/gyRFwHLw1J7aKHjZdjinVv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473434; c=relaxed/simple;
	bh=7D4O2sIto1+YddrO5XE/zkQV/lXR7MAubfCFPusRxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=All0wE004r5yM6AT6ujD0ekXpeGwJlGqi9XGO7lPkk0Z+AWCcL+cJOhbMMqgen74qz47WBV3B4/JW5q9HSSyqNe5rc2tn+fq5IMJ1onBCrxUKF9u2rKK3CgnC+OjawXv7TFxdJy9cYXoIcGsr8fSeNdieMDh6t7r4DhQ8Xy5jbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29439 invoked by uid 109); 12 Aug 2024 14:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Aug 2024 14:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30010 invoked by uid 111); 12 Aug 2024 14:37:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2024 10:37:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 Aug 2024 10:37:10 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <20240812143710.GA3800522@coredump.intra.peff.net>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2afa51f9ffedfa6dab51c9515f695ddfe0a9a4f9.1723121979.git.ps@pks.im>

On Thu, Aug 08, 2024 at 03:04:33PM +0200, Patrick Steinhardt wrote:

> When we have a `url.*.insteadOf` configuration, then we end up aliasing
> URLs when populating remotes. One place where this happens is in
> `alias_all_urls()`, where we loop through all remotes and then alias
> each of their URLs. The actual aliasing logic is then contained in
> `alias_url()`, which returns an allocated string that contains the new
> URL. This URL replaces the old URL that we have in the strvec that
> contanis all remote URLs.
> 
> We replace the remote URLs via `strvec_replace()`, which does not hand
> over ownership of the new string to the vector. Still, we didn't free
> the aliased URL and thus have a memory leak here. Fix it by freeing the
> aliased string.

Thanks, this one is my fault. When I replaced the open-coded replacement
in 8e804415fd (remote: use strvecs to store remote url/pushurl,
2024-06-14), for some reason I thought that strvec_replace() would take
ownership of the pointer. We could make a "_nodup()" variant, but it is
probably not worth the extra API complexity.

Curiously, these are the only calls for strvec_replace(). You added it
in 11ce77b5cc (strvec: add functions to replace and remove strings,
2024-05-27) but I don't see them used in any iteration of that patch
series. So yet another option is to change the semantics of
strvec_replace(), but I think that is an even worse idea. ;)

-Peff
