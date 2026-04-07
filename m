Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15398337699
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541882; cv=none; b=AkmYDZAXUUKG5MUcGAL+hogh9v/sFEW9bICekEv9sHARuNY/gIzd6n6XSQh4XLgmdXEDIoM/V9j0vuw/EqbZIhB3tLNIopIn2rV7IPTu42lqTQQPQnnGlqPKhBuikHIWz0e1hWVZaLsr/4SD7KWPh5kUYXPd07xP7ThLPODFiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541882; c=relaxed/simple;
	bh=795OLz7XY63PzAqnZt76lo0rPsP0ty0ElhHYzyif3WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG7U194Qbaf0hZGmBlxXlz3t+CEsX2dyRRQ7yCe4yPqQWhS6eetq9EpbbrFSbd9CSf3YYXv363h3Y4/ltHf/tRZp3NoTqa3+dr/rquX+GM29lNYQep5FR9k3AdInFXog90rw5WxKTfTLVjJ0XqNyTMxEgKWQ6O+As30M3GF8chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X9htazCH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X9htazCH"
Received: (qmail 269401 invoked by uid 106); 7 Apr 2026 06:04:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=795OLz7XY63PzAqnZt76lo0rPsP0ty0ElhHYzyif3WU=; b=X9htazCHWpw3tCkbrSkXFVgvYrW9Y7pTT36A+O9Ui8/ZnK9xlZUFaw0snYoV6EsIuYuQgxBKDXdehW2NUHgwL+0mXVAmjX1cEj1ihEFftOP3WPgBf/d5BaqLnio0dTj4/ZFjiWhxLXzpDZY4HQsnupvJtZKpeDSZvecxabyu/pyfUeYKr0nXdCmgtxhTC4FthrXnx3EZxfDoBjsmwxIV/NtMMx8k4SyjgICAeJFG7xl6C0pAi9a92qAtUsv2xAMSbYpovfjSZK+fvfjhBnI/MHyjKnJOkEk9UB3QM1M0x9ItsTEAkdhvwPwJD8oh7VIJfIlWaoZ11jmx0SwxlELlqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:04:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441702 invoked by uid 111); 7 Apr 2026 06:04:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:04:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:04:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 07/16] repack: track the ODB source via existing_packs
Message-ID: <20260407060439.GB714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <2d377f534071ad9def3fb4860b2581197d02726b.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d377f534071ad9def3fb4860b2581197d02726b.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:08PM -0400, Taylor Blau wrote:

> Store the ODB source in the `existing_packs` struct and use that in
> place of the raw `repo->objects->sources` access within `cmd_repack()`.
> 
> The source used is still assigned from the first source in the list, so
> there are no functional changes in this commit. The changes instead
> serve two purposes (one immediate, one not):
> 
>  - The incremental MIDX-based repacking machinery will need to know what
>    source is being used to read the existing MIDX/chain (should one
>    exist).
> 
>  - In the future, if "git repack" is taught how to operate on other
>    object sources, this field will serve as the authoritative value for
>    that source.

Makes sense. I wonder if we still need the repo field here:

> diff --git a/repack.h b/repack.h
> index bc9f2e1a5de..c0e9f0ca647 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -56,6 +56,7 @@ struct packed_git;
>  
>  struct existing_packs {
>  	struct repository *repo;
> +	struct odb_source *source;
>  	struct string_list kept_packs;
>  	struct string_list non_kept_packs;
>  	struct string_list cruft_packs;

since we are going to mostly be operating on one odb source. But I think
it gets weird asking about things like "which hash algorithm to use",
because then you end up back at source->odb->repo. Plus there are some
parts that seem to look at the whole repo.

So I think it gets complicated and is well off the path to our goal, so
not worth thinking further about for now.

-Peff
