Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C539435EF2
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726557; cv=none; b=TEqwDMFY9YWMASmXF0bpLayKdq0VmRw0H/Zp4moDYjzT3BNjy/m6K9mA6IWqsuKytoB1W7sPJrcVX89OzhJ+uwKNK/GbzS35+sVNIAkTc1ea5GQMvspwnEQ+88kGvahnw92x5uZab8mYiWAN/JV3a8CniU+53AukdnOGUf2N/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726557; c=relaxed/simple;
	bh=0Wdjl64YEUO9dL6z/kh7VxZBMoSKCyEx7Sx1aip71Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7AcBK8kS0sZrNnYnuiHatfKtpd4uuzwlHlTj4vou48+ApbtDVFgncqzs8XhkMmRQKFnJHX7po1cSigUCAGN7tYudkAGm+FrHj+Xae1xCZ9wxQJeaRgl9hSA6qTCHNuWVzqBd+2EibzKrng3EAfykILz0f+lHHcXeuyvyzPpb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hxTbRZyX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hxTbRZyX"
Received: (qmail 60668 invoked by uid 106); 14 Aug 2026 16:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0Wdjl64YEUO9dL6z/kh7VxZBMoSKCyEx7Sx1aip71Uw=; b=hxTbRZyXjaMU4v0X9pknuxDwh9nygPBiS61R9BW9oxBLIWiu4N7DU0HnLRILyH+u/xDJE09JsJhI5DMAJqqWxAPTp3m3vjM5HRy8EFYdUSgcE3ogZIX16T2DKBYbztxTUSwD1n1uOnJv2+USGHIrfLmgh+Ens1EcMJsv47cE53dpTwJR7SHUA07WIm9Eo4mSU01eH2nsGdolSO7mPHsNVB4W7Plnw8UsKJK9jpQDYbSdXmx3vGcoivfCyHE0JZtlhewQmVvRKAAy3mnzuA76nz8Hf3At/BUITEiwCnkGAqKo2wbuonydELDC7kkOXQY+4T+H7mmF9ssJQHRn7oMfjg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2026 16:55:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58948 invoked by uid 111); 14 Aug 2026 16:55:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2026 12:55:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Aug 2026 12:55:46 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <20260814165546.GA2563235@coredump.intra.peff.net>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <20260813161525.GB1386479@coredump.intra.peff.net>
 <an7IhgES-reCzQMr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an7IhgES-reCzQMr@pks.im>

On Fri, Aug 14, 2026 at 09:49:26AM +0200, Patrick Steinhardt wrote:

> On Thu, Aug 13, 2026 at 12:15:25PM -0400, Jeff King wrote:
> > On Thu, Aug 13, 2026 at 09:35:49AM +0200, Patrick Steinhardt wrote:
> > 
> > > An alternative would be to use a hashmap here that tracks the packs that
> > > have already been added. It has the advantage that it also covers the
> > > `prepend()` operation and that callers don't have to be aware of this
> > > mechanism at all. Furthermore, moving preexisting entries to the back or
> > > front could become O(logn) if the list was doubly-linked. We do this
> > > operation quite often to re-sort entries in the list when looking up
> > > objects.
> > 
> > Don't we already use such a hashmap via packfile_store_add_pack() and
> > packfile_store_load_pack()? That comes from ec48540fe8 (packfile.c:
> > speed up loading lots of packfiles, 2019-11-27) and is how we know that
> > this "is_new" flag is true (otherwise we'd get duplicates during
> > "reprepare" operations).
> 
> That's a good point, we indeed do! Maybe it would make sense then to
> remove that map from the packfile store and instead move it into the
> packfile list to make it more generally useful.

The map protects more than just adding to the list; it avoids all of
add_packed_git(), which allocates and does a bunch of stat() calls.  So
it couldn't just be a check in packfile_list_append(), but would have to
be a separate existence check well before that.

That's not impossible, but it would be a lot easier to see what
generalized pattern would be most useful if there were more than one
caller of packfile_list_append(). ;)

-Peff
