Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDA315D40
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482882; cv=none; b=IElyFQidfcfhGXh8RFyyVmojtgO09rs6rqMXpUN9D0YhJ8hhZZJqfPuz+KwOU1D3QZQvET5o858AvTSee+gu1UzzpOvoj3Jfb26owRkFAUEJ+Xj/pHL9owwOCOS9FtgkaSYL2eXTUc5Jk/KH4e9N5o+1vccvH6vepVuh6KPeZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482882; c=relaxed/simple;
	bh=Fbi268XpCKCDAfOZFb6wWb5w281HdMgEAZzdmATdZVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEbB7FRyA5H0V5V15rBR75LQVODRa0Tav/sf4iZcekAnqgRGlfiSAB1NVLDhgAY+UT5dk/owdx2zSihN1q+Yp2LLY3r0SzUC0osb0uZWI4zxaTvHM8rquaLw8lwyb31bjHiHmFXeGdzCcfoBkSRlyOx1CUivatxuz4b4EZW8i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M8wCDMLl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M8wCDMLl"
Received: (qmail 25506 invoked by uid 106); 8 Jul 2026 03:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Fbi268XpCKCDAfOZFb6wWb5w281HdMgEAZzdmATdZVE=; b=M8wCDMLlMUACQy6TTDT5XXbGoclJXW6sH6A6FRPbT7RXHoQLWdskobx94wKtkkzwt0NZwrwOAwS3CnntWx0u7zQInf2n6pKYD1prCgY+sbiZAfi8y8Gvweh0DHBKLA0JiOhwuvG2ZfY53cVvqeI6NzMRx/a52OXYJlg/jBbzVnlWBTzVh/nfEUODYmkNm0J+UD6OzavWjcJGpc+4XPGDLJNE1bz2RM9BTMN9XhLbqNchJuJzWZbBNS267GjMA6BtJc5bzhN35jrQfQdHcobNlvEZecK2ovm2Vvvj+kDuMSgSqwvLzLtPNznqhhS6Cv/qiZ/+5Uh9ihOz9QW0GtERDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:54:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41054 invoked by uid 111); 8 Jul 2026 03:54:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:54:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:54:39 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/7] hash: use git_hash_init() consistently
Message-ID: <20260708035439.GA41684@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050141.GA1288294@coredump.intra.peff.net>
 <ak1u25b2pmRAQIxD@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak1u25b2pmRAQIxD@fruit.crustytoothpaste.net>

On Tue, Jul 07, 2026 at 09:25:48PM +0000, brian m. carlson wrote:

> On 2026-07-07 at 05:01:41, Jeff King wrote:
> > We'd like to add more logic to git_hash_init(), but many callers skip it
> > and call algop->init_fn() directly. Let's make sure we're consistently
> > using the wrapper by adding a coccinelle rule.
> > 
> > Besides the coccinelle file itself, this is a purely mechanical
> > conversion based on the patch it generates. There should be no bare
> > init_fn() calls left (except for the one in the wrapper).
> 
> For context, the reason `git_hash_init` exists is that our Rust code
> needs to initialize a hash context but it treats `const struct
> git_hash_algo *` as `const void *` and doesn't have any access to the
> contents of the structure.  We could fix this with `cbindgen` and
> `bindgen`, but haven't done so yet.
> 
> So that's why everybody has been using `init_fn` instead of
> `git_hash_init`.  Anyway, I have no objections to making this the
> standard interface going forward.

Thanks, I remember there being some actual reason but couldn't recall
exactly what it was. The use of bare algo->update_fn(), etc, in two
spots was what really puzzled me. It's not wrong, but just harder to
write than the usual way. ;)

-Peff
