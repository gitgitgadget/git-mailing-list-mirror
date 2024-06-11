Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BBA145B38
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092943; cv=none; b=DT5XNx1f1kpxfrX/QnBX9j8qaz2oP+SqSEoRL0x296tOrFP0TPZdGA7A2i4nsHK8+03qU2FYIlcmhnSn9EZQ5jKfxkZrrRJ8Rgp+ItUqpL1tzHz2Mqhs78iJpH71zSApKXlDOG4yv3V5c0GENJLZ3izw7lluCellkVleoEBUmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092943; c=relaxed/simple;
	bh=NfOutswsR5/+6gADBoTvpFMs8cIRbVwRCUgN8zp2rzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYiGdI3HMUs27fVElEIfhG2BNSEJlhmeXBW2dIlmJrjJfxE/Nt+1HmrTrPoU4bPW/rR1+q33s3vpQ/z/FopX8ZJdn15sRB8e74AZqChOK11fHJDGrKbc60p6RK51omIVu2CF2tD38ht54ojieFl7AwZYfV7FnO02zNi5LHRy5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18145 invoked by uid 109); 11 Jun 2024 08:02:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 08:02:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24572 invoked by uid 111); 11 Jun 2024 08:02:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 04:02:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 04:02:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <20240611080220.GG3248245@coredump.intra.peff.net>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
 <20240608081855.GA2390433@coredump.intra.peff.net>
 <ZmXKzJ9CpbYTmTwC@nand.local>
 <xmqqmsnuaqus.fsf@gitster.g>
 <ZmYJ+d3+j1E08Ms/@nand.local>
 <ZmYPjuGnh+UvT5dt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmYPjuGnh+UvT5dt@nand.local>

On Sun, Jun 09, 2024 at 04:24:46PM -0400, Taylor Blau wrote:

> But in summary, though I think it is possible for either a client to
> send a broken push to a server (if the client were using MIDX bitmaps
> and only doing single-pack reuse) or for a server to send a broken pack
> to a client (if the server was also using MIDX bitmaps in the same
> fashion), I think that it is exceedingly rare to hit in practice. Which
> is not the same as saying that it is impossible, of course, but I am
> confident with the fix I posted in:
> 
>     https://lore.kernel.org/git/4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com/T/#u
> 
> to fix the issue. Note also that I don't think a repository would be
> able to actually corrupt itself using this bug, since we don't bother
> taking this code path at all during repacks.

Right, I think this is mostly just a vanilla bug. It could cause bogus
packs on fetch, but the clients would realize it. If people aren't
screaming about broken fetches, then it is not happening very often (and
your analysis nicely explains why). But I don't see how it could ever
cause corruption.

Directing the fix to "maint" as you suggest is sensible, but I don't
think it merits any special treatment.

> So in short, I think the fix I posted above should be tracked down to
> 'maint' at least for the 2.45.x series. It will avoid the MSan failures
> and more importantly the issue I described above. I would also like to
> find a way to further test this case so that we aren't bit by such a bug
> in the future.

I don't think we can test the case where the bug would produce a bogus
pack, since that implies guessing the uninitialized data. I guess we
could come up with a case where try_partial_reuse() should say "this is
OK to reuse", but the bogus pack_int_id prevents it. Which implies
looking at the resulting pack and checking that some delta is there that
we expect?

-Peff
