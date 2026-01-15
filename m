Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9F29E117
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507747; cv=none; b=PPN/DgOdpxPihOnA0024TulnTKJAhn2MWr8DJuLpv3NPhwz4JXFTMEnETL00cGau/h3UPoBQDTlJg0ryGMglmVy8juFRJizANsejFkaW2EeB+E5xz85QXuJrht7qe9fzaDhB57wY3ciyllO5E3sqhFFOof5hfB88FtjWqIkmo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507747; c=relaxed/simple;
	bh=3TPyya28HEIOfEq7Ne7xH/GjUA30oGCb+OMSy1kn12s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqCfmGXC8p3WBD8Am4isQcN95wsGV5dy757M+coOnP6F/LJZAJxAZRvTCjipxY1m7gJbHLRPYQKAVIh0Xmwe8GKdQkNa6vtWJvupL7IIW4PWGEzQIx57ssIifXn0UlSzU+R4hWZRgYx+M//TtGGSaSK7uJOiYoi44H/zaY0eui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EtdmMO51; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EtdmMO51"
Received: (qmail 50404 invoked by uid 109); 15 Jan 2026 20:09:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3TPyya28HEIOfEq7Ne7xH/GjUA30oGCb+OMSy1kn12s=; b=EtdmMO5162UZTBE4m05hGuappHAp2noUpI1j1x6otc+p56pEM9549vFLfpite9GWUfyWqSTWCb2DKZ6LQ+rDWr+Woj7M3pBqGdBGi0YSCIAgpVvK4CpXwjyHLwc/6jo9PV9G1o1Mks9s5n0fV8rNARRb2B+lMfrk6dAUiSn+bCALojwZ0hZUVJs3JaxrUtWRce4hU7DOjeJxq7/cv9XVICc3WOCOWicvixYlXISqANWa7nwIdfWQFYS6FXGvYmCs6oEuSE4UNGG8CyTp30PX4m4iF9eQ4R3l58qCd2Axg442oGS1gWHv5vpPJ5ps+XcncC/HlJFibpxJX9EreXVXXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 20:09:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 82522 invoked by uid 111); 15 Jan 2026 20:09:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 15:09:05 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 15:09:03 -0500
From: Jeff King <peff@peff.net>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
	newren@gmail.com
Subject: Re: [PATCH v3] sparse-checkout: optimize string_list construction
Message-ID: <20260115200903.GB1053259@coredump.intra.peff.net>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260115130935.93526-1-amishhhaaaa@gmail.com>
 <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPvEtreX9sGHUn7+Y0kLo_VnK7Y=OYLq-kz-+np3bu1QtoEpnA@mail.gmail.com>

On Thu, Jan 15, 2026 at 06:45:35PM +0530, Amisha Chhajed wrote:

> I was also very curious about the presence of
> string_list_remove_duplicates in the original code, from my
> understanding string_list_insert already removed duplicates and
> string_list_remove_duplicates was still present with it.

Yes, I don't think you could have duplicates when inserting with
string_list_insert(). Of course your patch removes that, which means
we're falling back on the notion that the hashmap cannot have
duplicates, either.

I think our hashmap _does_ allow duplicate entries, though. The
insertion code in insert_recursive_pattern() avoids duplicates in
parent_hashmap, but adds its arguments directly to recursive_hashmap.

So I think you could get duplicates with something like:

  git init
  git sparse-checkout set --cone
  git sparse-checkout add --stdin <<\EOF
  foo
  bar
  foo
  EOF

Before your patch, that produces this .git/info/sparse-checkout file:

  /*
  !/*/
  /bar/
  /foo/

and after we get:

  /*
  !/*/
  /bar/
  /foo/
  /foo/

So I think we do want to retain the duplicate suppression. Switching
from insert() to append() is still good, as long as we keep the
remove_duplicates() lines.

-Peff
