Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9B15B0EE
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263530; cv=none; b=Gp80eEkBpUdo88B/r8add5sRLS+OCBbq+wq7hcZbeRhIK4xoNCScEIHlD2f3PjklpjDrDT4WnERHrMmZJ/rGMO1yUD+rGz473J1a9bys87/Xa0AJpcjiLU96ey6LzRKie/P1Ga9j8NFziK+76Zz8nGGtkZ2t9GHWxJqdOmlXyEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263530; c=relaxed/simple;
	bh=T5lO6QIIHnM/Wwt4dPYJiubuBzf0fkkBxGBGvsw/KwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN+jX22QzDpnSpjZEa/c0HT433jRcXp1S18gBDjvSJFvA0D6+AzGbNkE3vixB5aOFwfr6zRkPfFGVfJrLIjL+fuIXGAGwb4o1n4Ax35IsazpqAriuRG+gqwIcSVUIB1HEuIq09/rAvLcblus8y780gREsdnfYB6FRniuAitm/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DBXS0IFl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DBXS0IFl"
Received: (qmail 26728 invoked by uid 109); 18 Mar 2025 02:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=T5lO6QIIHnM/Wwt4dPYJiubuBzf0fkkBxGBGvsw/KwY=; b=DBXS0IFlOjig3pQdQckplvlX07A9vFDd5ZwUYDMqil2kHhlLfpgrDZl4YRzGrOcAuLM6WkeAPHhRMQknCssr/PjU+auk3a62V/ijliMscPSSMAzEOqk5MfUo81oWl5S/6RbFrx3BwM328cNzkfJ6RkriFvv5hI0ZNKZ6IggjH4Uj1kB9vEUJv0vcMCLQmNs3flXujae53aqua6uK+M2fubYk26ezoS5uox/AUUXAhGIfuSeCnW1DcH+vVQDykkZRN7fvYF1L4icIc7feYu/GvbW/WK89VGQyPjA/gyVCTeKq/OH9vUSgOitQim/K2Q4WskIrhfohqhJL1lgUfr8CFg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 02:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3825 invoked by uid 111); 18 Mar 2025 02:05:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 22:05:27 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 22:05:26 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <20250318020526.GB1473033@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <a1cf65bedc94ab6e318ff81a6d48eb30b6fc7868.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1cf65bedc94ab6e318ff81a6d48eb30b6fc7868.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:56PM -0400, Taylor Blau wrote:

> -static void init_type_iterator(struct ewah_iterator *it,
> +static void init_type_iterator(struct ewah_or_iterator *it,
>  			       struct bitmap_index *bitmap_git,
>  			       enum object_type type)
>  {
>  	switch (type) {
>  	case OBJ_COMMIT:
> -		ewah_iterator_init(it, bitmap_git->commits);
> +		ewah_or_iterator_init(it, bitmap_git->commits_all,
> +				      bitmap_git->base_nr + 1);

This certainly makes sense. It looks like we now use the or_iterator
unconditionally, even for non-layered queries. It's probably a little
slower in practice, just because it's an extra layer of indirection. But
I don't know if trying to micro-optimize here is worth it. In general
I'd say no, but sometimes there are surprising tight loops with bitmaps.

I dunno. I guess it would be easy enough to do a simple before/after
benchmark on a single packfile with this series. I wouldn't expect it to
find anything, but might not hurt to double check.

-Peff
