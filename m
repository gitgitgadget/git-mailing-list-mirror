Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE64C83
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788248; cv=none; b=EGHFgj3pg7hdElTSffrcx55wkb4KmM1+UYtd2adJq+3KsveEZesC+idVtLooftsWVx1Pa2sfpE8+liIuAA9nYrvIy65MydR8gtTwuBXhXNG8E9K+BcCtNGwPtUXdpgoL9+DulAk3X7XHFB/1qhZWvbhwhUQ4tdAmna1ABQaxmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788248; c=relaxed/simple;
	bh=2luKSQlXlRfAjjZshmKaZmKOa8vTnWfEkgmMGXY7M5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgeNmH4I3/pJZ28lxRSJD3R8cVn1NAfjl2IoQBLyOtCSH+BuuyxpgA7hIxRTtFWQwnblmqMBW3eZqnEZuYdZVk3VmTwvMAdCUWmcKze6/Gp6aBBcZfylu4rBdsLRWLWOs5B/MaV6AMVDuRQJ5k4tfQKYeyRjnY5PXEL19wETNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cMbl4tHe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cMbl4tHe"
Received: (qmail 27407 invoked by uid 109); 2 Jan 2025 03:24:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2luKSQlXlRfAjjZshmKaZmKOa8vTnWfEkgmMGXY7M5I=; b=cMbl4tHepBLlBmB5IhFX+jiIYNp3JUJ0p9WTfU339qlEYCihWHtL00BWPsvbrgUzvC6OWbl7iFy48KVW9JpQdTI7JePW2+5YnYrbivySxW23MVbYVuSiFNfcoYdTCs7fqahY9AfIp46UaYWiWOckUcfoIm5xPnCm3hCs1mSIlMNCx63E9WxHd9J8l52p+ppiJSR5c0dR4a43w3tDgBiYA3Pe1olqPI1aZ6hlAq494FleT06BmTLEasxkbzfpxr3KbOKSbveYnJCwyGTd2iuHvQZzDEhWmQQ+fC3Wr2ddvzEL6in0aJww3R7oldZOXqdzmkLRjD5GJoD2Cm8ana+8Kg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jan 2025 03:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15648 invoked by uid 111); 2 Jan 2025 03:24:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 22:24:04 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 22:24:04 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in git.git
 (Dec 2024, #11; Mon, 30)
Message-ID: <20250102032404.GA817606@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
 <20250101191422.GC1391912@coredump.intra.peff.net>
 <xmqqa5cavz8h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5cavz8h.fsf@gitster.g>

On Wed, Jan 01, 2025 at 04:25:02PM -0800, Junio C Hamano wrote:

> > What do you think?
> 
> I like the small hack.  "This is ultimately LSan's racy-ness and not
> ours, so let's avoid changing our code to work it around when we can
> do the workaround somewhere else" is an attitude that I would endorse
> fully.

BTW, in case anybody wants to follow along with what happens upstream, I
reported it here:

  https://github.com/google/sanitizers/issues/1836

-Peff
