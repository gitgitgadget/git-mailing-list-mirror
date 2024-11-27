Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E899224EA
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719874; cv=none; b=Kvp3nxTJ0cp6QETBeCT24M8XBzA3ddb50Z5ufuRIMqOaqK/3C81TAaZWOlQqNMadJJaRQQe962Rp0qjyXrOXlPltB6hzL7QYQgu33/KBH2LwDkxx/LTyAnd2wLJkZOknm2OFQ0QS9PnlC0yPIRR7BC11xfG5y95yhhSTNPjm2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719874; c=relaxed/simple;
	bh=1aHWyiPaauSJy+3/emmdTXfQurbh9R25vFO3pYwbxlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fofEnFG2Dey6bWVuAOOVTYC3m9L+rAB272oa+x+Lq/r2GAW8zrXi94cnNvEd1/Y0QZFJwQp/Sz93RNRkCc99HQD6J9/RDux5pjKnuETJMxcbseoAmrsHhixlY/DSmeqQzfD2lThwsio3hyt4zD/UMjGXVJ5xwlYlnw1QpMcfWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z/G+dSuU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z/G+dSuU"
Received: (qmail 6525 invoked by uid 109); 27 Nov 2024 15:04:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1aHWyiPaauSJy+3/emmdTXfQurbh9R25vFO3pYwbxlw=; b=Z/G+dSuU9ruLJZnwr3J0syBy8wGMatHvw7MxkyI1kuYPSkfD3orIaxWsVkNknPhaF5wCu7wClZOSaIbRYFroJC5TfMKfPrlb7XtxpJsO2FSimwEFsTjIS1oVhbM62xA2sg6lGKyWzRXt7J+XJV1kF4psHDExic4L32xxjjnY785FnoTkbgsYnLEdx3p3aZ+F3yT+Z5NKkNjMEQg2niim3QV2xqxsjCTPWxdWU5mmfGkiRvPkL9zD1wvqtguEjuXWFtqJJvTnFYsQipvTLmgJ9sqacUyzAYnBVLp2t96XzBCIBhJy1qfVe4ZF1jK2HO8SDGTk6QUGmhSDeJ4zuZ5CQQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Nov 2024 15:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1255 invoked by uid 111); 27 Nov 2024 15:04:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2024 10:04:29 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Nov 2024 10:04:29 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Extending whitespace checks
Message-ID: <20241127150429.GD2554@coredump.intra.peff.net>
References: <xmqqbjy5bc6m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjy5bc6m.fsf@gitster.g>

On Sun, Nov 24, 2024 at 11:25:21AM +0900, Junio C Hamano wrote:

> I am wondering what we can do to add a different kind of checks to
> help file types with fixed format by extending the same mechanism,
> or the checks I have in mind are too different from the whitespace
> checks and shoehorning it into the existing mechanism does not make
> sense.  The particular check I have an immediate need for is for a
> filetype with lines, each has exactly 4 fields separated with HT in
> between, so the check would ask "does each line have exactly 3 HT on
> it?"  It would be extended to verify CSV files with fixed number of
> fields (but the validator needs to be aware of the quoting rules for
> comma in a value in fields).

Coming from a devil's advocate position: what makes these CSV format
checks any different than syntax checks we get from a compiler? Or for
that matter, the result of running "make test"?

I.e., why implement a complex system for single-line verification
plugins when you'd be left with the much larger problem of evaluating
whole-tree states. And once you have solutions for that (like using
branches to separate unverified work and then merging it once it has
passed checks), then simple things like line syntax are easy to call
there.

Now you could argue that the existing whitespace checks are similarly
redundant. Rather than having "apply" complain about whitespace errors,
you could just check them as part of "make test".

The reasons I can think of for doing something like this are:

  - catching problems earlier is almost always less work for the user

  - for things that _are_ line-oriented, looking at individual diff
    lines lets you focus on problems being added, without worrying about
    existing violations in the final state. OTOH, that's not foolproof;
    if you modify a line with an existing whitespace problem without
    fixing it, "diff --check" will still complain.

So I'm not necessarily against it. But it seems like a very deep rabbit
hole to start adding in shared-library line validators, because I think
it ends in "now compile this before I agree to apply the patch". And I
think Git's model has mostly been the opposite: make it cheap and
private to branch and make changes (including applying patches) so that
you can inspect the state before deciding whether and how to publish.

-Peff
