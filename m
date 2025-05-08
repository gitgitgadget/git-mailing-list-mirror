Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44F1946A0
	for <git@vger.kernel.org>; Thu,  8 May 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734865; cv=none; b=Mqb+2pS/OYHZPbOSRJpg5RRFBHobA8HBDQK9GdCdafiBb9pF5ZRwNAfJO1IkgZc2tBQUclZcv0zZVyOfvmun6DDqYjcfOgyr6pqWargrk0fgszaB17oEQqXRpf3wsKtqFdm8HqdaOYd0jk9z1m6YnMnzXjc66f2BfAjU3pfaKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734865; c=relaxed/simple;
	bh=Fquz0AENcOIgaY3vJa3m2pGPvypyKxUgON9zvHFt1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8b6L207uGKnBWthVMoMFxUfHDfC+OvS0B8H26Hc2+p3J4EYUQ3DytfhXGG1h7ac4+Ttha+B16vDf6ECWxdEHqX408BD1OaE2k68sx+G2rFklaCQFb+xrcw95mbWJtnB4vIr5G27dtdMCl8u6MvT0w50OzcC3uyUqVftACXogSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CoNuGEaE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CoNuGEaE"
Received: (qmail 29193 invoked by uid 109); 8 May 2025 20:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Fquz0AENcOIgaY3vJa3m2pGPvypyKxUgON9zvHFt1C4=; b=CoNuGEaEI99YuZVzKvytaQ0W2rSQ1DvSQLZxnhS/GC1Iv+jQI/V4EQFOYDid0QHXO9+uf1R5NZ2AeEJ8I31bUMa7HXH/xUqxN2pBxUQbA1YcWV6p/PiPBNphoiqnL8J790bVjnka/rF3sYUM/M+9psnzOKtIQJrLENob/Z6dPGP9iaXZOWv4peqv8OEEcl30DpFLbai09Tu24KLaLl5QCBx36cC953LOGbpkO5UlDnF/04b+/bOqZ/p9YUPwYMtAsHIlzmkcidXDM3p4s0BmvlK+cx/tut7I3JLPcXXh7d3QkusnpRbWhQv+i0/nudIzdAOA6Uud6c3JjVVXjcwIQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 20:07:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20061 invoked by uid 111); 8 May 2025 20:07:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 16:07:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 16:07:41 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <20250508200741.GB18229@coredump.intra.peff.net>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0C8gdBecq5f8U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBt0C8gdBecq5f8U@ArchLinux>

On Wed, May 07, 2025 at 10:54:03PM +0800, shejialuo wrote:

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index ae6b6845a6..ff744f1d4c 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -2079,7 +2079,7 @@ static int packed_fsck(struct ref_store *ref_store,
>  {
>  	struct packed_ref_store *refs = packed_downcast(ref_store,
>  							REF_STORE_READ, "fsck");
> -	struct strbuf packed_ref_content = STRBUF_INIT;
> +	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));

Minor, but is there any reason to allocate this here and not just:

  struct snapshot snapshot = { 0 };

?

> @@ -2126,21 +2126,23 @@ static int packed_fsck(struct ref_store *ref_store,
>  	if (!st.st_size)
>  		goto cleanup;
>  
> -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> -		ret = error_errno(_("unable to read '%s'"), refs->path);
> +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
>  		goto cleanup;
> -	}

Looking at allocate_snapshot_buffer(), it will return 0 only when the
file is empty (and thus there is nothing to allocate) and will
otherwise die(). So we do not need to report any error when it fails.
Good.

But that makes the "!st.st_size" check in the context redundant, doesn't
it? It can just go away.

> -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
> -				      packed_ref_content.buf + packed_ref_content.len);
> +	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
> +		munmap_temporary_snapshot(snapshot);
> +
> +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
> +				      snapshot->eof);

Why are we unmapping here before we use the content? That will create an
allocated in-memory copy of the mmap'd content. I thought the whole
point here was to avoid doing so.

It does shorten the amount of time we hold the temporary mmap in place,
but I don't think we care about that here. The whole point of
MMAP_TEMPORARY is that we usually hold the packed-refs file open across
many requests, and on some platforms (like Windows) we don't want to do
that. But in this code path we plan to mmap, do our verification, and
then drop the snapshot. So we're always "temporary" anyway.

I.e., I'd have expected this code to allocate_snapshot_buffer(), do its
checks, and then call clear_snapshot_buffer().

-Peff
