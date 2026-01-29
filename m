Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECD3815E2
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685889; cv=none; b=Nkq05sMBpnV7uPtoLdY6rFm6Ih0HMkqPJZx9dwzUOABwi6xbSKOEbTHMQrjWzuoWqgQJyiGKLvDj5Ls3VLGFhgomrQV/GRt3xVuX5W37F2wV/7bdnaneNmnCEFuLvqKc6WVdKmR4pONcUT37kSuj0gQrELQb18Y0Xi7Q+82ESow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685889; c=relaxed/simple;
	bh=kJ7igUVA588saczav/Pr/ORYshozm4PsGT2ehKrBmdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auEys67eaV0Fer5xE6aXOpyAP9lseJGAvSP2KIUpGes+ZBSJmPWYZzNCL41ZCy9FHfHcrDpb9X1ZFOZU5lwaLEW0GXf3/5jIQ14qwnIzKAqIr9H11H+gTU/2Y1m8rc6ZqaWFA++XyWrtQfW905AJh7WQnvzq3TJqZR70h5ZGq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aytGmHbO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aytGmHbO"
Received: (qmail 210037 invoked by uid 109); 29 Jan 2026 11:24:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=kJ7igUVA588saczav/Pr/ORYshozm4PsGT2ehKrBmdQ=; b=aytGmHbO+qqhq+3c0XuZhhQCwlq/xLw7T7h5ukb8uTuxgt/oviuX/fYcolZxB2PgvfONF4SqzPccH/RYKjfkzQl7p5/IqL8wnMmhttSH/ZuJVYBylaRhg52YUW/3cLixNOa2B/KKko+siobueht3JBE+UYKg/+UR4Oh9Fwhm8S0FPk1b6n9OWO7A6N86Ns9KXnrnZWgTDyINLuZRIhx4GZXPVMI+rxYdmwzjW6Ods1teTggNDKt1Vui/lqCyFx87nHhB4lLLWPjIlHzu400DHmPvw+GGph69aXwdta/g5qsle0YxCmrGF7eX9IzV0hwN30yX5UBbeJw6WGJz2eORLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jan 2026 11:24:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 400602 invoked by uid 111); 29 Jan 2026 11:24:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jan 2026 06:24:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Jan 2026 06:24:46 -0500
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] config --get-regexp: avoid rewriting regex patterns;
 consider REG_ICASE
Message-ID: <20260129112446.GB1285720@coredump.intra.peff.net>
References: <CALE2CrQD11Qa+wGVhsF8JwkuwkLWkDf9kGvs1NM2dsYFuPgUKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALE2CrQD11Qa+wGVhsF8JwkuwkLWkDf9kGvs1NM2dsYFuPgUKA@mail.gmail.com>

On Wed, Jan 28, 2026 at 07:42:34PM +0530, Pushkar Singh wrote:

> The documentation says matching is performed against a canonicalized
> lowercase key, but the current implementation achieves this by modifying
> the regex itself.
> 
> Would it make sense to stop rewriting the pattern and instead use REG_ICASE
> when compiling the regex? This would preserve user-provided regexes, support
> more complex expressions, simplify the code, and eliminate the NEEDSWORK.
> 
> If this direction sounds reasonable, I’d be happy to follow up with a patch.

No, I don't think that would yield correct results, because the whole
config key is not case-insensitive. The "subsection" (the middle part of
a key with two dots, like "section.SubSection.key") is case sensitive.
That's why we only lowercase the regex up to the first dot (and after
the last dot).

So as a concrete example:

  git config foo.Bar.baz value
  git config --get-regexp foo.bar.baz

should not match (and does not currently). Whereas:

  git config --get-regexp foo.Bar.baz

would (and does).

If anything, I think we should consider deprecating the auto-lowercasing
of the regex.

The "right" thing for callers to do is to downcase their regexes
themselves, in order to match the canonicalized name (which we do
document; I think it was added around the same time as the comment you
found). So any lowercasing we do is a favor to callers to make their
lives easier. The fact that we can't do it as thoroughly as possible is
perhaps OK, but I also think we could actually screw up their regex in
some extreme cases (say, by thinking we found a dot as a section
separator that isn't really one). Which is gross, but nobody seems to
have cared too much.

OTOH, it does help the regex queries match the regular ones. We will
canonicalize "git config Foo.Bar.Baz" into "foo.Bar.baz", which we can
do unambiguously. And especially since we document names as camelCase,
people tend to write things like "fetch.unpackLimit" in their queries. I
don't think we'd ever want to stop making that work (though
interestingly, I do not think we document that anywhere).

So probably I'd do nothing. ;)

-Peff
