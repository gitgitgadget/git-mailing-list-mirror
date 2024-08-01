Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00A446A1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507475; cv=none; b=fRXxyNCeXpvF/oysnMr1vksgYgkJrFDetCEyZFRPjBrhqzuaTmOqYS1m6sTvd7yvC2ULyiheyEmxcrcmC6MiDDwLdpoHHa0t3dpHsBS7w9mW/nA6MhnIycFsx0hBD2ZxNwFHu9Hab64QlnNW8NFzkZrnmgmhCFrmhsc77ilx3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507475; c=relaxed/simple;
	bh=4WzFol3bbKCspYyDKsf2JywQyygArb0Cll0D5zi1bnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIG3yCX5Lq1nzitJNjhgiuNN1UPl13G/m7m/Lm/GLmPxM+/C1//dfdCZmfa/EQs9cFtaFOYCYAd6XIS2QiZUDCggGXqtO2OPBI9mpZbWq8ShyJILOENst4QsE2O7kXiGx7pdx0R+0mvW7gEfKICLQ1r/K56GhHnciS6HDt3Rbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19032 invoked by uid 109); 1 Aug 2024 10:17:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Aug 2024 10:17:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30523 invoked by uid 111); 1 Aug 2024 10:17:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 06:17:57 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 06:17:51 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/19] midx: teach `midx_contains_pack()` about
 incremental MIDXs
Message-ID: <20240801101751.GL1159276@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <fb60f2b022d1dc8c0e6df53253dc924f8d00a382.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb60f2b022d1dc8c0e6df53253dc924f8d00a382.1721250704.git.me@ttaylorr.com>

On Wed, Jul 17, 2024 at 05:12:32PM -0400, Taylor Blau wrote:

> Now that the `midx_contains_pack()` versus `midx_locate_pack()` debacle
> has been cleaned up, teach the former about how to operate in an
> incremental MIDX-aware world in a similar fashion as in previous
> commits.
> 
> Instead of using either of the two `midx_for_object()` or
> `midx_for_pack()` helpers, this function is split into two: one that
> determines whether a pack is contained in a single MIDX, and another
> which calls the former in a loop over all MIDXs.
> 
> This approach does not require that we change any of the implementation
> in what is now `midx_contains_pack_1()` as it still operates over a
> single MIDX.

Makes sense. There is no ordering or relationship for which packs might
be in which midx, so we have to just walk them linearly and check each
part of the chain.

-Peff
