Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531903CAE84
	for <git@vger.kernel.org>; Wed, 13 May 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713709; cv=none; b=Zqwa0AbVxAmE/DWf7gjsxkUglxcdny5z9BSUz6zUAEDuvEU6U0PZt11lyOyyOihkVzONvL85Ksdwc96vSpYZ87VWDu9ZyuvHE47RPSIAvMRdGCkEwsQv/gPcW/gqd/bLPCGaCerXm8PC638aUbwOCDPJhOdUPz5pWXKB01YTZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713709; c=relaxed/simple;
	bh=NblrVA1S6X/jL8yoZftwolSiWipAJGOsKa8hnX/vJsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgBV8jqZELHQY5KOrCkdpWS+apoEJ5NOHduIVwa0ya1uMoM5g1/7Vv5dPFlpAaqwU8sdFZWDLC9g/Jiwus8SV9WaF2QmMvE4lW/X3EBz5USLl4NKAEe1MHu2fyX2bOLxKnfFLUf0alooVRfpqQiZjD7Q/PbilzDvE+FS5Ws3VZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HTk25H2V; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HTk25H2V"
Received: (qmail 41198 invoked by uid 106); 13 May 2026 23:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NblrVA1S6X/jL8yoZftwolSiWipAJGOsKa8hnX/vJsY=; b=HTk25H2VWb3ZlQfh9FjSn4LDSfEgoPxYLjaGn3ajv1Esmf9TV1U9rPS3ITllSoOEqt5MFtds47t9MmH6U2av8zdsGc8ym5PnoqgniQ41lUe57+64UbWM6cWL26k+qMkcxI9ksV9Ajj0+r4dLPI1Z2ndq0ViiRlTDQUbLYOk2Fm72Z7Nbjkz0nray5Ej5goFgVjke25Civ8z/KxeYdq7nY4taSgWbR7c3CQa8DOGFfawL6V1s9N1atDEdt/sTAl/gYXtHFgQHBCWLSsgfW0XmdAbdeUQfan89QZESV1uuROX367BoVUO57isKc3fGWxr4+skki3gsbzYSkOdZWS0zRQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 May 2026 23:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73254 invoked by uid 111); 13 May 2026 23:08:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2026 19:08:25 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 May 2026 19:08:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 15/16] repack: introduce `--write-midx=incremental`
Message-ID: <20260513230825.GA1378716@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
 <04cfecd5136b2e5a3f76d538f7adbd697b6f5abf.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04cfecd5136b2e5a3f76d538f7adbd697b6f5abf.1777507303.git.me@ttaylorr.com>

On Wed, Apr 29, 2026 at 08:13:49PM -0400, Taylor Blau wrote:

> +void clear_incremental_midx_files(struct repository *r,
> +				  const struct strvec *keep_hashes)
> +{
> +	struct strbuf chain = STRBUF_INIT;
> +
> +	get_midx_chain_filename(r->objects->sources, &chain);
> +
> +	if (r->objects) {
> +		struct odb_source *source = r->objects->sources;
> +		for (source = r->objects->sources; source; source = source->next) {
> +			struct odb_source_files *files = odb_source_files_downcast(source);
> +			if (files->packed->midx)
> +				close_midx(files->packed->midx);
> +			files->packed->midx = NULL;
> +		}
> +	}

Can r->objects be NULL here? If so, then the get_midx_chain_filename()
call will segfault, since we look at r->objects->sources. If not, then
this conditional is tautological and can be dropped.

Looking at the two callers, the one in repack_remove_redundant_pack()
unconditionally looks at repo->objects->sources itself, so we know it is
not NULL there.

The other is in write_midx_incremental(), but the flow there is less
clear.

I'd guess it is probably the case that it is always non-NULL so there is
no bug, but dropping the conditional would make the code more clear.

-Peff
