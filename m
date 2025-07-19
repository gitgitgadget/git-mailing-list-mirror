Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4043164
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908670; cv=none; b=hYHpRbvCl3uDWdp7jy0palr1w1r5+XGU1yyicwd+J6q0AZ/4DoFM7KO1kPlSJV/Ege4wEU2I1M2We3oc1SDYexoHcqCmwc+dM9ZD/itwm5FSW53DFPitdAlu9aMLoceESDRLrGoKpzh8riHIbGTYiQNiOQj/pERfYRDbM+ZqvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908670; c=relaxed/simple;
	bh=Z11kQZyyA/Pm9grIkqX9RUdUO6Yf8DpDNB4YV0xfYIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPmUSCZ9GMWQUNw2H2Rwq/fW/US9AM7Ywx/3jva9iziL8oYdEGBh3Wq6ch4qYT5lKUNIKwJrpq/A7XAAgdItvxtbMp5tRkgV9s9RwGGBYPzJGCs8iX8yyOhjnhMr/SZVmWIPoteEn+gd0uwPLeR40tDEhHBbuRPbHiFojwUIAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GfFd0Nm4; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GfFd0Nm4"
Received: (qmail 27224 invoked by uid 109); 19 Jul 2025 07:04:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Z11kQZyyA/Pm9grIkqX9RUdUO6Yf8DpDNB4YV0xfYIo=; b=GfFd0Nm4ZCthF2MeFGi0Iez9UmriEwfk+rufE/F6VgVvOrpnOtjqqMLj4uwDmqvZmYpjgt88ECK0CRIg01+q1Z6rK+WxI5Eha8QrdUAR2Ze4kUe5Fry3odmKSTuzb0FMZ0XW1wNWc+UoRhJHOKKDUJXtdfBiXawqb/XCk8ricAvyHfN5fg2F5VMPQq37RAZAgB+hXFO6XD9w3cvd7ifzprOsJ9a+89I2tELR9zvN21i79u1l2GOfxaKUEknp7UbMJb3jiroIaJghtDA8WPp+mPcndNiMsqYro7gjFqVAVGC8qMtOFAHKK9a14CAyX1ejO9io6LdDLhIHXko235/lAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 07:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4657 invoked by uid 111); 19 Jul 2025 07:04:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 03:04:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 03:04:27 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250719070427.GG705356@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ff40c56-368a-4347-aeae-2aca2cb6a5b2@web.de>

On Fri, Jul 18, 2025 at 11:09:04AM +0200, René Scharfe wrote:

> Use prio_queue to improve worst-case performance at the cost of slightly
> worse best-case performance.  Then add and use prio_queue_replace() to
> recover that loss.
> 
> Changes since v2:
> [...]

Thanks for fleshing out the test script. This version looks good to me.

-Peff
