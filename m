Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85D22CBD9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146829; cv=none; b=e1o5Mbil73nCU4OaP6xMm2CiUVt26jajOvDbT2JTZDBmRCfrpB6m0j3wePjoI40YVYWNyEigkJVbNO4ZsVIXFXKszVjERagkClQJAscgpCGZFzKXvLkxU1Pm8J438fFA14sYIfAi6CSQhw47y9IIl2ZVqczVIDgXyX8/xPTSfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146829; c=relaxed/simple;
	bh=TXGlamvw2GhLLKYlqUQp6KX6qJfJrr8+aJFbvTKTdxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC3dqiRxtNIjduZAibgFw853DUtRadkOC74F/giQC9JSahuPP9JE2dh7D9Ff2I0ZlxoKsjHy4Qix7DHDaLvJIgObtA7Rn3fp4lOXSq8rYS4dcsIPi8H1KOGeBxKiIMfo1WR8Y1j/NUAQf+bc4RlW7VzBoZh+rZr/zqmmmuhMp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B/gx2Zkm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B/gx2Zkm"
Received: (qmail 44827 invoked by uid 109); 15 Feb 2026 09:13:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TXGlamvw2GhLLKYlqUQp6KX6qJfJrr8+aJFbvTKTdxY=; b=B/gx2ZkmQsMd4s3sMsc0KSgAmdGvOeydXKTPQwRZarCUEkSvJ/o0kGQ7kXDIJLjLyn3rkQcvY5lUrJ8d034UxMJPcuIKyZhpGA41EADTLTBmhYE75Fyi/LSGkgfiqlNQgybQfhzEUbW3JhR7Bb6u3P4Fx2WBp0yHQj8+OqqBsOv32AUKKKnEwBRgRo3P+7oB9XjV8I/WC+mWSiAiuaRoopp4JdUwGHljSsSSKesrC804Er/AFyREcR8WLI760A33GQpLCiSc2VcHWFhIlGnNqfvtQbW9dn+/1UkA6apTGhNzpkwUK0cVJtbYHmxs5JlE85iGtBEFhn0onrBfZWuGJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113428 invoked by uid 111); 15 Feb 2026 09:13:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:13:51 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:13:46 -0500
From: Jeff King <peff@peff.net>
To: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
Message-ID: <20260215091346.GB696020@coredump.intra.peff.net>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
 <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
 <aYvV2W5pcvqZig8S@nand.local>
 <20260211091333.GA1868492@coredump.intra.peff.net>
 <CAGjQmDMhWFx32M+2DrZ3cF-mt+T==LNEzXRO4z=R73RjZnTQPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGjQmDMhWFx32M+2DrZ3cF-mt+T==LNEzXRO4z=R73RjZnTQPg@mail.gmail.com>

On Fri, Feb 13, 2026 at 03:41:55PM +0200, Vaidas Pilkauskas wrote:

> > There were lots of uses of "date" that I suspect may give us portability
> > problems. "+%s" is not even in POSIX, but maybe it is universal enough.
> > But stuff like '-d "+2 seconds"' seems likely to be a GNU-ism.
> >
> > Using "test-tool date" might get around some of that. We even understand
> > relative dates like "2 seconds ago", but I think only in the past. :-/
> > So you'd probably have to do:
> >
> >   now=$(test-tool date timestamp now | cut -d' ' -f3)
> >   then=$((now + 2))
> >   test-tool date show:rfc2822 $then
> >
> > or something.
> 
> I was not aware about test-tool, thanks!

It might be a little awkward to bend it to your will, especially since
it likes to print "input -> output" instead of just the output you want.
If it gets too hairy, I wouldn't be opposed to teaching it a new option
or even a new command-mode for doing this kind of computed date stuff.

-Peff
