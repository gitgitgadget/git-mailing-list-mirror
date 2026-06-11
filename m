Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97026373BE9
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160561; cv=none; b=FhOTOGbRojUye5YBr8PuGqI4D8a1Hhx7F79jSK2UrI/oMSUnjWKPpv0tkRiiblVroC5A27uRC5PGNdtSFl27JCZEGGy5L4cmHUBoYuzl/q+lOEnQMEOZj+sM3tDz/jsviplD7a1XVHuJQqMIfqHemAGsTW3pGcdblnVkkm+EOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160561; c=relaxed/simple;
	bh=/Ug7JwV/MCfzAzuptamjwCfKG7//JckwalWMs06deRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijl1ujSKNyHuvBkVU53UlTTnXFhDGetl6TKixsdceMiXoUXNbdMrVhKQbkK8UVqNX620T13JifPmfpiuQwkIG9sGzc58zoOhWUU1HxtQOiq9BKI/V/wzHf52hJ1LW7FcGuKKn3JIDw1yJ60ddxTieylDuzL9K6SBZHhmF9Rqiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y8Y4hAHD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y8Y4hAHD"
Received: (qmail 106303 invoked by uid 106); 11 Jun 2026 06:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/Ug7JwV/MCfzAzuptamjwCfKG7//JckwalWMs06deRM=; b=Y8Y4hAHDwTCbnv0TjBP0f0CeySGaS21A4BwAWwvJ79XOurUeA6hSremBamp8FEj+MTtAS+RXpbZHR5daB5PauQNTSONxT1MJbM56k7RL6t2bAbfBJBMCnynzv87rovfDKzWwx4lX/unFAQYE5OOgiQfxM01XbeWOFfgqyVDbOg/+1z64FKuQv6swtcbKkir4enpFr0YFGnGrS1JC/2I/bw1MnNOir4UrFZtDyWxV+pqXidlKj4wf+BPecklWszsHl3XlA1eDH8DxN9ZU5x5Cw/EY+7zWpDvlRqMtffjqxDdvSScIlTNluCRHYkVw50ogqTXkRAFbfU2GxwdmV9xr/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:49:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 314065 invoked by uid 111); 11 Jun 2026 06:49:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:49:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:49:12 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] describe: limit default ref iteration to tags
Message-ID: <20260611064912.GC2191159@coredump.intra.peff.net>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
 <20260610-describe-tag-ref-scope-v3-1-5aa63ab279f7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610-describe-tag-ref-scope-v3-1-5aa63ab279f7@gmail.com>

On Wed, Jun 10, 2026 at 11:50:01AM -0700, Tamir Duberstein wrote:

> The runtime drops from 0.03(0.01+0.01) to 0.02(0.00+0.00). In a
> repository with 120,532 refs but only 330 tags, the same command went
> from 171.7 ms to 9.9 ms.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v3:
> - Pack the synthetic refs to better match repositories with many refs.
> - Generate update-ref input with test_seq -f.
> - Shorten the commit message and report the p6100.6 result.
> - Link to v2: https://patch.msgid.link/20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com

Thanks, this looks fine to me. I am still puzzled that your 120k ref
repo is so slow in the before case. Even bumping the perf test to 100k
refs, it ~10ms on my machine. But maybe it's a combination of not being
well packed, plus a slower filesystem.

At any rate, I think it is obvious that doing less work is always going
to be better, so there's not much need to dig too deeply into the
differences for information that is probably not that useful.

-Peff
