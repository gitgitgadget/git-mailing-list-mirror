Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301223BBC1
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754144; cv=none; b=ZhtTUieXKKWIzGyIkLqqCSXK5bJ55mPSM2sd3DWvVrBC+dWMxhTOR/LFsZl0jj9pcbrvikONy1Nk6q32y2mgyKe4oolChTkCcrpStwWq2UPNIjBqnRAZFUKNjAcNddRrdQrGyA0QPwLhq/WvOYGThgKp9W5E64Ttvb175LTQCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754144; c=relaxed/simple;
	bh=HRewIbMEL6lm6SXstwmEELbmcEEUpSUMkAL1SYoA8k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi0671pvOy7cReE2UTKXqdUtbhu9NcDUR/OQFhYknT6C766WzaURvAqHQvIbX03wIw2fxSvRjo/lIz5exxudEJGrBPR5gQE1YJ76XzbwvzY5zOfKuYvze3co43cNIxG+01T1nPfRYEyIXuUMpXgTgsflGei0kfQVwMpDBXyiMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15072 invoked by uid 109); 15 May 2024 06:22:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 May 2024 06:22:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30715 invoked by uid 111); 15 May 2024 06:22:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 May 2024 02:22:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 15 May 2024 02:22:20 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <20240515062220.GC110841@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
 <20240503181339.GH3631237@coredump.intra.peff.net>
 <ZkQ3EiL1OY10Y2JP@tanuki>
 <ZkQ8mDrBB2eGg8Ns@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkQ8mDrBB2eGg8Ns@tanuki>

On Wed, May 15, 2024 at 06:39:52AM +0200, Patrick Steinhardt wrote:

> On Wed, May 15, 2024 at 06:16:18AM +0200, Patrick Steinhardt wrote:
> > On Fri, May 03, 2024 at 02:13:39PM -0400, Jeff King wrote:
> > > On Thu, May 02, 2024 at 10:17:42AM +0200, Patrick Steinhardt wrote:
> [snip]
> > > And arguably is_pseudoref_syntax() should be taking into account the
> > > "_HEAD" restriction and special names anyway. It is a bit weird that
> > > even if we tighten up the refname checking to use is_pseudoref_syntax(),
> > > you'd still be able to "git update-ref FOO" but then not see it as a
> > > root ref!
> > 
> > True, as well. I'm less comfortable with doing that change in this
> > series though as it does impose a major restriction that did not exist
> > previously. We probably want some escape hatches so that it would still
> > be possible to modify those refs when really required, for example to
> > delete such broken refs.
> > 
> > I would thus like to defer this to a follow up patch series, if you
> > don't mind.
> 
> Arguably, we don't need `is_pseudoref_syntax()` (which is being renamed
> to `is_root_ref_syntax()`) at all anymore after this series lands
> because it can be neatly rolled into `is_root_ref()`. The only caller,
> `is_current_worktree_ref()`, should really call `is_roof_ref()` and not
> `is_root_ref_syntax()`.

Yeah, and I'd expect that the more-strict check_refname_format() that I
proposed elsewhere would be in the same boat. The only reason I used the
"_syntax()" variant is that it was obviously wrong to do existence
checks there. Once those are gone, then naturally it should be able to
rely on is_root_ref() itself.

-Peff
