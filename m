Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2B86338
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734317; cv=none; b=U1lGmUZgx/tRpQ6boqUQ5jlGkOo3I8zy7CNRHfG/2sooeQvvAiOVGfHcJ0RAZorp9mLtBocsZylGLZ+d81XKoEI24gvJXsNmumZ/6lLm5XZl0W1urXSbA/ducnprQYIvKBVL//IS9tt8qknj+wtm9HBTzhyUDpY5kIlyjrUO/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734317; c=relaxed/simple;
	bh=TXUieWxFSw8JlOEWpvLCG4tEjzzkVH2UizvhA3MSWkc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bKl/SRAm4AXIv7MRSFKX1gLis51XNUOv/nMSoA/Y4apUszb+eAQc80yosuPqJklwAR6CO35k5V2iSBuMtAZJm2fbDn8SWd+QXn7tLOjHWUZzzCV1NksYGE13mvQ/pPcza4agGShq10ZN3t0CaT9flJj6dme3CBmnf48iWmX9/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=HXcp/wmO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="HXcp/wmO"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id D6682407616D;
	Mon, 28 Jul 2025 20:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D6682407616D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753734310;
	bh=nzFONitdeGeUngYwz2nuk+QctDc88UI4pXGEU+YIzj8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HXcp/wmOF2RLxa6wTZyWjEwauRWqh2WlrTYrnjWGmnjWf0zakow0SlyqOiGFaCFSH
	 9Fg+eLpcbBOwBYXG3OM0axJjqLvBje6WinRsvmFAz8uyIbYs4hahcdxRh2XzPCUleZ
	 QHG2DZ66DpNZgbmaRclMYNpL18MpDZwQpkkMbFjg=
Date: Mon, 28 Jul 2025 23:25:07 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] optimize string hashing in xdiff
In-Reply-To: <xmqqa54oun5w.fsf@gitster.g>
Message-ID: <43459416-ced2-d551-40e3-6db594ca4520@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <xmqqa54oun5w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-443840255-1753734310=:1851"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-443840255-1753734310=:1851
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 28 Jul 2025, Junio C Hamano wrote:

> Alexander Monakov <amonakov@ispras.ru> writes:
> 
> > I've noticed the work by Phillip Wood regarding hash optimization for xdiff.
> > I want to point out that it is possible to speed up the existing hash by 1.5x
> > matching the peformance of xxhash (but without introducing a dependendency).
> 
> Using xxhash() was merely a sample code path for technology
> demonstration, so the Rust adoption topic may want to pick a
> different code path to do its thing.

My interest here is just speeding up xdiff in C, is that a welcome topic?

> > The additive variant of the djb2 hash is used in ELF symbol lookup, and
> > Noah Goldstein contributed a well-optimized implementation to Glibc.
> 
> What is the licensing terms for that code you are proposing us to
> borrow?  If it is anything recent in GNU, I'd expect that it would
> be GPLv3, which would be incompatible with our code base?

Noah's code is not usable in xdiff due to different context (mainly the need
to limit iteration by length — ELF hashing iterates until the NUL character).

I have participated in review of Noah's patches and he kindly listed me as
a co-author in the final revision of his patchset. So while I'm aware of how
his code is structured, I had to write a new implementation in order to meet
the contract of xdl_hash_record_verbatim. Therefore I think I can contribute
this code on GPLv2 terms with my sign-off.

Maybe someone would be willing to look at patch 2 and compare against Noah's
patch (linked in the commit message)?

Thank you.
Alexander
--8323328-443840255-1753734310=:1851--
