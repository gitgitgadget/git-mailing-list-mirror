Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5461D1DEFE7
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838726; cv=none; b=lnZV4+DKImF7fQTTAaUwNQVZWs5y8voQUdddkGJujwEoAw+GcKCkdgoqLc/9KQw0FI46FqE5HijkQj4kXUC7ygsTZEZWW3YAKzwDuZQfIZqdApffUbgD731+3Pjpg7cQySjpdlL0m5GjOvHUAVC+zZ6LBK3PkIkctQGRjNS5DPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838726; c=relaxed/simple;
	bh=93xLB+xlbSV+3zisFHuXF3ENo7hr8S8Ml7uhlnwQw8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4oVuNttU+e8qizEPQ7mPpd7W0Pd8g0RWB6u05867x+asx6CTcvvhassX5zhjbJtK9q+Rq8nl5u8e6gfE3TpIeP0LzVLxZ4rbScBQocNkXx7a8I2+/vzxnevegeX+cdM6D8zFN9RpfXCOn+wk6PNfA2Hp3B5yvmag279wXddajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KhlWigD6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KhlWigD6"
Received: (qmail 49411 invoked by uid 109); 23 Feb 2026 09:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=93xLB+xlbSV+3zisFHuXF3ENo7hr8S8Ml7uhlnwQw8w=; b=KhlWigD6DRTZeKAd2MVg8+ToyhonezssSO4W0pKqQF0XgLRbIJfuFlGJWhBzae/y5lnhP5jk0MAQ4o0dPN8MTqnt+dwKHcHcxVFt72uvBuqIBaorEn1oYJPulCJVQy2sWQkcsIYdkzksR9wppbD5lhPNnIqjY/sAO5iqAhx6WLwmLfcme3cc9FZdnDIB55sXVLNTmmpiqv/5h1eGtytapFQtuzEejgvpkZS2zVmjrhMyWpoieVdCz/DcEJfsoqq9ook2wt90xkDO7lNd0VXqMMnig8KdDxy1FUvWfmomlMeezomSA/bPz6AuB6aXKHsleUI2tFFEiB9BoCurjLPN/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 09:25:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96169 invoked by uid 111); 23 Feb 2026 09:25:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 04:25:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 04:25:23 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <20260223092523.GA209277@coredump.intra.peff.net>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
 <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
 <20260223071215.GA136463@coredump.intra.peff.net>
 <aZwTyLMWbcXWnYhQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZwTyLMWbcXWnYhQ@pks.im>

On Mon, Feb 23, 2026 at 09:46:00AM +0100, Patrick Steinhardt wrote:

> As pointed out in [1] the root cause is actually something different,
> and we merely expose this now with the MRU-based iteration. But I
> wouldn't mind if we eventually switched back to maintaining two lists,
> or finding a different way for how to maintain the iteration order.

Maybe I don't understand what you're saying, but isn't the root cause
the same?

Code is iterating the list, and then during that iteration calls
find_pack_entry(). The fact that fsck only calls find_pack_entry() in
some subset of cases is immaterial, I'd think. The risk is always there
when iterating now.

-Peff
