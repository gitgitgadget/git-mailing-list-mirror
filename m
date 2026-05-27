Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC7379EDA
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877639; cv=none; b=uOOiUu/R0BvckdWf0IojLMubrwFZI8kW7O5TWvc2ZVQHZyGhTEErX1b9PnjHkilGMVgDrGRvQ++WbqLmcTf028Yon1t/xa8JJGm7Pa+4A3a/fKbBKodHxwN5YMeej/vbr4uPbByFTfNt57piR5tmpWBN83JMLx1/tvt2w0Dpcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877639; c=relaxed/simple;
	bh=6zGiKlyj/a+3ALJWM6tmrsQkyRh5aDSbeDCRUJHfKZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8fLjS47k+cU3qV0dyRn+dTedcqFzfUdpNI+Ve9BPG+obFFK4XzoYLag4JGRqfSfzF5fqLjdCpy6Tv8X8uooLMXPruF0hGShYydJFNQ54/lXVj7nFFkDXdgvZaG9/qNVB7yjHuxte5piC/dXRasWPhI5G0/UxDREhDKqa1NBQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lt/+k907; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lt/+k907"
Received: (qmail 29279 invoked by uid 106); 27 May 2026 10:27:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6zGiKlyj/a+3ALJWM6tmrsQkyRh5aDSbeDCRUJHfKZc=; b=Lt/+k907MolPiEmwIbt3UM0QTQ9hFcg6ClXROMnNqgrQfVieN0cVFQWyS6Gtcy1rL2H4cbi7anoBV2sqg9rZzXnXzX7YG6kEhRMFi//OfF1vNGOrZh4g0ANUYs9BiciuaQYsdGD4PoYqDwpxHnryKMn/WjkKY4W+DuubhksUjChdW5w+sb7f7m3W5zR4Ed1859LMqHsqd04Tys4oQmxZGx9QsWWzjyv/lSsn32TYWWF1BelBhPcRevPG3jzfLk53wM/Clg3EBmHDOkxczpUGKWTo/GUhNmn0NTSnDS+dlez0ZcQAI7otkBxwmlSkNycBszQzhsySD0BwVOntdHnMFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 10:27:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73215 invoked by uid 111); 27 May 2026 10:27:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 06:27:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 06:27:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/8] pack-bitmap-write: speed up bitmap generation
Message-ID: <20260527102716.GI981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:33PM -0400, Taylor Blau wrote:

> This series improves the performance of reachability bitmap generation,
> focusing on very large repositories and the penalty to generate
> pseudo-merge reachability bitmaps.

Very nice numbers. I'm especially excited about patches 1-6, which are
really just speeding up bitmap generation in general, pseudo-merges
aside. I think you could even have split those off into their own
series, and then built the final two as a separate topic, but I am happy
either way.

I looked through the patches and had nothing to complain about.

-Peff
