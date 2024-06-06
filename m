Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8513AA31
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661303; cv=none; b=fzC3gyJ0UDnQFLnl8KkUo+JpS2aACYmC37xOQbONVpKrOiXi4xJsFVchdIWiHkrtnz511BO1PyU8G78y52P000iyI59LXIai4tmSqEWTlMwDBtZGjBO8GalljbLwgnMWD6L+3uoiDyq7YmvE9fpPMJqDz6rEt+yN5OZ6W47H9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661303; c=relaxed/simple;
	bh=I882yQs9vLAyEr+GYa/N6372GvvZzWuNJf+Ehr2QSU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iztj11rcjqJxt1Zenbi58ugvnZxXxHTMxhC7PMOm4o+BmbJj3E8BMqCddkAXYFqY4RXyofrLaXd9GmoyJfOvZAXdofb6PZDciOnO+MhC7zb0n8RSuAx2uwbTOmqToQXSPqJGCokTp1Rk285UsUmTbi5z6Dpf5A7M83ZqTM+4Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11155 invoked by uid 109); 6 Jun 2024 08:08:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:08:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6516 invoked by uid 111); 6 Jun 2024 08:08:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:08:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:08:19 -0400
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
Message-ID: <20240606080819.GB658959@coredump.intra.peff.net>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
 <20240605085733.GE2345232@coredump.intra.peff.net>
 <dcbbd00f-1730-41fd-90d3-c7b070c4f17d@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcbbd00f-1730-41fd-90d3-c7b070c4f17d@nvidia.com>

On Wed, Jun 05, 2024 at 09:45:32AM -0700, Aaron Plattner wrote:

> > And in that case you really want to retain the "query" parts of the
> > credential after the reject. In this toy example you could just move the
> > url-to-cred parsing into the loop, but in the real world it's often more
> > complicated.
> > 
> > Arguably even the original code is a bit questionable for this, because
> > we don't know if the username came from a helper or from the user, or if
> > it was part of the original URL (e.g., "https://user@example.com/"
> > should prompt only for the password). But it feels like this hunk is
> > making it worse.
> 
> The comment above credential_reject() mentions that it is "readying the
> credential for another call to `credential_fill`" which does imply that you
> can use it again right away without having to fill in the protocol / host /
> path fields. So you're probably right that this should remain the way it
> was.

Heh, OK. I was the one who wrote that comment originally, which I guess
is why it was in the back of my mind. ;)

As I said, clearing "username" is a little questionable there. But it
also gives the user a chance to update the field, so maybe it's not so
bad. There might be other fields in the same boat, but I think you'd
really have to think about each one. I'm content to leave the code as it
is for now, and if somebody comes up with a case where reject+fill
doesn't behave as they expect, we can think about it further.

> > The rest of the patch made sense to me, though. As would using
> > credential_clear_secrets() here to replace the equivalent lines.
> 
> That's certainly fine with me. Using credential_clear_secrets() to just
> replace those two lines would definitely keep the original behavior of this
> code.
> 
> I'll send a v3 patch to do that.

Great, thanks!

-Peff
