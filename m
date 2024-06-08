Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1CCA40
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717843704; cv=none; b=L5yz2qvu/gSgABQxt5MM0qEEzfZZPPGLUHUUAqm/9vapA4JBuRnbmhTfOtnek43XPhlX3R5TzLdgp55gDSG1xNJebfIBulwZJIASC5HUJgVb48YZu/j0StKcO7aaThwOKgHCYFImKvZIbvDsr6/RVXrn8KVM59roFgSlEnunL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717843704; c=relaxed/simple;
	bh=X82ckgdq9F9vaw6LDRQMvmBftoQSuv7Us+30Fi4yhK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNNsRG1pXehVocVaDjRgnNPgvu65ceoWV0u1KwpTkOPdsW1W9FPkd34wKn327OUt+oQcU/nXLWyXB9APmA9suEXIbTKa6jPIKAHYChHAXVHN+hvZCFbCxiPD8i5mJDv/8aXmCvT9T5YHEul1s50mDuKO5kwYXfcyZPKSBnH/5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8439 invoked by uid 109); 8 Jun 2024 10:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 10:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29399 invoked by uid 111); 8 Jun 2024 10:48:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 06:48:19 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 06:48:21 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] commit-graph/server-info: use tempfile.h in more
 places
Message-ID: <20240608104821.GF2659849@coredump.intra.peff.net>
References: <cover.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717712358.git.me@ttaylorr.com>

On Thu, Jun 06, 2024 at 06:19:21PM -0400, Taylor Blau wrote:

> Looking at the remaining uses of mkstemp(), the remaining class of
> callers that don't use the tempfile.h API are for creating temporary
> .idx, .rev files, and similar. My personal feeling is that we should
> apply similar treatment there, since these files are generated based on
> .pack data, and thus keeping around temporary copies is unnecessary when
> they can be regenerated.

And actual loose object and pack files themselves, I think. I think it
was a deliberate choice long ago to keep those files around, since in
the worst case they could be used to recover actual repo content (e.g.,
a failed fetch will leave its tmp_pack_* file around, and you could
probably extract _some_ objects from it).

And the philosophy is that we'd leave them sitting around until gc ran
and found tmp_* in objects/, check their mtimes, and remove them then.

In practice, I don't think I have really seen anybody recover anything
from a temporary file. You're better off looking at whatever was feeding
the temporary file (if it was "git add", then look at the filesystem,
and if it was index-pack, look at the fetch/push source, etc).

And leaving them around is a minor nuisance, since degenerate cases
(like a script retrying a failed operation over and over) can let them
pile up.

And indeed, for push we don't keep the contents around anymore. Even
though we don't clean up the .pack files, we stick them in a quarantine
directory which does get cleaned up. This solved what used to be an
operational headache for GitHub, and I don't think anybody has ever
complained about not having their partial failed packfile available.

So I'd argue that we should just treat object/pack tempfiles like the
rest, and delete them if they don't make it all the way to the rename
step. If we really want to support debugging, we could perhaps provide
a run-time knob to leave them in place (and maybe even have it apply to
_all_ tempfiles).

But that is all way beyond your series, and I don't think there is any
urgent need to tackle it. IIRC, GitHub's fork does sprinkle some
register_tempfile() calls around the odb code, but I don't have access
to that code anymore.

-Peff
