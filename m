Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93615B5AB
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773543312; cv=none; b=ob59bA9xL1JFrnZROHUyxwKRXyZ5amzazXCBV/KY45YFmdcbot7RA8e5px+vdHa3ixQCcLD60jSrqR3Ev1DiZEvCd+o/O1mvnpqO+WWPWVjhmLh9uF9CLrnBKqhuYRRYZVchuPaQ3aupcWdFZNybV2xPyu2th7Y0uwVpLhXmLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773543312; c=relaxed/simple;
	bh=+WqmM7WOQqeOQoXqI9yutaF2HaF9aDzdNRlLEh41mOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7EYurHO3yeho+0DK4WNvj0Q1kCZFbHhz5IDbCjsLMS4WAxI1Pxw2J5eoNPW3T16znODH23Ay9MViArfrPMBhnBmaDzuzpQ7K7bmA2yC0uRudF8P3yNMW+GZwYd7lJJVBixPzQ4aNQL1NSBAbC7OcuyqR4t63W1Ica7/gi6yyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eXrVmvcx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eXrVmvcx"
Received: (qmail 123407 invoked by uid 106); 15 Mar 2026 02:55:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+WqmM7WOQqeOQoXqI9yutaF2HaF9aDzdNRlLEh41mOw=; b=eXrVmvcxInGKMv9ZiKIjXj0AWLTYHSmCAq1ESH6pxcL+m6FMWY1ZfBbpNyd0793aU80D0SAmzbICv5ZgekLEOlzxfPExtqjgPWkSPJcP7sN0vMuy2GiMdhfKxV4XpuxlUYQID1f1oWQcNP6I3+Zy7IShsTeFVa1BApTpqw4WnrsTwQWDRhLazU3S7v8YoSg8Li5GsIXTM94SBJ2c3m6AmasvSiFOseJxf5l8P3NKVRrftdyH2cAo4JBlnRAJUUPdaJ6/oIC5RUL27hdLBa2KmPGgEqFtVlROTk4G2Y7sBl22c0zLVUy19sBHr8lTDeRVg4PByiZ5sy78BTPgHMrq+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Mar 2026 02:55:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 554560 invoked by uid 111); 15 Mar 2026 02:55:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Mar 2026 22:55:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Mar 2026 22:55:08 -0400
From: Jeff King <peff@peff.net>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] coccinelle: detect struct strbuf passed by value
Message-ID: <20260315025508.GA926820@coredump.intra.peff.net>
References: <CAG7UgESKLMnO_4+PSJUt-TXJxFQyxEEfpCmJfMmTw2+rhT-HWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG7UgESKLMnO_4+PSJUt-TXJxFQyxEEfpCmJfMmTw2+rhT-HWw@mail.gmail.com>

On Sat, Mar 14, 2026 at 10:42:19PM +0530, Deveshi Dwivedi wrote:

> A transformation rule achieves the same detection without the
> dependency.  It rewrites a by-value strbuf parameter to a pointer.
> The resulting diff will not produce compilable code on its own
> (callers and the function body still need updating), but the spatch
> output alerts the developer that the signature needs attention.
> This is consistent with the other rules in strbuf.cocci, which also
> rewrite to the preferred form.
> 
> The rule itself:
> 
>     @@
>     identifier fn, param;
>     @@
>       fn(...,
>     - struct strbuf param
>     + struct strbuf *param
>       ,...)
>       {
>       ...
>       }

This is much better than what I posted before. The real source of the
problem is the functions which take strbufs by value, not the callsites
that pass it to them (and mine was checking the latter).

And your use of "..." is better than what I had. I think mine insisted
on having arguments after the strbuf, which is why it failed to find the
case in save_untracked_files().

So the only question to me is whether people who hit the coccinelle
suggestion might be confused by the patch output, since it doesn't carry
any rationale. But I would rather catch the problem and risk confusion
then have it go unnoticed.

-Peff
