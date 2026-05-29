Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C831347BC1
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033022; cv=none; b=fkkdbFNE8JkZ8zzNJMfuNz8Gg5KFGQMFwIAGePSEtVzPsHRHXZabUcUjRtWSc2t2YLeNfQRdHhG6WEhSuAy4kFdvjjxkgcsTHaEnBhmaKVwhpbmcrzc4NAMH1RiVEvx1reOJktlUoTgcjS80rRvfVnmpOdvt8g1TJSvLPUGF0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033022; c=relaxed/simple;
	bh=y3wvMV+vfbn/sYpl7XkTUVUcSXSmmcUpAAyPMY/LXTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSYfW8ibirfhPSaXWC6G45uDntIPmr23C21yZPldC9pf69RXBCkAXE1gPgGwcYTr1YJ6zwfjDDcfeRFpSqsA+f72yNncrU0frGkTToW2cJe2TUxB1eTfa4XPRG6JmmyUuVHeFE85qAu32fzgGSUC0xo+aL/daSPL3CsBC9zDS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cru4QpBG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cru4QpBG"
Received: (qmail 3865 invoked by uid 106); 29 May 2026 05:36:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=y3wvMV+vfbn/sYpl7XkTUVUcSXSmmcUpAAyPMY/LXTk=; b=cru4QpBGl6xOm2kEtOymFY+owl1A4LIYYBVHjV31JMOMNEx5/HcmcS2kC6KeY6FQwAud9Hwkl1mC8E8JjFtan/u43qnEXC5/zdi/yplZjHgYLityXgyHYUkkI5EMxpmE8upi5W2YMjI1a5L45/72P7/NECCh1EMC4VVTi0SqIaWy2qZ1v/bNy4XhDWpomy5zFxUUQgLzfe/V+z2Ug6wKqjcbgsGBqllS0RXMqyLF626KsjNQX1NrdETVIG4dcodOh7YxJ4M5NctE8nO9nYu6UzGUNF+wiam0i+1w5kYeqPAT58rpF+w2YFbXpYMkfd0/MzOSa/SDus9guXrlR2ppSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 05:36:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7243 invoked by uid 111); 29 May 2026 05:37:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 01:37:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 01:36:59 -0400
From: Jeff King <peff@peff.net>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH v2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <20260529053659.GC1099450@coredump.intra.peff.net>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <ahjUmMCKxREamQE-@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahjUmMCKxREamQE-@lorenzo-VM>

On Fri, May 29, 2026 at 01:49:44AM +0200, LorenzoPegorari wrote:

> Inside the function `fetch_and_setup_pack_index()`, when the pack
> obtained using `parse_pack_index()` fails to be verified by
> `verify_pack_index()`, the function returns without closing and freeing
> said pack.
> 
> Fix this by calling `close_pack_index()` to munmap the index file for
> the leaking pack (which might have been mmapped by `fetch_pack_index()`
> or `verify_pack_index()`), and then free it, when the verification
> fails.
> 
> Also, do some more cleanup by removing the useless call to the function
> `unlink()`. This is not necessary anymore since 63aca3f7f1 (dumb-http:
> store downloaded pack idx as tempfile, 2024-10-25), when
> `fetch_pack_index()` started registering its return value (in this case
> `tmp_idx`) as a tempfile to be deleted at process exit.

I think the patch as-is is OK. But when I see this kind of "also, do
this..." in a commit message it is a good time to consider whether that
should happen in a separate patch.

Here it does not make sense to remove the unlink() afterwards; you'd
wonder why it was not present in the cleanup added by your patch.

But it _could_ be done as a preparatory patch. And the rationale for
doing that on its own I think is roughly:

  1. It is mostly doing nothing, because 63aca3f7f1 registered it as a
     tempfile, so it will be cleaned up at process end anyway (whether
     we succeed in fetching it or not).

  2. It is maybe a little harmful, because we are going to unlink() it
     now, and then later the tempfile code will try to unlink() it again
     (so a simultaneous fetch could have created the same file).

For something this small, though, I am OK just lumping it together.
There are diminishing returns from polishing it further.

-Peff
