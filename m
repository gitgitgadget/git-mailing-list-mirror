Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193565026E
	for <git@vger.kernel.org>; Fri, 10 May 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378839; cv=none; b=eeqDmtmY7JLHWoZ57MLcCVefInkQQv4doY0G0SkEtll2+H8rfWdjqUx4vBaCjzDW0O+FTf8BjdmMuSwaiztvhAC5/sRbpjIt8wIzele1DCc/0ocOBB9WJp2xx/+zoT1C0uRMo38pG5J6jDtdBkWXtR3UQdsnBr1eQPzRMXF5vuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378839; c=relaxed/simple;
	bh=uc0TLWmxSKTcneIYZXjGciKtJi5lJR9no5tx1M5kYvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILsDGfTSM8PMKlfcq+GmQW7Vz+l7dLukDTJv7+2U9RtcI84GBYRYqk0Tvk7R99Ei4tx/qIJFvjrTVxQoF2tUi/pWE+3bz2+jl+W+RVaLmhXogwzJDwqux6l+miDYgfv2VWZcsANITIOPpIoMIC4ABTYNfcnbWSwgDkGDnsSV8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19595 invoked by uid 109); 10 May 2024 22:07:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 22:07:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14028 invoked by uid 111); 10 May 2024 22:07:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 18:07:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 18:07:15 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Bo Anderson <mail@boanderson.me>,
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: lock for exclusive execution
Message-ID: <20240510220715.GB1962678@coredump.intra.peff.net>
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <D7A8539F-E33C-44F3-A7BF-5F5D4A26F2A4@boanderson.me>
 <20240510200114.GC1954863@coredump.intra.peff.net>
 <Zj6EhJi9MgALC5Ti@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj6EhJi9MgALC5Ti@tapette.crustytoothpaste.net>

On Fri, May 10, 2024 at 08:33:08PM +0000, brian m. carlson wrote:

> > Some possible alternatives:
> > 
> >   - we could remember _which_ helper we got the credential from, and
> >     avoid invoking it again.
> 
> This will break the new `state[]` feature, which relies on being able to
> see the state after the fact to know whether the operation was
> successful.  As an example of the functionality the current approach
> allows, authentication could use an HOTP (like TOTP, but using a counter
> instead of time) value, and storing the correct used counter on success
> would be important.
> 
> I agree it's not super important if we're just using a username and
> password, but considering I just added support for arbitrary
> authentication schemes, which can include things such as limited-use
> OAuth tokens, one-time use passcodes, and certain types of HMAC-based
> signing, we probably don't want to choose this approach.

Yeah, I think it makes sense to keep the Git side as general as
possible. So invoking the helper but giving it extra information (so it
can decide whether to be a noop or not) seems like the better approach.

> >   - we could record a bit saying that the credential came from a helper,
> >     and then feed that back to helpers when storing. So osxkeychain
> >     could then decide not to store it.
> 
> This is actually possible with the new `state[]` feature.  `osxkeychain`
> can simply set that field to something like `osxkeychain:seen=1` and
> simply do nothing if it sees that field.

Makes sense. Back in that old thread I showed a patch which would let
helpers pass arbitrary fields to each other (or back to themselves), and
this works in roughly the same way.

> All the credential helper needs to do is declare support for that
> functionality with the appropriate capability and emit the field if it
> gets that capability on standard input.

If I understand the protocol, it is just:

  printf("capability[]=state\n");
  printf("state[]=osxkeychain:seen=1\n");

in the helper when it returns a username/password? And I guess the
matching parse/check on "store".

Sounds like that would be easy for folks on macOS to play with.

-Peff
