Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F298174E
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037650; cv=none; b=C75tSwEqJl4a5EF/1Zb02cHprUyL2giroMGpvr3p1qVQW5oA6bIq3MyET4DeWDFDSJLWvbFHD5emFhWRWAB6/6laKs0rc25t+9cU4ZqJYcEQkTOvpjiWllnvJHBNCH3/zYwWDw1/s7rg5rTydPDOMs9HpMq9KMY8y/m++5O1TRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037650; c=relaxed/simple;
	bh=dPhCRv1UL3agYVhriFGqxz7hYxkiwB/DXv2IFIeMsP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sep5qcjgLij2ZBVbswMyrxxduC0pFtfoJNXL19RZOTGkyN03kA5qMtJhekN0wPclgqx03MqRaOxHR17iIu7HkmMzsTBPDkLedPtf+HWyauXGQXyWfsuz9hil3HN+YxlnS3Lbi3tQtiOFeE3SQ60sgVi4lmro4N6GTBswFRoMUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9682 invoked by uid 109); 11 Sep 2024 06:54:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 06:54:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6091 invoked by uid 111); 11 Sep 2024 06:54:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 02:54:07 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 02:54:06 -0400
From: Jeff King <peff@peff.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, cc@mail.ferdinandy.com,
	/tmp/FUboFpyPuH/0001-fetch-set-head-with-set-head-option.patch@mail.ferdinandy.com
Subject: Re: [RFC PATCH 1/2] fetch: set-head with --set-head option
Message-ID: <20240911065406.GC1538586@coredump.intra.peff.net>
References: <20240910203129.2251090-1-bence@ferdinandy.com>
 <20240910203129.2251090-2-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910203129.2251090-2-bence@ferdinandy.com>

On Tue, Sep 10, 2024 at 10:24:58PM +0200, Bence Ferdinandy wrote:

> When cloning a repository refs/remotes/origin/HEAD is set automatically.
> In contrast, when using init, remote add and fetch to set a remote, one
> needs to call remote set-head --auto to achieve the same result.

Yes, I think this is a good goal, but...

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2b5aee5bf..6392314c6a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1961,8 +1961,19 @@ static int fetch_finished(int result, struct strbuf *out,
>  	return 0;
>  }
>  
> -static int fetch_multiple(struct string_list *list, int max_children,
> -			  const struct fetch_config *config)
> +static int run_set_head(const char *name)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	strvec_push(&cmd.args, "remote");
> +	strvec_push(&cmd.args, "set-head");
> +	strvec_push(&cmd.args, "--auto");
> +	strvec_push(&cmd.args, name);
> +	cmd.git_cmd = 1;
> +	return run_command(&cmd);
> +}

...this is just calling "git remote" to do the real work. Which means
that git-remote is going to make its own separate connection to the
server (so slow, but may also require the user to reauthenticate, etc).

I think the intent of your patch 2 is that we'd only invoke this when we
saw a change, which mitigates the impact, but it still seems somewhat
hacky to me. We already have all of the information we need to do the
update inside fetch itself.

-Peff
