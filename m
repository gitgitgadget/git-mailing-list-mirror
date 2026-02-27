Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DB3B52EA
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232659; cv=none; b=ikt8ekydIWI/cSYEMSi+GYISM2dl3VYvRznGnI5DaQsyvpx5TBL1IRDHmGFQ2fHnsRm7bOpmtxoM5VQANw90stfktFTPbimQeTxEjtI1ecFiTFw6ZjH715LanzyJvBuky6C+vFGQlC0Uif0T5H7TKXkDDjot+U5H3pvaRFmquXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232659; c=relaxed/simple;
	bh=j2wWeoHMasl9SpgnBzD3+05GJnumUdZa0WQdgnmgYRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpYCHdLkhIfMYbAhPrCEr29zTrBoMXiwuSLO78ocfAMuVIObedndBQxiaq38w5sNU3JEabj5ZtMr5ErFROvq3qZNOEkgy0S8yyTjubRZ+TaoAD46c0tMz0vLexB3B771V8N4iYH6jQaFGSB/L8qQvc6azFmm6M/wYQ/yKiKf+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=daR6riPA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="daR6riPA"
Received: (qmail 83515 invoked by uid 109); 27 Feb 2026 22:50:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=j2wWeoHMasl9SpgnBzD3+05GJnumUdZa0WQdgnmgYRY=; b=daR6riPASOepnfXdHUAGBMPFsUPtyImv1HWyp+PvQqZimNTJ2iJCD+wwR/g1AgLhIFqzw4m+MITqwnUgU9sEnCdjPyRb1MU79+Rmu/7+RfsY/i5lMOjPwmMR35ZmSQ7VYagG+hbIzGU308kDw3jeG1tYyb+qMk+pEjMTCAnM1xEU9CwwegdFAlOoA4MyZSm0WLNSpiZrR5xxggt8qVvRi2HKxQSYam+KaHBkcNgrR1XCozz2HvFhDDdaoxnUewnPPxRG5fl9alyUt9xhQKVrz5T699ecYhvrhE20jpjXs8/+Nl1VW5bVhAKs8iEvRQFTczrBuWJCPphtPgvD7fdBlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Feb 2026 22:50:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 282073 invoked by uid 111); 27 Feb 2026 22:50:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Feb 2026 17:50:58 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Feb 2026 17:50:55 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] parseopt: check for duplicate long names and
 numerical options
Message-ID: <20260227225055.GC2956443@coredump.intra.peff.net>
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>

On Fri, Feb 27, 2026 at 08:27:02PM +0100, René Scharfe wrote:

> The check clearly has a cost, but I have a hard time measuring it.
> We already do lots of (kinda cheap) checks.  Turning them on only
> in DEVELOPER builds (and ideally demonstrating a speedup) left as
> an exercise for interested readers (with stronger benchmark-fu)..

I agree it is probably not introducing a measurable slowdown. If we were
to make it conditional, I'd suggest a run-time toggle (so we could turn
it on for all test scripts, but not regular use).

That said...

> @@ -655,6 +658,16 @@ static void parse_options_check(const struct option *opts)
>  			else if (short_opts[opts->short_name]++)
>  				optbug(opts, "short name already used");
>  		}
> +		if (opts->long_name) {
> +			if (strset_contains(&long_names, opts->long_name))
> +				optbug(opts, "long name already used");
> +			strset_add(&long_names, opts->long_name);
> +		}

...if you want to micro-optimize, note that the return value of
strset_add() tells you whether the item was already in the set. That can
save one hash of the string.

Probably the allocation for each element is the dominating cost, though,
and it doesn't help with that.

-Peff
