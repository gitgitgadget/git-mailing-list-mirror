Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC92224EA
	for <git@vger.kernel.org>; Sat, 10 May 2025 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746912280; cv=none; b=L6ILpOUBvE9PZaNhVGBviKG8TZYoeNmud/yKrqWp/L7pSE5C465ZCKRbqRY18xUjuSWHeqxh1Og0XtparqAwcubYLV9sDbGu6voLhDEnpnXVQVFbNm1FMAXiVSzOyNn74xDMs14lDXPXToHoEH9hX2MWO4d+NyU6fb5/K1ynDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746912280; c=relaxed/simple;
	bh=2MO4K/jQTLr9+cPlEuN3mzxPF1R6TMM0AmSLa4CfP3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAKcM/XDfL5At1vuPBBN4i3sMdDvCuG8dOnwa2eUGRuk7m5N4QpLXxtc4TIYTKHJ7VjTJbk4pRAHGY6KuwK8P5HE5OWUzuZI4ARloMpEeCAfxAmhDGUZhwfdUXSB5vj/3a0C2jc9APDfTedle1DcVSTHpaBIUcUm+6DegQjOBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZxPHXg3V; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZxPHXg3V"
Received: (qmail 16460 invoked by uid 109); 10 May 2025 21:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2MO4K/jQTLr9+cPlEuN3mzxPF1R6TMM0AmSLa4CfP3U=; b=ZxPHXg3VJjFbC6nQRDccid4wGNPTRVFV9KBd9KGU3fTVY39Dfvet6uGDFQPckGVh1JUZumJz7+3qYWyK2hlJRFZnqCI42PwjgsyVoLRlRmy4lDsg6OTrLzzSOJt0n4yV6EKeZEg0uY+Py+agymW/X7S0rDoFHnC14cufecA5eRdCdGzDtcBUVNBz+HFRPjX2ydXHw9/gpFtFi4mFbnJylvRN7H/zFYY65H65TOBc2EnkQfRByvTEm3U9m03NwCWThWxJnIR6xSi1vXF5y5yWeXmM7teKaFvCmWUc9akzJJ4dUPKMUkIrVVVBtp8xDMvIHjMIywRKagaz5tuF91YK3A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 May 2025 21:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16415 invoked by uid 111); 10 May 2025 21:24:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 May 2025 17:24:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 10 May 2025 17:24:36 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] builtin/stash: provide a way to export stashes to
 a ref
Message-ID: <20250510212436.GA1139735@coredump.intra.peff.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-4-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508234458.3665894-4-sandals@crustytoothpaste.net>

On Thu, May 08, 2025 at 11:44:56PM +0000, brian m. carlson wrote:

> +static int write_commit_with_parents(struct repository *r,
> +				     struct object_id *out,
> +				     const struct object_id *oid,
> +				     struct commit_list *parents)
> +{
> +	size_t author_len, committer_len;
> +	struct commit *this;
> +	const char *orig_author, *orig_committer;
> +	char *author = NULL, *committer = NULL;
> +	const char *buffer;
> +	unsigned long bufsize;
> +	const char *p;
> +	struct strbuf msg = STRBUF_INIT;
> +	int ret = 0;
> +	struct ident_split id;
> +
> +	this = lookup_commit_reference(r, oid);
> +	buffer = repo_get_commit_buffer(r, this, &bufsize);
> +	orig_author = find_commit_header(buffer, "author", &author_len);
> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
> +	if (split_ident_line(&id, orig_author, author_len) < 0 ||
> +	    split_ident_line(&id, orig_committer, committer_len) < 0) {
> +		ret = error(_("invalid author or committer for %s"), oid_to_hex(oid));
> +		goto out;
> +	}
> +	p = strstr(buffer, "\n\n");
> +
> +	if (!orig_author || !orig_committer || !p) {
> +		ret = error(_("cannot parse commit %s"), oid_to_hex(oid));
> +		goto out;
> +	}

Coverity flagged this as a potential NULL deref. We check that
orig_author and orig_committer aren't NULL here, but we'll already have
looked at them via split_ident_line() above. Probably the error checks
should be reordered?

-Peff
