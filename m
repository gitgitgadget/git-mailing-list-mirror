Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED4154456
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400328; cv=none; b=XR/fRAciNf7da+vc0I22o7KCZB/gIJWAtvas6v5Yevm/L3CjrSsYb0rLeiPej4soqUmhnvdeAEBpQciAJ7STEepMrNXBmDOIBt1AED2ujSH8XyeJD4l9rWnR0/7edQNA9di/wE5r2I7QT6zd8afq/22tNGL6+bgaHJmIDFo5sr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400328; c=relaxed/simple;
	bh=1NIoiQ4VQi1fGiVPunLUQ+cpnh9x4VUe1yTiFq+xHtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn5WFW7s1TrDEYDojhS3ei9Xv7WeI0XHFYr5PxH4duvflMsaaQVWb5PmJ0HayYWzanbFevgD8inGadT5LpRWZ+2fQ0d+YasTT9pn+KUS9hXR3rwuDN4XaAydU9VcyqHFklYkC9Jfv5SZ0PPaWmP5q/VATQDrg4TtZG94k6bqQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dMenXFSP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dMenXFSP"
Received: (qmail 30269 invoked by uid 109); 12 Nov 2024 08:32:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1NIoiQ4VQi1fGiVPunLUQ+cpnh9x4VUe1yTiFq+xHtE=; b=dMenXFSPvgHV6aVuc8m/rZLuYC0+gjOwakEjo8fQJQipxe19HJ8ULjDZ9eg4ysrt7rCnBIh2NjyEBiZhbkI2xtUerMwQEtvR36ed9Qo/ojZFKXwz/BRKK/NzlLabr/l9u6/0CAGS15uNfSVy7WWWSIAv6pnQHmdgCIcBl+RWZHFiIkJUpd+8twGoe6sS36M7S6fcFBU/55CQPF5+ZcBV4KoJuPX0DOPhcgbCAAZWFP8btftJMy/JjKARjnS4m4jlJoAUhHQa4LlndmUE0LD8io61OZxNFt0y6BE/J+7ibwRcWtk2cdjU7l3OQQ45vDbWrxnUwWk/+5W99smpwDn52w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:32:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27504 invoked by uid 111); 12 Nov 2024 08:32:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:32:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:32:04 -0500
From: Jeff King <peff@peff.net>
To: Eric Mills <ermills@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 0/3] double-free with git fetch --prefetch
Message-ID: <20241112083204.GA2636868@coredump.intra.peff.net>
References: <SA1PR17MB6501281EF202EA694CF9DC03CA582@SA1PR17MB6501.namprd17.prod.outlook.com>
 <20241112064951.GA619985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112064951.GA619985@coredump.intra.peff.net>

On Tue, Nov 12, 2024 at 01:49:51AM -0500, Jeff King wrote:

> Bisecting on:
> 
>   make SANITIZE=address &&
>   bin-wrappers/git fetch --prefetch origin master
> 
> turns up my ea4780307c (fetch: free "raw" string when shrinking refspec,
> 2024-09-24). I'll see if I can figure out what's going on.

OK, it turns out to be a fairly simple bug. The hardest part was
figuring out why it was not triggering all the time already in the test
suite. ;)

Patch 1 is the minimal fix. It is sort-of a regression in v2.47, in that
it became easier to trigger the bug; but it existed before then. Either
way, it seems like material for the "maint" branch.

The other two patches are cleanups that I contemplated when doing
ea4780307c. Now that this code has caused _two_ bugs which would have
been impossible with the cleanups, I figured it was worth taking a stab
at it.

Thanks for a clear report.

  [1/3]: fetch: adjust refspec->raw_nr when filtering prefetch refspecs
  [2/3]: refspec: drop separate raw_nr count
  [3/3]: refspec: store raw refspecs inside refspec_item

 builtin/fetch.c                   |  8 ++------
 builtin/remote.c                  | 16 ++++++++--------
 refspec.c                         | 26 ++++++++++----------------
 refspec.h                         |  6 ++----
 submodule.c                       |  8 ++++----
 t/t5582-fetch-negative-refspec.sh |  4 ++++
 6 files changed, 30 insertions(+), 38 deletions(-)

-Peff

