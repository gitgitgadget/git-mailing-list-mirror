Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D019FA77
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870040; cv=none; b=ODjyCp86j5m6q/0ScUlDOtA4YIeuXb/QdoPjIeCL7KfF4EyKFTMMxJj344tggW3Fq5tVY4Cab8vAhLdWK980PWdxpNj/V4TbGzqLSi9K2VEWn4DR4wqrbz1+l0HNs9v5WUfKOyz0146cuvY1xGp6VenlMhWY54EeV5OXpY99z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870040; c=relaxed/simple;
	bh=+WGrWvTvrrDfHHAjQItOWv3i2GME7cDLLw7G+ZdJ2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC91Zu3VhwDH5jPhCjMoqwD2cyR5nVihkQ93VxKQ7ZP04LdEQ+84OSiJnDo+PK88Gn6WsOvkUJWp2nq/8CsnXKr51phq7bbQ6+nW7kdUyzcZbtsQ+Qd4+UuMl+tICLlb5iV7fQBA1CFvzJmHleMTYkMIdCVNvoktMin6rWx2IUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26655 invoked by uid 109); 28 Aug 2024 18:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 18:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30131 invoked by uid 111); 28 Aug 2024 18:33:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 14:33:58 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 14:33:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] fixup! midx: implement writing incremental MIDX bitmaps
Message-ID: <20240828183356.GA4043247@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
 <afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
 <xmqqseuozg53.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseuozg53.fsf_-_@gitster.g>

On Wed, Aug 28, 2024 at 10:55:20AM -0700, Junio C Hamano wrote:

> With -Wunused, the compiler notices that the midx_name parameter is
> unused.  In this case, it is truly unused, the function signature is
> not constrained externally, so we can simply drop the parameter from
> the definition of the function and its sole caller.
> 
> This comes from 01a2cbab (midx: implement writing incremental MIDX
> bitmaps, 2024-08-15), so I'll squash the following to that commit.

Well, that didn't take long for this to come up again. :) I've been
fixing them progressively as they hit 'next' (since I don't usually
build 'seen'), but this one isn't there yet.

I'm always curious in these cases why we have the parameter at all if
it's unnecessary (i.e., is it a bug or leftover cruft). In this case, it
was present before that commit, but refactoring meant that we no longer
write to $name-$hash.bitmap, but instead use get_midx_filename_ext(), or
get_split_midx_filename_ext() in incremental mode.

Is that right, though? It looks like the caller might pass in a
tempfile name like .../pack/multi-pack-index.d/tmp_midx_XXXXXX,
if we're in incremental mode. But we'll write directly to
"multi-pack-index-$hash.bitmap" in the same directory. I'm not sure to
what degree it matters, since that's the name we want in the long run.
But would we possibly overwrite an active-in-use file rather than doing
the atomic rename-into-place if we happened to generate the same midx?

It feels like we should still respect the name the caller is using for
tempfiles, and then rename it into the correct spot at the end.

-Peff
