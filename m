Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4451DFFB
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152652; cv=none; b=MxINi6Y+uCicQ3WaaAA1MZNGcmmR8Bhlp5tAEywfkGAEsuvCZ3tz5x8+zLSps13eok1qVwCTOLlklDxFXKZ7WmwZF4wM2LB+dnpC1SlGZqkj24HCqvHUkpgBqBxE4mij/Q0JhT7FgmsPdo/RWejbYU2tswCkJq/T5lz/EU407As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152652; c=relaxed/simple;
	bh=xSpOD7zzzkqwSXPJ57HD+9cJLMYpHamKCEv9Tmb9+1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTcmKsl5nIOLjTAj89TK3qrM3yWPVPuKBXgjF1HqTo0zyvTeW4DLENTqw1p11FM6jSVEpuUzA8ITC4OlLJjRxiWTTDNWLaz6scumIt01z4Ylwx5hoJ0hAz6t+kHeeD8Z1WR0vNiV72LsFFdO7TXjde6N6ySZ5/B7E+1byWkhsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=SJGpNryc; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="SJGpNryc"
Date: Tue, 19 May 2026 03:04:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1779152648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B/9Q+PdTAcJBmQEXbH/htlDd3Cxxi10gqH3EjNL6SAo=;
	b=SJGpNrycaZ+Fa49BVjaLOPI+QNKjgkGklM0b1qLAmvD7ZOmNk26Az1GYfm0Shx5H4hmR34
	H8cw4v9AM2jNMsNx9GqjanjPlXA1PUFbkv4yc/TC222RiM7o1cQQ0OmkJRk5fmYK0Q93Lb
	AHHlz8/veD0IulxsZZmZmN+z5iQO2dRNC32eKK9eErOvuXmji819F/dFPMKid9JedtECFN
	5ou+2k2aIJ/82zjBPoza/L+xxJIIDm/j3DKkTKsHd5yw//BDpdP9xbrcvRORR7VA0KRxLf
	0frRk56IoumsHrLhuyKYArHRcNCgMXm65iGgIE6bNHm/1FsYjQr2XklYkZhttw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Chris Torek <chris.torek@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v8] revision.c: implement --max-count-oldest
Message-ID: <agu1rZe0BiNowmBT@exploit>
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
 <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
X-Spamd-Bar: -----

On Tue, May 19, 2026 at 02:55:22AM +0200, Mirko Faina wrote:
> --max-count is a commit limiting option sets a maximum amount of commits
> to be shown. If a user wants to see only the first N commits of the
> history (the oldest commits) they'd have to do something like
> 
>     git log $(git rev-list HEAD | tail -n N | head -n 1)
> 
> This is not very user-friendly.
> 
> Teach get_revision() the --max-count-oldest option.
> 
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/rev-list-options.adoc |   5 +-
>  revision.c                          | 111 +++++++++++++++++++++++++++-
>  revision.h                          |   2 +
>  t/t4202-log.sh                      |  41 ++++++++++
>  4 files changed, 155 insertions(+), 4 deletions(-)

Sorry, forgot to write down what changed since v7. There was an issue
with the counting as --max-count-oldest counted boundary commits too.
That is simply solved by only adding on non boundaries.

That left another issue, there are now some "orphaned" boundaries when
printing the graph. In addition to that, because of how the graph
machinery works, the graph is now trying to include the parents of the
orphaned boundaries. To fix this we just flip the CHILD_SHOWN flag on
the parents of the commit we're discarding.

Hopefully this is the last version.
