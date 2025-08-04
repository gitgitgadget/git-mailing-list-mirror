Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F52472B6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318397; cv=none; b=HSocTq4Pz7NTkJquj8PVa4aj5/39IGdgX8GxjGf7bQ/IAAiz1j57fA3SRIwCRdzcHDQWhqSPFwL1qlF9OaO9I0yj+sgwixOo7Idcmmi09Eh7tlIn3EPuItw+99lMn/3dD39yXheYqHGwd8Xw84s2if4MGs1sLB+mSf6/P1L7SeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318397; c=relaxed/simple;
	bh=8Yh8v47o4fiQsszPXva53W9uFGsjRFGHp54pcq+PRgM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E0iI7OCj60RLeA4aooCR7JBUFTE+w4C3uT16Y2JolkOwDRpM1/e2GQ4JNBk5vuHS5VoYxliG//MFUobp6uC2bb/iCq/gL37/mbmySHkZj8EaYdnFXG3RUV2u9yQw9tepHy6e+Y6JgSth51/zw+NoNFOJDcttsxNbgaij3VWFbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=d0volzLz; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="d0volzLz"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 711F340A3278;
	Mon,  4 Aug 2025 14:39:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 711F340A3278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1754318384;
	bh=NZ1wxMB7h4mjCVGpgurQKg4WV7zao8tkUUR/JrI2rtM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d0volzLz7r6gVt/JtPcNsq+T8+h5yU9Qah0R1M2ELOPbXyTXy8YHHZIuGeM4egFGe
	 ttTZhzXeMj9AnLpBgq/h2qWwt8hWbcLyR05FGwk2GRdOCDkadrfO4k7I9Duw0KFI4r
	 iydw6/HLS/EvTjSFs2Yx3bh10gI3g1qxOqsJecKM=
Date: Mon, 4 Aug 2025 17:39:37 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
Message-ID: <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <20250728190520.10962-3-amonakov@ispras.ru> <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1225942926-1754318384=:23243"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1225942926-1754318384=:23243
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Mon, 4 Aug 2025, Phillip Wood wrote:

> > Switch xdl_hash_record_verbatim to additive hashing and implement
> > an optimized loop following the scheme suggested by Noah.
> > 
> > Timing 'git log --oneline --shortstat v2.0.0..v2.5.0' under perf, I got
> > 
> > version | cycles, bn | instructions, bn
> > ---------------------------------------
> > A         6.38         11.3
> > B         6.21         10.89
> > C         5.80          9.95
> > D         5.83          8.74
> > ---------------------------------------
> > 
> > A: baseline (git master at e4ef0485fd78)
> > B: plus 'xdiff: refactor xdl_hash_record()'
> > C: and plus this patch
> > D: with 'xdiff: use xxhash' by Phillip Wood
> 
> I think it would be helpful to say that B is the previous patch and provide a
> link for D.

Ok, reworded locally, will appear in v2.

> > The resulting speedup for xdl_hash_record_verbatim itself is about 1.5x.
> 
> While that's interesting it does not tell us how much this speeds up diff
> generation.

That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)

> Running the command above under hyperfine it is 1.02 ± 0.01 times
> faster than the previous patch and 1.11 ± 0.01 times faster than master.

Then you get 9% from the inlining patch and only 2% from the faster hash
function? That's a bit surprising, which compiler and CPU you used? Is it
with default optimization (-O2)?

> Using
> xxhash (D above) is 1.03 ± 0.01 times faster than this patch. How do the
> changes below affect compilers other than gcc and clang than do not see the
> re-association barrier?

I'd say under reasonable assumptions (e.g. a not too ancient CPU with 3-cycle
integer multiplication) the new scheme is generally faster even without asm.

But Git can certainly follow Glibc's choice and employ this only on x86_64
(and only with GCC or Clang).

> We'd want to make sure that it does not result in
> slower diffs. Can we use atomic_signal_fence() on compilers that support C11?

No, what we need to do here is outside of the abstract machine's view, standard
functions are not going to help.

Alexander

> (we don't require C11 so we'd have to make it optional but it is supported by
> things like MSVC)
> 
> Thanks
> 
> Phillip
--8323328-1225942926-1754318384=:23243--
