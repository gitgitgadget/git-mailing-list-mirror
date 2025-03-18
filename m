Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA408158545
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262262; cv=none; b=O9GZCJ11pY9chZ/t5COmdEMH8caFuwO/9hsRfxfCRDFvBbYxbYA/b1ywO8cKyESAEwgjNvpM9dEk+ZYaLSEHz0lPNZgKkSnRQ/UZKxR9jAAbZ5fxbrzwlJ0CRhxVF5WUkpvYofuuC3I7/7X50W6lIQg2oXVXVsNmxKpHhs+EIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262262; c=relaxed/simple;
	bh=pJbU2sMVBipElwbUJFVaYVghu8X8TsXiOeQaPDVDQNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVrnxJz1WknCIKcAdahMfqbe5u6s+e4D67uw1nrbdlT1IPzmaiOpd2pxlSVv7LaU0y7kryxsOhC1GEEnAZ7tPwGLqwzgPGvPOKkXMaUzU6SabBAVNckWjYkDlXQC2Lt9WmnXOIX5UfXuJazl+B7D40v1pTmv5CEqP5nIRsSab30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YYLhh2b3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YYLhh2b3"
Received: (qmail 26520 invoked by uid 109); 18 Mar 2025 01:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pJbU2sMVBipElwbUJFVaYVghu8X8TsXiOeQaPDVDQNA=; b=YYLhh2b3vH++CVuLJm0//tyGA9Ix6uwBAAZ1MpSc1fxc7/QTcTC5LPQ2cFjzLNovpmPIK8lE/hvnnliQGn066UmV3izmjBBgqDmwkxk6MGSxglh8kJD7UC4H5sxuIRj5GpAQGNUqUSmH/qawldWR15LtxMW/FqzsDcPEZhGKxu9uza6BJYhopWSNO6h/Tjz9aHAauakdLUHf9D+HwsumAWtWiLMA7Pawb7aVa/WKbSqT30i6plI6lYu7IEvEiVUyOiPHnswHFYbjfU9es5CAipDpwq8RjwRufiGP+6o0+OF9tRO9pVKMVW1/h+WKjALBj3HNR2UqiopFleagM85DNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 01:44:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3507 invoked by uid 111); 18 Mar 2025 01:44:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 21:44:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 21:44:17 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <20250318014417.GE1471939@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <cb08ad6a62092b9521a11c0524f23bd8831c0409.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb08ad6a62092b9521a11c0524f23bd8831c0409.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:50PM -0400, Taylor Blau wrote:

> +void ewah_or_iterator_free(struct ewah_or_iterator *it)
> +{
> +	free(it->its);
> +}

Hmm, I thought this was going to be come "_release()" based on the last
round?

-Peff
