Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC751C078
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801738; cv=none; b=r3sDONzrxbxY2aqAbYfSbHN5+DbIghb+hcSTrFOjctg0VIW7mRCcJbOlVFVrFvklwsUNH7KEFmpQTxvfbSD+y1FwA0MOZkT3HLz+iCGIP061q9L+zfwvr06iksGq4877O9LSDedHYd8dL5E0meoauwp7Hr85y0bs3wx+5HkBheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801738; c=relaxed/simple;
	bh=Fizc4nwfHTndramwjMOvG0+eOnGyeq6lKw6lv1beG3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+f3LC1WHAbXrdgQiMxC86wsVx4n2TTijVUqwV/ijOnKgboIYzrQUdE5mVvXJl5JIkdl3czccp99qIHIBcOUkeMqDa8QT68avakwXpS+jImoF2sew0zpwZ4j0E2FNMj+8Y+PQqGLbMWjCYEbyAHrusAf7kNJ82gSx8H2cD4fw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E9E58rOm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E9E58rOm"
Received: (qmail 7581 invoked by uid 106); 30 Sep 2026 20:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Fizc4nwfHTndramwjMOvG0+eOnGyeq6lKw6lv1beG3I=; b=E9E58rOmwkQIs5oUy9DNSGCn+9hyyrZw+F4SHZDo0dXUK3ElGLSlJpnVzCzxyfSUuXVBdt5RGG7l22MsMoJ3/o4mLah4+aL1jp0YTAmTEMRKgMCSpFlYcsBxT3otFYV0DUI8LTewUNBeyWmFTyI3g3KLKzByWJIxFLv9PNTUh4gxfLkjH4P7AsNEkUcYdgkGJF7zsfTzThPwNQuMEgCT3Falpt+rDSyoA5ddTg4QZqP/EzDjmty/hl2OQ9lqs3GnIyfvZiHqR0UYW+nntYvzEnPl1IWCRLHAT2cmgwr7zWhThCtkfrR16i+CnERFSoPFsOEeJvJ8PQTIgZUKKivr2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 20:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18879 invoked by uid 111); 30 Sep 2026 20:55:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 16:55:37 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 16:55:35 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 0/4] repack: various corner cases for cruft-less MIDXs
Message-ID: <20260930205535.GD747209@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

On Tue, Sep 29, 2026 at 08:28:34PM -0500, Taylor Blau wrote:

> This patch series fixes a few bugs I spotted while investigating the
> cruft-less MIDX feature.
> 
> The bugs addressed are found in various corner cases, and, when
> triggered, may result in a MIDX being written whose objects are not
> closed under reachability. When this happens while the caller is trying
> to write reachability bitmaps, bitmap generation may fail if one or more
> selected commits are descendants of the open portion of the MIDX.

I think all of these are making things strictly better, but I did find a
few spots where the fixes might be incomplete. I'm not sure if that
argues for a re-roll or for punting those to future work. ;)

I agree with Stolee that an oidset is perhaps a better data structure
for storing the extra roots (which are in a kind-of random order anyway,
since we're pulling them in pack order from various packs). But it also
probably doesn't make that big a difference in practice (we'll skip
duplicates during the traversal, and you probably don't have that many
duplicate objects in a repo in the first place).

-Peff
