Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E391BBBFD
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086336; cv=none; b=Qhn5tYRS/mymZfhPV7rxxWzpa46PyU9fSRDFNQL/HVTRj3/25ElwgvrBwJr8fQrt4eyCdGrKsWCr/pSMIN/vqfvEPLUzcjZd5iNW4AKe8cGQRTBDtNOW6x6zQbjm7gMJTD92iPoS/otEDEOE00WqopNyVlez49RhegGk9StXiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086336; c=relaxed/simple;
	bh=4/4W0BQFSKtHjZKYXavNuVUPKy3UnWZ6kjt6NQVS96w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzsdl9k8PWQBiSL9Vy+eCCJWQqOllMzJCunYZ6H1SqWHFbJECVF7Id8WMAlCKOcI2XRN630rCVWhak1C88yU3aNNJZV+QG0xgfgaIUoeE+LB4I1mAgiZHRIp7koyGTKtw8xpJuU4GLc+UZT+mPV/gCC1dsdeMpRn5kq5kAitqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aWWKrWrG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aWWKrWrG"
Received: (qmail 15781 invoked by uid 109); 13 Dec 2024 10:38:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4/4W0BQFSKtHjZKYXavNuVUPKy3UnWZ6kjt6NQVS96w=; b=aWWKrWrGFLUVdqo8nxBgKzgItaDauWIddhNyyi01TPN6osXqJVjOg1h3sABgXaQsp7khH/vmmbQERbKOPk8BF1QMvGMNqKSQufR5tHxI191FD8iGoNAQnxAKVHaWarZXk1lfyvWvfFyp1ZXGMZMef5Zk4V5ZKTHconhO0OQ0t0TR1Efwhrv1NMqoty9WnS5tqKD+RRIy2VShxiIKXJMHUe8MH890PgYPotkmIoCjF7BSxnqIfRZEOJy+1ZZIhsfu0e5r/F9kIxWA3pYK2OwEFrLW1gPlzRskMEwh96GhbZl1iSLiw8Yolf7XadUR590ZuJ0EyFws/mK609qDHQdIRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Dec 2024 10:38:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27188 invoked by uid 111); 13 Dec 2024 10:38:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2024 05:38:51 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Dec 2024 05:38:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241213103850.GA1456983@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqv7vnevjc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7vnevjc.fsf@gitster.g>

On Fri, Dec 13, 2024 at 07:17:59PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Feeding just blob ids has a big drawback: we don't have any context! So
> > you get bogus filenames in the patch, no mode data, and so on.
> 
> And the lack of filenames and the tree object name at the root level
> means you do not get anything out of the attribute subsystem, which
> in turn may affect a few more things.
> 
> Unfortunately the format used in the output from "diff --raw" does
> not capture this.

Don't we just use the working tree .gitattributes by default, and ignore
what's in the endpoints? In a bare repo we wouldn't have that, but I
think the recently added attr.tree and --attr-source options would work
there.

You can't use attributes from multiple trees in a single request, but I
doubt that would be a big drawback.

-Peff
