Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488434D3AE
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293898; cv=none; b=apCItvqZ88IHbXrZnjyBFt0bPClte+D2Ge9Ebofpkn0eSJAMSPC4u6cO6RBn6NTl+ZbE3EcnKWmS2bFQysFM5SS0E3rDviEJx51n5DQd9cxpPy7r04sElp4ifcIqTn2KBeM6Air2gvPIU7iQYDOtK/btIz8CN1TTNN32yGIL1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293898; c=relaxed/simple;
	bh=ZQZXV8qSYTmpSqpIsy+F3sQgRU4TwgkPDbWtp7tzZAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hclORnBq1Sld9c4SncNe0pXAaN85uB37fD/EOibGCA5FeKvRLdvRKXVxslTrwGYx32p2nI5f5I6n8aoY8d8HltqjkT7POUIBPOTDPK83hpEjsDhd7nVLPynkDxUAJThWfCJ4dat/FpCPIuS98M8Qz19niwpnd7ODGG8uiX0h/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NxmAhD1t; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NxmAhD1t"
Received: (qmail 431273 invoked by uid 109); 4 Nov 2025 22:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZQZXV8qSYTmpSqpIsy+F3sQgRU4TwgkPDbWtp7tzZAs=; b=NxmAhD1tKt1Rpl5zwO7wp/5+Aln4cWam4Bq5GveCqKxIC6Zl+O9QLv0WPiHb2HuxJ57+SwI2tTAp7ojZA1WXoeP1y7L1fszqQUlfOBahynxaW5XSCXxCwYR74y/vFm910KARgSBCiQDNh3yCELsfsr82Mg/8E4bWgQ8x5JIRcoLsN8U4pzmz2n+VyH5G+8iKfGDKMJKneSg941LQshIBADBsWvzAKTeRyMN1Yz269AIhLOyRKsR6o+QDF7tbH3NFF19HBgxNBz5rbK8fVcpACgt4ij2kZTxsz4DeclITaDKntIWFasiS4COZgNwfN0HQH2G0B/KQZkweJKyboV9adg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Nov 2025 22:04:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 678023 invoked by uid 111); 4 Nov 2025 22:04:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Nov 2025 17:04:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Nov 2025 17:04:54 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
Message-ID: <20251104220454.GC2618884@coredump.intra.peff.net>
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
 <xmqqpl9xps3x.fsf@gitster.g>
 <20251104211130.GA2618884@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104211130.GA2618884@coredump.intra.peff.net>

On Tue, Nov 04, 2025 at 04:11:30PM -0500, Jeff King wrote:

> I actually wonder if there is any other placeholder that benefits at
> all. The ref-filter code already tries to avoid doing unneeded work. The
> most obvious there is not loading the object at all, which is why stuff
> like "%(refname) %(objectname)" is faster than adding in %(raw), which
> needs the object contents (but no parsing). And likewise stuff like
> %(tag) needs parsing, and thus also triggers loading the object.
> 
> So 054f5f457e helps formats which require the object contents but _not_
> parsing. I can't think of another placeholder besides %(raw) which would
> benefit from that.

BTW, the one other oddity I aw while looking at this is %(describe). It
asks for SOURCE_OBJ, which causes ref-filter to load the object. But we
don't need it! We're just going to call out to git-describe.

But just changing that SOURCE_ flag is not enough, since we call
grab_describe_values() from deep inside grab_values(), which we do after
getting the object content. We'd have to move that call further up, but
taking care to handle both deref=0 and deref=1 cases. Or maybe not? Does
git-describe always return the same answer when describing a tag versus
what it points to? In which case it should be more like how the
AHEAD_BEHIND atom works.

At any rate, I was sufficiently grossed out by the ref-filter code that
I stopped poking at it. Loading the objects is an unnecessary
inefficiency, but compared to spawning a separate git-describe process,
it is probably peanuts. So somebody who cares more can dig further if
they want.

-Peff
