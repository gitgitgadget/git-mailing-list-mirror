Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541315C132
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057725; cv=none; b=QlCdFPyfiC4oppdB+4HUCtz08ZJ2f688cCGBEwQMfzvIPbeyRqhWWgKO+rw1DHl+HApnmQUM75s1T382XNOB37TBOtKb0B+ODshoVbHY2MN2Qk6Edyt2uAlopJRyZ7hs6+UG+5rFDmJ1g3YiInmesNxZP4lOSyPtJIOJ1jgWCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057725; c=relaxed/simple;
	bh=fANbUd5h8JAagBdmEaCbvmOVb8TP2hPnPrLsIR8gqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMHnbXX6DuDcqVKSntB6VbtXHlptEMcthzIkIjoLrTa8JlGCQ4C1WI2QKjrY1DllCABSt/VaMrGnoZ/hlEsXI88E0RFNK4pkPd8GDuI6TFoYsJv5eZ84Tkzdl/+lwkkCsSIKvBBTxEgYNnJanYZ9HIdEA98LG8e+RQh0CJPCKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8779 invoked by uid 109); 19 Aug 2024 08:55:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Aug 2024 08:55:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17586 invoked by uid 111); 19 Aug 2024 08:55:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Aug 2024 04:55:27 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Aug 2024 04:55:22 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <20240819085522.GD2955268@coredump.intra.peff.net>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>

On Mon, Aug 19, 2024 at 09:48:05AM +0200, Patrick Steinhardt wrote:

> The "loose-objects" maintenance tasks executes git-pack-objects(1) to
> pack all loose objects into a new packfile. This command ends up
> printing the hash of the packfile to stdout though, which clutters the
> output of `git maintenance run`.
> 
> Fix this issue by disabling stdout of the child process.

Ah, I wondered where that output was coming from.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 13bc0572a3..be75efa17a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1159,6 +1159,12 @@ static int pack_loose(struct maintenance_run_opts *opts)
>  
>  	pack_proc.in = -1;
>  
> +	/*
> +	 * git-pack-objects(1) ends up writing the pack hash to stdout, which
> +	 * we do not care for.
> +	 */
> +	pack_proc.out = -1;
> +
>  	if (start_command(&pack_proc)) {
>  		error(_("failed to start 'git pack-objects' process"));
>  		return 1;

I have not paid much attention to the "maintenance" stuff. It is a
little weird to me that it is not building on "git repack", which
already handles this, but perhaps there are reasons. Anyway, totally
unrelated to your patch (which looks good to me).

> +++ b/t/t7900-maintenance.sh
> @@ -978,4 +978,20 @@ test_expect_success '--detach causes maintenance to run in background' '
>  	)
>  '
>  
> +test_expect_success 'repacking loose objects is quiet' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit something &&
> +		git config set maintenance.gc.enabled false &&
> +		git config set maintenance.loose-objects.enabled true &&
> +		git config set maintenance.loose-objects.auto 1 &&
> +
> +		git maintenance run --quiet >out 2>&1 &&
> +		test_must_be_empty out
> +	)
> +'

I wondered if you needed --no-detach here to avoid a race, but I guess
as a non-auto run, it would never background?

-Peff
