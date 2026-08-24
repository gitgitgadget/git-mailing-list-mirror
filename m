Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09383EC689
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555165; cv=none; b=EMQ5cTwACYiiMz1bxlwQv2Suq8n/aNoWevH9vTUDz58HJHUIOCKmKhD+2pOs+5w9h/5kzP+AncWtt+MmW/Ac8Xh2CAo9uaCkWRAMPmWmhE6YUiShQc0HzVLTcPwtTYmrTbVHP8JZRvlPOsi12BrYazUdaVV485TR9W72IEvab+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555165; c=relaxed/simple;
	bh=4Ve7gZQ9b/HMXWldW7FYJyEKAAg/rxUVry1j+YM3aJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHYUQ+irEaM9bT0tefneBWe6ylLI6mEsJsV/de94W99m+xZOe2haxl2yIdWOQT8KWrAISjLbY/fGRTMDd0IaUbCB/Qh1NaNxjfVCxT50Dk37qp4jH5/3JxZIhHma150F359OWpK7tvHev4J8DyxRblkRZ92zbPEm52oFTwZvlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VpRUtSuC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VpRUtSuC"
Received: (qmail 105928 invoked by uid 106); 24 Aug 2026 07:06:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4Ve7gZQ9b/HMXWldW7FYJyEKAAg/rxUVry1j+YM3aJo=; b=VpRUtSuCpYhu3PwtRx0Q5Wbv2miOzpE6McoQjQAUgcjsDQFoWgTe3UUYh9Xn6wg0SfaR+h3rw6nAECY2fRCw71w6ni6xw3nGFeAEmBR+YY5mzoIsc9ax6lwcqqRHPc4EQUqnszH0MD9w4YomzMihnPGvMlZFNPU1mdzaWRxLpPnJ9CssqpjmQX2rXSR0v91mByXxYV2UcINve8wdrcBHmswrggnJoRYZv4gNDxID7hsfxkRZbDuNsi/3p1JQf2UfFzxV6VT2PEU1ewMwKrSNixavGqyd7xy951E8mP1dSMfTjL27NKb92BO3rV6i4bmBnh5ymlO7bNtGV7wYux1SGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 07:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 130108 invoked by uid 111); 24 Aug 2026 07:06:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 03:06:06 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 03:06:01 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260824070601.GC149254@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im>
 <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
 <20260824044822.GA142844@coredump.intra.peff.net>
 <aovTA4F04aX8SPTU@pks.im>
 <20260824065539.GA149254@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824065539.GA149254@coredump.intra.peff.net>

On Mon, Aug 24, 2026 at 02:55:39AM -0400, Jeff King wrote:

> Right. It would be OK to skip Elijah's fallback workaround when
> SECOND_READ is not set; the QUICK callers are prepared to accept the
> false negative. But since it is cheap-ish to do the fallback check, it
> is perhaps OK to just do it on the first pass?
> 
> I wonder how true that is. Imagine you had a midx covering a million
> packs, and you notice an object is missing, but you're in QUICK mode. Do
> you really want to individually check each of those million pack idx
> files (that were otherwise not even opened or mmap'd because they're
> covered by the midx!).
> 
> I think it's mostly academic. You'd have to do the million-pack search
> if we are not in QUICK mode. And the point of QUICK mode is mostly
> avoiding tons of fruitless searches for objects we don't actually have.
> The bsearch() conditional means that we _know_ this is a racy negative
> and not just some object we never even had. So it would trigger
> generally only when the search is useful.

Actually, thinking on this more: we _don't_ usually scan the million
packs for an object we actually have. If the object is available in a
new pack, the SECOND_READ scan should find that pack and put it at the
front of the packfile list (because they sort by reverse mtime), and
we'd find the object immediately, without having to open the new packs.

It's only the case that this patch is helping (when the object is not
moved at all, but an existing duplicate is hidden in the midx) where we
have to re-scan all of those packs. But we don't know which case is
which until we get to the SECOND_READ stage. So I think this probably
should only kick in for SECOND_READ.

-Peff
