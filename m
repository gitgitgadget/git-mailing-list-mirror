Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821473B29E
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921701; cv=none; b=ABikoJlafK7YnoXolcHvxR6ye+qhH7tXo69IzpaD4J78+Qc+A/0H7nLHlz/wHeDxShjEx6VO/ohJm2fd248yYOv7aWNEa7ACpzw3gNkMb8ro13J5ceEMHoQ+cosi591oEXC4/AXzf4JM+b9auTuL17WWQm/4BUeprF8q0to2DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921701; c=relaxed/simple;
	bh=FmyYgQl/lV4a9uMqXzMtpJGynPfe5idq+1gH8910kM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qb5Uukwbnylpb6q7LS/IVipyf4TVHUJAG/Bdp/KbRoxsYDQk4h30weBU1qg+ppcx/AY+zgGa8DyhXOldQs69xWco6uNTcmIp4Ttp3rOPEhPQ+pM91xY6GBKIsHl0ZDTpMNXMXywATGAcIg8ruAsbSBQAwgqRezdiAXRX9IqBWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=bW7LnP9B; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="bW7LnP9B"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 69BC340A3277;
	Mon, 11 Aug 2025 14:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 69BC340A3277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1754921682;
	bh=beQaQ8uQoGTLbF/5IMN7AqEqhsNKRSn142UPL02ScYE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bW7LnP9Bp17eh65MuRn1+fwwiLLlkrZk9EJz++PDrb70MW6m+1eTwWSXKDA8JpSKn
	 phHCIxt0ty5zlbo9SgvbUTqRu9YjN81m3t2pAwfmfCyWGxof/wzTRZCZY/I/+45CxD
	 afkIFitWQyy+6g3e5vrTyqYS3sT632aGAh9I7LiU=
Date: Mon, 11 Aug 2025 17:14:39 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
Message-ID: <c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <20250728190520.10962-3-amonakov@ispras.ru> <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com> <353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru> <5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Mon, 11 Aug 2025, Phillip Wood wrote:

> > That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)
> 
> It would be helpful to add a column with those calculations in it rather than
> forcing the reader to calculate the speed up for themselves.

Ok, will change it to

version | speedup over (A) | cycles, bn | instructions, bn
----------------------------------------------------------
A                            6.38         11.3
B         1.027              6.21         10.89
C         1.1                5.80          9.95
D         1.094              5.83          8.74
----------------------------------------------------------

> Also what is the cycles column measuring? What is it that takes 6.21 cycles
> for B and only 5.8 cycles for C?

Billions of cycles, e.g. in C the entire command completes in 5.8e9 CPU cycles.

> > Then you get 9% from the inlining patch and only 2% from the faster hash
> > function? That's a bit surprising, which compiler and CPU you used? Is it
> > with default optimization (-O2)?
> 
> I used gcc with -O2 -march=native on an i5-8500. I saw a similar improvement
> from the inlining when I was playing with xxhash.

Thanks, I'll see if I can benchmark it on a Skylake in the coming days. That
said, I think most users will get Git from their distro, without -march=native,
right? So I'd suggest looking at plain -O2, especially for xxhash, which
selects hashing primitives based on CPU-indicating predefined macros.

> > I'd say under reasonable assumptions (e.g. a not too ancient CPU with
> > 3-cycle integer multiplication) the new scheme is generally faster even
> > without asm.
> 
> Thanks, fwiw I don't see a measurable difference in the timings with and
> without the asm on my machine -

To be clear, by "without asm" you mean forcing the !__GNUC__ branch where
REASSOC_FENCE macro is empty?

> sometimes one is faster, sometimes the other, any difference is within the
> noise.

Would you mind showing your 'gcc --version'? Also, I prefer 'perf stat' for
such measurements, because its measurements are not so sensitive to frequency
scaling (plus, you can compare my cycles/instructions counts with yours if you
run 'perf stat', but I cannot compare your seconds from hyperfine with mine
because of course my CPU runs at a different frequency than yours).

'perf stat -r 5' runs the workload 5 times and prints averages and deviation.

> > No, what we need to do here is outside of the abstract machine's view,
> > standard functions are not going to help.
> 
> That's a shame. I'd hoped that stopping the compiler reorder the code would do
> the same thing - what is the asm doing that's different?

atomic_signal_fence only blocks reordering of references to memory that can be
observed from a signal handler interrupting the current thread. It has no effect
on variables whose addresses do not escape (let alone never taken in the first
place). Here we want to force a particular evaluation order for variables that
end up on registers and are not supposed to appear in memory at all.

Alexander
