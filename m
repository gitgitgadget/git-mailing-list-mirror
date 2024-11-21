Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA04206E
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180443; cv=none; b=gwpgeMfuZVbkyyovQCEgmCmCUSMgbMi0NWZsuV4JfnKr9YQPIjeB8ERrvRkooin7knItmw9difpXr6Uo6a4THHP1tHQWfiv527N4UvegUhGErtsq/3c4ReYNGiOoD7ideeYQKgKJaoOOAZtbk8cq97MD/iRL9/IUZ8Q4if+vX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180443; c=relaxed/simple;
	bh=abG96S1WI4UfoUaLTj+QMRJSYjWI4Go9gjAjBdLgvho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWWxjuCqGsC5eIJkQiblcp1ZIFX0fEwrlQnXOlHWdeSbrMsLq0Kkw4dgyBIh33uVQFYeF+gSweiWoqQ4uYa6rhqumdOc6hSLMr12gtfwLJYgCix5icDsnqQdJCyxX4fSPELIFkzpsaqZ8PSKt0Ghn5tnNWtPLIHI5kcxAv33RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eOBLvsT5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eOBLvsT5"
Received: (qmail 30142 invoked by uid 109); 21 Nov 2024 09:14:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=abG96S1WI4UfoUaLTj+QMRJSYjWI4Go9gjAjBdLgvho=; b=eOBLvsT5jbXeBoLw6u4ELyMO+UuvOM7pUVWibhcCwCa3NfRcnMoGhK9sr5NM3SSdwxhGvF+mebtaG5HBkzKXVjn82ry0O3oNDoNuJRY/M2QNOvSnRetztCzqPU/N0lWjsvSTOQjVFEjHsl2tjyJa/7CQmzCauvOjYq4+aU4n5Nc+OQLrtm5i0W6di4epn/M5ibxtPC8XdaGiNV1ib763JcchsStfJPdCyhcvlitLiCvwQ+lbApmdKbBW/LSIxzOI9Hokc6ZVcGcch8cPCP2O4mZyuZC44Spfbbc4ZQan8m2vi2IW4q87lFjEzRg5PbgNUrmpklkAUNWGH2QfBuk5zQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 09:14:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22555 invoked by uid 111); 21 Nov 2024 09:14:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 04:14:04 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 04:13:59 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] packfile.c: remove unnecessary prepare_packed_git() call
Message-ID: <20241121091359.GB602681@coredump.intra.peff.net>
References: <Zz5k9HsezqHEWTEm@nand.local>
 <884ca9770d1fb1e84962b1f700b1ce4adce6321c.1732142889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <884ca9770d1fb1e84962b1f700b1ce4adce6321c.1732142889.git.me@ttaylorr.com>

On Wed, Nov 20, 2024 at 05:48:51PM -0500, Taylor Blau wrote:

> In the instance that this commit addresses, there was a preceding call
> to prepare_packed_git(), which dates all the way back to 660c889e46
> (sha1_file: add for_each iterators for loose and packed objects,
> 2014-10-15) when its caller (for_each_packed_object()) was first
> introduced.
> 
> This call could have been removed in 454ea2e4d7, since get_all_packs()
> itself calls prepare_packed_git(). But the translation in 454ea2e4d7 was
> (to the best of my knowledge) a find-and-replace rather than inspecting
> each individual caller.

Yeah, I think that describes what happened.

> Having an extra prepare_packed_git() call here is harmless, since it
> will notice that we have already set the 'packed_git_initialized' field
> and the call will be a noop. So we're only talking about a few dozen CPU
> cycles to set up and tear down the stack frame.
> 
> But having a lone prepare_packed_git() call immediately before a call to
> get_all_packs() confused me, so let's remove it as redundant to avoid
> more confusion in the future.

Agreed. I think this is worth doing.

I briefly grepped for other cases. This one confused me:

  builtin/gc.c=1272=static off_t get_auto_pack_size(void)
  --
  builtin/gc.c-1292-      reprepare_packed_git(r);
  builtin/gc.c:1293:      for (p = get_all_packs(r); p; p = p->next) {

It's not a noop because it's calling the reprepare() function, which
will re-check the directory. But why? Are we expecting that something
changed?  This is called only when making the midx, so maybe it's trying
to refresh the set of packs after repacking. But that seems like
something that should happen explicitly, not as a side effect of an
otherwise read-only function.

Removing it still passes the tests. So I dunno. It looks superfluous to
me, but it's perhaps more risky than the one you identified.

-Peff
