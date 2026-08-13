Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837749502D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637734; cv=none; b=FBKovBcwNAHXKC7x4umW7GrEKDS6K2718W7IuhexwezM8tHTMHg05Y85faSz4+kbb1Pfc7jnkwejcoXMqhjJPx/Xx7AfedjHlkX3OsNEL7bxLFZThfFdfg8p+sod7TA+PN1sEGAqPNdCqLGGNuM4+yB+/JLGfOf76ktcVeAV9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637734; c=relaxed/simple;
	bh=y6g2fChbxeA/zquLM6MhfTHygN8F7foAvlAFSQ4lkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIaULmNlCDdnAMqQjf8i52d2xW3ZgXF4Xb4BV+phh9mNM7103CbviKJIqb0BvEEqe1SncGjo1XM7kTRtKnVwkqo3o3O91jectjrgu9y3tLz5WWppYVQT+aPHelPqtVeO5g4xQgdgW9QrWpMmd47nvrm9kbj9IMM6zQjFKv6ghdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O/xl4m8Q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O/xl4m8Q"
Received: (qmail 52112 invoked by uid 106); 13 Aug 2026 16:15:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y6g2fChbxeA/zquLM6MhfTHygN8F7foAvlAFSQ4lkzY=; b=O/xl4m8QFjO/GKs12XX8y0acFpt0rrM2q/M3Hq5kBiXBom3+r2Ub1v4cPfjue+dRW4acR7+cxwtSuWHCDYHn2As7jCWjVcyVCFGvICo/OX4O77WWDZ9mXhXcQTVAiaQvCjlMhZHaIk0JHFX6C5l5QsCRvyDWFPLeIapgvMpCjOe8hRzjeY1cRwMJNEPvUtjuX5gKnJiP0yFAme/CbI6Z83A79OXzIljlhfF+w9PCat6d1oy1mZwog5WpaHfbrLrd0V8fhfpIznnGPoQJMjtAM63kLDddbBbXDki5YG/4+xvp38Bj/037aIotv0AEZ1DbeiZb/b2fVxnTBFUJ8hNH0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2026 16:15:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43473 invoked by uid 111); 13 Aug 2026 16:15:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2026 12:15:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Aug 2026 12:15:25 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <20260813161525.GB1386479@coredump.intra.peff.net>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an1zz02GNqDu-0Oz@pks.im>

On Thu, Aug 13, 2026 at 09:35:49AM +0200, Patrick Steinhardt wrote:

> An alternative would be to use a hashmap here that tracks the packs that
> have already been added. It has the advantage that it also covers the
> `prepend()` operation and that callers don't have to be aware of this
> mechanism at all. Furthermore, moving preexisting entries to the back or
> front could become O(logn) if the list was doubly-linked. We do this
> operation quite often to re-sort entries in the list when looking up
> objects.

Don't we already use such a hashmap via packfile_store_add_pack() and
packfile_store_load_pack()? That comes from ec48540fe8 (packfile.c:
speed up loading lots of packfiles, 2019-11-27) and is how we know that
this "is_new" flag is true (otherwise we'd get duplicates during
"reprepare" operations).

-Peff
