Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3F539A
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942606; cv=none; b=cylFclcyAsUSc2xYtZkRmPp36OeR6ws/FmRKyksSB+d4/p2MYip3Ml0FzfctloAi6t3ULdwjoLgUhN2AAkpy6lKl7rOuR0BcI9UinsbQ3sSbnVP4l1Dh9U7jkGCNNI9fk1nUtwFGuPtX09/QUSls9cysJj+nmpCF1/Z2Mg4V9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942606; c=relaxed/simple;
	bh=kS88JvzmT2x8A82FrdW0TysAU3+w5uUIQxHUd8JIm+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUROcu7fexhltp0GYYMwD4Zs/JCfz07s7K1Q6pF8L/HfyMZqDyNpXWGjyZGIxIP6f5tSCxd0SdNRj8fc22TP9IanohQKXq3731sLcgk3ARFlFUWRESVataSMFL6OEVjXZe+zSSPx3Oth/6l6yn6oHnNTqpkpN0U8KwMWgHMv7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13770 invoked by uid 109); 1 Apr 2024 03:36:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Apr 2024 03:36:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14752 invoked by uid 111); 1 Apr 2024 03:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 31 Mar 2024 23:36:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 31 Mar 2024 23:36:42 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Message-ID: <20240401033642.GB2639525@coredump.intra.peff.net>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>

On Sun, Mar 31, 2024 at 08:53:07PM +0200, René Scharfe wrote:

> If len is INT_MAX in mem_pool_strvfmt(), then len + 1 overflows.
> Casting it to size_t would prevent that.  Use st_add() to go a step
> further and make the addition *obviously* safe.  The compiler can
> optimize the check away on platforms where SIZE_MAX > INT_MAX, i.e.
> basically everywhere.

Yeah, I think this is a good thing to do. I was confused at first why we
had an "int" at all, but it's the usual crappy snprintf interface.

Which, by the way...

> @@ -123,13 +124,14 @@ static char *mem_pool_strvfmt(struct mem_pool *pool, const char *fmt,
>  	if (len < 0)
>  		BUG("your vsnprintf is broken (returned %d)", len);

Not new in your patch, and I know this is copied from the strbuf code,
but I think a BUG() is probably the wrong thing. We added it long ago to
let us know about broken vsnprintf() implementations, but we'd have
flushed those out by now, as nothing in Git would work on such a
platform.

And meanwhile there are legitimate reasons for a non-broken vsnprintf()
to return -1: namely that it is the only useful thing they can do when
the requested string is larger than INT_MAX (e.g., "%s" on a string that
is over 2GB). This is sort of academic, of course. There's no useful
error to return here, and anybody who manages to shove 2GB into a place
where we expect a short string fully deserves to have their program
abort.

I don't have a good example of where you can trigger this (it used to be
easy with long attribute names, but these days we refuse to parse them).
But in general probably calling die() is more appropriate.

There's a similar call in vreportf() that tries to keep going, but it
ends up with lousy results. E.g., try:

  perl -le 'print "create refs/heads/", "a"x2147483648, "HEAD"' |
  git update-ref --stdin

which results in just "fatal: ", since formatting the error string
fails. Perhaps we should just print the unexpanded format string
("invalid ref format: %s" in this case). It's not great, but it's better
than nothing.

I guess I diverged quite far from reviewing your patch. ;) It obviously
looks fine, but the snprintf() int return value got me off on a tangent.

-Peff
