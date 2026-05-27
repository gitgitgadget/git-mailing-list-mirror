Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A953DBD4E
	for <git@vger.kernel.org>; Wed, 27 May 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872263; cv=none; b=krTY2tx4k8RQCVaHdi0dNdvbcJmPlyBCx0aHODmpLainP5l/DYW0ub48fknmR93323V0YgIDwuiqaR188z+Wz7MxAO8+e/73lTeFr+TD1Qk+RH4YaPOkD3GSOvOi4ya2CQSriafCE1SBit+vSwca7ZAHWH1bZ29goNvGYdZTwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872263; c=relaxed/simple;
	bh=8zwicSTVawlJcNWFC5qFoRCqZC7AOicv13w9emuyVYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rth9JnQRXKzt5hY2/pSOj7bAPkeVyLD18b6jV0P/s5+OWHDX5ktpaukq2rJ3iPR3cC4TGIM/3tQyd8tW3aFRkBY6kMGYvGVrkW7tPgMw2+iR+E289Za7hjwXoAXfZbFr6T52IMv0nwc2gAt/fXHQS8c8sAb7y8L0ZUqysNoFPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MvO9vxg1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MvO9vxg1"
Received: (qmail 28751 invoked by uid 106); 27 May 2026 08:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8zwicSTVawlJcNWFC5qFoRCqZC7AOicv13w9emuyVYQ=; b=MvO9vxg1DTDM/MMufVrv6/0nfv5D/Wr4Q4+8GwRPXYePv/MM1SEkJ4k/jAAUy9+7r/Eb992H2aiwAkWAi9GHMg5WC5oaauKLltWaZokciLpKxNq0HbCu5Y/AoZB5t5FbD/O6kGJvZpAC0VOmmf3fwJjdSS/4sRtfNM02OlVE+2oXjvXvYJdlvVxIyW0wLWhk29udf+UFTc3qaPeRUL7HA5ntozQhP3j88yg7iEMqxvmFzGgKVrNFt26z6D/jL4vg1iG4i6H+OijP7G3FAJ16ieLSmOWcbGDX91S0FQsaKuLpXY0W57mDsXWIF3zLncaiLI2MSPDjyGkZ7oe7fdIWrQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 08:57:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71391 invoked by uid 111); 27 May 2026 08:57:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 04:57:45 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 04:57:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/8] pack-bitmap: pass object position to
 `fill_bitmap_tree()`
Message-ID: <20260527085740.GB981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <13191c19b91bc3f5d671b7016b97f2309f12737d.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13191c19b91bc3f5d671b7016b97f2309f12737d.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:36PM -0400, Taylor Blau wrote:

> In the following commit, callers of `fill_bitmap_tree()` will be
> required to check the bit corresponding to their tree before calling
> that function. That change will reduce the overhead of setting up and
> tearing down stack frames for trees whose bits are already set.
> 
> To prepare for that change, have callers pass in the tree's bit position
> in `fill_bitmap_tree()`, which will make the next commit easier to read.
> 
> In the meantime, this change has a surprising and measurable benefit
> during bitmap generation, particularly on very large repositories.

It is indeed surprising. There's a possible candidate for the speedup
here:

> @@ -482,8 +479,12 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
>  	while (tree_entry(&desc, &entry)) {
>  		switch (object_type(entry.mode)) {
>  		case OBJ_TREE:
> +			pos = find_object_pos(writer, &entry.oid, &found);
> +			if (!found)
> +				return -1;
>  			if (fill_bitmap_tree(writer, bitmap,
> -					     lookup_tree(writer->repo, &entry.oid)) < 0)
> +					     lookup_tree(writer->repo,
> +							 &entry.oid), pos) < 0)
>  				return -1;
>  			break;

Whenever "found" is false, we cut out early and skip the hash lookup in
lookup_tree() entirely. But that should almost never happen! It implies
that a reachable object is not in the pack/midx, and thus the bitmaps is
not closed (and we'll refuse to generate it).

So it really is the case that we do the same operations in a different
order. Weird.

But the patch itself looks correct to me, and I get ~6% speedup on a
from-scratch bitmap generation of linux.git. I guess it could vary
between architectures and compilers (I'm using gcc on x86), but since
the reorg is setting us up for further optimizations in the next patch,
I suppose there's no need to look a gift horse in the mouth.

-Peff
