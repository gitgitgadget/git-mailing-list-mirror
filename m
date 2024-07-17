Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75416E57E
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197015; cv=none; b=ZV1MRjPc+TLVVa70Ye0CRYxlp96k3AYxYk66cEGmw8bh+lv4J5oIon3L7vo/jYAs0b1eZeH3dYUInzGepLn4CpMU4PotdxTIJJg8k3yeUNo63e59clVcJyoDZzAui34o7S1EtzWgsfDcpHyWClS/K7AEHikgLnxzTakmFQWDR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197015; c=relaxed/simple;
	bh=h6swU/a8Oi5sHU2s1FPiSOoOeTNepfXO6UZ4HVWDt2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuOf+lWWAlsPcOg24lNwxd9yJCoC+5VA+vVYejE4KBwjMZLkTJKY8Oqp1ym6Fp465/Sbzrcho/tP66H97ryWiamnslG/4CdsKKYPvJtr9bHcyQbKSYXh22h17PQLXOV/QGM3ikvpOFD5tR/jpMb1+lze3m0GCoJOwjgezOOEhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23727 invoked by uid 109); 17 Jul 2024 06:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 06:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18914 invoked by uid 111); 17 Jul 2024 06:16:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 02:16:50 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 02:16:51 -0400
From: Jeff King <peff@peff.net>
To: Haritha via GitGitGadget <gitgitgadget@gmail.com>
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH] Fix to avoid high memory footprint
Message-ID: <20240717061651.GE547635@coredump.intra.peff.net>
References: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1744.git.git.1721117039874.gitgitgadget@gmail.com>

On Tue, Jul 16, 2024 at 08:03:59AM +0000, Haritha  via GitGitGadget wrote:

> From: D Harithamma <harithamma.d@ibm.com>
> 
> This fix avoids high memory footprint when
> adding files that require conversion.
> Git has a trace_encoding routine that prints trace
> output when GIT_TRACE_WORKING_TREE_ENCODING=1 is
> set. This environment variable is used to debug
> the encoding contents.
> When a 40MB file is added, it requests close to
> 1.8GB of storage from xrealloc which can lead
> to out of memory errors.
> However, the check for
> GIT_TRACE_WORKING_TREE_ENCODING is done after
> the string is allocated. This resolves high
> memory footprints even when
> GIT_TRACE_WORKING_TREE_ENCODING is not active.
> This fix adds an early exit to avoid the
> unnecessary memory allocation.
> 
> Signed-off-by: Haritha D <harithamma.d@ibm.com>

Good find. Any trace function should verify that tracing is enabled
before doing any substantial work.

Let's take a look at your patch. First, your line wrapping is unusual,
making the commit message a bit hard to read. We'd usually shoot for ~72
characters per line. So more like:

> This fix avoids high memory footprint when adding files that require
> conversion.  Git has a trace_encoding routine that prints trace output
> when GIT_TRACE_WORKING_TREE_ENCODING=1 is set. This environment
> variable is used to debug the encoding contents.  When a 40MB file is
> added, it requests close to 1.8GB of storage from xrealloc which can
> lead to out of memory errors.  However, the check for
> GIT_TRACE_WORKING_TREE_ENCODING is done after the string is allocated.
> This resolves high memory footprints even when
> GIT_TRACE_WORKING_TREE_ENCODING is not active.  This fix adds an early
> exit to avoid the unnecessary memory allocation.

Second, we'd like a full real name in the Signed-off-by line, as you're
agreeing to the DCO. See:

  https://git-scm.com/docs/SubmittingPatches#sign-off

Likewise, the author name should match the signoff name (you can use
"git commit --amend --author=..." to fix it).

For the patch itself:

> --- a/convert.c
> +++ b/convert.c
> @@ -324,6 +324,11 @@ static void trace_encoding(const char *context, const char *path,
>  	struct strbuf trace = STRBUF_INIT;
>  	int i;
>  
> +	// If tracing is not on, exit early to avoid high memory footprint
> +	if (!trace_pass_fl(&coe)) {
> +		return;
> +	}

I don't think trace_pass_fl() is what you want. It will return true if
the trace fd is non-zero (so tracing was requested), but also if the key
has not yet been initialized (i.e., nobody has used this key to try
printing anything yet).

I think you'd just use trace_want(&coe) instead.

Also, two style nits:

 - our usual style (see Documentation/CodingGuidelines) is to avoid
   braces for one-liners.

 - we only use the /* */ comment form, not //. Though IMHO you could
   skip the comment completely here, as an early-return check in a
   tracing function is pretty obvious.

It would be nice if we could test this, but besides the wasted work, I
don't think there's any user-visible behavior (the problem is that we
are computing things when we're _not_ tracing, so there's nothing for
the user to see). And there's no provision in our test suite for
measuring memory usage of a program. So I think we can live without it,
and just manually verifying that it works (but it would be good to show
the measurements you did manually in the commit message).

-Peff
