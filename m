Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6A3CB2D0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892949; cv=none; b=qyl1oqqPa2mUhyevSTKNyZwj4p5lgsV5UGxe/C2i0X/ZbG/lLgrqSKiGunZLmFivMlLuO0uWZioPMqiwOjcbI5n7M4AQl/IzbkdiJeahSGNGH7rAuoSjzI8+QG8NhG6ppiZRksXey7KMZC/epLercTGubHzD5HYFUZsmash5gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892949; c=relaxed/simple;
	bh=08JC70HJuAyQR308gimG1mkD/2/WKSpyszmxq1FRJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txZSaCVQNnu8984nA1rIUjTDwjEgLpysaubk75qFjKeDUyf8wZzKEixP+NvVr8DZ0T0g57YGF6IxDSOgi2Mgj66lXXlFlbKJrfb47E5vQe9Y/aM1i/x2XOWUewbVbNkumvw+t4Z2KzXEXMchGMyOFoHUNqNXrus/9a0E/GPIBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OSIIdHyY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OSIIdHyY"
Received: (qmail 77534 invoked by uid 106); 1 Jul 2026 08:02:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=08JC70HJuAyQR308gimG1mkD/2/WKSpyszmxq1FRJdc=; b=OSIIdHyY/brzIxqyanHE1Bmd7rgJjyGr73Ji2bErwl8OcKixFmtpPoUb5fIvi1nDU8dcusk1vkBD/urEaXqKKuaYR+Vi981+zfh+tpANTS4bCetXXhKq3vc9xLjRd1IAnNQrJkxAHNM9otoGI3Nd10rc4S/i2+6N14kX1nXgLDorF2vKDqy0v+EdETnUAFp28NVLHpYERbIGFNupWtFjhhokrgpTLby4fdVIkiv92Bstl0t7SxApbk5vD7ReXYgzTmpoTah9qIr91dbpMV0Zuz+7KOYWgHMe/A7LUqUG3sj56Ue8ofhiiuedKAeccGglXQlq+VrtAWuc1jKb7PCH8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 08:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 158664 invoked by uid 111); 1 Jul 2026 08:02:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 04:02:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 04:02:24 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/13] line-log: avoid redundant copy that leaks in
 process_ranges
Message-ID: <20260701080224.GA813310@coredump.intra.peff.net>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <5a6b17f075ca2d0442d512a0021557aa112860fc.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a6b17f075ca2d0442d512a0021557aa112860fc.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:24AM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When bloom_filter_check() indicates that a commit does not touch
> any of the tracked paths, line_log_process_ranges_arbitrary_commit()
> propagates the current ranges to the parent by calling
> line_log_data_copy() and passing the copy to add_line_range().
> However, add_line_range() always makes its own copy internally
> (via line_log_data_copy or line_log_data_merge), so the caller's
> copy is never freed and leaks every time this path is taken.
> 
> Pass range directly to add_line_range() instead of making a
> redundant intermediate copy. The callee's internal copy handles
> ownership correctly.
> 
> Pointed out by Coverity.

Heh, I just posted the identical patch (in my case found by running the
test suite with GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1).

So yeah, looks good to me. :)

-Peff
