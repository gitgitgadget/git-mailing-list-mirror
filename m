Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2D146D45
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384695; cv=none; b=d6ApLjyP4iBXfsT2SJsuG5JR7JecryHmiw3R+5q5HDkD0HRftgxOnU4FDuZpoC3mUFNqbk+kq4vJUYIV5PRq19gXYTFQTsAUjVGqPFoXkRceYEzKGlvdtWsgIg7Tg5TPOYCzBd1wJ/3pM6z+zwQvvNPksfvqmPym4wJjhoHdoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384695; c=relaxed/simple;
	bh=jRsInCGsN6smVrrFc2pDZE/VIUrJjmwCHndzcSQrhv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcUy45hOjfM/vLOwoV3ivgHIzgY1YDREUGhiyeSRlq6ldDGrkaFhzJGc0GdzBRJmshP3v2DQGzRLwpkriI33QrN5pmTMHFgZYRBZ+l0poZdN2YB4vz92tCprLl1sUf7KJsr5bJaBubWZdRMbhEQKo39lP0n/tdNa5lo4/2HrKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SCIUbrjq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SCIUbrjq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C807239DC;
	Fri, 14 Jun 2024 13:04:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jRsInCGsN6smVrrFc2pDZE/VIUrJjmwCHndzcS
	Qrhv0=; b=SCIUbrjq9Ook0x5xcHgl48bRUYO374dFCyDgOPBQinooOt0MYkGo5/
	QGksi8ztPQCm5btwCfl2rUXntSVDRQr6nytNBPL23amWi1YOZ5kuUb/n/qUDikNu
	WSWFICxqHZ+hBe2AYo83NNSYcKr/sinE4xudSR/GyEnPH+HSj5few=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 737B3239DB;
	Fri, 14 Jun 2024 13:04:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9608239DA;
	Fri, 14 Jun 2024 13:04:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mathew George <mathewegeorge@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 03/11] remote: transfer ownership of memory in
 add_url(), etc
In-Reply-To: <20240614102722.GC222445@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Jun 2024 06:27:22 -0400")
References: <20240614102439.GA222287@coredump.intra.peff.net>
	<20240614102722.GC222445@coredump.intra.peff.net>
Date: Fri, 14 Jun 2024 10:04:50 -0700
Message-ID: <xmqq1q4zh2vh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36FDA22A-2A70-11EF-9B12-965B910A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> diff --git a/remote.c b/remote.c
> index fd9d58f820..f7c846865f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -64,13 +64,13 @@ static char *alias_url(const char *url, struct rewrites *r)
>  static void add_url(struct remote *remote, const char *url)
>  {
>  	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
> -	remote->url[remote->url_nr++] = url;
> +	remote->url[remote->url_nr++] = xstrdup(url);
>  }
>  
>  static void add_pushurl(struct remote *remote, const char *pushurl)
>  {
>  	ALLOC_GROW(remote->pushurl, remote->pushurl_nr + 1, remote->pushurl_alloc);
> -	remote->pushurl[remote->pushurl_nr++] = pushurl;
> +	remote->pushurl[remote->pushurl_nr++] = xstrdup(pushurl);
>  }

OK.  This makes it easier to reason about why these elements are
freed in remote_clear().

>  static void add_pushurl_alias(struct remote_state *remote_state,
> @@ -79,6 +79,7 @@ static void add_pushurl_alias(struct remote_state *remote_state,
>  	char *alias = alias_url(url, &remote_state->rewrites_push);
>  	if (alias)
>  		add_pushurl(remote, alias);
> +	free(alias);
>  }

OK.  I wondered if we want to strdup(url) in my review on the
previous step, but now we are making the add_url() responsible
for making a copy, we instead do the opposite, i.e. free alias
that was allocated for us because we no longer need it.

>  static void add_url_alias(struct remote_state *remote_state,
> @@ -87,6 +88,7 @@ static void add_url_alias(struct remote_state *remote_state,
>  	char *alias = alias_url(url, &remote_state->rewrites);
>  	add_url(remote, alias ? alias : url);
>  	add_pushurl_alias(remote_state, remote, url);
> +	free(alias);
>  }

Likewise.

> @@ -336,7 +338,7 @@ static void read_branches_file(struct remote_state *remote_state,
>  	else
>  		frag = to_free = repo_default_branch_name(the_repository, 0);
>  
> -	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
> +	add_url_alias(remote_state, remote, buf.buf);

It is curious that you delay ...

> @@ -347,6 +349,7 @@ static void read_branches_file(struct remote_state *remote_state,
>  	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
>  	remote->fetch_tags = 1; /* always auto-follow */
>  
> +	strbuf_release(&buf);
>  	free(to_free);
>  }

... strbuf_release() of the buf to the very end of the function.  

In the original, buf became invalid by doing strbuf_detach(), so we
could do strbuf_release() immediately after add_url_alias() returns
to us if we wanted to.

> @@ -431,15 +434,13 @@ static int handle_config(const char *key, const char *value,
>  	else if (!strcmp(subkey, "prunetags"))
>  		remote->prune_tags = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "url")) {
> -		char *v;
> -		if (git_config_string(&v, key, value))
> -			return -1;
> -		add_url(remote, v);
> +		if (!value)
> +			return config_error_nonbool(key);
> +		add_url(remote, value);

OK.  config_string() does (1) check for "I exist hence I am true"
boolean, and (2) give us a duplicate of the value.  We do not want
the latter, so we do the former ourselves here.  The same story
repeats for pushurl below (ellided).

> @@ -495,8 +496,10 @@ static void alias_all_urls(struct remote_state *remote_state)
>  		for (j = 0; j < remote_state->remotes[i]->pushurl_nr; j++) {
>  			char *alias = alias_url(remote_state->remotes[i]->pushurl[j],
>  						&remote_state->rewrites);
> -			if (alias)
> +			if (alias) {
> +				free((char *)remote_state->remotes[i]->pushurl[j]);
>  				remote_state->remotes[i]->pushurl[j] = alias;
> +			}
>  		}

OK, this is the replacement codepath we saw earlier.  Makes sense
for this and the .url[] side on the other hunk (it is curious that
this has .pushurl[] before .url[], which is the opposite order of
how everybody else deals with them, as pushurl came later).

Thanks.
