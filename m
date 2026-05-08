Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175FA1397
	for <git@vger.kernel.org>; Fri,  8 May 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249597; cv=none; b=XP9tcWy/1/7gJiZt8WygirCtyGT+rQJmNihKVmJM4Pu3lTVUTQTcBad7uyusmvpoRPp3OFvsigcMNIlE5Tp1eoLmLul/DZq63Im2Mi/HxRwYZRjQZu9RaF4mQnBqcs2TAbtbl4phOEuX/veS7zmFp7dvsBhFMZBMhemqMXJ+gEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249597; c=relaxed/simple;
	bh=+YwgKM/tuymggiaeWTavnt4y5q+SVhGgNFFj4rAvGCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frDsjp5cX/MoK+2C1kdRfzpy54yUKM2NhmittQInwaIyG57D6mxEmYvFErm/hsi6TacaRa99m4wkV3yw5tEmH+SOdfmFRB2htf7YitIDrGm2QKM7mHmRTRK2QXMpOc/gse141x0GsD/DNYHnfLUwj/x+y0CrjJ7KyAVJo46GDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K0qO0pH1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K0qO0pH1"
Received: (qmail 63100 invoked by uid 106); 8 May 2026 14:13:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+YwgKM/tuymggiaeWTavnt4y5q+SVhGgNFFj4rAvGCg=; b=K0qO0pH1YCPWW+Op8onHBoQkYGGesV69THWsCOnPi68GQStkPVrpZB0ogBh28SfXuj4t7lFHQx5t1FH0v41TkaPUBIT1+JCXmxcMaK+0jcBT4SH76qikC8e0tgn7smJEmainNhvY2+R5Ya8d5/So7q6wdjwimVLZbjsPYwCUmoIpdX++hBrFYk+xpNvlcatO5pmII9JDQinXf4rCfj9XIo+V5QOIMlF/X/w8l7qOH8OqirfRDlz3YV2iEQX8/0zRfrB4up0ggYhth1Pd9oXIG/wlI09U2WH/TgXqUyyGjyOx7YV+3SalWGajTrsXML5ILU6xxrtpVP5hQ6JfSKCMuw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 May 2026 14:13:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 123761 invoked by uid 111); 8 May 2026 14:13:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 May 2026 10:13:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 8 May 2026 10:13:14 -0400
From: Jeff King <peff@peff.net>
To: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without
 arguments
Message-ID: <20260508141314.GB709299@coredump.intra.peff.net>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>

On Fri, May 08, 2026 at 09:07:34AM +0000, Greg Hurrell via GitGitGadget wrote:

> From: Greg Hurrell <greg.hurrell@datadoghq.com>
> 
> When `git jump` is invoked with no positional arguments (and no
> arguments after `--stdout`) it currently prints usage and exits with
> status 1.
> 
> But there are two situations where we can usefully infer the most
> valuable and likely mode that a user would want to use, and select it
> automatically when they run `git jump` without arguments:
> 
> 1. When there are unmerged paths in the index, the user likely
>    wants `git jump merge`.
> 
> 2. When the working tree has unstaged changes, the user likely
>    wants `git jump diff`.
> 
> Detect these two cases and dispatch to the corresponding mode
> automatically, falling back to the existing usage-and-exit behavior
> when neither holds.

OK, I guess this saves a little bit of typing. I never really thought
about it because I long ago aliased the various invocations in my shell
("git jump diff" in particular is so useful that it is just "d" in my
shell).

I'd be a little worried that it is more confusing to somebody
approaching the command for the first time and just runs "git jump" to
not see usage or other guidance. But that might be overly paranoid.

Would having "git jump auto" work for you? I.e., are you primarily
trying to avoid the mental effort of selecting the command, or the
finger effort of typing it?

>  if test $# -lt 1; then
> -	usage >&2
> -	exit 1
> +	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
> +		usage >&2
> +		exit 1
> +	fi
> +	if test -n "$(git ls-files -u)"; then
> +		set -- merge
> +	elif ! git diff --quiet; then
> +		set -- diff
> +	else
> +		usage >&2
> +		exit 1
> +	fi

The implementation looks reasonable. In theory we could save a diff
invocation by trying diff mode and reporting whether it found anything.
But the --quiet invocation is not too expensive, and avoiding it is
probably not worth the gymnastics required.

-Peff
