Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC2387593
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543399; cv=none; b=ITJ943vxMdwe4Ds0fDNffBx3e2Pa99e8W3iMOQdtIzSqQ1Tjzhf7vYPwSK5axv4Vh3rO5wFZzeteZovj1Mq4lg8fijw7I+KGNEm4/AE89pLE65j0WKIBxj/Ib93OOr7GFYkH+pyUR4bS8S1RYSSStf1GiF3R0LYzEljWRTlMJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543399; c=relaxed/simple;
	bh=6NT05aLHGFWeuJL5yxtXCFuU2luIjk9pvlKZ84h81h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpMgAsAeQIShCsv5pEt4qGxTxJsH8LYc6EF8bXmpq9pkqyuqbFx5CVjvDnYxPdFOFde5xbA3O/vTCdbymUr+OVyGJsbxw+7VFLdsiaL7W8vNMmUHqsHjuu+1fPFdjvnldz1hAp4P6mOc9AZJFrinFJP+XarmAsmizsj3cWJGr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S7jFc9jh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S7jFc9jh"
Received: (qmail 269615 invoked by uid 106); 7 Apr 2026 06:29:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6NT05aLHGFWeuJL5yxtXCFuU2luIjk9pvlKZ84h81h0=; b=S7jFc9jhlBC8qyscTSYNmoT0j4AKp2ot9vZIVXwec5QH5xFRXIybodEsKdMUffsO3CDEch6h0QkHwuml3HQdX7aSpLkrJVcyOFrrpbL8l0YEyx8qSn+2y+O+MeJ9pRK4HxxcRLYdrNwAQErZ9JwBjdFghfFjvaJirFVXj5apDl2u6eMFBCodSoH9PPV4ipQCvxm/Nq8KJhHcX9B8VEy34JqQCEbvVSj2p4zxrkwADYs8IBdb/y4mX/MSW18Qg5yZFAPogtkFOZymyJFKRFeKOwlYpJn6ZvMBedUn0tLouA/jMJvuxeDYKonmaTvBvfoA7bvOTPWnOKSpsNEXZMDEKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:29:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 442001 invoked by uid 111); 7 Apr 2026 06:29:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:29:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:29:54 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 13/16] packfile: ensure `close_pack_revindex()` frees
 in-memory revindex
Message-ID: <20260407062954.GG714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <e304e316ac4d4e92125e2e57b32fa445acf66e3e.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e304e316ac4d4e92125e2e57b32fa445acf66e3e.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:23PM -0400, Taylor Blau wrote:

> The following commit will introduce a case where we write a MIDX bitmap
> over packs that do not themselves have on-disk *.rev files.
> 
> This case is supported within Git, and we will simply fall back to
> generating the revindex in memory. But we don't ever release that
> memory, causing a leak that is exposed by a test introduced in the
> following commit.
> 
> (As far as I could find, we never free()'d memory allocated as a
> byproduct of creating an in-memory revindex, likely because that code
> predates the leak-checking niceties we have in the test suite now.)

Hmmm, I'm surprised we don't trigger this leak during the course of
odb_free(). But I guess we do that fairly rarely. It mostly happens via
repo_clear(), and we never do that for the "main" repo (just for
submodules). And it's unlikely that we'd have loaded a revindex for the
submodule for most operations (mostly we need them for generating packs
or when using bitmaps).

So I can't see an obvious way that this would be triggered in practice
with the current code. But I agree it is a leak waiting to happen, as
nobody ever clears p->revindex.

> diff --git a/packfile.c b/packfile.c
> index d4de9f3ffe8..97f7662e079 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -420,6 +420,8 @@ void close_pack_index(struct packed_git *p)
>  
>  static void close_pack_revindex(struct packed_git *p)
>  {
> +	FREE_AND_NULL(p->revindex);
> +
>  	if (!p->revindex_map)
>  		return;

The fact that this is called "close" made me wonder if some code might
want to just relinquish access to on-disk resources, and then pay the
cost when we have to unexpectedly re-compute the in-memory revindex.

But this function and its siblings are really about resetting the whole
state of the packed_git struct. So the behavior you're proposing matches
that.

-Peff
