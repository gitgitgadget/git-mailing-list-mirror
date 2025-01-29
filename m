Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E11DF739
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181226; cv=none; b=Zq9FdJB0ACjOZgqJri0W3vLyMDapnu2LWANWLCFsqnaoNd3fdnQR4T6uPSD+ir6BdY4WZSXrDW/qMPRXCD6UU/BxTbku5xovaOSAwXC+foqBqkoT+50a3+Zzw8rzRjIlHwqm/5UyCwYxn8y0C7Zzai7W9mxUGf2jifd/AvjsXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181226; c=relaxed/simple;
	bh=QIfa8lcyW5LV23XiyHddakRWI6fYXJG9HgwPCPxjMhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfPyQ252KE59KDUqYGW4lykiVx1HEFqLoLsdsPT1s665jnvCe8S+2LBhHPe5e9zIto9994zcfqwzIpruimGNbfuwt+/ihaz46ZvbO7qfAXDchzArAo+2EAapyWKGbDOfm7yH83gd2+7HCcKEKH2Syd1GeSeLUt5M6QLycBqebGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ccdv1btB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ccdv1btB"
Received: (qmail 29485 invoked by uid 109); 29 Jan 2025 20:07:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QIfa8lcyW5LV23XiyHddakRWI6fYXJG9HgwPCPxjMhU=; b=ccdv1btBnBiMNtTMt6evchv5iMxSIKSlcSRdBVGv5i7Kk6t8oUHfeBxPDY5TGgBx+TvvFUE5LqJVdgN6UuKbj78U8QRjmGK0NoXCShgpx3rYPA2pWMIN2y4vLdUVyJUU9zhPK9GUciAbgAufbISkGcau87PZTfr2F/uTx0J8Q3YkppCxM0QYP8/Hojg0x4ZHxs0ZVbxTsZDNBqQ/fbHhtVCCrSPsDeF3aZaqiz0ZBQOeUL2HSD+rRBIdtz/0cPtp0c0uza2bD0X/vhPHcfGPmnnowYamztQVsRiIrG3jYJFcgwDPId77M1Uqb/Zs6Yr3kQCAO5zU+fjvht6nNrf+nQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jan 2025 20:07:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32479 invoked by uid 111); 29 Jan 2025 20:07:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2025 15:07:04 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Jan 2025 15:07:02 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] unix-socket: fix memory leak when chdir(3p) fails
Message-ID: <20250129200702.GB2331283@coredump.intra.peff.net>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
 <20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im>
 <xmqq34h1k02k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34h1k02k.fsf@gitster.g>

On Wed, Jan 29, 2025 at 09:21:39AM -0800, Junio C Hamano wrote:

> > This leads to a memory leak: when we have already populated the context
> > with the original directory that we need to chdir(3p) back into, but
> > then the chdir(3p) into the socket's parent directory fails, then we
> > won't release the original directory's path. The leak is exposed by
> > t0301, but only via Meson with `meson setup -Dsanitize=leak`:
> 
> Did you mean
> 
>     $ meson configure -Db_sanitize=leak
>     $ meson test t0301-credential-cache
> 
> I'll need to figure out how to make various tweaks at runtime
> working with meson based build tree.  The next thing I need to
> figure out is to see how to get verbose error output from the tests,
> as I cannot just go back to the source tree and say "cd t && sh
> t0301-credential-cache -v -i -x" because the build is out of tree.

I did:

  GIT_BUILD_DIR=$PWD/../build ./t0301-credential-cache.sh -v -i

but I don't know if there's an easier way from meson.

(The "b_" prefix on "sanitize" confused me as well after reading the
commit message).

-Peff
