Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA222931D8
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996308; cv=none; b=ceJYj5pTfsBj4ZeQLPU/iD84/aFlvXU1B5cb+uf0kmDAVlw+K/Bbom6ZmQndMk9NOjsnwF/QEFBCWXXd2qm/AWtqI/QeYN0lw/V5XrzKBTrD8VIALUI3RE1fgfjxWoVWyhOg0g56dmDY5XBTfO38+aeYE6VtIBc5wvUYUClEfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996308; c=relaxed/simple;
	bh=kDkDShSRqQLJ5/QaRBDb++zvrEVpw2mRnprSD5KE6eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGKFpbwHv5zeGMQ5rJ1zyrdfhX3oykVvi/RXZlwJ5m6ygZm1ep7orL058Ps1VJbhsUaqa6NIsexk/UXp0eZuX4RkPMr7xISRVtfp99ZaOkCnwEE/GeEYE4yc7VZTH/eGu0AF0nE8iHsGMCjRfIfZneVk2LWPxp1sSN3TLiisKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=go2qo7df; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="go2qo7df"
Received: (qmail 48506 invoked by uid 106); 25 Jul 2026 16:18:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kDkDShSRqQLJ5/QaRBDb++zvrEVpw2mRnprSD5KE6eU=; b=go2qo7dficNfntcdhGlMpnqf9BAV0j4XW5jl7BPTsWsq++0BAkIMVPAas9oz+cTZhcTsu+b/zH9v/C8mV994O/p6McndfMtg9gRMD+a18r+Fpt/S49RneHXnFQlDK6SYEbFkUxPAxwbmloQEv3k2+nl259Ipsfla9HPhQgpbhU9bruJ+mWlecOo7yyfaytTRs/w/UMjVXWJlQi0qeCxTR3EcLZx6bU6Y2gBnkoSXk2TPfQmAiD+2A7PsMmGpf9L1Pia2qCiJumS/VeSgXMwfjYVDfOz8u3qfvo2bUo88b/pAQuEGmsVUYTAEyZYo7xvSvJKxRxsc3FS5F2casiCW4Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2026 16:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49151 invoked by uid 111); 25 Jul 2026 16:18:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2026 12:18:20 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Jul 2026 12:18:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] remote: plug memory leaks
Message-ID: <20260725161819.GA2343104@coredump.intra.peff.net>
References: <xmqqv7a33nm9.fsf@gitster.g>
 <xmqqpl0b12gj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl0b12gj.fsf@gitster.g>

On Sat, Jul 25, 2026 at 09:03:24AM -0700, Junio C Hamano wrote:

> * The initial iteration relied on the assumption that strings
>   borrowed from the configset subsystem will not go away, attempting
>   to plug the leak of 'instead_of[n].s' pointers without making
>   copies.  However, it turns out that all existing users other than
>   a select few make copies and do not rely on that assumption.  In
>   this version, I decided to simply follow suit, which might be
>   slightly inefficient but is vastly safer.

Heh, I was just in the middle of writing a message digging into this.

We should not rely on that assumption, because we sometimes discard the
configset (e.g., when discovering the repo, or when writing a new config
option). I couldn't come up with a case that fails, but I think it is
mostly luck (or lack of imagination) that there is no code path that
invalidates the configset between when we read the remote config and
when we actually use it.

So even though in something like:

    git -c url.$PWD.insteadOf=$PWD clone $PWD dst

we end up with a state were the instead-of structs are broken, nobody is
reading them at that point.

So I think this v2 is doing the right thing.

-Peff
