Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6B28E17
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749163679; cv=none; b=S9LcrfLd4dZF951HdRPmW6gdfB/RMBY2O3ZJIpwv2/x020F4acqIchzrQdHIZ8KXTXtdr6Yd5c9tNK2pZ5YfUM92em361vJ2Xi8Fphve9yq+bVFVzA5/43mnOmKMATz5ekwrUY1XLJ3M6LlGkNtmMHWkAHBFjmaJsI9j1dI8CNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749163679; c=relaxed/simple;
	bh=cYC8muYElU2VwDILcS4CCavkC5sj/HPF55Cq6wArSM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJFxdxIkvM9msAVODgWffgkX4Uc0NpOXoCez2Kjn6xMUpPEq3B3RAPYQDLBFNVHRdPHDlYW6Vb9JXSttPNQiqoeCMtIfjYUaV5Y5ikLKbJu/yvqHqJ2nKwUcm80L+91YNKFJj9BqnsF1oOyTFetNV0/ANHTyUE9IpOIXErjvJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aKXRUTBI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aKXRUTBI"
Received: (qmail 23687 invoked by uid 109); 5 Jun 2025 22:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cYC8muYElU2VwDILcS4CCavkC5sj/HPF55Cq6wArSM0=; b=aKXRUTBI7m7pUxgI9nIZ6qLDRBPkop/ifHmcehStzq6FiwzkWUyY1eD/fj9INYCLh9kzgczRfATzMmiz3N8YSG+T+r86NIgCWkE+BgBQBDRaXLwqKXLGcSBl7eIicQCI/GfHYWzzmRXdGtAoxqHUGl1I2VFWpTGW0UmRPj+wvPMeJaRuaR5/REqljE7nanVKWjNXdK+fzUi4fmp7P20dBzNcwilBfLjsf4ylQe2dvU1kltHHNgn6A7tEKxlDlffpJv1fHraoC7ET3OuyKCa7RNxZ0XWpevlH8VmPuJLbFdxF3K/HFehk1Tb0KVT31WhT4tdhxAKW4VZWMYIW5T4M2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 22:47:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32348 invoked by uid 111); 5 Jun 2025 22:47:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 18:47:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 18:47:47 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] curl: fix integer constant typechecks with
 curl_easy_setopt()
Message-ID: <20250605224747.GA3005733@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
 <20250604205513.GA1510819@coredump.intra.peff.net>
 <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bd5f0f3-d0c5-067b-ffa6-12a2c0353580@gmx.de>

On Thu, Jun 05, 2025 at 12:57:35PM +0200, Johannes Schindelin wrote:

> > But when we pass an integer constant like "0", it will by default be a
> > regular non-long int. This has always been wrong, but seemed to work in
> > practice (I didn't dig into curl's implementation to see whether this
> > might actually be triggering undefined behavior, but it seems likely and
> > regardless we should do what the docs say).
> 
> The `curl_easy_setopt()` function takes the parameter as a vararg to allow
> for multiple types. That means that 32-bit systems wouldn't see a
> difference (where commonly `int` and `long` are both 4 bytes wide).
> Windows (and other LLP64 systems, if they exist) would be fine, too. But
> on LP64 systems like Linux/macOS, it would make a difference. It might
> work "by mistake" on little-endian systems if by happenstance the
> remaining 4 bytes are zero.

That was my intuition as well, but then I'd think it would be failing
reliably on big-endian LP64 systems. But maybe nobody is using such a
system? I _thought_ building on Android might get us there (something I
do myself sometimes), but at least my ARM64 device is little-endian
(apparently it's bi-endian but defaults to little).

So maybe it's a problem waiting to happen and we just haven't seen it.

At any rate, that is all just curiosity and I don't think changes what
the patch should do.

> Mine was driven by the failing `osx-gcc` job, and curiously after
> (changing all the `l`s to `L`s and) rebasing to your series, I still have
> this:

Interesting. As you might guess, mine was driven by fixing the compiler
warnings I was seeing on Linux, and I didn't do a full audit of all
calls (since doing so requires cross-referencing the expected type for
every CURLOPT specifier).

I wonder why these extra cases are caught on macOS but not Linux?

It is probably another mystery not really worth resolving, as clearly
the right thing here is to fix them, as your patch does.

-Peff
