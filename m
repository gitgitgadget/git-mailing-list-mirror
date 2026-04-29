Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDF32D0FC
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450220; cv=none; b=oA0p5deGjB+fijeLVs0Nr6SzwsFqMQqwwJMkQVW/hNevqA8NoHRIvkumuG6/bsNrQxPeMQLRcyNvDwCvZnTjFWO6tMkAq5a9uxTmRRmLAoANC4PhYgNHU7GzMzTQpVIOcrcEPD+mbB6jBwy/nyj9ES9IjpfFTot7091ewpgFYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450220; c=relaxed/simple;
	bh=ZN3LgBwxliVmE66Yc1x/J9WecLSB5FoClsdwXBhY5BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRaheQ59XRASt0KjS2PA6AHG0yjvbRge0hZ3Xlfdwp3PTFB4B1wXB9NNR4IfmJx1cABexIj6eePYJ19R1I08tRWMYwIazzgDGSqDhaEt3GUDZTaWOE1nadgyq2Dm1rgIOTeun4fry/D2tyZAmNNkKPMTehsgWBBFa2iZOTNBoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KZ34DGls; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KZ34DGls"
Received: (qmail 485877 invoked by uid 106); 29 Apr 2026 08:10:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZN3LgBwxliVmE66Yc1x/J9WecLSB5FoClsdwXBhY5BM=; b=KZ34DGlss+obCMZjS5m1CygSArfyUklOBNVQXxBi5pLv+3lnKddWnv+cDJErk221BDCXqEo8j09xPklbvs+raU/6FjmSGNlKh3IgVeMUDPO2PvLTyS/7Kldg7qcvn4kPIJV/TeFX1LjNamV9/IpPTh6OX4hYNnxTVjomwCVwl2bKx3VLVEs5wWk7/mdQrX5z+cHx+uPmHk3o/1JcGeF6YrVTp+poKbakKhMwGtByQ6ieA3fQdcQ7BWv/PFlCqKQ6wmgxdi/2OyNbGXm/FT23WCHxlR7Y4NFzAW2A9PxUQPkzJpGlzEijnycxATLzyZzXhV7crTIPpghK7fR7BK1tWw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Apr 2026 08:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099805 invoked by uid 111); 29 Apr 2026 08:10:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Apr 2026 04:10:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Apr 2026 04:10:17 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 14/16] repack: implement incremental MIDX repacking
Message-ID: <20260429081017.GB1269182@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
 <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93e152fb6aa3bbd450d46c6cdd219dfef14d41fc.1776803827.git.me@ttaylorr.com>

On Tue, Apr 21, 2026 at 04:37:54PM -0400, Taylor Blau wrote:

> Unlike the default mode which writes a single flat MIDX, the incremental
> mode constructs a compaction plan that determines which MIDX layers to
> write, compact, or copy, and then executes each step using `git
> multi-pack-index` subcommands with the --checksum-only flag.

This should be --no-write-chain-file, I think.

Ditto here:

> After writing the new layer, the strategy is evaluated among the
> existing MIDX layers in order from oldest to newest. Each step that
> writes a new MIDX layer uses "--checksum-only" to avoid updating the
> multi-pack-index-chain file. After all steps are complete, the new chain
> file is written and then atomically moved into place.

In the code I think it is all good, though:

> +	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file", NULL);

-Peff
