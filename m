Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD1714D7
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409557; cv=none; b=ui/ftrR6tr8LFGXCV0vwu4VXBG/Rf9jxI0wM4FniRTAcuMI+6eWVTrn9NUc8AQMleQvrTM6c4J390XPTlbPYQEtn5rQnZvawW41BC3o9ihklRSaoFixR+qnhit6+4RTqoVhO3W6/emgbVPSpKJ4TZ2F0EaVwYcP2ruol+ntx5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409557; c=relaxed/simple;
	bh=v4CpljpzPmnzzeE3IqS4otqv2A/5Xd0oD1eK9mvdPM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4I6hhzivaN5OpjZYEi9eMCLmO1mZ4eq32ySMxuNr1toY3svQ2Qqj2eCpYS/492WktzcZdgcoYum1vG3cMpkCGN1dUTA5YXDjZAAqaIR8TAgrD4IXrQ2DBCvVErxOReaQw2y/rdpalFMfcpnJ1MT6myCc9knV1oOrd4PIYqFrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JXFzt9pm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JXFzt9pm"
Received: (qmail 25169 invoked by uid 109); 9 Jan 2025 07:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v4CpljpzPmnzzeE3IqS4otqv2A/5Xd0oD1eK9mvdPM8=; b=JXFzt9pmLgylqdlBBYjQskfM/oSQvRBMhB0dyBitsfj+6SGGhEr0U4dY3/k6K3xONDn3x/brsn9mqp0ukWxqzstei1Ie1xGVyRZ3hcC6uvTeRQ4XeGwkVbeT2MLqTrL5qw2d1eM5zVP5NXsRFuIlBu9OmTutUvK+UQzlpf56f0cPs2OQkeqxBmJ4WNf3jHJGg6CCt7LU1Wm65KAgI4k6VEmU3TBEpHyQQ5NnL6suvaNiFJwMGvAaCDW+nH6KL573nyl7sI4v04cgx2v17KIVsHVOYn3FCcZeIcsKgnZBFfnQqVFQArDiIpwbGthySJ2PTw1pvDQVRFsfLMfxkyIrpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 07:59:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19775 invoked by uid 111); 9 Jan 2025 07:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 02:59:14 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 02:59:13 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: simplify lsan results check
Message-ID: <20250109075913.GD2735258@coredump.intra.peff.net>
References: <20250107070409.GA584456@coredump.intra.peff.net>
 <20250107070752.GB584668@coredump.intra.peff.net>
 <xmqqmsg2vbi1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsg2vbi1.fsf@gitster.g>

On Tue, Jan 07, 2025 at 08:23:34AM -0800, Junio C Hamano wrote:

> > We do need to use "grep -s" for the case that the glob does not expand
> > (i.e., there are not any log files at all). This option is in POSIX, and
> > has been used in t7407 for several years without anybody complaining.
> 
> Also since c625bf0e (git-p4: git-p4 tests with p4 triggers,
> 2017-07-13) t9831 has also been using it.  It is not like a stray
> error message about unmatched glob would really matter here, though.
> We are not doing 2>&1 to let the downstream of the pipe see it, and
> unless the test is run under "-v" option, it wouldn't even be seen.

Yeah, I saw those. But I don't think they count since hardly anybody
runs the p4 tests. They do run in CI, but on a rather limited set of
platforms. Though come to think of it, this one would only kick in for
LSan, which may also run on a pretty limited set of platforms. :)

-Peff
