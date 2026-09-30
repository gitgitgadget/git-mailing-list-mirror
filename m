Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B746D0A6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808377; cv=none; b=CRDkbKFUMpBy1VOaimKM+J6kBrEeOFwwt27cpX89D1UNJBzR7t2raifo65MuIh9fboI0C1e8Ic2RRmjTCPpwZyuIgvTS62Oy1cm8ybQbLgNHNqD/zdfXAWyjFQ2HMR3JMQaOZoxMmF7gx8nhxyVgnSQX2jfIqmGN8FqzUSDD2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808377; c=relaxed/simple;
	bh=sUpd7YK+NmaZS1DytOTGBEk2plsvkNAO9GHnlVFs8Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKsta28FtDratwplJd1W0UuTCikJzFmivZIKpRy+luqG8TgiRQZ3ofQTX+6iIYeTLYjO2PvZsnjRNcxNBVZs7IgXJqFrX7NZPEzRvdYR28uWORDE87pPrW4O7bwbr7js85gA89wnU9IxENeQXsi4lQ89pKqCe1CLh49zjUJ3Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RwOoyKa9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RwOoyKa9"
Received: (qmail 7947 invoked by uid 106); 30 Sep 2026 22:46:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sUpd7YK+NmaZS1DytOTGBEk2plsvkNAO9GHnlVFs8Ks=; b=RwOoyKa9fe8MRYmBm170Q/9LURBU6eZ8p8IMe4qUQi29XLv5QZS10+jutaqIKMmJiKgpgEhq1xeDH1TG0TaO7fhns3XEmoDrTAg21F1RiUmuxM9hQzZAZHdw1meMBP9Ikbtu0qSyCm5IoqU2f5w0chYhnbV8NzuZbPBuau8wyVBqBco5jxJM9NryD+JZOGQJWzVXZdMKZ1LJqm36CmPdLE2qq2YSqviSNfwDvI/GBfbGdUdyJFqIMW+wv5Rzaoh2TMPwRBsh4JR5xJM8O6z4rr21+ANbS/zSUho8kNjnhkgGM51HlAsz9U6ctgxMEXe7HzsS/2W2QkumiwFSd1W85A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 22:46:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20065 invoked by uid 111); 30 Sep 2026 22:46:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 18:46:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 18:46:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
Message-ID: <20260930224613.GA765052@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065239.GB1697497@coredump.intra.peff.net>
 <ar0roZKCwALv0n_A@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar0roZKCwALv0n_A@pks.im>

On Wed, Sep 30, 2026 at 05:32:49PM +0200, Patrick Steinhardt wrote:

> > Let's use mmfile_t for both cases and drop mmbuffer_t. The latter is
> > probably a more descriptive name, but we have many more uses of
> > mmfile_t (and helpers like read_mmfile). So let's consolidate using that
> > name; we can always change it to something more sensible later.
> 
> Yeah, that was my initial reaction, too. `mmbuffer_t` is indeed a better
> name as `mmfile_t` indicates that it's coming from... well, a file. And
> that's not necessarily true.
> 
> I do wonder whether we should just aim for gradual improvement and use
> `mmbuffer_t` regardless or even shoot for something altogether different
> like `struct xdiff_buf` and then simply not mind the fact that we're
> being inconsistent. That would at least be an initial step into a better
> direction in my opinion, and we can then touch up things over some time.
> 
> But I won't insist on any change like that, I'm okay with keeping
> `mmfile_t`.

I'd really prefer to punt on it for now, just because the diff would be
_so_ big, and has so many extra rabbit holes (e.g., should "mmfile_t
*mf" get a new variable name?).

-Peff
