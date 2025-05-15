Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E17185B67
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341147; cv=none; b=fVCZp0P/k0KRZ4CiAw12v5SmIZSW5Ql5jGPoa4kJoLCZT/udzzfN0SrWXSKnXzfnI8wJRDaNmaFRl1zFCUs9Yd3j1KNIBoGjVZgdi7mktZrSksjNWcWB60tRQdcFJKyIfnD1mJF3PQ6UnQWMLaRW+vRX20KkFFs1WEaMfllqFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341147; c=relaxed/simple;
	bh=kWbfkdsOc+Sdz9+wknwBT23oV7DULXImKNY4z5oHkwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kyfi5s1Qhx7a8a1lLc6NgqRUAaNFIaPOcUCbipUsom5rVm2tbeFalxx9Q+dqEMTiqiXtBAF4nfwlPEbLr+gyvGx/KWoaZoNdmvF8b8f92Kgl0E8/0rMoRYbR1Fagu8+zluqlAY1agfqooBx0vLTj31HyMYIHvRBFNxeBEBw5K80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hBnADgau; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hBnADgau"
Received: (qmail 991 invoked by uid 109); 15 May 2025 20:32:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kWbfkdsOc+Sdz9+wknwBT23oV7DULXImKNY4z5oHkwQ=; b=hBnADgauu23o+7DwGxSnBhvpHs5gArmpSftEZqwBh72+daFHUYOpvqr1Zlc6r0pkwJbWHdqD5uiP2C0R88f23wt2MCVQ7Un+vOpDnHGKeZubod50XGeA0Zc0WtHpVy6NdLTCkDy/cattV4sma6dh40b1WHlZGHcXP1rwvTG+JHEnBvTwdyvBjliRVTR815tl4ApIdGxwGH1YFGto5wbKph2F3LteiS8eLowghwt2QmK+Ux3UXN1kvYgheKybrsBjTzfeccWP5CEDhnDIlsZF/Vv81SUAxFVSAVCbJCLtMlkHgAyk942MMxg3NOxESHE4KfKMIuVmOHogxtZa3XeJuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:32:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31040 invoked by uid 111); 15 May 2025 20:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:32:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:32:23 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/14] get_parent(): defensive programming
Message-ID: <20250515203223.GN3320240@coredump.intra.peff.net>
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
 <35c4870e2c101c9ef72d1657c8f6dd077cecc5fa.1747313140.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35c4870e2c101c9ef72d1657c8f6dd077cecc5fa.1747313140.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 12:45:27PM +0000, Johannes Schindelin via GitGitGadget wrote:

> CodeQL points out that `lookup_commit_reference()` can return NULL
> values.
> [...]
>  	commit = lookup_commit_reference(r, &oid);
> -	if (repo_parse_commit(r, commit))
> +	if (!commit || repo_parse_commit(r, commit))
>  		return MISSING_OBJECT;

Sure, but repo_parse_commit() can also handle NULL values. It returns
"-1" in that case. I think CodeQL is not smart enough to know that.

-Peff
