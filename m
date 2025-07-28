Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54C2253FC
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736245; cv=none; b=fQ+x6WVf9kSZrBK416FiFSZayqSt00YOe5UBDRTNeVO4rKzBKj2XEbu0stQYa1Y/SOCbKioti9pJvp3iEZBfmDfk1yfXrX4otV/f8FRqPJP/VzT9LI0u6bv05LsN0j/aWkIEX8C0TdCeaNcxNzPOAA4tfwXOa0G3+RCCqIFdHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736245; c=relaxed/simple;
	bh=95T65iPFiw3RDGNytwGkGqLblYdD902VPCsV5kMqxKU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cxTID98UBtuWTwxDuxH9xRA20hhe+8bais9usT2qr+4JU9UFrxoL1595DQRZjliWLGCRLuBb/+pivTe56nQyc5RZ+MEsPTRIXGKsdUCSivSTeKMNxxDw80pMqoX+h4gjcfRMPNpyW0lodyznu8TqvwWW9cwr5TmyHRtM7gzNNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rNhp9z47; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rNhp9z47"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id 971A7407616D;
	Mon, 28 Jul 2025 20:57:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 971A7407616D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753736238;
	bh=c/rJDWoYKKjGOhKl7790Mn12JPvPmeIRqLKTxENDoKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rNhp9z47Eij+76D/zYXi90MtT1b6vlk9NmmgkW81YU3rWmQNGyN3tZj+nvGrsXl84
	 snoEZ0fJtGmzB6l3FGlyLKevxxOP36ZR0wcflKxEXSXg9DDeqpBX+YlC7cN2kwdJy4
	 bmEwd9sUFlUhl01wcC2f7TIbDQqIjom1NH9GdVZI=
Date: Mon, 28 Jul 2025 23:57:18 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <xmqq5xfcujjn.fsf@gitster.g>
Message-ID: <3405f274-cef1-b361-7424-840dc55b48a1@ispras.ru>
References: <20250728190520.10962-1-amonakov@ispras.ru> <20250728190520.10962-3-amonakov@ispras.ru> <xmqq5xfcujjn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Jul 2025, Junio C Hamano wrote:

> Alexander Monakov <amonakov@ispras.ru> writes:
> 
> > +/*
> > + * Compiler reassociation barrier: pretend to modify X and Y to disallow
> > + * changing evaluation order with respect to following uses of X and Y.
> > + */
> > +#ifdef __GNUC__
> > +#define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
> > +#else
> > +#define REASSOC_FENCE(x, y)
> > +#endif
> 
> With gcc we can build, but with clang, we unfortunately get this:
> 
>     $ make CC=clang DEVELOPER=YesPlease
>     xdiff/xutils.c:330:4: error: extension used [-Werror,-Wlanguage-extension-token]
>       330 |                         REASSOC_FENCE(c0, ha);
>           |                         ^
>     xdiff/xutils.c:302:29: note: expanded from macro 'REASSOC_FENCE'
>       302 | #define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
>           |                             ^

Sorry, wasn't aware that Clang would warn. The solution is to spell 'asm' with
double underscores, __asm__.  I'll make this change if I post a v2.

Thanks.
Alexander
