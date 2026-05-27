Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151A7E792
	for <git@vger.kernel.org>; Wed, 27 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870746; cv=none; b=jOj3ta1Rdvx7NPaGXRYBJMtH4uCaiXqvVjlm41E+hNPjmytp2nUhChLjW0s7ayGVaB3AmHhpPwj6zaCKrk21FqaiLKaw6IfsEyiBRs/AHrmQtb9jbbK8IWuTXRUitv+OTQXs9GQeEiItdXMlZ2yeHm++433d+/dZ3egImxa9AoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870746; c=relaxed/simple;
	bh=KCYX4tyhWtslInB/MLDY0zRRt+e+x9d0rIRfoU+zDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j67jcD1HjOxOZnENkozN0TsE1nzmysg9MminAhoDewYz2HTpRw+BaJR42ZYtG+RBiJMzKwLWGjIle87m3zFTQqzOli8hhlcTahm3oJRoYxLyLQQ950uPJQofLXzBYZhJKEv87MUnVeRr2Ni+qoW72Kxy+Ef4gc8jN+WSbqKyuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZAaEcGlb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZAaEcGlb"
Received: (qmail 28637 invoked by uid 106); 27 May 2026 08:32:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KCYX4tyhWtslInB/MLDY0zRRt+e+x9d0rIRfoU+zDRg=; b=ZAaEcGlbF3D1yOyuucD2RB6YiqCQTwVTa0VS8K99hmWm3BMabShyH7TbWs+6lPMRBWVgPwD9LYLhyaufRK1ZQxorENOE3T325SrtZAOTkNDK8Mu2mgPTLgNGphdgs1TAbNcKpRsyGBLwtekTrelJXWjeCn1oNK9y4YJzs6MW9hhmgKwEZHgzaj9s7xTwL25wfsUdQkvv/nkOCDhPflRC1HgK7m99FPUW/CWdVWF/qusvoxrjzeTphVV+QCyr7346WqzUgiKCpfLrD3G5MQo+60oY90oAPZVPQe9hBzP7LPa/JnpXkcFBRZohcGcyqtzs4vkjgw5WHkuqWTM64qB2Bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 08:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71155 invoked by uid 111); 27 May 2026 08:32:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 04:32:21 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 04:32:16 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] fetch: pass transport to post-fetch connectivity check
Message-ID: <20260527083216.GA981444@coredump.intra.peff.net>
References: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>

On Sun, May 24, 2026 at 12:28:12PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> From: Kristofer Karlsson <krka@spotify.com>
> 
> When fetching with a transport that sets `self_contained_and_connected`
> (as index-pack does for self-contained packs), check_connected() can
> use find_pack_entry_one() to skip connectivity verification for refs
> whose objects exist in the new pack. This avoids sending those OIDs to
> the rev-list child process.
> 
> However, store_updated_refs() never passed the transport to
> check_connected(), so opt.transport was always NULL and this
> optimization was dead code for post-fetch connectivity checks.
> 
> Thread the transport parameter through store_updated_refs() and set
> opt.transport so that check_connected() can take advantage of
> self-contained packs.

That makes sense in principle, but one thing puzzles me. We only turn on
the optimization in check_connected() if the transport's smart_options
has the self_contained_and_connected bit set. And we set that only when
we were told via check_self_contained_and_connected to do so (and we
pass the appropriate option to index-pack, which tells us the result is
OK).

And the only place that turns on check_self_contained_and_connected is
in builtin/clone.c. So how does this optimization work for a non-clone
fetch? Am I missing some code path?

-Peff
