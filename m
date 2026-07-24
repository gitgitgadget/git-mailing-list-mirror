Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448D37D101
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893799; cv=none; b=gOorIu3/l9toIgDiZ+gr9yfAfj2o+FtXbW6SYs8b1Ly1HKshBVe7o1rQA2ok9ARqBPA33c80EqtAiyKi/A9Et+Wj26Ti5s9nSh8Dj92KNIDA//lipxkPk3rc1f33wFFAAA/lDJ3NyL1kKDf5MR0tIquq0Txaawv7hbXeZz9i82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893799; c=relaxed/simple;
	bh=fwvRAlW7lphPkE9kTAjFABU/Cc6NepCmz2Y2hWVES6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP/v/ySoyImaoJ4GsbcOmUOmUoaa/tPdIwMwwagu3EhfZhVtuW9pL1GE9ZIzfhbGkSnOSYr+SHCrmUYtvT28Aj2J63VYa6ka9BoI6y8BnLDCQullGdu6+amZ4aMgzq1Ffwrds113ed6wb1gyeJJWhSbx61/PhBzxANnzUWSiVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Pxp/EHkg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Pxp/EHkg"
Received: (qmail 36740 invoked by uid 106); 24 Jul 2026 11:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fwvRAlW7lphPkE9kTAjFABU/Cc6NepCmz2Y2hWVES6c=; b=Pxp/EHkg9CVAOl+qJR7KYT14m03ozrKh7F7Bvc/2OyynTp5LyVipjp7XurzmUCYW3tLHHBBVICNOyhw32+SeGwXY15aa4pUoTNyFxqSSyRneW1mt0Bw/Esgae95uUSUMZ/W6Vjgzk7j2Z31kTcCYZp+3BN71FiAVjlZ5SZ+xdIGOZOlOHOD1kBl9G0UwNMCAnB1JYI2IuXq/WhKHxloNSiq94NadsSoRUoiVEwr/F/yX7ta60hghXxKQhYEy9uA+Pz+DCaP8MllxXfoREE3OeDVfkH6YFmkB7qx4s+oQpJ21JZUSsMt0V3H5FfO2ZOgZ4zpKGFK0qq2oQ0EtHXjAlQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Jul 2026 11:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34747 invoked by uid 111); 24 Jul 2026 11:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jul 2026 07:49:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Jul 2026 07:49:48 -0400
From: Jeff King <peff@peff.net>
To: tnyman@openai.com
Cc: git@vger.kernel.org, gitster@pobox.com, haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
Message-ID: <20260724114948.GA825505@coredump.intra.peff.net>
References: <20260724091152.27794-2-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724091152.27794-2-tnyman@openai.com>

On Fri, Jul 24, 2026 at 02:11:53AM -0700, tnyman@openai.com wrote:

> The --delete-merged implementation declares a loop index at function
> scope and reuses it to walk its strvec of upstreams and its list of
> candidate branches. Coccinelle 1.1.1 spends hours matching this against
> the separate_loop_index rule in tools/coccinelle/strvec.cocci, causing
> the static-analysis job on 'seen' to reach its six-hour timeout.

Yuck. So this is really a coccinelle problem. It looks like it has been
fixed (or at least improved) in recent versions. I can reproduce the
slowness locally on 1.2.0 (I couldn't get 1.1.1 to build), but 1.3.0 is
fast. Bisection turns up 58619b8fe (break up envs for e1 & e2,
2024-08-18), which says:

    Since 362937b2a84840e68ae021171df10c7a4cc6fbef, e1 ... e2 has the
    quantifiers for the free variables of e1 around the whole thing, to ensure
    that the when code on the ... refers to the same variables as e1.  This can
    make the semantic patch very slow, as illustrated by kmerr.cocci in
    scripts/coccinelle/null/kmerr.cocci in the Linux kernel.  The slowness
    comes from environments based on multipl metavariable bindings getting very
    large.

    To reduce (but not solve) the problem, for the first & where the left side
    has multiple results, consider these results individually when working on
    the right side, and then union the results.  This may lead to some loss of
    sharing.  Maybe it is not advantageous when the ... contains when any and
    does not contain any explicit when clause containing the variables of e1.

The static-analysis CI job uses the ubuntu-22.04 image, for no reason
that I can really discern. It looks like coccinelle 1.3.0 is in ubuntu
25.10, according to:

  https://packages.ubuntu.com/km/questing/coccinelle

Why don't we just use the more recent version instead of trying to work
around it? That would fix this problem and prevent future ones. Looking
at the code in question:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 42f2221547..2415a275ea 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -797,10 +797,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
>  	struct strbuf key = STRBUF_INIT;
>  	struct hashmap_iter iter;
>  	struct strmap_entry *entry;
> -	size_t i;
>  	int ret = 0;
>  
> -	for (i = 0; i < upstreams->nr; i++)
> +	for (size_t i = 0; i < upstreams->nr; i++)
>  		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
>  			die(_("'%s' is not a valid branch or pattern"),
>  			    upstreams->v[i]);

...there is nothing suspicious or wrong about it. It seems likely that
somebody else may end up writing something similar and triggering the
same problem.

That said, moving the iterator into the loop declaration is perhaps
nicer anyway, because it avoids two unrelated uses of the same variable.
Notably:

> @@ -809,7 +808,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
>  	filter.name_patterns = argv;
>  	filter_refs(&candidates, &filter, filter.kind);
>  
> -	for (i = 0; i < (size_t)candidates.nr; i++) {
> +	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
>  		const char *branch_refname = candidates.items[i]->refname;
>  		const char *branch_name;
>  		struct branch *branch;

This hunk is not using a strvec at all. Because it uses the same
variable, if we did not change this loop, then we'd still have to
declare "i" at the top of the function and the other loop would
introduce a shadowed variable. That's not wrong, but it is confusing.

However, if we are going to have our own variable here, perhaps it
should use the correct type? candidate.nr is an int, so probably this
should also be an int, and then the gross cast can go away.

-Peff
