Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401A1422B8
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723871398; cv=none; b=snippxucrq4AGiqM5YVMyOW7Yjh2FyLJsLVwEeuhfIDAM25b2oHCx5xuhlwaJZuAUt+/ld9u7aQ6RzHrVA7ksiDekSq2B1743+fU2SWuh8WCVDeBBOIa3UFwgLFGBRJU587an4u6h4Yk5MhVTuU5cRhMJroekTHssE0wyjyEVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723871398; c=relaxed/simple;
	bh=wegO/H7OFLmpVLy0yrYYtog/1ajimxG0n96egEDN534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMEXbcBHJRAhXa1TPBG65SeDVUVsu3vJtpKya/8usFHp+qqIIDVnjouYmDiqbWXGBBKAwnfphoa3VrDJHtsQhST8pxCkx3pcVRpnHYxVpo9jt6qKacXr5l0M33tfLEW/SVmd58Y/NQYO7hgYB4fL5YcmDxlKtX52ZPFaqgY0m3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22593 invoked by uid 109); 17 Aug 2024 05:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 05:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26315 invoked by uid 111); 17 Aug 2024 05:02:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 01:02:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 01:02:40 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: feature request: set remote/HEAD with fetch
Message-ID: <20240817050240.GA29822@coredump.intra.peff.net>
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com>
 <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net>

On Fri, Aug 16, 2024 at 09:55:00PM +0000, brian m. carlson wrote:

> > I would propose that running `git fetch` should also update remote/HEAD. In
> > case there is a possibility that it is useful in some cases that remote/HEAD is
> > actually different from whatever is set in the remote repository as the default
> > branch, I think a setting for opt-out would be better, and the default
> > behaviour should be essentially always running `set-head -a`.
> > 
> > My current workaround is an alias:
> >     fetchall = !git fetch --all && git remote | xargs -i git remote set-head -a {}
> > 
> > which works for me, but I think it would be more elegant not to have to do this.
> 
> I believe this would be a valuable change.  I know a lot of other users
> want this features as well.  However, I think it needs to be opt-in,
> since there are some cases where you want `git fetch` to specifically
> fetch only certain objects or don't want to modify the refs. For
> example, I know some server-side implementations use `git fetch`
> internally and require refs to be updated in a special way, and they
> would not appreciate extra refs appearing.

There was discussion a while ago that proposed a tri-state config
option: never update the remote head on fetch, always do so, or add it
only when missing:

  https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@gmail.com/

I think that is a good first step, as we could stop there and leave the
default at "never" without any compatibility issues (and/or contemplate
a change in the default as a separate step).

I don't think the patch in that thread is likely to go anywhere at this
point, but if somebody wanted to pick it up, I think everybody was
positive on the general direction.

-Peff
