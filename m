Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF8305E33
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561703; cv=none; b=M2b3DHfaxBxxI6J/X2HUMU+S7vyXidgVbkJ4dnitJh77zEPYDqNFSplEcppvbJltdEpdEBXd0c/fsNyklGZqr1asmGVekAmBVOxhspw6WMPcu8nYUAKAmxQUGkqslj6JadroxSB7BpS/pbAA7UZzbm2Cg+yrJZsfBOHn5VAxy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561703; c=relaxed/simple;
	bh=HhD/si4SEo6iN4Io9XFX5jZRyVZAsK8Kfd70+8hybVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwLJAxiQwODyZ7X0g5LorzEAeJS8CKNT15XrgsyAIA+MiXInDuWAe9xMnRr7IuKLuuh0/9xU0j8F5ocF9IQXx32T3Jm/8BWZLuq/zXI3t7rAyOuEPEox8DOWftV/i0WJco5gxKJry9pD3RCySAmWdHYpFpywLT9KJXRmwBfsA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bXKHgtM5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bXKHgtM5"
Received: (qmail 161301 invoked by uid 109); 22 Sep 2025 17:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HhD/si4SEo6iN4Io9XFX5jZRyVZAsK8Kfd70+8hybVc=; b=bXKHgtM5KqARsVT9FdWJ3M9V9o/2UcoR5KGV6l32rTZvCowHP7vt9jfyHB+mLV0qj3YEzga/8hamSWS2i8bGxFtNUQ2ZclNRZNOCkmhS2OQa2329CrS5UGVcqHYd7AGUD9iw4VhrPQSOcAifO+ZsMCVk4aIkjkJSF4a0RM3i9obPmQ6Lomd0rib6wXkr2qtHvFx3x5j9WUFu6MWChgW8UfG+b0EaWSaofAJ9Eyjuj3VmVDlSdaM3jH3PPzHV9dPBM6+MFBW/G3f+0tNOg+K1qrd6ePAR0NAlFBsjM0mD1i9DR3Imn8G0LY58pEhMBZLrkccczb8KunGecdNi3lE//w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 17:21:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 252586 invoked by uid 111); 22 Sep 2025 17:21:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 13:21:40 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 13:21:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <20250922172140.GB2202085@coredump.intra.peff.net>
References: <20250819192934.GD1059295@coredump.intra.peff.net>
 <20250922122332.584428-1-toon@iotcl.com>
 <xmqqwm5qv5xh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwm5qv5xh.fsf@gitster.g>

On Mon, Sep 22, 2025 at 08:54:34AM -0700, Junio C Hamano wrote:

> Toon Claes <toon@iotcl.com> writes:
> 
> > We use `update FOO_HEAD 000...000 000..000` to delete a symref, if that symref
> > is dangling (otherwise the old oid would have resolved to something). I've
> > attached a patch that would allow this (on top of your patches). Do you think it
> > makes sense to allow this scenario?
> > ...
> > +	test_when_finished "git update-ref -d refs/heads/dangling" &&
> > +	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
> > +	echo "update refs/heads/dangling $Z $Z" >stdin &&
> > +	git update-ref --no-deref --stdin <stdin &&
> 
> "git update-ref --help" seems to show that the "--stdin" mode has a
> separate command that is designed for exactly the purpose of removing
> a symbolic ref, though.  If you are changing the semantics of "update"
> to make it safer while dealing with a dangling symbolic ref, do you
> also need to touch the code path that handles "symref-delete" command?

I don't think so. Whatever we are trying to write (whether a regular
ref, a symref, or a deletion), the "check the old value" code path ends
up in the same place.

IMHO the directives for "update-ref --stdin" are a bit mis-designed.
All of update/delete/verify should accept either "old-oid" or
"old-target" (you do not need it for create, which always implies an
old-oid of all-zeroes).

And then symref-* is used when you want the _new_ thing to be a symref.
So symref-delete is not needed at all. You just have symref-* directives
for create/update/verify. Which almost could be replaced by "ref
<new-target>", but IIRC there was some syntactic ambiguity (because we
allow new-target to be a ref, so you'd have to pick some invalid name
like ":symref").

It is probably too late now to switch from "symref-update foo" to
"update :ref foo" (and again, I think that may have even been considered
and rejected). But we could add support for "ref <old-target>" to the
non-symref commands. That is not just a syntactic weakness, but
something you literally _can't_ do now (convert a symref into a regular
ref atomically).

Anyway, all very off-topic for Toon's issue, though. I think his patch
as-is does the right thing for his case, if we want to loosen it for
historical reasons (see my other response).

-Peff
