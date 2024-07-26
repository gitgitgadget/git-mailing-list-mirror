Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F4249E5
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721969047; cv=none; b=nKFm3/h61TifW/kqjEKYSqu5zZVbNayy2AeGVQ/bEkft14m9EmrGX+gANSYri8mOHV7FilnNo8XoBwcpNaxDTZVxV7DGNvmSsNNsgkT+n3GJlq1MPWuzg5jnjt3+2UjPA2k+JFTa9ge7JSRy62LRTtj9LuLStrZwwD+xhXBHZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721969047; c=relaxed/simple;
	bh=ymvyW3S3k6f8QImh4YbNk5d+hZb0ShGQekWzbO+WX9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLBTB0y52dRVCjSwNK/R2dQwYTo/tImHJtGXWQK+8Qzqz1Tkx846WfdCD4ry6g/zLzZqBY9Qrk4dyfwbLaTHtiOWK0Pht1q88RtxaHO9M+0g+LiNcwZzy0GSeJ8KUgtS3MEOBmW4j5HTtOrZLgjrTjg8rWaGEhr2Z6PoexgNU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16013 invoked by uid 109); 26 Jul 2024 04:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 04:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30616 invoked by uid 111); 26 Jul 2024 04:44:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2024 00:44:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jul 2024 00:44:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] mailmap: plug memory leak in read_mailmap_blob()
Message-ID: <20240726044403.GB642208@coredump.intra.peff.net>
References: <xmqqcyn112xi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyn112xi.fsf@gitster.g>

On Thu, Jul 25, 2024 at 04:12:41PM -0700, Junio C Hamano wrote:

> When a named object to read mailmap from is not a blob, the code
> correctly errors out, but it forgot to free the object data before
> doing so.
> [..]
> -	if (type != OBJ_BLOB)
> +	if (type != OBJ_BLOB) {
> +		free(buf);
>  		return error("mailmap is not a blob: %s", name);
> +	}

Looks obviously correct. This one is almost certainly my fault.

-Peff
