Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FB54764
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305637; cv=none; b=Gud/S7DlsVKaGjemkOg/Hh4S14HDr3v13niNLvkeofNk24uqByUKI2oU/OlmlZTFfpvT0bkWP7uvfDXG6+vGb9B+ih4yBM8B4fFjksjI4rCW9NG8CL8Fbv1sGcdOKSY0HN3M9oLZcEH9hQC/LkxZt6aZF/v/dItNg0eNMRzJfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305637; c=relaxed/simple;
	bh=U3QyXkvyLAKozTau86vHu/jswIJzNd5n3SADXQANpoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krx0LsxTJQoHbuBCIP5czBOghJoC3bVTAxR77El1Wna0OzoD1c7Au06VA1gY2ivLqX/AkyqB2dVSlGKeSVBkGVUY1oAIOZpe1C/m7V86Q/yTGqfv3bMG6W60b+nOa+oJFtTcJuOL/TvJud4wku0JuxqtmjuTfM9Yhci7iTz2rD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fvgbC6YC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fvgbC6YC"
Received: (qmail 19001 invoked by uid 109); 19 Jun 2025 04:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=U3QyXkvyLAKozTau86vHu/jswIJzNd5n3SADXQANpoI=; b=fvgbC6YCarv+UCd8i4c/Jfrv0gAy3BNh2l6Q5kMARPGx42yMbUXwQ2yY3QYPb4O6y9+AAxpHl+g8MM6VAQ7KfDRY6YXmcWtUdagUt0WYKTBDyFwNX80odaABNzExmyISMHOthxrDp8mDXUI76ZIsLOYHT4Aha47CjlZK5OvXmcCR832P1LE3SpsFs23MUAD7udx0iMCi6V571TCgVvu0fOl1+sYK+YB4kwSnXi3U+/WCkyhFYPaiTXOh3lmw3916N9P4Q+UU988Z2AVxYG0DPpX1kY193yyd6fUQM4TTD/a7NWL6kpQrLvTUeoooiy7YaarFfdHuoQ1M2tV1vS4f7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jun 2025 04:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10250 invoked by uid 111); 19 Jun 2025 04:00:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Jun 2025 00:00:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Jun 2025 00:00:33 -0400
From: Jeff King <peff@peff.net>
To: Phil Hord <phil.hord@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
Message-ID: <20250619040033.GB1801319@coredump.intra.peff.net>
References: <20250618211024.2332525-1-phil.hord@gmail.com>
 <20250618211024.2332525-2-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618211024.2332525-2-phil.hord@gmail.com>

On Wed, Jun 18, 2025 at 02:08:39PM -0700, Phil Hord wrote:

> From: Phil Hord <phil.hord@gmail.com>
> 
> When pruning during `git fetch` we check each pruned ref against the
> ref_store one at a time to decide whether to report it as dangling.
> This causes every local ref to be scanned for each ref being pruned.
> 
> If there are N refs in the repo and M refs being pruned, this code is
> O(M*N). However, `git remote prune` uses a very similar function that
> is only O(N*log(M)).
> 
> Remove the wasteful ref scanning for each pruned ref and use the faster
> version already available in refs_warn_dangling_symrefs.
> 
> In a repo with 126,000 refs, where I was pruning 28,000 refs, this
> code made about 3.6 billion calls to strcmp and consumed 410 seconds
> of CPU. (Invariably in that time, my remote would timeout and the
> fetch would fail anyway.)
> 
> After this change, the same operation completes in under 4 seconds.

Very nice. I left some thoughts on the ordering question elsewhere, but
I'd be OK with this approach, too.

> I considered further optimizing this function to be O(N), but this
> requires ref_store iterators to be sorted, too. I found some suggestions
> that this is always the case, but I'm not certain it is.
> 
> The current speedup is enough for our needs at the moment.

I think we do guarantee the output order, and for-each-ref at least
takes advantage of this since 2e7c6d2f41 (ref-filter: format iteratively
with lexicographic refname sorting, 2024-10-21).

That said, I wouldn't be surprised if there are other n-log-n bits of
the code, and we usually consider that "good enough". So stopping here
is probably fine.

> +	struct string_list refnames = STRING_LIST_INIT_NODUP;
>  	const char *dangling_msg = dry_run
>  		? _("   (%s will become dangling)")
>  		: _("   (%s has become dangling)");
>  
> +	for (ref = stale_refs; ref; ref = ref->next)
> +		string_list_append(&refnames, ref->name);

I was going to suggest using strset over string_list, since I think we
prefer that these days for a simple set-inclusion check. But...

> +		string_list_sort(&refnames);
> +		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
> +					   stderr, dangling_msg, &refnames);

...we are ultimately relying on refs_warn_dangling_symrefs(), so we'd
have to update its interface. And we also reuse the list (here, after
your patch, but already in remote.c) to pass to refs_delete_refs(). So
probably not worth it.

-Peff
