Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51757C9F
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722820466; cv=none; b=a+olycARKheVKMK85KulMyBkSuvy/sgkxM5nM46PvjZeNy3AEuX9iMTha5bPqtnFmnajMTukRZOulx2GVqQGNxNOoEzUZUahqg7vLeva/tUYPX64ita1RcCxVDk7Im/T4K1zgKd9PA9IFndPlx3Q9Csg6EjO3kqIy6edxT+wMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722820466; c=relaxed/simple;
	bh=F3XwV37D0hRI3vC1t0Ll5aO5F9qVUHHuIt2kUIJChzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqmBWa/J15PepkA9tNa6fr/bLIA6LwwnoW2PbFF73/1CPtuHQnBJYZh9OhahPbV+LvIDZTzKitUUWZoMOvirEtZT7mcXCIRjFLY32hvQakB2mvO4ggb3sx2QrA1kPEuR86E1MCkXVirBzIainkBprQA2Kb5cZURkk+qfwD8oKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23110 invoked by uid 109); 5 Aug 2024 01:14:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Aug 2024 01:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6473 invoked by uid 111); 5 Aug 2024 01:14:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Aug 2024 21:14:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 4 Aug 2024 21:14:23 -0400
From: Jeff King <peff@peff.net>
To: the.tester@mac.com
Cc: git@vger.kernel.org
Subject: Re: Date and time processing issue
Message-ID: <20240805011423.GA68394@coredump.intra.peff.net>
References: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com>

On Fri, Aug 02, 2024 at 11:46:30AM +0200, the.tester@mac.com wrote:

> To me, the error message is at least misleading. 
> It also seem to be hidin the underlying issue that git (commit)
> doesn’t accept time stamps before the epoch.
> 
> Given that 1970-01-01 00:00:00 seems to be the lower boundary, I
> expected some time in 2038-01-19 to be the corresponding upper
> boundary.

We use an unsigned value (hence the lower bound being at the epoch), so
in a 32-bit world the high boundary would be 2106. But we actually use
uintmax_t these days, so it's effectively infinite (even no 32-bit
systems, there should be _some_ larger type available). But...

> However the same error message is given when the date is >= 2100-01-01
> 00:00:00.

...the sloppy tm_to_time_t() code does not handle conversions past 2100
due to the leap year skip there. There's more discussion in:

  https://lore.kernel.org/git/20240604093345.GA1279521@coredump.intra.peff.net/

That message mentions patches to handle negative timestamps completely.
You can see them here:

  https://github.com/peff/git/jk/time-negative-wip

It works fine on Linux, but IIRC I got stuck on the system time-handling
functions of Windows being unhappy. Probably solvable by implementing
more custom code.

If you're interested in trying to push it over the finish line, I'd be
happy to discuss it.

Although...

> I’d also expect that correctly formatted time stamps containing valid
> date & time information should be processed correctly.  (at least for
> dates after Friday 15 October 1582 (as the day before was Thursday 4
> October 1582)

I'm not sure how my implementation would handle this. The tm_to_time_t()
fallback doesn't know anything about historical calendar shifts, and
going in the reverse direction would depend on your system gmtime(). So
probably:

 - if you feed a correct epoch timestamp for October 4th (e.g., "git
   commit --date=@-") you may or may not get the right result. Certainly
   on Windows if we have to use fallback code you wouldn't. But even GNU
   date doesn't seem to handle this:

     $ date --date=@-12219361438
     Thu Oct 14 00:00:00 LMT 1582

 - we'd always use custom code for going the other way. So:

     git commit --date=1582-10-04

   would give you an epoch 11 days before the 15th, not 1 day.

Even still, IMHO handling negative timestamps at all would be a huge
improvement over the status quo. And we should be correct down to the
second for "recent" stuff (like say, code written in the 1960's).

-Peff
