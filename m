Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0A1862
	for <git@vger.kernel.org>; Sat, 25 May 2024 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716606919; cv=none; b=S/KVumPNmovLyDV+C0wHxEkU7Eow7tTStTSP8I8ctnfPHPCzjKchIj71v2S0vl+dt1PYTUYeKUHyKLIfq2mftbOnLdyzicWX7M5WRhM9nrQiiNHSNoPzMxsjrq71wAg30DFVirGfeS4nJDbICSvl0qTlVQPGCNdNiPTB1ak38fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716606919; c=relaxed/simple;
	bh=tG5LIbi+fKqUcfJ5pvMJYlmYa789Ji6TRk8iN9M3ZIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rhdb0DzzaoWQEj+xaPNK6ZHaUacaZFdA5CRHQW1MpDuCZj3rmvztzDPCz8LtbgdtFxoYUj8CHnL3EIOuBI93RONMQCA0Lfo52c/mCoGjSmCQ/kOzcAU8P8W3mW5vyBuI2WbklpHGbpYjfzWo0uKWn9Zprh+Ppwzg1oALsL9bb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3819 invoked by uid 109); 25 May 2024 03:15:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 03:15:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15314 invoked by uid 111); 25 May 2024 03:15:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 May 2024 23:15:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 May 2024 23:15:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/30] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <20240525031516.GB1889620@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <20240523110532.GA1326297@coredump.intra.peff.net>
 <Zk+hP++s/Pz+yym4@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zk+hP++s/Pz+yym4@nand.local>

On Thu, May 23, 2024 at 04:04:15PM -0400, Taylor Blau wrote:

> On Thu, May 23, 2024 at 07:05:32AM -0400, Jeff King wrote:
> > I wonder if the start of the pseudo-merge section should have a 4-byte
> > version/flags field itself? I don't think that's something we've done
> > before, and maybe it's overkill. I dunno. It's just a lot easier to do
> > now than later.
> 
> I think the tricky thing here would be that the extension itself is a
> variable size, so every version would have to put the "extension size"
> field in the same place.
> 
> Otherwise, an older Git client which doesn't understand a future version
> of the pseudo-merge extension wouldn't know how large the extension is,
> and wouldn't be able to adjust the index_end field appropriately to skip
> over it.
> 
> Of course, we could make it a convention that says "all versions have to
> place the extension size field at the same relative offset", but it
> feels weird to read some of the extension while not understanding the
> whole thing.

Ah, yeah, I didn't think of that. That definitely complicates things.

It certainly would be possible to have a version+size header at the
start. Which is...basically reinventing the chunk format. Let's not
worry about it for now, and as a long-term thing we might consider
moving the bitmap format over to the chunk style.

-Peff
