Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255483C09F4
	for <git@vger.kernel.org>; Fri, 15 May 2026 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817379; cv=none; b=dN9OePvBCHeDm6X0KbXB+pzrMAy+GhOehu03oiBvGRCN0V7oKxzUA5dOEUFhtUHBerYU9Xk+GhFi8K7PdtAZxm9pX0/0EOgpgQf65cb/9LU/hKrn7IFle8vicdRuvHDCrNnSQyH1mVgWGW6yKsumeYGIBdYchzUYXks6LkCT+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817379; c=relaxed/simple;
	bh=1NtlkCpSSD6Nf9a7taSTYHZDTbEJdeDDtY90NViwwPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/Da64T1JSmjroweNV3DmA8ENBXNrUkWYtwTzkUAZOtS2DwGxKFtxVYpoknSFcLwgmRmRH7Lf4Vz9OinxCKo/euEtrIHJw/wys0BiGDlbihUny+MKCnAPMmwjs6bGuTcNp2YbNthohdF5m2lICsNprvow9gkcA1tNKl7Bno8A00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JCvxhct5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JCvxhct5"
Received: (qmail 52621 invoked by uid 106); 15 May 2026 03:56:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1NtlkCpSSD6Nf9a7taSTYHZDTbEJdeDDtY90NViwwPw=; b=JCvxhct5eSpEgwF8HQlt+uvztu9KtsTjJkhb+uER/goiB3vuoU0J53I7Kl9dVfuB4tLZuV7pXP5JnIQgjOR09Yvsc7gaAfgqnUSYKocti4T7g8uPZa+3HgJ+UEKvQ1HGwGG9gqHPTzznFKSBaBqbGr0S+Gkd29f3GMpdO5mpprh1jwpH63TnABfuWw+ICQ2r+17l4teQPL/Yf0DDQ3w/6r0/zZfm4WW/7DUGOU/dJYe+tA9+lL/jQTh5VvJO6pip5vjpVDtCO7PYNOR8qeYW8XHOer3gzayHFaaGIqQFG2wnbYdbBIQuDVjXyoxTfv7oDFx7dyUcpeormBbSKNIEMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 03:56:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96235 invoked by uid 111); 15 May 2026 03:56:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2026 23:56:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 14 May 2026 23:56:16 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v4 0/7] odb: add write operation to ODB transaction
 interface
Message-ID: <20260515035616.GB75627@coredump.intra.peff.net>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>

On Thu, May 14, 2026 at 01:37:33PM -0500, Justin Tobler wrote:

> Changes since V3:
> - Fixed leak due to an fd not being closed when exiting prior to
>   close_loose_object() being invoked.
> [...]
> 3:  11321ad607 ! 3:  d53ad95712 odb: update `struct odb_write_stream` read() callback
>     @@ object-file.c: int odb_source_loose_write_stream(struct odb_source *source,
>      +			ssize_t read_len = odb_write_stream_read(in_stream, buf,
>      +								 sizeof(buf));
>      +			if (read_len < 0) {
>     ++				close(fd);
>      +				err = -1;
>      +				goto cleanup;
>      +			}

This fix looks good to me (and I think is the best way to write it,
given the rest of the function).

I briefly wondered whether callers might care about errno being
preserved, but I couldn't find any indication that they do.

-Peff
