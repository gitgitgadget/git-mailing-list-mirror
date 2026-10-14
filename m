Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9202116F4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972847; cv=none; b=sstTE65PaXKJNoTB0cUDS9iL+fZCBpf3KQKU+hoMfRInZgGHhlU/c4+m9YOFPuKJU3NTbp4G7lAesFS48GnGEavqNSNIhZMDTq9iFEEZnGScV+smT+zwlnFEKO8Y/LVenDdj+zeX79lX7i4T3zU4/s8HRVRR9kXICg6mTQiv8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972847; c=relaxed/simple;
	bh=7gS6t8Nb2kYMkSQ7/JdWoSnLi/mU8E/QCkQ0hsMsU+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMB+t0GYnKX4b5GXUBpH4OIk/Mv6kTLqjcJKqdlq+2EB7MxupxNkBwCHT9xSuRRWYMPw3WiCAJjPMkG56pjF4erP89wQWD8n79ZnFdzqg788XbK0D7xVWaJdhsWHkR4Z8PxMWHgprt5VJrOPoEn9IxetxDUMQ9wsTCZYZunpjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Tnkv80EA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Tnkv80EA"
Received: (qmail 69290 invoked by uid 106); 14 Oct 2026 10:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7gS6t8Nb2kYMkSQ7/JdWoSnLi/mU8E/QCkQ0hsMsU+0=; b=Tnkv80EAm8I2yjv3FT3Y+xR90jdaMhJguq6fHvtefZ9n+E35Xc5+HawzjUwlKYq6K472mOfxmmbETbncK9GlGHFnYSQPo0dje8GZP7wIVoeMUgSdUhwqvTI9XLj5c1NRhjvCPhMil+0GWnpGqgqNgyQVpmTVvc1aKZKn94jImLfsIzI1N8nXuWx1ouoKzlozUaJ1l1ibU2ICyO/JBHJsLNtENKS9pbyxrDUN3cw8s9BSRcjKVGfMNdz3bNChjW7hiQ+4xYiiGVaN3JK4Ro4Bv2RR7vUP2y2HqorEw6Z0kNUMReGbDEkgZPuOuS+eC+zixLqW3I12SV5oEW0DNIruUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2026 10:14:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 36244 invoked by uid 111); 14 Oct 2026 10:14:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2026 06:14:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Oct 2026 06:14:02 -0400
From: Jeff King <peff@peff.net>
To: Jun Wu <quark.zju@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 0/2] Add a way to wait for index lock
Message-ID: <20261014101402.GC1344504@coredump.intra.peff.net>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013172315.2997446-1-quark.zju@gmail.com>

On Tue, Oct 13, 2026 at 10:23:13AM -0700, Jun Wu wrote:

> From: Jun Wu <quark@meta.com>
> 
> An IDE that runs `git status` periodically in the background has 2
> choices. Both are suboptimal:
> - with `--no-optional-locks`: `status` becomes slower over time.

The idea of --no-optional-locks is that the user eventually does actually
run some command in the CLI that updates the index (or even via the IDE
if it's not git-status). But yeah, that isn't necessarily guaranteed.

It's possible that an IDE caller could be smarter about _sometimes_
running a normal git-status, if it's been a while. But then of course it
has to worry about what "a while" means. ;)

So I think looking at lock timeouts and retries on the other side is a
reasonable approach.

> To minimize write race, if the index is read before locking, the
> wait will be skipped, as if timeout is 0. Depending on the read/lock
> order, some commands (e.g. add, rm, mv, checkout, restore, read-tree,
> apply, update-index) respect the timeout. Some (e.g. reset, stash,
> merge, rebase, cherry-pick, am) do not. I started with the simple and
> common commands. If there is interest in other commands I can take a
> look too.

I think any problem exacerbated by the timeout was already a possible
race even without it. But it would be increasing the race window (which
is fine for racing benign commands like "git status", but probably bad
for racing "git add"; see my response to patch 2).

I think the git-commit race, at least, has probably been there for 20+
years. It's just that nobody has really seen it in practice because
making commits tends to be a serial-ish process (as opposed to things
like receiving pushes, where big sites hit every kind of race). But it
does seem reasonable to close those races, at which point the timeout
behavior seems like a no-brainer.

-Peff
