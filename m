Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267B177990
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840406; cv=none; b=LkiZo95wOsF9gfYcprqYgKQkdhZEFX7X92TJ29y2glLGMu2JqMdtUjRERLtFsISz0WCWR18wGuMvBz6ARM/8cqIM7TICnVDDxvTDWnfYELZoMtW3FQy3FCjOpCfCuVZR0SU6ZUYt3dJCAa6uljwnG91pqIfBgrUFyqV45QBZPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840406; c=relaxed/simple;
	bh=t+DcxX5fyA73S7XVwKTtbwKne95rZz1b+Qa36PxNcSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvFgpD/3tNHyPvicyKGvxQlEl5WZ8eORxMpg0GFcviPU8/R/sw8+5qsmMB42xb2bCoc2XAUnqAoB2a4nH64tqBjKQVA/Dl5bIXpkq6N/irHRGI1LEVULMEO1Wpt8mHz+EjVlV6lfyxU3ACvFB/cgUQL3/GHw1WHyMyLblKzkdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7788 invoked by uid 109); 8 Jun 2024 09:53:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 09:53:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29086 invoked by uid 111); 8 Jun 2024 09:53:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 05:53:20 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 05:53:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
Message-ID: <20240608095322.GB2659849@coredump.intra.peff.net>
References: <cover.1717712358.git.me@ttaylorr.com>
 <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>

On Thu, Jun 06, 2024 at 06:19:25PM -0400, Taylor Blau wrote:

> @@ -2035,24 +2035,23 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  					       LOCK_DIE_ON_ERROR, 0444);
>  		free(lock_name);
>  
> -		fd = git_mkstemp_mode(ctx->graph_name, 0444);
> -		if (fd < 0) {
> +		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
> +		if (!graph_layer) {
>  			error(_("unable to create temporary graph layer"));
>  			return -1;
>  		}
>  
> -		if (adjust_shared_perm(ctx->graph_name)) {
> +		if (adjust_shared_perm(get_tempfile_path(graph_layer))) {
>  			error(_("unable to adjust shared permissions for '%s'"),
> -			      ctx->graph_name);
> +			      get_tempfile_path(graph_layer));
>  			return -1;
>  		}

Most errors will cause us to die(), but this "return" and the one that
Junio noted later (when renaming the base graph file fails) mean we'll
return with the tempfile still active. We'll clean it up when the
program exits, but if there were a long-running program that
called write_commit_graph_file(), that tempfile might hang around longer
than necessary.

But that is the same strategy that the existing code uses for the lock
we use for the chain filename! And it is much worse there, because now
it is not just a tempfile hanging around, but we're blocking anybody
else from taking the lock.

So I think it would be OK to punt on this for now. Your patch is not
making the situation worse, and it's all a problem for a hypothetical
libification of this function.

> +test_expect_success 'temporary graph layer is discarded upon failure' '
> +	git init layer-discard &&
> +	(
> +		cd layer-discard &&
> +
> +		test_commit A &&
> +		test_commit B &&
> +
> +		# Intentionally remove commit "A" from the object store
> +		# so that the commit-graph machinery fails to parse the
> +		# parents of "B".
> +		#
> +		# This takes place after the commit-graph machinery has
> +		# initialized a new temporary file to store the contents
> +		# of the new graph layer, so will allow us to ensure
> +		# that the temporary file is discarded upon failure.
> +		rm $objdir/$(test_oid_to_path $(git rev-parse HEAD^)) &&
> +
> +		test_must_fail git commit-graph write --reachable --split &&
> +		test_dir_is_empty $graphdir
> +	)
> +'

I'm glad you were able to come up with a case that fails cleanly and
non-racily. The exit code of rev-parse will be lost. I doubt that it
matters in practice, but I wouldn't be surprised if our shell linting
eventually learns to complain about this spot.

Looks like there are a few similar ones in the test suite already, from
t5329. I'd be content to leave it for now and deal with it later if
somebody really wants to go on a crusade against lost exit codes.

-Peff
