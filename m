Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95A38B140
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790979819; cv=none; b=XUgoIjgCLfhgYIJc5JDWSdSXTUmJH4Nf4tbSmOA00EQrTnGHXbx4T5odozr5Ndzn/EdKobziLDZrM3FGlQ7z83j8G4mkb948E1dlyh3ctdohpUf14D7sqJkMHg7rtj5d2figfE/FJQGPle+u2GmcvY0Gl1I1xM+35zUPI3qbRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790979819; c=relaxed/simple;
	bh=+XR92VfrTA/jwheiae8s81kSVL6zKZweBIrCtM/DH3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh2G5GWuO5q4JYGcgRrSrFDg8XXkSMhUgkCaZ4yNrvltiuMGUBCIQbJD0gJesFa7mqd8araIuYBLM5u0iLD5BUlmg2ZD0UEQ2duVVW9hacacttFTpk+z9QYLQF0aKdwBoqGEGYvomzdVnhl1eoKrx0ZnOgFTUubBHkjN4bbeOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FyVysFOh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FyVysFOh"
Received: (qmail 16648 invoked by uid 106); 2 Oct 2026 22:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+XR92VfrTA/jwheiae8s81kSVL6zKZweBIrCtM/DH3s=; b=FyVysFOhnd1Mo+Tx9jQCB3cA3mSL98EH0ZTv6Fm8wUTjerWj2aKfdVIl3gS9gr2dTTgtuIuuzrC4UFRyG8cun4NhASG4dezVSWdSwBbFzFZt/QM/JWOwdYw17VcuE01x1aCd+P+LWyt7Zz9yfw9Og7ss73fEwnjZnBld1KaoT1FkCD8iPZGn86ScajVTvPU1mWOi/NSCjmunrjvJlRvhy5eMIapiNbjwa3qrIPx78WSnUKd8RYU7EwnEqhjom1khe8+iaFIg00PbfkDp3cy1pbXH7McoSrjK9sQ7iMHXYXz+39XDLRKrG2uRgeTv6T9px/Rbrr9wE+Lq+aAkmK9sLg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 22:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 48616 invoked by uid 111); 2 Oct 2026 22:23:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 18:23:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 18:23:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <20261002222335.GC833115@coredump.intra.peff.net>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
 <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>

On Fri, Oct 02, 2026 at 09:34:07AM +0200, Patrick Steinhardt wrote:

> Note that the added test reliably reproduces the above bug on my machine
> that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> specific allocation behaviour of glibc it is very likely that the test
> will not work on other platforms.

At its core this is a user-after-free bug, isn't it? If so, I think it
would be fine to say that ASan will reliably find it (and we don't even
really need to demonstrate the complex case where the packed_git has the
same address; all bets are off once we access the freed pointer).

-Peff
