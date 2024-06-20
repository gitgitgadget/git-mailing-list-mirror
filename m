Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DE1AF6BE
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896967; cv=none; b=V5yQduilm9E4U3veENDltbRrIP5v0jLL3XI5Lv9IwMkCE6M1JXv6+rOywVY8y1TIJZDZvLB9ok9RtFgkIHteCspkhyIKsZp1ohOr72epYoSm72tIHBjh4OKDPAvAoLj46Iunu+d8VAkSV4zfjtbP+brKnzOKce/fIl9yE2qVLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896967; c=relaxed/simple;
	bh=Cv3tYqpBSpNkLlGYC3NartSVz8N+VfBPBe5evBd6LSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9KCJCrzxsPfpVqhUr6IaIgqaxncnnhIziTuTEkCWBCeV5aZJ1LX7/lyYKhhod2J3i0snBmJ5EA8lZoZVF7CvESlfkSQ1WiQtNNKVy7ykrGcsGesTNG1/G5or4kRO4dwuzI6X/IvJWwS5x0KR/EpkSBiNIqeENf8qb6r/kqASbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17669 invoked by uid 109); 20 Jun 2024 15:22:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Jun 2024 15:22:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31725 invoked by uid 111); 20 Jun 2024 15:22:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Jun 2024 11:22:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Jun 2024 11:22:42 -0400
From: Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5500: fix mistaken $SERVER reference in helper function
Message-ID: <20240620152242.GA1555496@coredump.intra.peff.net>
References: <20240619125255.GA346466@coredump.intra.peff.net>
 <ZnM3I11IRporu4sj@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnM3I11IRporu4sj@google.com>

On Thu, Jun 20, 2024 at 11:27:58AM +0200, Jonathan Nieder wrote:

> Alas, in a copy-and-paste gone wrong, 07ef3c6604 gets the name of the
> blob (but not the commit) from "server" instead of $SERVER.  And this
> happens to work because the first time we call this helper, $SERVER is
> "server".  The only reason this happens to work at all is that we're
> looking at a blob id; if we looked at the commit id, then the
> timestamps wouldn't have matched.

Yep, exactly.

> Particularly telling that the author of 07ef3c6604 introduced this
> typo while trying to make the tests _more_ robust.

:)

> Once the library code is ready for it, this might be a good candidate
> for moving most of the test cases into unit tests and just having one
> or two less repetitive integration tests.

Maybe. The subtlety fixed by 07ef3c6604 was that Git was lazy-fetching
objects when we didn't want it to, and the solution was to acquire the
needed data from outside the repository/process entirely. Sticking it
all in a single process creates more risks there (though I agree in a
robust lib-ified world you would have two separate "struct repository"
handles).

-Peff
