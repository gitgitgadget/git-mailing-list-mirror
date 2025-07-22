Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DA27AC50
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225831; cv=none; b=FK++8Q9YGSh0YRlTmM55rtitYJbXMIXzuTYFwN9adgCyZDFnQqJfcEkgpCky0SGIMKc8NRE1ZTI4J3lFKuyc7y+W1CfAhYFoz+XawcNjZ8NqEUvtzy0xpAoDGa8TkNqAjVjWaAMDcWtm8p9aEFM9V98ZxTZcY+s41ytO01XYbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225831; c=relaxed/simple;
	bh=1rtK7qd1mLlhYyhUfmFqJpi4uFVLRnRnyFVQI99ITnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohTBfPi6pIQ24naQ5m4B6dFtNh2hFO9Pb6rSR6qntggIN9gl5vHP/ldE4QVUz0NElgs6IHYV9NXyECfU7yZ+kqZYHkQ/1ILSo7vSP2TGvKhuDhjqJrRn768rjKKCsyIPr8BDkFGuPf09a7DG8ArdqOSYV5xH1fD9Hdmh+LQ5enE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UkIWZ6tr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UkIWZ6tr"
Received: (qmail 32515 invoked by uid 109); 22 Jul 2025 23:10:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1rtK7qd1mLlhYyhUfmFqJpi4uFVLRnRnyFVQI99ITnI=; b=UkIWZ6trvR8ptV0Zbjxnva0I5VdH/BPSYxhIzwsafn8ow7awPZj6lvjmCA+fT4K0kznA3Yw+9TMLuqkhVFQwVXFE/DM+opx3bFlMgVpHHprhCMjj8O9w2KC79rpzFk2V5c1/tEgrp3P4luqwjYf3vYpJozRw6shPHw8wSufP43zWCcYogzgL4/XCsqwtcv1AZnrNlzwO3c/M6nTu/uvGRAp90EAT4lKQUm6G1j0Iyc5XlzQFRJskHveo/yVHQZXAv50yDnrt/UGQpc4YbV1V43yDUTym7djQ+yuTS7WxYktkND3QmpMPYCdQYbRbcwdmxQhV9FImSxgxexjlK2E1bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 23:10:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6298 invoked by uid 111); 22 Jul 2025 23:10:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 19:10:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 19:10:19 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
Message-ID: <20250722231019.GA1598@coredump.intra.peff.net>
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
 <20250722045456.GA824456@coredump.intra.peff.net>
 <xmqqms8wuxkf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms8wuxkf.fsf@gitster.g>

On Tue, Jul 22, 2025 at 07:09:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] t1410: add test of gc.<pattern>.reflogExpire config
> >
> > We have long supported the ability to set reflog expiration config for
> > individual, going back to 3cb22b8efe (Per-ref reflog expiry
> > configuration, 2008-06-15). But we have never had any tests.
> 
> Yikes.  I completely forgot adding that feature, but it seems I also
> forgot to add tests when I added it.  My bad.
> 
> "individual" -> "individual refs" or something?  I was confused
> after my initial read, which sounded as if we are talking about
> allowing individual users to set the configuration variable ;-)

Yep, exactly. I admit I didn't spend as much time on the commit message
for this one, since I figured it might just get squashed anyway. :)

-Peff
