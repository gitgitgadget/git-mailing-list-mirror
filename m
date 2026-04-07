Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE23793C8
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 05:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775541476; cv=none; b=gbeiQbIlok9Y/1W9UO/OddipMFxMQfWyVfSpcPQPPSqrBkHDeYFNCZhvtPp2ksUhYkcQdwwDJAWKNKqw6XiTgDCfxdi5CHG9P5JJE0nn/3Pj03Q8rnWa6CkeGHIocvlTHDeaxggq/PZrnWt4NmwlG0cMaTu4X5XeCcnTyXsMotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775541476; c=relaxed/simple;
	bh=zXBPKcU/Zre1argrarYc0bNzabtvCxvR4kYgKUDzMtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZITitWBGDtzFi29PvkEfy9GCQt2cgGuIOq/+atZFDO8lzPJOXjjaZvTEQfrxQTgOSFxdmJuPLPsFNtn/ASDp22HpufjoNewtPVa1R3iyKlNrnms3fbSLJMLHuUX7HDgl7WXofkhx/9k/C41/NnulUJKIhWBJ3xqMdP/mwq/j6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eIAy0neA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eIAy0neA"
Received: (qmail 269360 invoked by uid 106); 7 Apr 2026 05:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zXBPKcU/Zre1argrarYc0bNzabtvCxvR4kYgKUDzMtQ=; b=eIAy0neAF0iNkJblsR+joThert0E7tQMsEPgPa7KmUiCo3U84+QHFNRDxodtARfyJ4OXq9WRX3tUTQBsEKj/2uLOdfTXLb2FB3GYf9DABwDd+zrjxxyqNbpa1vtqPJUdueuAVS4wET8nBlCs9QLIpZmxe3WBy8jztMYoJiOt/AC6ELtgnL64W5wdBaA3VdryeVvthdFh+f1nLOUuU741gM5jZdkDo3vDEK2SiaMy+fN7bka5siYp771yZ05zCv+I+NDO2F70SKET/8Jy6k4oCRgmI3CjWBiQym6iU48j9NKKBBqMW3gNoZJvGJ4MihU8eVxRuGrBNDTfp30wm/eU+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 05:57:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441638 invoked by uid 111); 7 Apr 2026 05:57:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 01:57:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 01:57:53 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 06/16] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <20260407055753.GA714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <6b42d284b79a25e97d506e22c709e4dbe6fddd58.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b42d284b79a25e97d506e22c709e4dbe6fddd58.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:06PM -0400, Taylor Blau wrote:

> Introduce a new `--base` option for both subcommands to specify the
> checksum of the MIDX layer to use as the base. The given checksum must
> refer to a valid layer in the MIDX chain that is an ancestor of the
> topmost layer being written or compacted.

OK, that makes sense.

> The special value "none" is accepted to produce a root layer with no
> parent. This will be needed when the incremental repacking machinery
> determines that the bottommost layers of the chain should be replaced.

My gut feeling on reading is that a chain based on "none" is really just
a non-incremental midx, so we could just write that. But:

  1. I don't recall off-hand how expensive it is to convert a
     non-incremental to an incremental one. I.e., can we just rename the
     file and write out a chain link and it becomes incremental?

  2. Even if it is cheap to convert, I can believe it makes geometric
     repacking easier to think about if we just always think about it as
     an incremental midx.

And perhaps (3), I am just wrong that they are the same thing. ;) I
haven't thought it through all that carefully.

> If no `--base` is given, behavior is unchanged: `compact` uses "from's"
> immediate parent in the chain, and `write` appends to the existing tip.
> 
> For the `write` subcommand, `--base` requires `--checksum-only`. A plain
> `write --incremental` appends a new layer to the live chain tip with no
> mechanism to atomically replace it; overriding the base would produce a
> layer that does not extend the tip, breaking chain invariants. With
> `--checksum-only` the chain is left unmodified and the caller is
> responsible for assembling a valid chain.

OK, makes sense. If we are using --base we are doing something clever
and weird, and the chain tip should be left untouched. I guess "midx
write" would never delete an incremental (it is always just adding one
more to the chain), so we don't have to worry about that. Presumably
we'll eventually write out the new chain tip from the caller, which will
then have to remember to delete the now-orphaned chain elements. But
that's kind of the point of the new geometric approach, so it seems like
things are falling into place.

> For `compact`, no such restriction applies. The compaction operation
> atomically replaces the compacted range in the chain file, so writing
> the result on top of any valid ancestor preserves chain invariants.

OK, so there's an implicit base..tip compaction here (as opposed to
without --base, an implicit root..trip compaction?). Makes sense.

> @@ -83,6 +85,13 @@ marker).
>  		and packs not present in an existing MIDX layer.
>  		Migrates non-incremental MIDXs to incremental ones when
>  		necessary.
> +
> +	--base=<checksum>::
> +		Specify the checksum of an existing MIDX layer to use
> +		as the base when writing a new incremental layer.
> +		The special value `none` indicates that the new layer
> +		should have no base (i.e., it becomes a root layer).
> +		Requires `--checksum-only`.

Not really a critique of this patch, but I'd guess that a lot of these
options are getting esoteric enough that it is hard to understand 

> [...]

The patch looked as advertised, and I didn't find anything in it to
comment on.

-Peff
