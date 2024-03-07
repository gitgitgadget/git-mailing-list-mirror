Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331012882C
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805402; cv=none; b=cAod8FBk8bW9Q/1/PDkhzijIBLxBHnB28vsDjdIdsl+CbyX5uudiF1aRGAxgi68oTrKoALPRfdbSBc6RCB5gwMZ02b9OPAlLkqVP9qwR5/BnPqg+9dd0cb5jDrnCua8JJL2AIomVNpZ4vBtMFcQ3ppxVhQZUzyjpSNozsRA2F3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805402; c=relaxed/simple;
	bh=S3Ze2TR3J8pOt5W1HYghQDBy6wZWBUu9U+S9rcMuaQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD4BBKrwGCkwovFMbJaalIlH9o3Dt86AZ6we6d+OlwmeUjvuugWUnKRUrarsIRJORATaOoYqM1b2BQBObsrEY+JOWOp3LGT2IP78q6oNjAPfWXVKZ3zNl8/8wKWjAj7noXuim4kVMUTGcCmCd8GuPs4R5IWKBiTJkFAi+sIL4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7222 invoked by uid 109); 7 Mar 2024 09:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12975 invoked by uid 111); 7 Mar 2024 09:56:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:56:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:56:38 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
Message-ID: <20240307095638.GC2650063@coredump.intra.peff.net>
References: <xmqq1q9mmtpw.fsf@gitster.g>
 <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g>
 <xmqq1q9cl3xv.fsf@gitster.g>
 <xmqqr0hcglpk.fsf_-_@gitster.g>
 <20240217054048.GD539459@coredump.intra.peff.net>
 <xmqqfrxexx15.fsf@gitster.g>
 <20240227074903.GD3263678@coredump.intra.peff.net>
 <xmqq1q8xx38i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q8xx38i.fsf@gitster.g>

On Tue, Feb 27, 2024 at 08:48:29AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's some prior art there, I think, in how GIT_CEILING_DIRECTORIES
> > works, or even something like "git --literal-pathspecs", neither of
> > which appear in local_repo_env.
> 
> Unlike GIT_CEILING_DIRECTORIES that is more or less permanent and a
> part of configuring an everyday environment for real work, I view
> this --no-lazy-fetch thing as solely a debugging aid.  A repository
> with promisor wouldn't be able to "fill the gap" by forbidding
> on-demand fetching of promised objects while running say "git fetch"
> from elsewhere and it just will die with "some objects we are
> supposed to have are missing from this repository".
> 
> So I do not have a strong opinion either way, if it is more
> convenient to propagate the request out to other repositories when
> we run processes in two or more repositories (e.g. "git clone
> --local"), or if it is more convenient to make sure that the request
> is limited to the target repository.  Here is a version without the
> local_repo_env[] change.

Yeah, GIT_CEILING_DIRECTORIES is maybe a bad example. But I do think
LITERAL_PATHSPECS is a better one, and the submodule-fetch example I
gave would be genuinely surprising if it behaved differently than the
superproject, I'd think.

I do agree this is probably going to mostly be a debugging aid, so it
might not matter much. But once in the wild these things tend to take on
a life of their own. ;)

> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH v3 3/3] git: extend --no-lazy-fetch to work across subprocesses

So anyway, this version seems good to me.

-Peff
