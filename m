Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073282F2609
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455779; cv=none; b=rtmbsX8QNT38lpvUMBL3PRgez2FG837uE5U+mWAi8Hlwan+25z8ykLqaGYSSDQV8sSdlILR11KF8yQGMq+0ZdNsw6LFi7vBvNPDz9Bpv5ueQUkOR2/el/5rk5+pJT/RFvffM4kVUcD32toSFl8p81HDrtWyMhr466jLVz/Oy6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455779; c=relaxed/simple;
	bh=d1OC2/jdybLlkQ2QkOLoJWKHMMZYX0K4eP6igV754XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMjnJmpsdv1Hc4fv1llVgtp5LegD7mqNCGoPJExqMbrJZSYgES2gS+KXMZGD/i0KVrl2ke/z7B22BgrLNkCa6O3etabtcSIcpqB/WOXmkU7U4yoQrWTSEHgiZTL3DI5xxJ3oWZabl8800BELEubp6u+b/gg93j43TCFN82buCHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d5nCPIq8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d5nCPIq8"
Received: (qmail 19428 invoked by uid 109); 18 Nov 2025 08:49:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=d1OC2/jdybLlkQ2QkOLoJWKHMMZYX0K4eP6igV754XI=; b=d5nCPIq8xTk8Q6dVFG8btjVaMw7sZg+Mxtt43Z62okU/9TI8CCQawF2xMtugPtNYwv69Kr0Bj2/wGHboWApnIqcjFnGtNLm14obvZchOcoT6l1ST9wfCAZ0r/odl35qAWVju6N5GslhsbGkb2xVAWifDayIwkgfu8lAxXRLotedfzPjrx0ttAf1umMG2HcoJofnl1rgrDWKAWLjgw2MSGfWXDUcIs36L3m6yDhSNnkUW8FxJRDWfBHa0iDtFWCoFuSFI7fEoCsmemZsvrs0rHXvN62yyAauWgj4dianiBSSTPOEc6OKa6dkvV/FezrZdItFp5Ksh5XU0d2qlHdPteA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 08:49:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27153 invoked by uid 111); 18 Nov 2025 08:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 03:49:40 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 03:49:35 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <20251118084935.GC4164207@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <aRRu1cxpIzd60AoU@pks.im>
 <aRVMggZi7I3vizc9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRVMggZi7I3vizc9@nand.local>

On Wed, Nov 12, 2025 at 10:12:02PM -0500, Taylor Blau wrote:

> I wonder what (if anything) our policy should be for keeping the
> Makefile and Meson build scripts in sync. On the one hand, I do not want
> the two of them to drift (too far) apart. But on the other, I am not
> sure that everyone who may be touching the Makefile are necessarily
> familiar enough to make the equivalent changes to the Meson build files.
> 
> I genuinely don't have a very strong opinion here or even really a clear
> sense of what the right thing to do is. Just something that crossed my
> mind while reading and figured I'd write down in case others had similar
> thoughts.

My personal preference is for people who care about meson to just post
their own meson patches adding the same features. Either as a separate
series (collecting several such features as appropriate), or as a
complete patch that the maintainer can pick up on top of the series in
question.

Posting something squashable (as Patrick did here) is almost as good
(and certainly better than tasking random folks with figuring out how
meson works). But I'm hesitant for reviews of random topics to include
"you should re-roll with my proposed meson changes". It's extra work for
contributors who don't care about meson, and it risks de-railing the
topic if the changes are non-trivial.

I'll admit I'm possibly biased and being selfish there, because I do not
care about meson myself and have mostly found its addition to the
project to be a hassle.

-Peff
