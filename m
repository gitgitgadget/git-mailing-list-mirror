Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2B54BD8
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020153; cv=none; b=uebiepy07FL2uHIAn0MXdhgxRyYby37F3/FQOuzkyjHwrcxRg1jTswuiSOw1cHlo2cOXxDvQsEcx/AGINsXyA+mRG/mfbj23JccHNoCIA6iLV73TWkBTE8MPuf8Ug12+bAXf/xVcg6RGcS7ckvuuTbYXgTz7go6IkAralXNqzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020153; c=relaxed/simple;
	bh=Zwi9VrxnVKDaoM6jWXFmRuRxW3v7C92skVRisHiCF2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9rYDqyneoV3RkIbSL8vN0WfuvdOiB/ogKjOrop46HZsZmSnZFDQbLiG6UjklHC+3M/g1K/h1EpTzviMbH1S5w7Q9JVah+Q6JYmdu5jnRHYsSqQFJevodYR38Dv/i1tw6m0B0C8f1pj4ZwHztvkfoQLOMprGaCD8KML3+eTWzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10938 invoked by uid 109); 27 Feb 2024 07:49:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 07:49:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7093 invoked by uid 111); 27 Feb 2024 07:49:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 02:49:08 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 02:49:03 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
Message-ID: <20240227074903.GD3263678@coredump.intra.peff.net>
References: <xmqq1q9mmtpw.fsf@gitster.g>
 <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g>
 <xmqq1q9cl3xv.fsf@gitster.g>
 <xmqqr0hcglpk.fsf_-_@gitster.g>
 <20240217054048.GD539459@coredump.intra.peff.net>
 <xmqqfrxexx15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrxexx15.fsf@gitster.g>

On Mon, Feb 26, 2024 at 10:04:54PM -0800, Junio C Hamano wrote:

> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH v2 3/3] git: extend --no-lazy-fetch to work across subprocesses
> [...]

This looks pretty reasonable to me, and the lines you drew for
#leftoverbits all seemed liked good spots.

The only thing I noticed in the patch was this (which I think is not
even new in this round):

> diff --git a/environment.c b/environment.c
> index 9e37bf58c0..afad78a3f8 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -136,6 +136,7 @@ const char * const local_repo_env[] = {
>  	GRAFT_ENVIRONMENT,
>  	INDEX_ENVIRONMENT,
>  	NO_REPLACE_OBJECTS_ENVIRONMENT,
> +	NO_LAZY_FETCH_ENVIRONMENT,
>  	GIT_REPLACE_REF_BASE_ENVIRONMENT,
>  	GIT_PREFIX_ENVIRONMENT,
>  	GIT_SHALLOW_FILE_ENVIRONMENT,

This will clear the environment variable when we move between
repositories. I can see an argument for it, and certainly that's how
GIT_NO_REPLACE_OBJECTS works.

But I can also see an argument that this is not a property of the
_repository_, but of the request. For example, if I run "git
--no-lazy-fetch log" and we cross into a submodule to do a diff, should
that submodule also avoid lazy-fetching? I'd think so, but I think your
patch would restore the defaults when we "enter" the submodule repo.

There's some prior art there, I think, in how GIT_CEILING_DIRECTORIES
works, or even something like "git --literal-pathspecs", neither of
which appear in local_repo_env.

-Peff
