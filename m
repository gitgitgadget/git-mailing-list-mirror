Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA750157A5A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059039; cv=none; b=TS6jJ1GnE0LEcXBXMNuWA4M8EQ98s1X2uIK2yewZFcPE8lUF3KxdWEOfCSaOt4YZBEs/gvNiaoypyeGVkhR/ngwyvXYX9RJuD0S2RyM7hedDN9WM31zM0NibzwW3vLefHmHH2mhSwWhHbSDVBLK/QT1/NUVHoihGf4qFfXYxtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059039; c=relaxed/simple;
	bh=4MY6ebRueWOyvdZFQDsQFxACwL6pUDw1iZP+vNW1OHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnzN9z/KDOyItJ5xv5J5atkyeWLlUFk5yEmt54dxJcKuW3/ZRfPhDNVtb+Q9he0JoL4KdEOg8mU4pxLDGLfe0964dZrXuLIgMlO9UTzN2nxgH6j3rgimhiRSl1tymly4Wkk/Q92hkwJP6wObCeknXD/MxNpy26hrl0qypyW2NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8848 invoked by uid 109); 19 Aug 2024 09:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 09:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18389 invoked by uid 111); 19 Aug 2024 09:17:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 05:17:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 05:17:15 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <20240819091715.GB2958552@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
 <20240819085522.GD2955268@coredump.intra.peff.net>
 <ZsMLZ3Tlhxsg6Qdr@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsMLZ3Tlhxsg6Qdr@tanuki>

On Mon, Aug 19, 2024 at 11:07:51AM +0200, Patrick Steinhardt wrote:

> > I have not paid much attention to the "maintenance" stuff. It is a
> > little weird to me that it is not building on "git repack", which
> > already handles this, but perhaps there are reasons. Anyway, totally
> > unrelated to your patch (which looks good to me).
> 
> git-repack(1) is way less efficient than running git-pack-objects(1)
> directly. I've also noticed that at one point in time when revamping how
> we do housekeeping in Git.
> 
> It mostly boils down to git-repack(1) doing a connectivity check,
> whereas git-pack-objects(1) doesn't. We just soak up every single loose
> object, and then eventually we expire them via git-multi-pack-index(1)'s
> "expire" subcommand.

Hmph. I'd have suggested that we should teach git-repack to do the more
efficient thing. I'm a bit worried about having parallel universes of
how maintenance works making it harder to reason about when or how
things happen, and how various concurrent / racy behaviors work.

But it's probably a bit late to re-open that (and certainly it's not
part of your series).

> > I wondered if you needed --no-detach here to avoid a race, but I guess
> > as a non-auto run, it would never background?
> 
> Even the `--auto` run does not background. That was the case for
> git-gc(1), but is not the case for git-maintenance(1). You now have to
> pass `--detach` explicitly to cause it to background, which I think is
> the saner way to do this anyway.

Am I misreading the documentation? The entry for maintenance.autoDetach
on 'next' says:

  If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
  to true if both are unset, meaning that the maintenance process will
  detach.

-Peff
