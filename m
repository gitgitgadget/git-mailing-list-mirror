Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099522256F
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425986; cv=none; b=KI7eLyOYXt+aGN9j8Yj6j3Zse7FU74Ek6LZlkKTnRNPIkcSEDanfhlFttFZmlqRrQNHDvdgSQsj7mm/OsDdXfUsV6ol27bxU4AhY6g8r6BEA8DspLGJ/LK0qH393OomBNrinn1kO0KwPdbM61yQnYMqrXlJGD8umRTLODhFOxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425986; c=relaxed/simple;
	bh=pILSZZeXs8LjfgXFhiakGm6T6srYlJBp9ZXUw100yp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PV16zFBFTlURzXWNPryphOYwR7cVw9avRT+aWY8OwFEU6V+6ETjTg6nnS0SNb4zWKgSrxe7Uyw/7n7vmVpqA/62mKaVDJhnFxgCAKQOio8nFTpa1PgM+Fwqp5ctzir0KV8Sipn0kbT/qWPfgVdSdFRQFu81INrBZ8Z9VghgBWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F8kHnnDi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F8kHnnDi"
Received: (qmail 31202 invoked by uid 109); 5 Dec 2024 19:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type:in-reply-to; s=20240930; bh=pILSZZeXs8LjfgXFhiakGm6T6srYlJBp9ZXUw100yp0=; b=F8kHnnDi0k/IlsT0hj24zYJZDfEbBm0bzeQG7Lc6zOzJMYQWW7uAXnh6tpi2G6870h3dw5TvobRXpwxmiWUrUxpWBHwEADaGt0SI/PlvjByFxzuNzsPlZ5Q/jnP2f+DiqrsVKDJD5y35aAiHeKJzmlQOm5pskxxVd7uwnavtP6oEDFcLMkNQvlrbkthA+yOyMxnZGkw2GclW66B0/IC7EHUD2akwWPw+dEXRYWkb/zlzNFsHIZbZY0AKJI+7WkfCdsbHFg5R3wZl7LvIn2iISdjOGZJpjYe9EkfYWoS0Tq6hhTphp87R0OW7GKyE1WFRrDSWctRYlAeyJAOvoEZ6xA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 19:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8993 invoked by uid 111); 5 Dec 2024 19:13:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 14:13:02 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 14:13:01 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241205191301.GA2629822@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_BC=J3-wc2w_-xLSDbN6B9xkS2aWPUMFJYVRHkE+Ch9Ow@mail.gmail.com>
 <CAJ-DG_BdAiFk_2eV=JDF7Lth9+Ay=86w-VT26Rt+T5fdN1vd_w@mail.gmail.com>

On Wed, Dec 04, 2024 at 08:59:03PM -0700, Dmitriy Panteleyev wrote:

> Strace with NO_MMAP=1, I gives:
> 
> openat(AT_FDCWD,
> ".git/objects/34/5819b235838e219d66420b536a54ce4cf0624c",
> O_RDONLY|O_CLOEXEC) = 4
> fstat(4, {st_mode=S_IFREG|0444, st_size=154, ...}) = 0
> pread64(4, 0x61a0292e15d0, 154, 0)      = -1 ESTALE (Stale file handle)
> write(2, "fatal: mmap failed: Permission d"..., 38) = 38
> 
> Weirdly, it's throwing ESTALE not EACCESS...

Ah, interesting. So yeah, it seems like there is some configuration
issue or other problem that is causing your NFS handles to time out, and
we get unexpected failures while reading. I _think_ that exonerates the
commit you found, as the code it removed was helping only by chance, by
creating slightly different filesystem access patterns.

> > Does your system have AppArmor enabled?
> 
> Yes, but I don't see any profiles related to git. And I can't image
> AppArmor would be version-dependent.

I think this was probably a long shot anyway. In the link I found it was
"man", which sensibly would have AppArmor profiles that disallow network
access. But clearly "git" would not have the same ones, since we expect
it to hit the network (not "git commit", but it is all one binary, so
AppArmor doesn't distinguish).

> Hrm. I just spun up a couple of different VMs on my server with old
> and new NFS versions, and git works fine from those shares.
> 
> I think we should put a pin in it, since I can't reproduce the problem
> outside of my specific server instance.

Yeah, that makes sense. You might find something interesting in the
server-side logs that explains the stale NFS handles.

Thanks for going through all the back-and-forth. :)

-Peff
