Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FECD19D07B
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384707; cv=none; b=K40gTXa2VW9MGSYp9QfdsPYgN6oFGAFo20o9xyFlW+aLMbXUpVYM83TdPll9FFC+fLH9rVC1sBPX3+q+tP5iYj7SPSu9JvZr2B3xxTY5Qg8aYacplILubLfDcd+kWMns+fYCyF5JsLKgvaMbayKoxNRr3NkVqIkKqrUwhVztxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384707; c=relaxed/simple;
	bh=ea0GXNZlS8FpfhvGBUBdgcEmzD1/RuOcM3ynmpO91Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tu1dRIMr1YMNNZ2Sspi17OOx18I9uglPRtSFhzrYkrBHtm0uhCoLGoM8e/DPDG9n31gSkoxbdufs6542DYqW5htxJi3RVu4wokd9JnHO3lFxM7DOGTQrehaHQTqclKtYd/bsknVHB2pgqmX1sOHrXM20PC6n1xrm3JtBaC/JdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LHKN8irl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHKN8irl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ED7E239E2;
	Fri, 14 Jun 2024 13:05:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ea0GXNZlS8FpfhvGBUBdgcEmzD1/RuOcM3ynmp
	O91Do=; b=LHKN8irl3+vxDBxG+3abI3SHkSMfwwOVlEb7lFSlaW1ykX6VGjaVfq
	MKk5HeuGO9Qk3ZeJpDu73/ZpHZQi6YLjGLfOZJ/4p4W1eHuW4vglkzbuZL6oMG3M
	O82aIskJ3oD7IGGjTVylega9P+ZLCu8h7iAUUQo23LNY3+XVzsTlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB552239E0;
	Fri, 14 Jun 2024 13:05:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06D55239DF;
	Fri, 14 Jun 2024 13:05:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mathew George <mathewegeorge@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 02/11] remote: refactor alias_url() memory ownership
In-Reply-To: <20240614102616.GB222445@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Jun 2024 06:26:16 -0400")
References: <20240614102439.GA222287@coredump.intra.peff.net>
	<20240614102616.GB222445@coredump.intra.peff.net>
Date: Fri, 14 Jun 2024 10:05:01 -0700
Message-ID: <xmqqtthvfoaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3DA1E7BC-2A70-11EF-B48B-965B910A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> ... So instead of
> returning the original string, return NULL, forcing callers to decide
> what to do with it explicitly. We can then build further cleanups on top
> of that.

OK.

> @@ -76,15 +76,16 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
>  static void add_pushurl_alias(struct remote_state *remote_state,
>  			      struct remote *remote, const char *url)
>  {
> -	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
> -	if (pushurl != url)
> -		add_pushurl(remote, pushurl);
> +	char *alias = alias_url(url, &remote_state->rewrites_push);
> +	if (alias)
> +		add_pushurl(remote, alias);

OK, that's an obviously equivalent rewrite.

>  static void add_url_alias(struct remote_state *remote_state,
>  			  struct remote *remote, const char *url)
>  {
> -	add_url(remote, alias_url(url, &remote_state->rewrites));
> +	char *alias = alias_url(url, &remote_state->rewrites);
> +	add_url(remote, alias ? alias : url);
>  	add_pushurl_alias(remote_state, remote, url);
>  }

This is also an obviously equivalent rewrite.

Looking at how remote_clear() deals with the .url[] and .pushurl[]
elements, add_url() makes the remote structure take ownership, which
is perfectly fine when we got a non-NULL alias back (i.e. it is a
new piece of string allocated just for us).  Depending on who owns
the incoming url parameter, we might need strdup(url) here, but
since we haven't heard crashes due to freeing remote->url[] elements
that should not be freed, presumably url is a piece memory the
caller is giving us the ownership?  In any case, I imagine that
untangling that ownership mess is left to the later steps of the
series.

> @@ -492,19 +493,22 @@ static void alias_all_urls(struct remote_state *remote_state)
>  		if (!remote_state->remotes[i])
>  			continue;
>  		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
> -			remote_state->remotes[i]->pushurl[j] =
> -				alias_url(remote_state->remotes[i]->pushurl[j],
> -					  &remote_state->rewrites);
> +			char *alias = alias_url(remote_state->remotes[i]->pushurl[j],
> +						&remote_state->rewrites);
> +			if (alias)
> +				remote_state->remotes[i]->pushurl[j] = alias;

Does this change behaviour?  No.  We used to (1) grab the current
value, (2) replace it if it is an alias, or (3) otherwise replace it
with itself.  We just do not do the obvious noop anymore.

The story is the same with the last remaing hunk of this patch.
Looking good.

Thanks.

>  		}
>  		add_pushurl_aliases = remote_state->remotes[i]->pushurl_nr == 0;
>  		for (j = 0; j < remote_state->remotes[i]->url_nr; j++) {
> +			char *alias;
>  			if (add_pushurl_aliases)
>  				add_pushurl_alias(
>  					remote_state, remote_state->remotes[i],
>  					remote_state->remotes[i]->url[j]);
> -			remote_state->remotes[i]->url[j] =
> -				alias_url(remote_state->remotes[i]->url[j],
> +			alias = alias_url(remote_state->remotes[i]->url[j],
>  					  &remote_state->rewrites);
> +			if (alias)
> +				remote_state->remotes[i]->url[j] = alias;
>  		}
>  	}
>  }
