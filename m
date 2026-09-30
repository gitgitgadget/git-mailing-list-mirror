Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E632FC011
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801595; cv=none; b=BSsWG3R72neUNkSDOrM/ERDJKg0kghBKa0Qkt8ZxV/KwGS1GGbb9l3d8QvLQSdGP9r/037nY38lEaA6Sd4pA6gE7+SGMULLoMBxyzXEXQz66PuG4Upup50jXGj2EAN/epREeMxAkqDshNRQ1AWVxp0ZWcS5ngQLIp8K3SXaaR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801595; c=relaxed/simple;
	bh=5yyfawULO/GvnrfHdK2BANxAR3A/U+8dLxaDRrEJHZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMp5yQQQkO0xKiRL0+QLwrsxLVl9GYkgJ9ThAwa0R1ovJr09GuogMJhHXDgjJvWDip+cfowHEXtEEfXPAeBe6lbSGOc/tBxO1o+2w+yYtZ6VJoSQ3/zNEDSZnsrePHjZQ0u7itZJdpY4sm6UC1fcjRrkisRDVhGArwCqFIKoOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cIub9OYV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cIub9OYV"
Received: (qmail 7565 invoked by uid 106); 30 Sep 2026 20:53:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5yyfawULO/GvnrfHdK2BANxAR3A/U+8dLxaDRrEJHZE=; b=cIub9OYVWfbEjB6yy94SKFMR55nw+n4qCRj4CkyX3EWuHYC5o7YizjS87AJuJugBx3Wd3MIwHgFXy2jLtwbxLGDFYwziWakPm8uWhfmRFZJBUNPGlXNMdsa8QWPt7uEFlbIMqlDal6p42jqiJ5uRYWcF8pkK5ZI1ABd1idrIyYizcct+BmWYejUiTMw9UdFoKa7zidq2y9xxUKzVZ5K752xa6Nag69h9HDxRIn2sDJnFjsyMyYtGY0FJULwxWcx5UyXkaOeI5SKkqsx1N1WUZXLoBslxH1dqIAnanea69HFCrm04cS6OLThknfy1XkPT1zaiuO8+pwgvxQRwEM9KfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 20:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18844 invoked by uid 111); 30 Sep 2026 20:53:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 16:53:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 16:53:11 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 4/4] repack: retain cruft packs in MIDXs containing kept
 packs
Message-ID: <20260930205311.GC747209@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <e942c256334e4de31ec0a1cb2d5f8c7465d8696f.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e942c256334e4de31ec0a1cb2d5f8c7465d8696f.1790731662.git.me@ttaylorr.com>

On Tue, Sep 29, 2026 at 08:28:58PM -0500, Taylor Blau wrote:

> When performing a geometric repack with 'repack.midxMustContainCruft'
> set to "false", Git uses '--stdin-packs=follow' to copy (once-cruft)
> objects needed for reachability closure out of cruft packs. .keep packs
> do not need to participate in that walk, though they *are* included in
> the resulting MIDX.
> 
> A .keep pack can contain a commit that reaches an object whose only copy
> is in a cruft pack. When there is no previous MIDX and the repack writes
> a new pack, neither `midx_has_unknown_packs()` nor the `!names.nr`
> fallback require that cruft pack to be included. If the kept commit (or
> a descendant of it) is selected for bitmap coverage, the bitmap writer
> fails because the MIDX does not contain all of its reachable objects.
> 
> Include cruft packs whenever the MIDX contains kept packs. This also
> retains cruft when the kept packs happen to have full closure, or when
> '--pack-kept-objects' lets the repack walk them. It avoids having to
> establish their closure before deciding which packs the MIDX needs.

OK. This makes sense to me, but two questions:

  1. Is this going to kick in racily because of the .keep that we
     temporarily install during pushes? That could cause unexpected
     performance changes in a big repo when the midx sometimes has to
     randomly include cruft packs.

  2. I'd have thought that the solution would be to treat .keep packs
     like other included follow-packs: traverse them in the usual way.
     But maybe there are good reasons we didn't do that in the first
     place.

-Peff
