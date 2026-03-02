Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F671E22E9
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475626; cv=none; b=rxNijrej4oRkaGb1G0duXUBs8J1el4OrCa1J/XbOwtMgFhUcVj9h62ng+ETDQ/dknhoK1tAVoaiiFBXVxt0Tbbvboh4C7t11dAr3thvpegLgUbcFAi7vVcNGUiLYjyIsWpiuKjv39WC3Pe7a34P5p/KDJddegQyirua9wC7S9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475626; c=relaxed/simple;
	bh=e95EoaisB6pfkxw1qvialRuT8jrOf/SRPDnWapPzlyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnguKqq05uEjaLgeZGA+NKlGI/URCoaXQB5+BFATLvRzrnlok5rdk5+eTjpJVcbAgnn2DVF99M3g5GdzkKeGyDb9KLDEtDPIM3ugi6UJpDlHUjQRxr3nL1ZklZO5r0qf1nBJD0O34mDxaOiS1+3kLS/2mh9eO2aof3K1qedCZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cSNhqCne; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cSNhqCne"
Received: (qmail 29705 invoked by uid 106); 2 Mar 2026 18:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=e95EoaisB6pfkxw1qvialRuT8jrOf/SRPDnWapPzlyc=; b=cSNhqCne9+44UUe6NZpzIdFYmFOec21uyKiIhZw1zRFEAZ0tUZBG6l6cy1RJ24ZHMHk07d/nmBe0h/cIJV25xU6jhYz1022jOZ89sywC9FUQZTMmS7uRNyF3JH6dwmeTSes/6YP5QeIh+8jIchStvR0juvua3TFtjorQG5eY+HFbZ5a10ifPGX5AvykgLQMJfFGSXTKvzRTb9FBBGuJXVAWefb1lKCmPqhI5seAH39NV9gfFuBn0Ahx1xYA8UvxMAPQHy8WULGR79DQDrsbI3i+k0pDJQin8mPo8KNtWVnVVahwDXDhFxCtRWqNCXYm7V+ACgIsAgOqm10fzISWmdA==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:20:24 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 334214 invoked by uid 111); 2 Mar 2026 18:20:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:20:24 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:20:23 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <20260302182023.GG28275@coredump.intra.peff.net>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <20260227193758.GA2931515@coredump.intra.peff.net>
 <aaV-l_NyWpkKDDp6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaV-l_NyWpkKDDp6@pks.im>

On Mon, Mar 02, 2026 at 01:12:07PM +0100, Patrick Steinhardt wrote:

> > Rather than buffering in upload-pack, would it not be simpler to just
> > increase the write size from pack-objects? Then we do not have to worry
> > about disrupting upload-pack's keepalive timeouts. And as a bonus, if
> > you are worried about the system-wide number of calls, you will likewise
> > be reducing the number of read() and write() calls over the pipe between
> > pack-objects and upload-pack.
> 
> We can do that. But we also have to keep in mind that downstream in the
> pipe may be a process that's not even git-pack-objects(1) in the first
> place because of "uploadpack.packObjectsHook". So maybe we should have a
> look at doing both.

True, though I think that whatever is producing gobs of output from that
hook should consider using a buffer size close to a pktline. In many
cases it will be pack-objects itself (just wrapped with some extra
magic), but I guess you may have some kind of caching layer at GitLab
(we did at GitHub).

That is getting specialized enough that I don't feel too bad suggesting
that authors of those tools should consider buffer sizes.

As far as doing both, I'm not sure if it's worth it. My two concerns
are:

  1. It re-opens the question of whether upload-pack might stall waiting
     to fill its buffer and fail to produce keepalives correctly.

  2. I wonder if we could get some weird interactions between the two
     buffer sizes. E.g., if pack-objects sends 50k bytes at a time, but
     upload-pack wants to wait for 51k. So we read 50k then wait for the
     next chunk. Either:

       a. we read 50k again, pull off 13k of it to make a full pktline,
          and then memcpy around the other 37k to await more data.
	  There's a bunch of extra copying as our buffer sizes don't
	  line up.

       b. we read 13k (to fill up the pkt we're trying to send), send
          that, and then the next read gets a partial read(). So we end
	  up issuing more reads, although sometimes pack-objects might
	  catch up and fill the pipe buffer, and we'd get a full packet
	  in one go. But depending on the timing, I wonder if things
	  could get choppy and we'd end up issuing a bunch of extra
	  reads (and possibly extra writes on the pack-objects side if
	  it's waiting on us to create more space in the pipe).

-Peff
