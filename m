Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EA2139C6
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735531; cv=none; b=qnJNOC4iTHUiETRDz9Wv4TaHXqKG2GoGx3XAM+JkIF5llaU2SxBrgSiTekutgyHgcYHk1aeZkl53VUM/eFn1FZaCnufT4YMeTsB40pSx2HgWH4bggvgFwYkRX/XYCbvjQ9By1aumlxP22N5cO0D+4Syr2bSgsh4XVLi6B+XA/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735531; c=relaxed/simple;
	bh=K/jEMhMgz27EwEiGnvIHAl8rfsyD+v68c9CL8XmkAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+DZcr8wPKgK9eftutMMxG/XXrTlsZBYjjjLtYiG4I9C9ssqOzbXS1KTpO1vyxu7tpaFKVF8oEOhICj4b9FMCCkgsULeBI+XoOBGnVHLLY1YJJjEt/rbmJHQhxAGVT6IoXsoEnk1geH++CCPH52JDFGViQWnIKpCYxTZ9CswI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1348 invoked by uid 109); 18 Jun 2024 18:31:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Jun 2024 18:31:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13363 invoked by uid 111); 18 Jun 2024 18:31:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Jun 2024 14:31:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Jun 2024 14:31:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Non-blob .gitmodules and .gitattributes
Message-ID: <20240618183156.GB178291@coredump.intra.peff.net>
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
 <xmqqbk43ilk3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbk43ilk3.fsf@gitster.g>

On Fri, Jun 14, 2024 at 08:35:56AM -0700, Junio C Hamano wrote:

> My knee-jerk reaction is that we probably can safely loosen by
> ignoring non-blob .gitWHATEVER files, but security-minded folks may
> be able to come up with some plausible attack scenarios if we did
> so.
> 
> Comments from those who have worked on transfer time and runtime
> checks on these are highly appreciated.

I can't think of an immediate problem security-wise, since we know that
Git won't actually read the trees. In fact, I was a little surprised
that normal Git commands outside of fsck did not run into problems with
a .gitattributes directory. What happens on Linux, at least, is that we
try to fopen() the directory, which works, and then read() returns
EISDIR. But because we do so through strbuf_getline(), it just looks
like EOF and we don't complain.  Arguably that code (and all the other
loops like it) should check ferror() and complain.

But I'd also suspect that other non-POSIX platforms would see the error
at open(), and _would_ actually produce an error message. I seem to
recall running into this before with Windows, maybe?

So even if we loosened fsck, I'm not sure if it's something we want to
support. And of course my bigger question is: why? These are reserved
names that have special meaning to Git. Sticking stuff that Git doesn't
understand and may produce errors for seems odd.

> Having said that, the checks for .gitmodules and .gitattributes in
> fsck.c first collect objects that tree entries with these names
> point at into oidsets (this all happens in fsck.c:fsck_tree()), but
> the actual check for these found objects are done only when they are
> blobs.  Only when we encounter a blob object, these oidsets are
> looked at in fsck.c:fsck_blob(), and if it is .gitmodules its
> contents inspected (and may result in a warning or an error).  So
> the "checks" Alexey reports may not be in the runtime or transfer
> time checks done in fsck but something else.  I dunno.

The fsck checks will kick in. When we fsck the containing tree, we learn
that some oid X is a .gitmodules file, and queue that. The hope is that
later we're fsck-ing X anyway, and we get to validate for free-ish. But
if we _don't_ see it (either we checked the blob before the tree, or
perhaps the blob is not even part of the set of objects we're checking),
then at the end we validate any queued items that are left.

We have to do it this way to catch the case of somebody pushing up blob
X in one push (perhaps with the name "foo"), and then doing a second
push that references it with a new name (i.e., renaming "foo" to
".gitmodules").

-Peff
