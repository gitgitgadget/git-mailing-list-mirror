Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A01B86FE
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960223; cv=none; b=qNsrFg08/5nbDzDFa351i/vKkVtstkRVv8dfCQn3S6FoBZc5tDJ1TvixDes4bmQM2NbPSblznOTiBYx0lUWesqwUm+inAbLggNyMH348ZDcU5WYlMF8ljALmrgko3lalYmkLqRQwsjXEb106PF7zAs9cmI7f1x+ZU2gxds3ar+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960223; c=relaxed/simple;
	bh=wfqRtbgOwlTc9nGB7CaG955LmxhV3XgoRzOVqw3+N+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA2zyU3jY0uxsF9JeM5b1ywinAajjug2+1DPm6f6wg56x/LFDf4nM0nolcRDlkvDHYLq7r+Kfse8jwPqN+IKkVuHIYOQ92n/LEcbNQ3pVrwpetepA3dn/vtwKRMPLPw57K7krwAgFVRfGOX/7HnzSr8hmPS60eQJdRa6CqzdHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5851 invoked by uid 109); 29 Aug 2024 19:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 19:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9945 invoked by uid 111); 29 Aug 2024 19:37:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 15:37:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 15:36:59 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] pack-bitmap: initialize `bitmap_writer_init()` with
 packing_data
Message-ID: <20240829193659.GB423429@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
 <9d322fc5399c453913d08f35eee907b5c909ad6b.1723743050.git.me@ttaylorr.com>
 <20240817103155.GA551779@coredump.intra.peff.net>
 <ZtDFRYQRLQoe+CHS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtDFRYQRLQoe+CHS@nand.local>

On Thu, Aug 29, 2024 at 03:00:21PM -0400, Taylor Blau wrote:

> > Even the midx code, which is not generating a pack, uses a "fake"
> > packing_data as the way to express that (because inherently the bit
> > ordering is all coming from the pack-index nature). If we likewise ever
> > wrote code to generate bitmaps from an existing pack, it would probably
> > use packing_data, too. :)
> 
> I agree for the most part, though there is a lot of weight in
> packing_data that would be nice to not have to carry around. I know
> within GitHub's infrastructure we sometimes OOM kill invocations of "git
> multi-pack-index write --bitmap" because of the memory overhead (a lot
> of which is dominated by the actual traversal and bitmap generation, but
> a lot that comes from just the per-object overhead).
> 
> I've thought about alternative structures that might be a little more
> memory efficient, but it's never gotten to the top of my list.

True. What the index and bitmap steps really want is not an array of
object_entry, but an array of pack_idx_entry (which is the first
component of an object_entry).

I wonder how feasible it would be to simply hold two arrays with
corresponding entries at each index. Many places only care about one or
the other. But for places that do care about both, especially ones that
receive a pointer to an individual object_entry, they'd need to receive
pointers to both.

I briefly looked at the compile errors that come from making such a
change. Many of them look trivial, but I think some of them get weird
(the ext_bases array is also holding object_entry structs). So maybe
worth pursuing in the long run, but not something to knock out this
afternoon.

-Peff
