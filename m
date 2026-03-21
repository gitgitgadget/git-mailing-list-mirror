Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468B30C602
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112234; cv=none; b=gMRt28wpPpXhGrUlFuV0/Zl4c1d/4O9KIFSQMxsHLiFGdJwYXr4m38+vmIaoek5UgfANmO+bYmoTBJBGjttLqqY2s2C3P1ZSrpph53roDPbLrB1yRwbUXYrqIHRgswzqD+QGT2gsyaC5Tv+Nh5S51xwLh/Ul3gB23QHjCNZKhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112234; c=relaxed/simple;
	bh=fIvMxyhr/k5DZO21yQ2Fb3VOftZ6ce+sxaUk0JVG5MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJxuV8A+SAMr3U3O6KRR4MG4NrnDF0lwgr0r7lcanuVxkTBmFnZCfqd50tm569aRslt90HhJxRo8w/EMHnLxq9ncziIR0VEZd6ghAiN1CpTOI6mC4vVt3MpU/JT9r4fjs8H8I4ukQkLY7/a+1isipyoXCoogRFn9LRbqZE4ZUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VLa06p1J; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VLa06p1J"
Received: (qmail 85856 invoked by uid 106); 21 Mar 2026 16:57:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fIvMxyhr/k5DZO21yQ2Fb3VOftZ6ce+sxaUk0JVG5MU=; b=VLa06p1J9R7rEkC/TNQo1FNgaFFkEBfhQdz2D9U/6CrJhNVpKpUDd+Cg2HvUuO+U4YLfZJ3TN+PnM6V6hdmVSFAby5IzDQULFeju9L9B6ZHiSGTD/XJtymIkZdKO9LnscrPN2l92jqkXYx4Vn7fd4KDYI8w3EkaW79llFSbaO9Pc3XJcG4OT2R6cZx3slNy/48eN1iDyjRK1qvNCcnS+EELnWXUCywDMuarOgf0gWdoDbPjwo0xICoUKzjomu5tfyN+hgu9SCiaEYoHOFAIuDIiP8WSUOwzq/fz5Ge2zg6zHsLvxRFd4/4+UNlSxSKovIdVH815lubfaIjjzeT1fBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Mar 2026 16:57:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 120619 invoked by uid 111); 21 Mar 2026 16:57:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 12:57:11 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 12:57:11 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
Message-ID: <20260321165711.GA718452@coredump.intra.peff.net>
References: <cover.1773959041.git.me@ttaylorr.com>
 <bd78919e19cfa968556ad4241391120ed56e9dce.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd78919e19cfa968556ad4241391120ed56e9dce.1773959041.git.me@ttaylorr.com>

On Thu, Mar 19, 2026 at 06:24:25PM -0400, Taylor Blau wrote:

> @@ -3750,8 +3756,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		return 0;
>  
>  	ofs = nth_packed_object_offset(p, pos);
> -	if (!want_object_in_pack(oid, 0, &p, &ofs))
> -		return 0;
>  
>  	if (p) {
>  		struct object_info oi = OBJECT_INFO_INIT;

I haven't read all of the patches carefully yet, but Coverity observed
that without this call to want_object_in_pack(), we are left with "p"
that came from the caller. If that "p" is ever NULL, then the
nth_packed_object_offset() call above will segfault. But if it is not,
then the "if (p)" below is pointless.

AFAICT it will never be NULL, and the conditional is now pointless. But
it wasn't before your patch, since want_object_in_pack() may set the
found_pack to NULL if the object is not wanted.

-Peff
