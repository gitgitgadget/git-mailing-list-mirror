Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFF20322
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055299; cv=none; b=KViltkppQw089jMyUMXili28AycmDyCWl/7g5uXsIqxDryZuOmu8MmfUPetn8lrQcvLgnteYgXYAJfNPPQrfRd3F1B4QCMzu120XEezHsGzxAZKn5JyCdU82Qwz5Bx+Ge1EdIpnNAjrGQ8tedDUxYQRGOBzrTD9Of+DaoSY5YKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055299; c=relaxed/simple;
	bh=IjcZ+XZqMWrwxtf8Wq+dkqeKKeqEZyhYjihyufTXjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ0NzkcEhgWMeDz4F9fDY/HUIyn2U75l+n2scf/nK436T3k0cd5PjK3NRSm47dvUrmkyoW/B405pf+NUEAydpnhOb/CFFEODPU5lzMuO+nlzMZOVpNN8xHv2xRNxmHr8SjTQ4YXqvceqN7eIzMhmaJ6cdw3FvhSgNVyUN6Y/0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bwCp36Ez; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bwCp36Ez"
Received: (qmail 1584 invoked by uid 109); 12 May 2025 13:08:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IjcZ+XZqMWrwxtf8Wq+dkqeKKeqEZyhYjihyufTXjFo=; b=bwCp36EzSDyXeQml6GlrmnkMVOadwS4EC5gUvrzZTEavp4DG8wwGxD8lzLybqQknKJQfecZDmDRIm0HElcY72tXb3yCOKRGGQCTGvzG4qXQXi8OTmuklrkGObqrRTgdPG2DJNl5ly8fhpqPrYD7RbGetRSLOSMWry9J8edC2Ep3NW17TciFV4JLTPnHu2L9smGJ0QKXUvVW8McEdKhVhg2VizAV2Ikn6WT+sjlgN3OdJgQ/RXNEJ/iKB5o9t8ndw5vDb5ZUoZKuH5l6kwVWg0ovq7udinKLQGZsKm1zX6VaAmcgaF5TDRB+6Tvh/vP4tAvVZwioHawK/IziJe0Yalw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 May 2025 13:08:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6197 invoked by uid 111); 12 May 2025 13:08:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 May 2025 09:08:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 May 2025 09:08:15 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/3] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <20250512130815.GC1191360@coredump.intra.peff.net>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCt1zJ2yviOz--l@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCCt1zJ2yviOz--l@ArchLinux>

On Sun, May 11, 2025 at 10:01:59PM +0800, shejialuo wrote:

> @@ -2113,24 +2113,19 @@ static int packed_fsck(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>  
> -	if (!st.st_size)
> +	if (!allocate_snapshot_buffer(&snapshot, fd, &st))
>  		goto cleanup;
>  
> -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> -		ret = error_errno(_("unable to read '%s'"), refs->path);
> -		goto cleanup;
> -	}
> -
> -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
> -				      packed_ref_content.buf + packed_ref_content.len);
> +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
> +				      snapshot.eof);
>  	if (!ret && sorted)
> -		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
> -					     packed_ref_content.buf + packed_ref_content.len);
> +		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
> +					     snapshot.eof);

OK, so we still use allocate_snapshot_buffer(), but then we hold on to
the snapshot. Good.

I do think just using xmmap() would have been sufficient (and not needed
patch 2 then), but I'm OK with this direction under the logic that we
may end up sharing more code between the normal and fsck code paths
eventually.

-Peff
