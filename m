Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925F1C862F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455491; cv=none; b=OTLIIFe1CxoNOjP0xscW+ZkY+18mnbVBkOI1vtKVdHx7xDgbWarSXhM24rg90VhwAV1neXh+d4wLzO8+sIShWxT7QQzpNQPYY4rPcm4ky8YzmaY4vn6Kgag8DmXQzOD/AKVd8l7Fu6FUwuP1NouvEoOgkl69JeIWh1zPm8WVHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455491; c=relaxed/simple;
	bh=blWSfKAr3Oa7OQ4gw/+KB50GPwZcNvRUGYjZ1Cfi8rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sru8xxVkfmJoirARaUl+zUPL1Hmxc+ohs5r3UNx472E+aWS0GijeA1Hq6Ok+w0PYD1h8oRE70lzs7MxfO2BRvSF82QZ1BXE26ZGbQLqi0q6LY4vqNtDiYEwRmhmqD+yk8T0+4gT8dwKkPB8bMXtWHplj05y/UhorM4UMjzBbTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SE23K3Hk; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SE23K3Hk"
Received: (qmail 22860 invoked by uid 106); 7 Jul 2026 20:18:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=blWSfKAr3Oa7OQ4gw/+KB50GPwZcNvRUGYjZ1Cfi8rM=; b=SE23K3Hk0u0w10sM6p7todAS3HNarxxHVW3wSKU7/dVBNuAXf5/a+gmvam6rvSavxEc4/vhj7gMi4STqod6CS81Fr7riIUNtLfIn8LaueW19uYpzZ8h/IYLqn3Y29pMIdYEi7ATiBb7IAkfELFZe5BofTZVAES6ZgNovFdK7qcHdzjNYyKmc5fTeFqBsZ+08Ep8bLCp5xhMz2osD1fzPzjt3WqeyakbF9691sDcP4RtToZDqPbWvzewG00s5XlrBYbq+puGpflCiqqbL/oEmytkB7Du6j9+EOPHOiBGzeceUEjv3wFbtyGzXBg4REyaNcmcX/h4+zC8a0rx45PRd8A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 20:18:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34310 invoked by uid 111); 7 Jul 2026 20:18:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 16:18:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 16:18:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/7] hash: make git_hash_discard() idempotent
Message-ID: <20260707201808.GD11780@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050700.GD1288294@coredump.intra.peff.net>
 <xmqqqzle7osz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzle7osz.fsf@gitster.g>

On Tue, Jul 07, 2026 at 09:22:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You must always either finalize or discard a hash context to release any
> > resources, but you must call only one such function. This creates extra
> > work for some callers, since their cleanup code paths need to know
> > whether they got there via their happy path (and the finalization
> > happened) or due to an error (in which case they need to discard).
> >
> > Let's add an "active" flag that turns a redundant discard into a noop.
> > That lets you safely do this:
> >
> >     git_hash_init(&ctx, algo);
> >     ...
> >     if (some_error)
> >             goto out;
> >     ...
> >     git_hash_final(result, &ctx);
> >
> >   out:
> >     git_hash_discard(&ctx);
> >
> > This should avoid future errors, and will also let us simplify a few
> > existing callers (in future patches).
> 
> Hmph, so is the point of this change to allow _discard() to be
> called even after _final() was already called that we do not need an
> early return or something before the out: label?

Right. Maybe fleshing out this example was not a good idea, as yeah, you
could fix it with an early return. If there were more cleanup in the
"out" label it would be harder. In practice neither of the spots we're
able to clean up look exactly like this. They are split across multiple
functions. So maybe:

  /* foo contains a git_hash_ctx and initializes it here */
  foo_init(&foo);

  if (some_error)
	foo_release(&foo);

  git_hash_final(&foo.ctx);
  foo_release(&foo);

would be more realistic. The problem is that foo_release() doesn't know
if the hash was finalized or not.

> Unlike commit_*() and rollback_*() used in lockfile API, where the
> names clearly say which one is for happy and which one is for error
> case, the _final() and _discard() pair does not exactly tell me
> which is which, but I guess I will get used to it, perhaps.

Hmm, I had hoped that "discard" versus just "release" would communicate
that. "final" is a bit funny, but that is the long-standing name for
that hash operation (both in our code and in libraries).

> But the change nevertheless looks mostly good except for one "hmph".
> When _init() is called, active gets turned on automatically, and
> either _discard() or _final() turns it off.  Only _discard() is
> protected from getting called multiple times.  Is this because
> it is already a no-op to call _final() multiple times?

No, it's a bug to call _final() multiple times. See my response
elsewhere in the thread.

-Peff
