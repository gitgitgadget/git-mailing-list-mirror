Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368F3019AA
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062039; cv=none; b=nEqsrA4pBkKHsqiW/3kux0oN19h7Wuz1k5lld/5r3diFdBqAhdqjTcm7Xw6c97+HpNncoy7dEn6ureOMSBLGvCedpcUqCG3blPQBbVDkLHiLtUeeFaMU/menCSl58YnmyD0EjuWpvn2JEemeKKEPe7vQWAKbq1mjExoulCfGi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062039; c=relaxed/simple;
	bh=1seBdkeNSkGLgehAy1DHHevySgG2PQ4fmIpqP3gz164=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5te4e3l91FCHEwhYiJrDLuN1jLWp/lQD6WoIRjBZ7ScP4H9wa7nNYsM7cCVztIf3Bv00i+lGe2XYH07JConNCEQnK4JeNp5dylu9o3JjXtupy+Glr2zITVaQAhdc/oNuW8Gg/jLcJ76ZlI9LBFBIE513sLY4OE2hW+mBTg9iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FqsItKD2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FqsItKD2"
Received: (qmail 91222 invoked by uid 106); 3 Jul 2026 07:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1seBdkeNSkGLgehAy1DHHevySgG2PQ4fmIpqP3gz164=; b=FqsItKD21+OsGo7nWAPjT1Sn/DjpsrMGgc4pIayoHQuL12Si34CLrLFo5VxyaHlj83s6eOHABaRMxozGoM3dhSGG73N+J9/pCln3s5NJxiwwXU7PqNTmbNikj7o4ldh7j+1AtHHYZpdIkHGQs1YgRhui211lmCTVPdTgARjtRM3rSRh1Q21C8MabVGv6OhaSePXnUXQJwu/JYcivbREM8AzXRPNIOtIcPiHoSmKeJfTzIA2qJw2yvu+5nBLZakAfx/3xWW3SOlf05U89oQkv+11Izz8FYuxrN8+zbmPgzhMpgDVJ3PgfN96W22AiOZFcsWy8E9he1ZRvxrng/96xUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jul 2026 07:00:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 194000 invoked by uid 111); 3 Jul 2026 07:00:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jul 2026 03:00:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jul 2026 03:00:30 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Message-ID: <20260703070030.GA2082500@coredump.intra.peff.net>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
 <20260702211614.GB2051171@coredump.intra.peff.net>
 <akdLqNHW3pGThQat@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akdLqNHW3pGThQat@pks.im>

On Fri, Jul 03, 2026 at 07:42:00AM +0200, Patrick Steinhardt wrote:

> > It feels like test_copy_bytes should be able to do much better in
> > general. The obvious thing to reach for is "head -c", but the function
> > was originally added because that wasn't portable. The "-c" option is
> > not in POSIX, though the original comment claims IRIX was the problem,
> > so I wonder if "head -c" is de facto portable these days.
> 
> An alternative could be to implement a simple helper as part of our
> test-tool. But I doubt it's really worth it: almost all callers only
> want to copy a small number of bytes. The only exception seems to be
> t0021, where we copy up to 65kB. But that whole test suite still only
> takes ~3 seconds, so optimizing that feels like wasted time to me.

Yeah, you're probably right that it's not worth worrying too much about.

-Peff
