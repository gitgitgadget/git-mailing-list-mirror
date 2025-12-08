Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB642C2368
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225696; cv=none; b=pjqG7cSqA0MY5G92t44ZgOKm7pLygSL2hQvHWudqV6h1m9qNx4/WJcnurphki+bMugKmIIitGGGoGva2nsvOYnh2qB9JJDGBYr8x7gpP4l3QL11bBVzzcfsANMxh0mbhQQoN+vH7l3OzoKP8W/4sJBC/6b6fARPLtsiw/uyjXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225696; c=relaxed/simple;
	bh=9xokSY3m1tsrjxiX62H1AQ1CPsqz4KPdBcEUyFLjlew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmNyePF/QlBs9XwylikEQakTGfbqcZnL2q01b2lqppSRrxZfmkEfjt8Td7u1iFXflcv7w1TaSRHtdgh5qOy3FGNrkuw3BiM/Axj08OPKnwMWF0hvPr4zxBKr8KoJ85cIuvgZ0d66NnzqgjSWF0xlDv/4VObiz9IjKHDm24xSouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E7hm2W3g; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E7hm2W3g"
Received: (qmail 305683 invoked by uid 109); 8 Dec 2025 20:28:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9xokSY3m1tsrjxiX62H1AQ1CPsqz4KPdBcEUyFLjlew=; b=E7hm2W3gAvY/FUhR0Nv1c9p8Tjbky5G+QNB5RTIWHm9e3EeD27YxEWW///X5jyKfHFTReGe8FY1WtnPYyN/dEOQtzlbALe/wC5htuReTZH4p54Arq33ufWT2aPqro/QOiu11ntlxICaMD3lXG+P2POlRk88JSh3va04f2FD/G/M5rJFj0eM8LA2GoPEwNlHNFujhzG4irP8WucMhuCKSFo4s9DG7v6jCJ2HkE3DZEaXgg4x0w9PEwrNkMuH44+DUuACUw4BAAOYANshzhGpYq++5qdL+WeN0qsqdLBr5+Sjum8tavf+HyJ//k1tTLLJa+zpewV/T3z3YLZ8W4E6hyQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Dec 2025 20:28:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 389976 invoked by uid 111); 8 Dec 2025 20:28:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Dec 2025 15:28:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Dec 2025 15:28:12 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251208202812.GC216526@coredump.intra.peff.net>
References: <20251206002014.2066644-1-aplattner@nvidia.com>
 <20251206020648.GB1714099@coredump.intra.peff.net>
 <51c866cb-9a7a-4c59-834a-2f710f34f3a1@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51c866cb-9a7a-4c59-834a-2f710f34f3a1@nvidia.com>

On Sat, Dec 06, 2025 at 11:40:01AM -0800, Aaron Plattner wrote:

> I was rewriting the commit message for that part to justify why it's safe to
> use PARSE_OBJECT_SKIP_HASH_CHECK, and now I'm questioning it. :)
> 
> It definitely seems fine for blobs but if what we're trying to check for is
> on-disk corruption, maybe it's not a good idea to skip it for other objects
> since we're actually using their contents here.
> 
> I still think the OBJ_NONE fix is worthwhile and I'll send that out
> separately, but maybe it would be a good idea to split
> PARSE_OBJECT_SKIP_HASH_CHECK into separate flags for blobs vs. all objects?
> Or just go back to v1 of the add_promisor_object() patch? Or do you think
> this version is okay despite that concern?

I think it's OK to skip the hashes here. In some code paths we really
care about checking the consistency of the objects (like "rev-list
--verify", or fsck). But if the caller knows that we are not trying to
do that, then that opens the doors to other optimizations like avoiding
object loads entirely.

You could argue that if we _do_ load an object, we might as well hash it
to check its consistency. IMHO there is not much value in that, as the
cost is not totally trivial, it's not a thorough validation of what's on
disk (because we are skipping some objects), and this sort of
bit-flipping corruption is pretty rare in the first place.

So to my mind, there are really two types of callers that want to parse
an object: ones that are verifying database consistency and want to be
thorough, and ones that want things to be as fast as possible. And I
think the caller here (traversing the promisor objects) is in the latter
camp. E.g., if we ever added a secondary index of "these are all the
promised objects we don't have" we would just use that!

So really, I think all I was suggesting for the commit message is to say
"this is the kind of caller that wants things to be as fast as possible". ;)

The ideal series to me is probably:

  - patch 1 fixes the OBJ_NONE issues. It would be great if there was
    some way to show the impact of this bug on an existing case, but I
    imagine it would be quite hard. We'd never produce the wrong answer
    but just do things slowly. So you'd need a case where we end up with
    OBJ_NONE, and then a SKIP_HASH code path that loads a big blob. It's
    easy to find the latter (just hand rev-list a blob on the command
    line), but the former is harder. I doubt it's worth the effort to
    dig for one, since we know your case in patch 2 will demonstrate it.

  - patch 2 uses SKIP_HASH

-Peff
