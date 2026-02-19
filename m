Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E41333436
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500121; cv=none; b=hiSpq9glhMcX5TyFUM7emsltl6p6GO4oFXn3G+X3Neir8MdTr1/ep5ewQ4quyL0KxogGvWCxzPQhtFfr18eSYRR+DjaevYNUP/q/3IN1OP5VxcDeUA7Y9jiwN+fifx+Ro7Rhe8F6egSXEAUx81xUPi0cpYdWjrsYrojVZffk7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500121; c=relaxed/simple;
	bh=ulG98num/TYHj21IdEi0e5DfjaZnEtBA7VIE81ReTaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctIO/D8VJ3b0NbqoB0/BQOLHHA9/h36l8EnZC7H7Xp9sdUQXNtVENbrYge8igJAvVk4FV9gXxesdWPzYazITeTDO75Ket76sONCkerJfuE1XvrZvvzk01A4+4apm2RsAyE3A323iRHkCwvKyx8YajBtDxhYD6Z06huXOE1VILNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LzGHVngp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LzGHVngp"
Received: (qmail 2210 invoked by uid 109); 19 Feb 2026 11:21:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ulG98num/TYHj21IdEi0e5DfjaZnEtBA7VIE81ReTaQ=; b=LzGHVngp6t0+ced4ZWOwsRslj2Fy9gOlIPMvWIiMSNkuvLmZSSSWb4I6lrkT23LMcL+BKmvmBnlXD69jWhcvok6Lcx2dx2Zpolmxy6GudC4JvTPC9cUhfV4o089gtfCHWxJ4ngdmhdcj064XAEJvM7ZNrgJ+O7k2YjQbwH3vEFy+eUZX5wLDx8/4o4xHHaKqIf/VaaDX4juUCqF1VM7fiNZ3eBcA/7Ri2xE+8el2chXH/W7ZNYQ+Xw8tvdLxfMu0gS9VokyTJtjqYej4NgeHmPcJAGYyj1ynUTxxELHE1SjvftTUYC6pLf9yTHsWUF5gvQQb/U0eLmgtywMSgTRK1A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Feb 2026 11:21:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4513 invoked by uid 111); 19 Feb 2026 11:21:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Feb 2026 06:21:55 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Feb 2026 06:21:49 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] ref-filter: factor out refname component counting
Message-ID: <20260219112149.GA3529@coredump.intra.peff.net>
References: <20260215085755.GA86262@coredump.intra.peff.net>
 <20260215090052.GA695631@coredump.intra.peff.net>
 <xmqqqzqjckgu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzqjckgu.fsf@gitster.g>

On Tue, Feb 17, 2026 at 10:07:29AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	if (len < 0) {
> > +		int i;
> > +		const char *p = refname;
> > +
> > +		/* Find total no of '/' separated path-components */
> > +		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
> > +			;
> 
> Sorry, but I have no idea what this loop (copied verbatim from the
> original) is trying to do.
> 
> We start at the beginning of the refname string, and while we are in
> the leading run of '/' we increment i to find the end of that
> run. E.g., we start with refname="///foo", p points at the leftmost
> '/', i runs from 0 to 3 at which point p[i] points at the first
> non-'/' character, at which point we do *p++, to make p point at the
> second slash?  Is the dereferencing of the pointer in *p++ a no-op
> that is there only to confuse readers?
> 
> And then p moves to the right until p[i] points at the end of the
> string.  It does count the number of slashes in 'i', but there is no
> satisfying simple answer to this question: "what does p mean while
> this loop runs?".
> 
> Anyway, the conversion looks very faithful to the original.

Heh, I missed your message initially but was independently staring at
this because Coverity complained that the dereference in "*p++" is
useless. Which is...kind of right. It is a void context, so the
dereferenced char goes nowhere and it is a noop. But if you don't do it,
then gcc complains that the two sides of the ternary have mis-matched
types (an int and a pointer). Which is true, but since nobody looks at
the result, it does not matter.

Writing it like:

  int i = 0;
  while (p[i]) {
	if (p[i] == '/')
		i++;
	else
		p++;
  }

perhaps resolves the syntactic confusion. Leaving only the semantic
confusion. ;)

I guess the thinking was that "p+i" represents the traversal, with "i"
encoding the counted slashes (so we must increment _one_ of them each
time). But I cannot fathom how that is easier than counting the slashes
like:

  int slashes = 0;
  for (p = refname; *p; p++) {
	if (*p == '/')
		slashes++;
  }

Which made me wonder if I am missing some corner case, and it is not
just counting slashes. But it must be, because "i" is never incremented
except when we see a slash.

+cc Karthik, the original author, for any wisdom, but the commit is now
almost 10 years old.

Is it worth rewriting to the "slashes" form above for clarity? I was
afraid to touch it just to shut up Coverity, but now we have two
confused people.

-Peff
