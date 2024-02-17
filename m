Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21917727
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708148452; cv=none; b=Wmt0esxK/wCY0i4Vv4WPor3VAriDlIdiRceku0bdnOrUZZEureNKTnDW4yl9+xGUEip4TKtJuT6nKEedBWSmeYP9r/PJtlmBCB2q9gGNf9CjCpuS3TMY0Wyh+5YSeamYLRNRyIJW4g56TOEf2L2Y2a+8qxB7ub00dUYmO6UEsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708148452; c=relaxed/simple;
	bh=xM+8EsslJN0qt0nxZackgtNvbVmsp4R0uqgCA2YcFnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7lNfC333FdhOyCP5PrcQa0LnekWhnkEc6PEN2WgrJptsofAMpFn9dxSc2bwGnwkXg2G3BFyeLbi4NAJ7xeygYq9yA587rmG3Y02XOY+pnXMAGbS5HWZL4mkzc1fx8MYYCD3b8BrkVKY7MSrGrS7PnmuNeui1IKare+jkvj8msk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2269 invoked by uid 109); 17 Feb 2024 05:40:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 05:40:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20842 invoked by uid 111); 17 Feb 2024 05:40:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Feb 2024 00:40:53 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Feb 2024 00:40:48 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
Message-ID: <20240217054048.GD539459@coredump.intra.peff.net>
References: <xmqq1q9mmtpw.fsf@gitster.g>
 <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g>
 <xmqq1q9cl3xv.fsf@gitster.g>
 <xmqqr0hcglpk.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0hcglpk.fsf_-_@gitster.g>

On Fri, Feb 16, 2024 at 01:09:43PM -0800, Junio C Hamano wrote:

> Modeling after how the `--no-replace-objects` option is made usable
> across subprocess spawning (e.g., cURL based remote helpers are
> spawned as a separate process while running "git fetch"), allow the
> `--no-lazy-fetch` option to be passed across process boundary.
> 
> Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
> variable is ignored, though.  Just use the usual git_env_bool() to
> allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
> to be equivalents.

Nice. I wondered if we would need to hide fetch_if_missing behind a
function that lazy-evaluates the environment variable, but it looks like
setup_git_env() is central enough to cover us here.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2f1cb3ef4e..be2829003d 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -183,6 +183,8 @@ If you just want to run git as if it was started in `<path>` then use
>  	Do not fetch missing objects from the promisor remote on
>  	demand.  Useful together with `git cat-file -e <object>` to
>  	see if the object is locally available.
> +	This is equivalent to setting the `GIT_NO_LAZY_FETCH`
> +	environment variable to `1`.

As with the other patch, I'd suggest adding an entry to the list of
environment variables later in the manpage.

> --- a/environment.h
> +++ b/environment.h
> @@ -35,6 +35,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
>  #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
>  #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
>  #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
> +#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
>  #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
>  #define GITATTRIBUTES_FILE ".gitattributes"
>  #define INFOATTRIBUTES_FILE "info/attributes"

A small nit, but maybe worth keeping the two replace-related variables
next to each other, rather than sticking the new one in the middle?

> diff --git a/git.c b/git.c
> index 28e8bf7497..d11d4dc77b 100644
> --- a/git.c
> +++ b/git.c
> @@ -189,6 +189,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
>  			fetch_if_missing = 0;
> +			setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
> +			if (envchanged)
> +				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>  			disable_replace_refs();
>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);

I _suspect_ this makes the fetch_if_missing call redundant, since we
should be parsing these before doing any repo setup that would trigger
the code that reads the environment variable.

This should probably also be xsetenv(), though as you can see in the
context we are not very consistent about using it. :) But certainly if
we failed to set it I would prefer to see an error rather than
accidentally lazy-fetching.

> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 5b7bee888d..59629cea1f 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -665,6 +665,15 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
>  	git -C partial.git rev-list --objects --missing=print HEAD >out &&
>  	grep "[?]$FILE_HASH" out &&
>  
> +	# The no-lazy-fetch mechanism prevents Git from fetching
> +	test_must_fail env GIT_NO_LAZY_FETCH=1 \
> +		git -C partial.git cat-file -e "$FILE_HASH" &&
> +	test_must_fail git --no-lazy-fetch -C partial.git cat-file -e "$FILE_HASH" &&
> +
> +	# Sanity check that the file is still missing
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	grep "[?]$FILE_HASH" out &&

OK, we exercise it by setting the variable directly. A more interesting
one might be:

  git -c alias.foo='!git cat-file' --no-lazy-fetch ...

which should fail without the patch.

I also wondered why we were testing the direct-builtin invocation here,
since we are building on top of the original --no-lazy-fetch patch, but
it looks like it is because that patch didn't add any tests at all). I
think they would make more sense as a single patch, but I guess the
original is already in 'next' (though I suppose it is about to be
rewound). I am OK with it either way.

-Peff
