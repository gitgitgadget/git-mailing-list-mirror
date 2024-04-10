Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FE168DC
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771684; cv=none; b=mThgstxAXdRBcl+ubzzQ2LixZtg21oKe1R+Dqq/OkX+dmLEhRUC3bv6Wd7jBJDw19MB8n26Hu6ATwZy0Fx230it5ES5ISUGduaCKNRVTzjM2xrLa8pjG6LKeDtEjOCSwx6tYvANroCCSZeM4B9D2YcyM6s7anS4Pv7YJCr2SNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771684; c=relaxed/simple;
	bh=V9Lkp2M5nobPKT8nsmElFjdJQzcp+ly3CeiR/LNb/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHGnQcCfqfMnOw266pvWY08EGyv+QxqIGbaSj6nHh1b87zUUEs5wKbMqT/6xGyLT8kYw99jy/G5An+RLqP9+VMsdtTc9DWYXgOF8n3NOhhp0Z/JdgpfXiHe1eYZ3fTwZAFPfITgmI7S0w8DP4G/LJnnacyT5iyF/Fjv0CE6mZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15531 invoked by uid 109); 10 Apr 2024 17:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Apr 2024 17:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18243 invoked by uid 111); 10 Apr 2024 17:54:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Apr 2024 13:54:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Apr 2024 13:54:32 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] config: repo_config_get_expiry()
Message-ID: <20240410175432.GA2260545@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <21d8f9dc2b4ddc8ac3f4e8f6b21bfb762fc6ab77.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d8f9dc2b4ddc8ac3f4e8f6b21bfb762fc6ab77.1710972293.git.me@ttaylorr.com>

On Wed, Mar 20, 2024 at 06:05:05PM -0400, Taylor Blau wrote:

> Introduce a `repo_config_get_expiry()` variant in the style of functions
> introduced by 3b256228a6 (config: read config from a repository object,
> 2017-06-22) to read a single value without requiring the git_config()
> callback-style approach.
> 
> This new function is similar to the existing implementation in
> `git_config_get_expiry()`, however it differs in that it fills out a
> `timestamp_t` value through a pointer, instead of merely checking and
> discarding the result (and returning it as a string).

The existing git_config_get_expiry() is a funny interface. That makes me
wonder how its existing callers handle this issue. In most cases we are
just grabbing values for git-gc to pass along as strings to
sub-programs. The only other case resolves via approxidate immediately,
in get_shared_index_expire_date(). Which sort of leaks the string,
though it is technically stuffed away in a global that we never look at.

So I can see the value of an interface which just returns the parsed
timestamp and handles the string itself. Weirdly we even have
git_config_get_expiry_in_days() which works like that, but always scales
the timestamp! So we could implement that in terms of this new function.

But...

> +int repo_config_get_expiry(struct repository *repo,
> +			   const char *key, const char **dest)
> +{
> +	int ret;
> +
> +	git_config_check_init(repo);
> +
> +	ret = repo_config_get_string(repo, key, (char **)dest);
> +	if (ret)
> +		return ret;
> +	if (strcmp(*dest, "now")) {
> +		timestamp_t now = approxidate("now");
> +		if (approxidate(*dest) >= now)
> +			git_die_config(key, _("Invalid %s: '%s'"), key, *dest);
> +	}
> +	return ret;
> +}

...does this actually do what the commit message says? It looks
identical to git_config_get_expiry() except that it takes a repository
parameter?

> This function will gain its first caller in a subsequent commit to parse
> a "threshold" parameter for excluding too-recent commits from
> pseudo-merge groups.

So presumably you call approxidate() there in that new caller. Looks
like that would be patch 10. But I don't see a call to the new function
at all! It just uses git_config_expiry_date(), which does what you need
(it doesn't use the configset, but it looks like you ended up doing a
config callback approach anyway).

So can this patch be dropped?

-Peff
