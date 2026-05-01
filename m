Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90828C009
	for <git@vger.kernel.org>; Fri,  1 May 2026 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777618004; cv=none; b=mQi1K/PgIz4wzLDkN1hJgzcFJp0ZJRfvNC7/qflfXaWQ7bwzmT96pSu2vqVl1dnoGa0YiL5L7MjPcb8WsB348DtPqsF3XVDw3g7XMOgGJSTB2MWw6Z7I294ZpPY+iBke0rS0B1LzTdggVH9rlJRToDMF0A/1irKi8Boh1VDIhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777618004; c=relaxed/simple;
	bh=g2zKM/k3xwUncKrZiEXje1ceeEZ13oj9RGSZpaZq8z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjnCUsFJs4ryBajKBb+VRNc+paPiQvxSmyQHVNOgRQLsuM47uehzC/+ySD3dxgvjsUpk4BeVM5qfMa+0ALCFuAxS9jxlBikst36ImRaAspNzZteaIhEI3TkB1V4qWTK/2AkgySQAjPiWtzz6nJArML6b4zdSSjdD2Il4vZW8F9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nif3EtAz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nif3EtAz"
Received: (qmail 2288 invoked by uid 106); 1 May 2026 06:46:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g2zKM/k3xwUncKrZiEXje1ceeEZ13oj9RGSZpaZq8z8=; b=Nif3EtAzYYcjx37BT+FVLcFm4p2M+BGGhiBZMbrGTYUxTLG7w1FmrIABZdt4+b6pmoPDup/ci4iDne03TH4ScF+lkoPlru/HXB0u/XD8cNIdBKo/Z/I/CwEfOiz4BkJX21ZcoV8ykBX9cwRi6UlkcuQ+cBAJKea2gIDMq/roNCluPr19GsxFOoqNuFqvxw4RUmfmpv1D81ja5Vd5MpBRCdQp6LNbYUgQMUuQUx9+7zGUgNuk1zh7BiYykTrVlpBAzegWm4afvI+axVEzs7hYnkGvkBKMH9zCS7cV5LBMNVzBUVGd5ZD8pqUxxVTodjr+FGj5yGEdyMEEmSAk8oc/Eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 May 2026 06:46:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3875 invoked by uid 111); 1 May 2026 06:46:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2026 02:46:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 1 May 2026 02:46:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <20260501064640.GB2038915@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

On Wed, Apr 29, 2026 at 08:13:04PM -0400, Taylor Blau wrote:

> I expect that this should be the final reroll absent any late-breaking
> feedback. The only changes since last time are the following:
> 
>  - Various stale references to "--checksum-only" have been eradicated
>    from commit message(s).
> 
>  - `repack_prepare_midx_command()` now uses `pipe_command()` to
>    eliminate the possibility of a deadlock.
> 
>  - `write_midx_included_packs()` now cleans up after itself properly
>    when receiving multiple lines of output.
> 
>  - The errant test in t7705 was moved to the final commit (where it
>    belongs) instead of the penultimate one.

Thanks, the new pipe_command() and leak-fix for patch 14 look good to
me.

> As usual, a range-diff is included below as well for convenience. Thanks
> in advance for reviewing!

Something funny going on here:

> Range-diff against v2:
>  -:  ----------- >  1:  d6c27317c25 midx-write: handle noop writes when converting incremental chains
>  -:  ----------- >  2:  629c8d23116 midx: use `strset` for retained MIDX files
>  -:  ----------- >  3:  e303bf6a4ac midx: build `keep_hashes` array in order
>  -:  ----------- >  4:  42d76c70060 midx: use `strvec` for `keep_hashes`
>  -:  ----------- >  5:  2c80aa34fac midx: introduce `--no-write-chain-file` for incremental MIDX writes
>  7:  d9acef1334a !  6:  2a05f4b86f3 repack: allow `--write-midx=incremental` without `--geometric`
>     @@ Metadata
>      Author: Taylor Blau <me@ttaylorr.com>
>      
>       ## Commit message ##
>     -    repack: allow `--write-midx=incremental` without `--geometric`
>     +    midx: support custom `--base` for incremental MIDX writes
> [...gigantic range-diff for this commit...]

I'm not sure what's happening here. The 6th patch in v2 was "midx:
support custom --base...". The series you sent looks right, I think, but
maybe your range-diff endpoints were wrong or something?

-Peff
