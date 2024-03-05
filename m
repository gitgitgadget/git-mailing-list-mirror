Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1ADDDA
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658506; cv=none; b=GcfA+ZzUyj0X4mfN+K9oYo3l68jc8oeJLWhyIRxuvvuZcFVEKV7mhxbeqplULUa7dYUf3/BSYRubltb2tkK1Ic6XoX+YN82C/46dvK154SEN4XCSyKPxwHXZoJU9RDZbcg6S4X0j3ZIhNiLQIWNANBIgh37A2YA+ZI+g6IHwEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658506; c=relaxed/simple;
	bh=OsMBwND2M1yE75rlzKbm2iM2ezuk36079H2KpgWjpzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=duWFj75t3eKM7EAbkh9jOhnmA+3EIaPRvare4kwv4hN9PmvjWfw3oGCXi99n+6dSHJ8bNWSHpQ+kxomOQNtpdU86hx7JVqdcO9Z6NluNZWTTZ9UPHGpZCBfQtb+eBOdxA+0iLdx8ASfWolXRzfBu2YS2xkRrGGHP+TnN78ssvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LsYIDv6j; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LsYIDv6j"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6342A1D9D51;
	Tue,  5 Mar 2024 12:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OsMBwND2M1yE75rlzKbm2iM2ezuk36079H2Kpg
	WjpzI=; b=LsYIDv6jvLiSd9w52C3ExDGA+Bg0wj04Rr7PDQMWzBr5ALkrAhpy26
	4Y6OehpFkRzKljXQG2Lt8IK7nzZCyJfRPNzBiijvsdzEFgsdONRzeJl0jjd6Fuf8
	O33via0qI6zOyt7NE7VHZfSBxGfHGSoQOn4tofDTqTfwDXl9OV3uU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ABA91D9D4F;
	Tue,  5 Mar 2024 12:08:23 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB10D1D9D4E;
	Tue,  5 Mar 2024 12:08:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Atneya Nair <atneya@google.com>
Cc: git@vger.kernel.org,  jeffhost@microsoft.com,  me@ttaylorr.com,
  nasamuffin@google.com,
    Tanay Abhra <tanayabh@gmail.com>, Glen Choo <glencbz@gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
In-Reply-To: <20240305012112.1598053-4-atneya@google.com> (Atneya Nair's
	message of "Mon, 4 Mar 2024 17:21:12 -0800")
References: <20240305012112.1598053-2-atneya@google.com>
	<20240305012112.1598053-4-atneya@google.com>
Date: Tue, 05 Mar 2024 09:08:21 -0800
Message-ID: <xmqqwmqg38u2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8F6B72A-DB12-11EE-9242-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Atneya Nair <atneya@google.com> writes:

> To enable parallel update of the read cache for submodules,
> ce_compare_gitlink must be thread safe (for different objects).
>
> Remove string interning in do_config_from (called from
> repo_submodule_init) and add locking around accessing the ref_store_map.

This step does two independent things, even though they may have
dependencies, i.e., for one to be a solution for the problem it is
tackling, the other may have to be there already.  E.g., even after
calls to ce_compare_gitlink() get serialized via a mutex, it may for
some reason not work without giving each kvi.filename its own copy
[*], and if that is the case, you may need to have the "stop
interning" step in a single patch with its own justification, and
then "have mutex around ref_store calls" patch has to come after it.

    Side note: I do not know if that is the case myself.  I didn't
    write this commit, you did.  The above is just a sample to
    illustrate the expected level of depth to explain your thinking
    in the log message.

Or if these two things must happen at the same time, please explain
in the proposed log message why they have to happen in the same
commit.  The two paragraphs you wrote there don't explain that, so I
am assuming that it is not the case.

The use of strintern() comes originally from 3df8fd62 (add line
number and file name info to `config_set`, 2014-08-07) by Tanay
Abhra <tanayabh@gmail.com>, and survived a handful of changes

    809d8680 (config: pass ctx with config files, 2023-06-28)
    a798a56c (config.c: plumb the_reader through callbacks, 2023-03-28)
    c97f3ed2 (config.c: plumb config_source through static fns, 2023-03-28)

all of which were done by Glen Choo <glencbz@gmail.com>, so they may
know how safe the change on the config side would be (I still do
not understand why you'd want to do this in the first place, though,
especially if you are protecting the callsites with mutex).

I also think Emily's (who you already have on the "CC:" line) group
wants to libify the config machinery and suspect they may still be
making changes to the code, so you may want to coordinate with them
to avoid duplicated work and overlapping changes.

> Signed-off-by: Atneya Nair <atneya@google.com>
> ---
>
> Notes:
>     Chasing down thread unsafe code was done using tsan.

Very nice to know.

>  config.c | 3 ++-
>  config.h | 2 +-
>  refs.c   | 9 +++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 3cfeb3d8bd..d7f73d8745 100644
> --- a/config.c
> +++ b/config.c
> @@ -1017,7 +1017,7 @@ static void kvi_from_source(struct config_source *cs,
>  			    enum config_scope scope,
>  			    struct key_value_info *out)
>  {
> -	out->filename = strintern(cs->name);
> +	out->filename = strdup(cs->name);
>  	out->origin_type = cs->origin_type;
>  	out->linenr = cs->linenr;
>  	out->scope = scope;
> @@ -1857,6 +1857,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn,
>  
>  	strbuf_release(&top->value);
>  	strbuf_release(&top->var);
> +	free(kvi.filename);
>  
>  	return ret;
>  }
> diff --git a/config.h b/config.h
> index 5dba984f77..b78f1b6667 100644
> --- a/config.h
> +++ b/config.h
> @@ -118,7 +118,7 @@ struct config_options {
>  
>  /* Config source metadata for a given config key-value pair */
>  struct key_value_info {
> -	const char *filename;
> +	char *filename;
>  	int linenr;
>  	enum config_origin_type origin_type;
>  	enum config_scope scope;
> diff --git a/refs.c b/refs.c
> index c633abf284..cce8a31b22 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2126,6 +2126,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  	size_t len;
>  	struct repository *subrepo;
>  
> +	// TODO is this locking tolerable, and/or can we get any finer
> +	static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
> +
>  	if (!submodule)
>  		return NULL;
>  
> @@ -2139,7 +2142,9 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  		/* We need to strip off one or more trailing slashes */
>  		submodule = to_free = xmemdupz(submodule, len);
>  
> +	pthread_mutex_lock(&lock);
>  	refs = lookup_ref_store_map(&submodule_ref_stores, submodule);
> +	pthread_mutex_unlock(&lock);
>  	if (refs)
>  		goto done;
>  
> @@ -2162,10 +2167,14 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  		free(subrepo);
>  		goto done;
>  	}
> +
> +	pthread_mutex_lock(&lock);
> +	// TODO maybe lock this separately
>  	refs = ref_store_init(subrepo, submodule_sb.buf,
>  			      REF_STORE_READ | REF_STORE_ODB);
>  	register_ref_store_map(&submodule_ref_stores, "submodule",
>  			       refs, submodule);
> +	pthread_mutex_unlock(&lock);
>  
>  done:
>  	strbuf_release(&submodule_sb);
