Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D528B4EE
	for <git@vger.kernel.org>; Thu,  8 May 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734238; cv=none; b=pYxgnwcNvPPs8KbaFCBI7rfyE67CqThT+5hNtNAqzdZzBouPv45UUeZ8YjRCnZdKk/WxDn7wM7UnxFgTvBdoHRvAmSQRzDiHOV7KXHZ1pNjXfWtBHDEoeyF3wam6YayBvSkLR72vUghSMhViMVsxcGGBjoRj56PeR5urMNxLE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734238; c=relaxed/simple;
	bh=+SqbCtsqBbPurfRpfwgmDxB2m+6Ho348iC48APldAfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtKKOfyRj22Dyxj4oQQ5tnK49G7xA1FIaCYdaXToVsbGNOtvKZiMVl/culyaEgNLQq33ImtD+jk1dqTxGQrCYFDX1CRlgS/RNWcAt0PJxEv+jwTFHKJi0Q7Z04bfzYox674byIDUdz57WCOMYGfQdcNC034ijKagLBCxCWbMcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CoBQTfCw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CoBQTfCw"
Received: (qmail 29097 invoked by uid 109); 8 May 2025 19:57:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+SqbCtsqBbPurfRpfwgmDxB2m+6Ho348iC48APldAfQ=; b=CoBQTfCwaLqOmKUmFUwxPWlHH8faa1k2bBNMtLXbXkvRtk85FnFSFg1Mm68GCvjlQlUCJEiDmvNBkRU7uk0AgprmHE9bWHqMk9jB6NKytM5WJbP6wTI6Pp7G14LHHc/n21/Ot0oAjlbcPdDWO0W1qW5J9yUmGoqZQ7kD979Ptkt8cTl/aXbTm146AQtgf6AJkH7EOM4JYE6dJb/ImvP052tLoR6yCNLcdlKGz4IndqzVQ/lScyuAZ2xICkp8wV6ywYmy6Xzhpqp27ZP74gomLbRdgRmuyBc2dJS5Q8PB3a9KxciowHEgOUgEEPzunxNqrS+nc7lP88cxjoRoGPSkaw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 May 2025 19:57:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19924 invoked by uid 111); 8 May 2025 19:57:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 May 2025 15:57:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 8 May 2025 15:57:14 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
Message-ID: <20250508195714.GA18229@coredump.intra.peff.net>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0BDTuOfUuCHE4@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBt0BDTuOfUuCHE4@ArchLinux>

On Wed, May 07, 2025 at 10:53:56PM +0800, shejialuo wrote:

> @@ -761,19 +782,8 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
>  		verify_buffer_safe(snapshot);
>  	}
>  
> -	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
> -		/*
> -		 * We don't want to leave the file mmapped, so we are
> -		 * forced to make a copy now:
> -		 */
> -		size_t size = snapshot->eof - snapshot->start;
> -		char *buf_copy = xmalloc(size);
> -
> -		memcpy(buf_copy, snapshot->start, size);
> -		clear_snapshot_buffer(snapshot);
> -		snapshot->buf = snapshot->start = buf_copy;
> -		snapshot->eof = buf_copy + size;
> -	}
> +	if (mmap_strategy == MMAP_TEMPORARY && snapshot->mmapped)
> +		munmap_temporary_snapshot(snapshot);

The original triggers this conditional whenever the strategy is not
MMAP_OK (so MMAP_TEMPORARY or MMAP_NONE). But in your post-image, we do
so only for MMAP_TEMPORARY.

I can guess that the two end up the same, because snapshot->mmapped
would never be set when MMAP_NONE is set. But if we are going to make
such a logical inference, it should be explained in the commit message
(though my preference is to leave the code as-is, or to pull the
refactor into its own commit).

-Peff
