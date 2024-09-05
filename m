Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D219AA63
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552373; cv=none; b=l/DIbhvREJi3CT/S8AH1aJd55g3drYhAd6viPSTicyOQlJhtWo+MbFHUn/YFB+vlY6Pe0jrsBYjh1iq8F/aeW1C1u6tIvcIQqVV4MMBSZXuNICuekt5nEMKcw3r/pI0L1VqrEeJuuF8z8MRSS3dPbIk0lMpprvKwI+1mkS4dpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552373; c=relaxed/simple;
	bh=x+LR5vkWky1nP9qFpsjAJu7FGUHD0dqOb52j4vfXkQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zo5G7aED9SairA51OwrsE/u9P00e2BcDfGmSNQ778dmSxcwlG7fs0Cnbc8OwDSok8cAOBZ2+rlIEWF28NoGojbc6PUkeup9WQjqSlh59WolxUbyzB3vAFKle99evwoAifdim6y3Ou+A9Bg4e24oPYffyOksk8FwG+C4mLoc5rhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OWLqykPW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OWLqykPW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADDEF2C2F9;
	Thu,  5 Sep 2024 12:06:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x+LR5vkWky1nP9qFpsjAJu7FGUHD0dqOb52j4v
	fXkQI=; b=OWLqykPWN59oZUdSbhIMNVdgsInJ5VSXBPxA1/0ZohmxRDilueKps/
	BxIdX9Tr6lb+v1T/WWqY6MxyxWmlPTmble/6IFwPluFHNzf8lye7RjZhUBwvOYzG
	MX32cUbf1JdibnhKhWywYmtqL8KtBhSxRDmoiz244E/mQ1bMGzi/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D9A42C2F8;
	Thu,  5 Sep 2024 12:06:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5004C2C2F7;
	Thu,  5 Sep 2024 12:06:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  Derrick
 Stolee <stolee@gmail.com>,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v2] remote: prefetch config
In-Reply-To: <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Thu, 05 Sep 2024 02:52:05
	+0000")
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
	<pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 09:06:03 -0700
Message-ID: <xmqqcyli3x1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C31ED3FC-6BA0-11EF-A304-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 427faf1cfe1..2ca3a3e7d6a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1027,6 +1027,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	if (remote->skip_default_update)
>  		return 0;
>  
> +	if (!remote->prefetch)
> +		return 0;

This, while better than ane xplicit comparison with "== 0", is a bit
tricky in this patch, as it is not saying "if we are told to prefetch,
fall through to the rest of the function".  It is saying "leave if
and only if we are explicitly configured not to prefetch".

It might warrant a comment.

> diff --git a/remote.c b/remote.c
> index 8f3dee13186..05edb3a5f40 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>  	CALLOC_ARRAY(ret, 1);
>  	ret->prune = -1;  /* unspecified */
>  	ret->prune_tags = -1;  /* unspecified */
> +	ret->prefetch = -1;  /* unspecified */

Or, we can just assign "1" (and drop "unspecified" comment).

	ret->prefetch = 1; /* enabled by default */

If I understand it correctly, we want this to default to true...

>  	ret->name = xstrndup(name, len);
>  	refspec_init(&ret->push, REFSPEC_PUSH);
>  	refspec_init(&ret->fetch, REFSPEC_FETCH);
> @@ -456,6 +457,8 @@ static int handle_config(const char *key, const char *value,
>  		remote->prune = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "prunetags"))
>  		remote->prune_tags = git_config_bool(key, value);
> +	else if (!strcmp(subkey, "prefetch"))
> +		remote->prefetch = git_config_bool(key, value);

... with a way for the user to turn it off.

> diff --git a/remote.h b/remote.h
> index b901b56746d..4522fdec354 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -77,6 +77,15 @@ struct remote {
>  
>  	struct refspec fetch;
>  
> +	/*
> +	 * The setting for whether to prefetch from a remote
> +	 * when a fetch is invoked with a prefetch flag.
> +	 *  -1 = unset
> +	 *   0 = don't prefetch from this remote
> +	 *   1 = prefetch from this remote
> +	 */
> +	int prefetch;

And then we can get rid of "-1 unset" from this list.  The comment
can become a lot more brief, as such a change would make it a simple
Boolean flag that everybody would understand immediately.

"prefetch" in the comment is superfluous, as that is the name of the
member anyway.  "from this remote" is superfluous, as that is the
point of having the member in "struct remote" that gives settings
that are per-remote.

	int prefetch; /* is prefetch enabled? */

If we really want to have "unspecified yet" state, what we commonly
do is

 * to initialize the variable to -1 to signal "unspecified yet",
   which you did in this patch.

 * after the configuration reader returns, check if the variable is
   still -1, and then explicitly reset it to the default value,
   which your patch does not do.

 * the code that uses the variable assumes it is either 0 or 1 and
   there shoudl be no "unspecified yet" value.  It indeed is a bug
   that the ariable is left unspecified as it is a sign that the
   code to do previous step was somehow skipped.

But I do not think it is needed in this case; initializing the
.prefetch member to whichever is the default should be sufficient.

Thanks.
