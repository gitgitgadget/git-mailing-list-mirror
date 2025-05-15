Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5320E01E
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340386; cv=none; b=g6kmHWInzpEoul2Tn/bCaLpDqC4At8q6oUaghvUrgjrsv4O6UbA5FRvdHhB0HPKlMAXfDp1RGrcj+AaVJklIS1rYEQnJeepvur62JQTBlLVYcgLajV0pcgaPQqmn87HvHOuTC9pOUcd+MET2YUFUPDZL8b/tJF+IrfoXG3FC/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340386; c=relaxed/simple;
	bh=k0iPsz3Q2npRF3dR9+TBLr9+Hti2TZaBMxO2nDnzoF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiA8mB9+y/dJvLnTxNjzMzI9GY9E7V7/rnF66l07oFn1UPY5l/XZFOlQvaPHjNUDU8GL4FvW6yCLCvJSk9LlW1Hen+74Un4APi2TIEV/r/bS3HtYji0ooensr7Ss+idQnweJNf6wlAqST5BUIgA/ef6SLvRi8YakJkihCHTm0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K3ViXiXH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K3ViXiXH"
Received: (qmail 843 invoked by uid 109); 15 May 2025 20:19:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k0iPsz3Q2npRF3dR9+TBLr9+Hti2TZaBMxO2nDnzoF8=; b=K3ViXiXH1q06T7//TEtrDRQJA2gkhJsZkcv9Za8VwOro+cjyvm4p2EPdXg74yhfcs/F8ZBNEeJb8IZVX5DDLcDqLdDsZcVXA0+xZ0OeYYFQZjwP4quVsZpdPBfobZkCnuZg7Y3RfIfgerqZkTV8T1wC6gIqdoLYef3dZZvfyE84IoYZ2I8y1SiVmXSaJwwpn/jY8N9dK/8Vp1nj3SC9NIGpBEewNastrGCZqPmUMeb33VGx0v1I+kl+bAaLgb2+0M+04HK1iVAhHFFo0iEW0kjE8hhvCdVCjKihRe/lKSxjfbCm31OCd6+X9FgglKHQc2y7zQQu5CWFlTfMuJ0J52Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30787 invoked by uid 111); 15 May 2025 20:19:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:19:45 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:19:43 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] commit-graph: avoid using stale stack addresses
Message-ID: <20250515201943.GJ3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <077bcab206f5bfc9fc10a28ad7b726a6ec16c2bb.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <077bcab206f5bfc9fc10a28ad7b726a6ec16c2bb.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:47PM +0000, Johannes Schindelin via GitGitGadget wrote:

> The code is a bit too hard to reason about to fully assess whether the
> `fill_commit_graph_info()` function is called at all after
> `write_commit_graph()` returns (and hence the stack variable
> `topo_levels` goes out of context).
> 
> Let's simply make sure that the stack address is no longer used at that
> stage, thereby making the code quite a bit easier to reason about.

Yep, I think this is a good practice in general. If the topo_levels
member is never used outside of writing, I wonder if it could live in a
separate data structure. But that is a much bigger refactor that I don't
think we need to tackle here.

> diff --git a/commit-graph.c b/commit-graph.c
> index 9f0115dac9b5..d052c1bf15c5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2683,6 +2683,15 @@ cleanup:
>  	oid_array_clear(&ctx.oids);
>  	clear_topo_level_slab(&topo_levels);
>  
> +	if (ctx.r->objects->commit_graph) {
> +		struct commit_graph *g = ctx.r->objects->commit_graph;
> +
> +		while (g) {
> +			g->topo_levels = NULL;
> +			g = g->base_graph;
> +		}
> +	}

This just clears the pointers to the local variable. Looks good.

-Peff
