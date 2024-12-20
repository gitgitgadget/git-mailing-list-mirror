Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C622339
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680245; cv=none; b=GceV8akxYy9yVHFlVzgDpwoAd0O5M2fdMPXcFV/ztIumRm1ZtS7L4M6xC8tfRgoF2xxkmrkOlVsxWznmB9nQPdci5gOw7044ncMvMwbTpxg5AegK8oZuvgc7HSUqJ4MQ9jfJPkUidWPy8EOrEYkxa5cvX119PSm1id+mQU64GUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680245; c=relaxed/simple;
	bh=X8ZkjNdG2wIqasqa9JthAI7IL28L0lksDgI+GGYEeE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmGxqUZ56obGV31y3YjT5K50zzouVc5fEVQYWOZ18pvC53Vd1mRkrV/jJw3BPPe2sVN7HHb3AS/6rOtngpwBLyEpTOV8Bxm/6l9HvCNAvzYkQexXlTycGUzOx1pyZIFAanKnDkmccjdhZBOYrN3knicxClDRB95/9R11LrM6afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M9O+4J7r; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M9O+4J7r"
Received: (qmail 7203 invoked by uid 109); 20 Dec 2024 07:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X8ZkjNdG2wIqasqa9JthAI7IL28L0lksDgI+GGYEeE8=; b=M9O+4J7rofk/eV7FZPM6UxYHaYvpgp5+a/mOp6quGYN3F+s/W9ofufVp52g4M9d7zKh876h1Pd9Rw6kiJ2UfBmQjFCEs+9oIoUWJHeoIGnygNzy25MFA2alkQJLfd3iZRzfNEQRW6JvERZ3pq5+dhMQGl6p16klZ5u5x111Q7S7pDIoQdjzBUb67LvRgSurBMLWujuB/aBFAbxEd721I0xul4uxAGIXlTwqAznhqJYLdYNEaWNNAfK8xA9AyCIn9orl4pa7ajY96INXcazc3rBMT6UHpOpuepo9488g7QuMy86vphvQFCMjVdV0jfafgTUObb0vLpjqnd3fBidQEEg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 07:37:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13796 invoked by uid 111); 20 Dec 2024 07:37:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 02:37:21 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 02:37:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 2/2] GIT-VERSION-GEN: fix overriding
 GIT_BUILT_FROM_COMMIT and GIT_DATE
Message-ID: <20241220073720.GB2389154@coredump.intra.peff.net>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>

On Thu, Dec 19, 2024 at 04:53:37PM +0100, Patrick Steinhardt wrote:

>  GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
> -GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
> -GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
> +
> +if test -z "$GIT_BUILT_FROM_COMMIT"
> +then
> +    GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
> +fi
> +
> +if test -z "$GIT_DATE"
> +then
> +    GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
> +fi

Looks good. I doubt anybody would want to override BUILT_FROM_COMMIT
(and it was never possible to do so, even before your recent patches),
but it's reasonable to include it as well.

-Peff
