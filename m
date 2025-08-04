Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED9274FD0
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312505; cv=none; b=BDd2wt0JdcEtoPgujgr0+F925FbUL9mVf/hhYwNW+W4QszmjUoaGq3qOZDqLBgqCjN2kUYlSnx+ZIZPExvTG0LDmueEkfnoBQOIWnC9oOZvq74nC3vVJY+EcBBROEt5HLw2nN0qUhg9oHZ2VdmFdnZ/WvTFhPzFJxXeQ7xc9a5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312505; c=relaxed/simple;
	bh=gAEUTk+z3fE2ON/CChygvzgHbNxe/fwkkdRihBjdSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EroYVQYSUlPT1pkaeNiH85cCPrc3PjzOd5ws+ILJO7wOguR72mjqoho4EhizqnNJDvezmAwbNKeG91KvIhy2pyUIij+ORvt7B+0buy98HpjiaVP/2W3b6oc5oFcPoEobz5jpQLyoskranu/qbrrczDIhGFD4b+5vCzTkNUGyEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TDxoNgbt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TDxoNgbt"
Received: (qmail 737 invoked by uid 109); 4 Aug 2025 13:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gAEUTk+z3fE2ON/CChygvzgHbNxe/fwkkdRihBjdSP0=; b=TDxoNgbtUqH4Glw+YB20rnMV6bt0M/h2wjcruWXxpq6GRp9q2ggT9ejYAG0hHNeaiVPor/d5GlashwPnBX/jK6h11cPHKcFNkvHQPKGXQY0XHoVnzSOY7bSam+TEN0Vftw1j+y4pB6OiIfv5MQagJYaAhaFrbKbc6fyibXwprpcMkJFYPsecS2ZTigINy7ZkfKaiAAPj/5kHYQ48fZzGgxcoxU8g2cFFWW3LJ4mgu2XZT2jgUwxe/xwVsXUseLrTN274INWtbk42Qb9sJhv8CLr+R0ULdAYmxPVRCUZvbIdqDEzXygoFODgzWZK+ii8Xo8WKpSAEg/wLLwg+IbNHPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 13:01:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19111 invoked by uid 111); 4 Aug 2025 13:01:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 09:01:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 09:01:41 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] revert: initialize const value
Message-ID: <20250804130141.GA95101@coredump.intra.peff.net>
References: <20250804130011.GA93475@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804130011.GA93475@coredump.intra.peff.net>

On Mon, Aug 04, 2025 at 09:00:12AM -0400, Jeff King wrote:

> There are a few possible options:
> 
>   1. Instead of a variable, we could just construct an artificial
>      sentinel address like "1", "-1", etc. I think these technically
>      fall afoul of the C standard (even if we do not access them, even
>      constructing invalid pointers is not always allowed). But it's also
>      something we do elsewhere, and even happens in some standard
>      interfaces (e.g., mmap()'s MMAP_FAILED value). It does involve some
>      annoying casts, though.
> 
>   2. We can mark it as static. That gives it a definite value, but
>      perhaps makes people wonder if the static-ness is important, when
>      it's not.
> 
>   3. We can just give it a value to shut the compiler up, even though
>      nobody cares about that value.
> 
> I went with (3) here as the smallest and most obvious change.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I dunno, maybe the comment just makes things more mysterious and
> doing the casts would make it more clear what is going on.

Hmm, I guess one other option I did not consider: we could just drop the
"const". The pointers to it are "const char *", but it is fine for them
to point to a non-const variable. Maybe that is less mysterious.

-Peff
