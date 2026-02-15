Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E422CBD9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146678; cv=none; b=QhDQnC5duRyRwfxQcB6mt4BHEm5vbPBUYclwtgukZakh8jsEPoB0CNb/DDwhgOSRiaRb82GkS6ufRoW3PqwAsYfeyxHj0CwkRu3NKlcvxg03iTc6jLdF2vAY77uk3G0ofiFW9a3ZgE6WshCaI3MgOvZgg/FHqtGvGpt0KGdySBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146678; c=relaxed/simple;
	bh=igkURYOLTHDRm+yr5tagigM9KmvrfL+cL9dGdgq80WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCAAHivBcMxQbsGG8umEHpbIQoj8Ex5+AL83VIIizV6RUwIFrBUQNUQZV0MihE5RyHOcMsg2HcvcrUEIVGcts6C+OIzDt2SrbFfgQbEYk1V377HzQsWpCuPQTEBJ+I94KbC+ejVsXH6SPCx0wLqvt7vfeOu+biRRueEP0SHIvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HbfaEQ+b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HbfaEQ+b"
Received: (qmail 44785 invoked by uid 109); 15 Feb 2026 09:11:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=igkURYOLTHDRm+yr5tagigM9KmvrfL+cL9dGdgq80WA=; b=HbfaEQ+bgKbcoOCSF1ySZaI3rqOHsNjHPQcT9Crm+BThfw3Xe+hnAwibyIemKQT3S5aE7P4dOZWjvTcxAlN8MRh+DctreK7+KO5KsDp3kFObJTjxeC8sdJ0iLijnEpIg3byls3BPtM14G0rLzoMDXC7T/cv/u8Eg9n1d9hKo4AnpIn6ZC7+Do/YBhv+z+EYyLy3igkF9jzQmqH7ARHIpGcjzMefmcYqGzykUxcw2L2CW3uVNtdhrIOWXC7rbKay527vcAkmI4I2aMMHj54cCjE20S0d0Jr1cR8tFrALxu12V7ifd9JmRXD9B39AdQ5cgrnIgq7BRzMBP84NZSFB7Ig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:11:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113339 invoked by uid 111); 15 Feb 2026 09:11:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:11:21 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:11:16 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] cleaning up ref-filter lstrip/rstrip code
Message-ID: <20260215091116.GA695914@coredump.intra.peff.net>
References: <c752a4a6c750bc485804b43d7b525754e39e5fe0.1771046151.git.collin.funk1@gmail.com>
 <20260215085755.GA86262@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260215085755.GA86262@coredump.intra.peff.net>

On Sun, Feb 15, 2026 at 03:57:55AM -0500, Jeff King wrote:

> > That is a bit of a seperate topic than fixing the warning, though, so
> > I left them as-is.
> 
> It is a separate topic, but I feel like this is a good opportunity to
> make this code less horrible. That is, there are some obvious
> low-hanging cleanups that make the code more readable, and as a side
> effect we clean up the const confusion. In such cases I think it is
> worth veering off the path a little.
> 
> I was going to catalog the numerous flaws I found, but by the time I
> explained them, I had basically written patches and commit messages. So
> here is what I would propose instead. I hope I'm not stealing your
> thunder nor knocking us too far off our goal.
> 
> The first three I hope are no-brainers, and the final one fixes the
> glibc const issue. The fourth is perhaps more risky.
> 
>   [1/4]: ref-filter: factor out refname component counting
>   [2/4]: ref-filter: simplify lstrip_ref_components() memory handling
>   [3/4]: ref-filter: simplify rstrip_ref_components() memory handling
>   [4/4]: ref-filter: open-code slash search in rstrip_ref_components()
> 
>  ref-filter.c | 54 +++++++++++++++++-----------------------------------
>  1 file changed, 17 insertions(+), 37 deletions(-)

BTW, you might notice one further opportunity for cleanup: these
functions return an allocated string via a "const char *". But that
issue is endemic to the ref-filter code, courtesy of f0062d3b74
(ref-filter: free item->value and item->value->s, 2018-10-18), and we
should probably look into cleaning it up all at once.

And that crosses my line of "way off topic, let's leave it for another
day". See, I do have _some_ restraint. ;)

-Peff
