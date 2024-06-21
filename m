Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972A14D2A4
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951369; cv=none; b=Amr4tPntVh+lYz/DsrSbfV1tDqRMm8s5QF1jF7CV+6vxfDkOTRzoB8j7D/H1fa4wRhCkyKpFnjtt+cVsn3O73StG4MzJLkaPZ/lL57UgF0n71ExKsF5T+1l79YDKS/Y3xAiqFS4GxktYAt2rVuFhySaFeZ/7VXg3q9GGPSdTXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951369; c=relaxed/simple;
	bh=r01+/dA7nhxzs7iutnV891uWGEJLl03DQ3aYhkEwu24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4iLrhuBmytggptn8zpqDCdt+/7dsmlz8WzP1t/Pzt4RrTv8E+mwCcEcc4vocYhFQuaFp47S156Tja35brhRVy6Hpcg/RxX2dd6ysGdlFeDyKr7+rV+gOW0RaM3jJGGNOHCirU1UxYWcVJAcynmuPqPU9ZLO696wkXSqwdWLv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25920 invoked by uid 109); 21 Jun 2024 06:29:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Jun 2024 06:29:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6414 invoked by uid 111); 21 Jun 2024 06:29:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Jun 2024 02:29:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Jun 2024 02:29:15 -0400
From: Jeff King <peff@peff.net>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cat-file: reduce write calls for unfiltered blobs
Message-ID: <20240621062915.GA2105230@coredump.intra.peff.net>
References: <20240621020457.1081233-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621020457.1081233-1-e@80x24.org>

On Fri, Jun 21, 2024 at 02:04:57AM +0000, Eric Wong wrote:

> While the --buffer switch is useful for non-interactive batch use,
> buffering doesn't work with processes using request-response loops since
> idle times are unpredictable between requests.
> 
> For unfiltered blobs, our streaming interface now appends the initial
> blob data directly into the scratch buffer used for object info.
> Furthermore, the final blob chunk can hold the output delimiter before
> making the final write(2).

So we're basically saving one write() per object. I'm not that surprised
you didn't see a huge time improvement. I'd think most of the effort is
spend zlib decompressing the object contents.

> +
> +/*
> + * stdio buffering requires extra data copies, using strbuf
> + * allows us to read_istream directly into a scratch buffer
> + */
> +int stream_blob_to_strbuf_fd(int fd, struct strbuf *sb,
> +				const struct object_id *oid)
> +{

This is a pretty convoluted interface. Did you measure that avoiding
stdio actually provides a noticeable improvement?

This function seems to mostly duplicate stream_blob_to_fd(). If we do
want to go this route, it feels like we should be able to implement the
existing function in terms of this one, just by passing in an empty
strbuf?

All that said, I think there's another approach that will yield much
bigger rewards. The call to _get_ the object-info line is separate from
the streaming code. So we end up finding and accessing each object
twice, which is wasteful, especially since most objects aren't big
enough that streaming is useful.

If we could instead tell oid_object_info_extended() to just pass back
the content when it's not huge, we could output it directly. I have a
patch that does this. You can fetch it from https://github.com/peff/git,
on the branch jk/object-info-round-trip. It drops the time to run
"cat-file --batch-all-objects --unordered --batch" on git.git from ~7.1s
to ~6.1s on my machine.

I don't remember all the details of why I didn't polish up the patch. I
think there was some refactoring needed in packed_object_info(), and I
never got around to cleaning it up.

But anyway, that's a much bigger improvement than what you've got here.
It does still require two write() calls, since you'll get the object
contents as a separate buffer. But it might be possible to teach
object_oid_info_extended() to write into a buffer of your choice (so you
could reserve some space at the front to format the metadata into, and
likewise you could reuse the buffer to avoid malloc/free for each).

I don't know that I'll have time to revisit it in the near future, but
if you like the direction feel free to take a look at the patch and see
if you can clean it up. (It was written years ago, but I rebase my
topics forward regularly and merge them into a daily driver, so it
should be in good working order).

-Peff
