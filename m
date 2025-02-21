Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266A1FF603
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123792; cv=none; b=F5B3L8CQWaxhItAmoILh+SduEa05zMjTSgmkIuTV5yCITuIey3HQMw8iu2N1IphsAZ/Iz8jk7uJs/DqKMkGY6jzUWVbXmR/F59zgY9DD6SiKU1tScnz3NSVl8BG0/oMa15W5TtHDQwcVmiX1zYHjcyHx3mpF+uxxFbTbragJtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123792; c=relaxed/simple;
	bh=Benr7U0tpIVm4jnxo8HDvgEP/sso+abY4UwLDJe/r+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpOCsW6hURRichQC5JBLKK/lJZsy7MSsgsEHZg8P2Mhlk5vJJgz8HB23TTCl26Zda1Svb3IZJy6rI9pZQqtfveY/4mLKpxKhG7wmYa0ta5Sd18JDtAEuq2eMtkX5SXYbmfBP3wxKEBEoFaxtGmckYhFqS4lwcrMdYvg4vKGzIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=azTM4xWt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="azTM4xWt"
Received: (qmail 3225 invoked by uid 109); 21 Feb 2025 07:43:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Benr7U0tpIVm4jnxo8HDvgEP/sso+abY4UwLDJe/r+Y=; b=azTM4xWtoxbAVuVcFKerXYoTVAw6Bo6lv+4gUnxlKaw3xf9yo44hM3mZvrGdsfmG/k/zg3+/TUbNnCO6gQ3iCTZWdK9PZTtQwE0uzV63O3rhx/csbMudy/T5a5h9URCF+sDTAEoYkItFwnOMgkiHRqERjhm7Jez0SBb6LtX5ZVN8gGfcVyhVa6flC36n4Lln9K7Rmbt+sBko29/jwOVNMK789+ZUXq5fSN2NbZiEOE7nlVC1F3A+F4oizp1YuqBh+lMTb9bh6qtpHfAfqnuNjM3kMFmAG24Gjlx/3hxNoy+6QWW8qXgA0SDtgu0FZkZsyTnMjrPdaeq9ZNUSxIbkEg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 07:43:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30913 invoked by uid 111); 21 Feb 2025 07:43:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 02:43:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 02:43:08 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/7] progress: add function to set total
Message-ID: <20250221074308.GB1988395@coredump.intra.peff.net>
References: <20250219-toon-bundleuri-progress-v2-0-a84e7ffa921a@iotcl.com>
 <20250219-toon-bundleuri-progress-v2-1-a84e7ffa921a@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219-toon-bundleuri-progress-v2-1-a84e7ffa921a@iotcl.com>

On Wed, Feb 19, 2025 at 03:30:19PM +0100, Toon Claes wrote:

> We're about to add the use of progress through curl. Although, curl
> doesn't know the total at the start of the download, but might receive
> this information in the Content-Length header when the download starts.
> 
> To allow users set the total size after calling start_progress(), add a
> function progress_set_total().

Makes sense.

> +void progress_set_total(struct progress *progress, uint64_t total)
> +{
> +	if (progress)
> +		progress->total = total;
> +}

I wondered if we'd need to do any other computation here (that would
have been done in start_progress() if we specified the total then). But
it looks like we don't look at progress->total until we're ready to
display something.

Would we want to call display_progress() or similar here, to update the
original view like:

  Working hard: 1<CR>

to:

  Working hard: 33% (1/3)<CR>

immediately, rather than waiting for more progress to be made? I guess
it probably doesn't matter that much in practice as we'd remain stale
for a brief period in most cases (particularly for transfers where we're
updating based on bytes received, which is a pretty small unit of work).

Plus I think it may be awkward, because we don't know whether to call
display_progress() or display_throughput().

-Peff
