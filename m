Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8B1A294
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102058; cv=none; b=CfB6mApUqAJwu1ueTEH/HYANZxYe94YQC5jISs8eev0oiD59u7emZT3nEdAPOAgJqLFTuRS4F7qk8dKnmtmifRChEm/rWCmrNElQLO8Dw1GcrX/AvqpKIgrDdfw4OsBPTnVxP4HpK6HKkitEJPGeX4ITKdeXC16NTLoTDipG99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102058; c=relaxed/simple;
	bh=GQR8pjmmMZ2QyG0dtM1zMhbKdydWwYltfODI0TR9Z4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKsVoMVoSY2qsRL9BR1NC+lOMmfZgzf5YhxV0q1L+srcbPwTm9zutwuXBX/zlwMlpqP83K26c8uEEx5nE2d1LVmCgnaeHwNBnCMHe/hzCgyks8bIZA1Id+M244WvLz1pG0xvmIPoPAmVY94S71Sp9Wx5oAWHPtfdX/rIKfPHoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D28J09dW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D28J09dW"
Received: (qmail 218531 invoked by uid 106); 2 Apr 2026 03:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GQR8pjmmMZ2QyG0dtM1zMhbKdydWwYltfODI0TR9Z4U=; b=D28J09dWI+j1ty4iKnilD3TOzCLsmE5QXatAyLJEtpPZphkNshYeZCD2FZcGGEIUnZIU1bBr71M5nu8CDKSPK4b0i6rqksHObGetHuEE1BNTmnTTdXqaQOwATGgwpN14ng1mprWZBZGBLOHEG9xQlSJZwnjLx5VmBJHHllUpFVVLCX5LrkU+CLgA0jZz69xTeBxXA+fblPckICYXmmz0yDEgcBF1CzQDXvfRSVXC2qaoMaXND4n9hSjOb1+uNFFdhkEGZzfShxrhlYkQABMw2Ox2jPINbLODWZFfhYDB/1DAQnTNxIttTh4r/cUr0Jy2ipGzA4voTBcokYN0T1NKSg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 03:54:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349445 invoked by uid 111); 2 Apr 2026 03:54:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2026 23:54:10 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Apr 2026 23:54:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 04/12] pager: explicitly cast away strchr() constness
Message-ID: <20260402035409.GA3492642@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331234220.GD2328529@coredump.intra.peff.net>
 <xmqqh5puv20c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5puv20c.fsf@gitster.g>

On Wed, Apr 01, 2026 at 01:50:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we do:
> >
> >   char *cp = strchr(argv[i], '=');
> >
> > it implicitly removes the constness from argv[i]. We need "cp" to remain
> > writable (since we overwrite it with a NUL). In theory we should be able
> > to drop the const from argv[i], because it is a sub-pointer into our
> > duplicated pager_env variable.
> >
> > But we get it from split_cmdline(), which uses the traditional "const
> > char **" type for argv. This is overly limiting, but changing it would
> > be awkward for all the other callers of split_cmdline().
> 
> Yeah, it was the first thing that came to my mind that const char
> **argv is the source of the problem.  We could cast the pointer we
> give to split_cmdline() and drop const from argv[] instead, which
> may make the in-code comment unnecessary but the patch we see here
> is good enough.

Ooh, that is a good idea. It puts the cast closer to the actual root
cause. I think there are one or two other touch-ups, so I'll include
that in a v2.

-Peff
