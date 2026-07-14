Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2042BC4F
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066445; cv=none; b=gxHSg+auizG3zbg9rGdRnZQd7TW3vy4xPjxgoGes77xpFTVFEtQIhxACk4mf+cNHQzJHnPnhuhE54qmiAxzFwmkUOHjBgQq1GKnkRhVwN54wmPN73XjSzB3kqRmiLRp8XgzwhligoQlZuNISe/+Ou3lKe1HfdPZUBdQlnySZDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066445; c=relaxed/simple;
	bh=LP2OvveK6j+wAk+4Ac7eq9A/LTp++mKd45hA5OsPyXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMSwnxo6MsTh//qTEQ3p7DjW/dV/UIbTWpcmevxYLgB4i7BZ7riMyrK1e00JJpCxbPkNBnW5eJgI3+Irw06FJBB4PRfmFK2FkFkrpKBWNOZ/yaCR7UpzoKraKpsmfmoXXMyUbTPP2ZO2UNMW+NAiRzPf0f8MyI5UlK+qCK2nWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iKgYb35e; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iKgYb35e"
Received: (qmail 26023 invoked by uid 106); 14 Jul 2026 22:00:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LP2OvveK6j+wAk+4Ac7eq9A/LTp++mKd45hA5OsPyXU=; b=iKgYb35ez47T/F0a1v8XUOoGQf1fqtTGoP/d4HWF950ESfHE87yCOS/Cm2/1TiC9+ScuTVSwUCCGZC/2CPJO8isPzmf5BTagT5gPp0+PKrQ7nn+OcT/KfmCPaYbfEniBAOL5fUDiqvw+MmCAha06qSbbxsA+Emg4q4GHhK162pAJylAzJ9Uu4td/WbwWDI4Q3xx7eck08eKiyEXe2ZWLOQmAmsMHmxKlpWQ7MX831xrgzoVq4NAVMgmXiJ4NUzbn4tujWnPEw5vF4QcwCSZ7S9hC7RI7J4aO4ZAOWy+1emtoUHN9NLuHllegM0qKwX847/4NvsB6eMz55ftsx+b7+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 22:00:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 53796 invoked by uid 111); 14 Jul 2026 22:00:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 18:00:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 18:00:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] show-branch: convert object.flags to commit-slab with
 uint64_t
Message-ID: <20260714220042.GC4095533@coredump.intra.peff.net>
References: <20260714183028.67857-1-gatlavishweshwarreddy26@gmail.com>
 <20260714200237.70509-1-gatlavishweshwarreddy26@gmail.com>
 <xmqqcxwps3ro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxwps3ro.fsf@gitster.g>

On Tue, Jul 14, 2026 at 01:41:15PM -0700, Junio C Hamano wrote:

> This limitation is precisely where the concept of using a commit
> slab shines.  However, to truly take advantage of a commit slab, the
> slab stride must be variable.  If the tool is handling more than 80
> branches, for example, each commit requires a `uint64_t[2]` array
> allocation (since a single `uint64_t` provides only 64 bits, while
> `uint64_t[2]` can store up to 128 bits).

Yep. Going back to the last time this topic came up, I'll just point at:

  https://lore.kernel.org/git/20250225011757.GA752084@coredump.intra.peff.net/

which references one of the earliest commit-slab series. Especially the
part that adds arbitrary-sized bitset support, which could be useful
here (patch 4 adds the bitset, patch 6 shows how it is used).

-Peff
