Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426D154C09
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207334; cv=none; b=R1Ugii30SIzg/cvcj0rExnU90WYmp1Fe4AkferJaHDyJ+HNTi8GSVvv/hSRCU/7HADINtNWWD0IbDJ1OIhPF8HM8SeDGBuGI0/VD1Vhy2khmNP1dSDLEVv3J4NRnYmqR2pXcP1MBh1S06IPb3TjmmC1rnGLpXY7t3yAUIZeeYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207334; c=relaxed/simple;
	bh=CeZlnIjipkWvGn6x59c700FJGS5kAzcjgVr0RwjVxzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY1dJ+5tiyhRwjbWDnfwWApWHUzdblb4nvqySEvXw4+dZMeOlAYR9Gdp1SqlFCkwQhK+t/kNfIm68x8FxKCOV7tBMkzFWnE8by0wFnSy+FipFefYrAex1JVk3k/77xAern6dmn+l9H4verahvq0UEfPHg0IaY2NYuSqwUfE6DOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30924 invoked by uid 109); 15 Apr 2024 18:55:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Apr 2024 18:55:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22658 invoked by uid 111); 15 Apr 2024 18:55:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Apr 2024 14:55:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Apr 2024 14:55:30 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: increase command size limit
Message-ID: <20240415185530.GB1709228@coredump.intra.peff.net>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>

On Sun, Apr 14, 2024 at 06:47:52PM +0200, René Scharfe wrote:

> While 1KB is plenty for user names, passwords and mailbox names,
> there's no point in limiting our commands like that.  Call xstrvfmt()
> instead of open-coding it and use strbuf to format the command to
> send, as we need its length.  Fail hard if it exceeds INT_MAX, because
> socket_write() can't take more than that.

Hmm. I applaud your attention to detail, but this INT_MAX thing is ugly. ;)
Shouldn't socket_write() just use size_t / ssize_t?

In particular, this made me wonder what we would do for larger items.
Like, say, the actual message to be uploaded. And indeed, we use a
strbuf to read in the messages and pass the whole buffer for each to
socket_write(). So we'd possibly quietly truncate such a message.

Fixing it is a little more complicated than switching to size_t, because
the underlying SSL_write() uses an int. So we'd probably need some
looping, similar to xwrite().

In practice I doubt this is ever an issue. 2GB emails are not likely to
be usable in general. And I kind of doubt that this is a reasonable
vector for attacks, since the inputs to imap-send would generally come
from the user themselves (and certainly truncating the attack message is
probably not that interesting, though I imagine one could convince
write_in_full() to do an out-of-bounds read as a size_t becomes a
negative int which becomes a large size_t again).

So I am happy enough with this (especially given my general opinions of
imap-send in the first place).

-Peff
