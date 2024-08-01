Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A85EEB3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505191; cv=none; b=Y1oysNt0ySKvDtDKbywm4DywCl9C3BkovUMQTF5NAs2M6ZKW7yTyMx+t8DRzQp8L0654soUgV2jMkSanuf3He5U50T9gpsT4k0UChxodfUmwBjfTAKDxL0xcbsZutrx9C8bAD7Rh0Wo2ehzotX1kjcbm7HOFGXb5ETKhiwWzMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505191; c=relaxed/simple;
	bh=YFuY+OptPqRFWVQvZu6+u60zn1PHxIhdyzH6802aq8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdNNNlpRkWUysJfPFSIsasixH86OOUL7O9Soc6AOMHJBIbgT1e0DdPcl2OhD/ZeM5Zu/jKcrN4RsI/r/TNFV9oGV1tDlsLHGKQ3sECHqyo9pnuZh3bmb+2IRmoyWNnuNpHFomr3S+O+eU5zMFH8uUEjWjW+OKk9wO9Zw/0rP/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18775 invoked by uid 109); 1 Aug 2024 09:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 09:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30197 invoked by uid 111); 1 Aug 2024 09:39:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 05:39:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 05:39:47 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/19] midx: teach `nth_bitmapped_pack()` about
 incremental MIDXs
Message-ID: <20240801093947.GF1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <650b8c8c21b7e8a6e4f65d9b47185a875f0022bb.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650b8c8c21b7e8a6e4f65d9b47185a875f0022bb.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:13PM -0400, Taylor Blau wrote:

> In a similar fashion as in previous commits, teach the function
> `nth_bitmapped_pack()` about incremental MIDXs by translating the given
> `pack_int_id` from the concatenated lexical order to a MIDX-local
> lexical position.
> 
> When accessing the containing MIDX's array of packs, use the local pack
> ID. Likewise, when reading the 'BTMP' chunk, use the MIDX-local offset
> when accessing the data within that chunk.

OK, makes sense.

>  int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
>  		       struct bitmapped_pack *bp, uint32_t pack_int_id)
>  {
> +	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> +

Heh, after the last one reused the "n" variable, now we are back to a
separate local variable. Not wrong, but curious to go back and forth.

-Peff
