Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF313CFA3
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378963; cv=none; b=WgiapBg+yCVsMP+oSXAcUy+HwBtslvgezd7FKqq3qr8SnWzL6ZqCXvWFAxrcCncvasCDINV7h9ENdrKmcnnEJyT/RKBsdK98ggBfPXITvmlZvCHz5iSYgDRV6bkqBwt1vs6fUN5/KQu8YrA/vOjNaTP2pp6ADYKKIbTkjcuqmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378963; c=relaxed/simple;
	bh=+BNUllip+/GSzWAd7ggzcMRmkb9ACB3dCw0IhKOqkSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVFvnSxVcQsqjGIk3XdKa9xDqC/sw0Pwc5DpdnJoyP+ruXF99b6Uj2yLHqzI4p4fH7/OmNYb6zKf3j7Bvpd0HFHPUcBF3ImYCXCQVwrPMrSIOwQ+u47WuTMwfr76Ad55/9VsVSIehXM+aYn0PxbS7yTS1Svh86B6hrdb0RNIKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19614 invoked by uid 109); 10 May 2024 22:09:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 22:09:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14036 invoked by uid 111); 10 May 2024 22:09:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 18:09:23 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 18:09:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
Message-ID: <20240510220920.GC1962678@coredump.intra.peff.net>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
 <20240510200114.GC1954863@coredump.intra.peff.net>
 <xmqqh6f54czm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6f54czm.fsf@gitster.g>

On Fri, May 10, 2024 at 01:40:29PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   - we could remember _which_ helper we got the credential from, and
> >     avoid invoking it again.
> >
> >   - we could record a bit saying that the credential came from a helper,
> >     and then feed that back to helpers when storing. So osxkeychain
> >     could then decide not to store it.
> >
> > Both of those solve the repeated stores, but still let credentials
> > populate across helpers (which I still think is a questionable thing to
> > do by default, per the discussion in that thread, but is the very thing
> > that some people rely on).
> 
> Would "refreshing the last-time-used record" a valid use case for
> the behaviour that feeds the successful one back to where the
> credential came from?  Such a helper could instead log the last-time
> the credential was asked for, and assume that the lack of an explicit
> "reject" call signals that the use of the value it returned earlier
> was auccessfully used, but it is a less obvious way to implement
> such a "this hasn't been successfully used for a long time, perhaps
> we should expire/ask again/do something else?" logic.

There was some discussion in that old thread about whether that was
important or not. I don't have a strong opinion there. Not refreshing is
a more secure default, but possibly more annoying (and a change from the
status quo).

I do think brian's suggestion to use state[] to pass it back means that
the decision is then in the hands of the helper. So "credential-cache",
for example, could decide whether to refresh its ttl or not, or we could
even make it configurable with a command-line option for the helper.

-Peff
