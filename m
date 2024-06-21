Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B517B4FA
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998944; cv=none; b=iO9BxDJfG/CGb0bjcDXgZGsgT2XUIfHZ8Xcdsom4/vzAIdMOFzIl9+hi+ir4SqRryknd/DE2wWqvqJBEeRXwl8mmgl040QZRAjNfb5vLvzqG2PutWTQMDoG5Y/ZiY8Clrv7z9Hy4w9aSvSI9ILIPOgU+u8Bz1ebP1MFWSdzwYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998944; c=relaxed/simple;
	bh=Y1kBirLmXc3j2YuiXKRxppVOLudAGVIpScbQEWBKYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HulpXW+SKKRWRu+Lb7GG8v2np2JrEd3qqyhY6ij/HYP1fsXS6WLgmyX9KPKu2qjrgbZg7ZvPxH9cTDkFoKeEMpVOBFQprUnzd3LRyFNPjaAkUlKpfsvLKIrhHGCDEqWaXa+OFlYX7o8j0eWP9CiWlE9rD3W519XARTwcb4SEu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=hW+a5SYi; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="hW+a5SYi"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8381F7BE;
	Fri, 21 Jun 2024 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718998942;
	bh=Y1kBirLmXc3j2YuiXKRxppVOLudAGVIpScbQEWBKYQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hW+a5SYig5Ml7P24KwEuRro9IKTwDCSr2tYT34M5eBZNEiZqrbewYmpFQovWU1cEW
	 w5+R39XEmtMpvGiLGiU6aThHuEAqo26FgIZtrHgjHcvah/Oh45TWW/6Bn6hM0pe0/t
	 uBhZmFQMJ7s/fBqgcLXR5hxTFFySdRuY+IFSElPE=
Date: Fri, 21 Jun 2024 19:42:21 +0000
From: Eric Wong <e@80x24.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cat-file: reduce write calls for unfiltered blobs
Message-ID: <20240621194221.M879537@dcvr>
References: <20240621020457.1081233-1-e@80x24.org>
 <20240621062915.GA2105230@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621062915.GA2105230@coredump.intra.peff.net>

Jeff King <peff@peff.net> wrote:
> On Fri, Jun 21, 2024 at 02:04:57AM +0000, Eric Wong wrote:
> 
> > While the --buffer switch is useful for non-interactive batch use,
> > buffering doesn't work with processes using request-response loops since
> > idle times are unpredictable between requests.
> > 
> > For unfiltered blobs, our streaming interface now appends the initial
> > blob data directly into the scratch buffer used for object info.
> > Furthermore, the final blob chunk can hold the output delimiter before
> > making the final write(2).
> 
> So we're basically saving one write() per object. I'm not that surprised
> you didn't see a huge time improvement. I'd think most of the effort is
> spend zlib decompressing the object contents.

3 writes down to 1 for small objects, actually: header + blob + delimiter

I was mainly annoyed to strace my reader process and find 3 reads,
or even more for non-blocking sockets, worst case (after initial
wakeup via epoll_wait) is:

  read, read (EAGAIN), poll, read, read (EAGAIN), poll, read

But yeah, scheduler behavior is unpredictable on complex modern
systems.

> > +
> > +/*
> > + * stdio buffering requires extra data copies, using strbuf
> > + * allows us to read_istream directly into a scratch buffer
> > + */
> > +int stream_blob_to_strbuf_fd(int fd, struct strbuf *sb,
> > +				const struct object_id *oid)
> > +{
> 
> This is a pretty convoluted interface. Did you measure that avoiding
> stdio actually provides a noticeable improvement?

Yeah, I didn't get any improvements with stdio I could measure;
but my measurements included AGPL Perl code on the reader side.

> This function seems to mostly duplicate stream_blob_to_fd(). If we do
> want to go this route, it feels like we should be able to implement the
> existing function in terms of this one, just by passing in an empty
> strbuf?

I didn't want to stuff too much into the loop given the hole
seeking optimization logic for regular files in
stream_blob_to_fd.

> All that said, I think there's another approach that will yield much
> bigger rewards. The call to _get_ the object-info line is separate from
> the streaming code. So we end up finding and accessing each object
> twice, which is wasteful, especially since most objects aren't big
> enough that streaming is useful.

Yeah, I noticed that and got confused, actually.

> If we could instead tell oid_object_info_extended() to just pass back
> the content when it's not huge, we could output it directly. I have a
> patch that does this. You can fetch it from https://github.com/peff/git,
> on the branch jk/object-info-round-trip. It drops the time to run
> "cat-file --batch-all-objects --unordered --batch" on git.git from ~7.1s
> to ~6.1s on my machine.

Cool, I'll look into it and probably combining the approaches.
Optimizations often have a snowballing effect :)

> But anyway, that's a much bigger improvement than what you've got here.
> It does still require two write() calls, since you'll get the object
> contents as a separate buffer. But it might be possible to teach
> object_oid_info_extended() to write into a buffer of your choice (so you
> could reserve some space at the front to format the metadata into, and
> likewise you could reuse the buffer to avoid malloc/free for each).

Yeah, that sounds like a good idea.

> I don't know that I'll have time to revisit it in the near future, but
> if you like the direction feel free to take a look at the patch and see
> if you can clean it up. (It was written years ago, but I rebase my
> topics forward regularly and merge them into a daily driver, so it
> should be in good working order).

Thanks.  I'll try to take a look at it soon.
