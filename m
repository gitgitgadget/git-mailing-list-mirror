Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CC4D8A1
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053060; cv=none; b=WgvZwFEH2Qxn5UaXNFWgc5LViM7tiJiBFnfufri3YW53bBN6LHxhjWAOvbed3BL5IFR8BArilR/V8QG+35PlVpYVY4a1/5gBhPhBWFdBMJrYpJ5oCUxoOt3wfiSL52HLbQM1Ysc8A0mZt77rYiJvgA08cYm9ZPUFEhlAVPzIetY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053060; c=relaxed/simple;
	bh=EkIxhi26TvUo4EmiXhbso5vj2Udlp+rinMj7fpFmZCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9ZJZEFKhu5Y5LpazpGdR+GSjm7cJYlutgVYzmsIDgwPAQ3K7jbaTJQ7mY+tbScfwUJrGolbvdZ9643RLibJraFMZH0Ug+tmteV7iiSA4reMenQGMdIGVqywyK/TO6hZpdvJwGQEa+WgIkHErKcKm49umJTffMAnVJKhW7GROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16930 invoked by uid 109); 30 May 2024 07:10:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 07:10:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28123 invoked by uid 111); 30 May 2024 07:10:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 03:10:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 03:10:57 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] midx: replace `get_midx_rev_filename()` with a
 generic helper
Message-ID: <20240530071057.GC1949834@coredump.intra.peff.net>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
 <f4f977c1c71ceed339361e8463bace9edc42ec45.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4f977c1c71ceed339361e8463bace9edc42ec45.1717023301.git.me@ttaylorr.com>

On Wed, May 29, 2024 at 06:55:42PM -0400, Taylor Blau wrote:

> Commit f894081deae (pack-revindex: read multi-pack reverse indexes,
> 2021-03-30) introduced the `get_midx_rev_filename()` helper (later
> modified by commit 60980aed786 (midx.c: write MIDX filenames to
> strbuf, 2021-10-26)).
> 
> This function returns the location of the classic ".rev" files we used
> to write for MIDXs (prior to 95e8383bac1 (midx.c: make changing the
> preferred pack safe, 2022-01-25)), which is always of the form:
> 
>     $GIT_DIR/objects/pack/multi-pack-index-$HASH.rev
> 
> Replace this function with a generic helper that populates a strbuf with
> the above form, replacing the ".rev" extension with a caller-provided
> argument.

Makes sense, as we have similar routines for packfiles.

> +void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
> +			   const unsigned char *hash, const char *ext)
>  {
>  	strbuf_addf(out, "%s/pack/multi-pack-index", object_dir);
> -}
> -
> -void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
> -{
> -	get_midx_filename(out, m->object_dir);
> -	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
> +	if (ext)
> +		strbuf_addf(out, "-%s.%s", hash_to_hex(hash), ext);
>  }

This bare "const unsigned char *hash" caught my eye, as we've mostly
been removing them. But it was present in the original, too; it was just
hidden in the return from get_midx_checksum().

And I'm not sure what the non-ugly version is. We implicitly use
the_hash_algo for these kinds of trailer checksums, and calling them
"struct object_id" is probably even more confusing. I guess they could
be "struct csum_file_trailer" or something, but I'm not sure that would
actually make anything more clear. Anyway, none of this is new in your
patch and we can ignore it for now.

-Peff
