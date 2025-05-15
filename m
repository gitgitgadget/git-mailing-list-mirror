Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC068200132
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339909; cv=none; b=EIJPuCNA4GMJyRRx9ZC88ptrmtru7Mg5hJ1UyOdvPBmXJ6MHaZwZZc10Dlsq3gg9x75BFBz+1N3+a3K+/yeAJ4xa8M2GLvHLK9WEFnkC/FZQv42LLBhP0ZHVyBJXWpN9Zs/fnsPP1nX5IpkzIgfqJqzTmkSajW1r7rQ4SimR8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339909; c=relaxed/simple;
	bh=het1XE9Oc4BrhRYImMGrlQb1fX+CCBCpdanUP+L7bvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZljh44COGUoPly+xVSp4yR4YoLMa1/4yKFboJXngOn0Tql0oK7PCLGSX3JpzsUzOuQpy0V6wKkCxAaqBU4tNGU/jHuySl0ZUpaWNmNhV41MKOe8CtTZy0v3EMzK6QSRCe6xBBjWCPZ6L8N2ELIpDiT+kQnB9xkR0iVNiVAtDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TGRAxWAK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TGRAxWAK"
Received: (qmail 767 invoked by uid 109); 15 May 2025 20:11:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=het1XE9Oc4BrhRYImMGrlQb1fX+CCBCpdanUP+L7bvA=; b=TGRAxWAK1x5oIKSMSK1r2Pm8f1sLZfS3pRAhN6/yYNS/wDjoGr6UMr/kQsvCK7KbcI9y7QEKrnAMy7uCQW/J39JfMfMCqI2k8d62I2CAwXiLpurJ7nXapPPcKjaYO02B9XFnTWNs5P3up/ODonb3bRj6JBxNWYzvoFOI2ePibT/gE/AsbJFIUFFawb/Ni9+zxM3l7JwnXCgID9GGtK2znoMwREVARzUojApigZmUfIdKh7BEz26GZ+GrxDoAww8kJxVM6twMuI9xUdgrxJLZUxKbUAFDpsu4wFt02DXhFmyGGmqgJsn0T+N74rzGMPe9byDlg6GpfvQNVn0r1sK51A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:11:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30676 invoked by uid 111); 15 May 2025 20:11:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:11:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:11:45 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/11] fetch: avoid unnecessary work when there is no
 current branch
Message-ID: <20250515201145.GG3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <dff0a3ec886cdccf199bdc3881094ec0ab8b3bca.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dff0a3ec886cdccf199bdc3881094ec0ab8b3bca.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:44PM +0000, Johannes Schindelin via GitGitGadget wrote:

> As pointed out by CodeQL, `branch_get()` may return `NULL`, in which
> case `branch_has_merge_config()` would return early, but we can even
> avoid enumerating the refs prefixes in that case, saving even more CPU
> cycles.

I am not sure how this patch changes anything with respect to CPU. If
branch is NULL, then branch_has_merge_config(branch) will always return
false.

I think this is just an issue that CodeQL is not looking inside
branch_has_merge_config(), and thus does not realize we will never hit
the rest of the short-circuit conditional (let alone the body) in that
case?

Still may be worth dealing with, but it makes me a little sad to have to
add an extra redundant check (one place is not a big deal, but as a
general pattern).

-Peff
