Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4302187844
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099144; cv=none; b=WhrcEB5kodSKL7yQyhB8isvlltvg+4U0gIFrtno6HVHdnEMUQvcQZbqoGGw6bXKimcO5FidVphC8YamVJfCxvsgRpDhMKw9pv63Ks7NSK6dp9tmCv8kmujq6KF8R1EGmVIJH5bCFYikthATnWTVvin7vTuXJoAJPknK1w4NVb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099144; c=relaxed/simple;
	bh=m77GI+G57+BCtXEwCzO/6apqFmoJIl9uaIFM0M9exGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4q4Gasw9soF30OqJHJCQ6eLVt+Kl0hMRSAxAhhLz4J+oAAIvMH+ngn2/sR6kEtNI5eVorO+I0cd2ZNZYVBCbquRgyGFPsUKz2F7Rk7tfnuHgaTkR5ux2EErBPn/1K5ZS+G3lYr0wRjcRwdzN3mFjbirPYQ9C8ICVCrYC9HwKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kFhXL/pC; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kFhXL/pC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1732099138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YOas/1h6eo7qtCGRL6eo4F9JxJO7POhH5VtYV2q2zMM=;
	b=kFhXL/pC0NfLzA09pAAjwHv2cjqMEIGvIXsEqb9E220ciVSNSq4uGD7bbHeZ05JzeEWowq
	ftT2xRUH8pMSTeda+lyB2pfppyoBrBwe+AuYWU33SVDEeY6tjOdSjt76f6Av8oCgT0eypL
	USPXAvoAZSBtg5gGc/pQdiwZ7Za/4rs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 11/27] git: refactor builtin handling to use a
 `struct strvec`
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-11-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-11-6154bf91f0b0@pks.im>
Date: Wed, 20 Nov 2024 11:38:47 +0100
Message-ID: <8734jmtcjs.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Similar as with the preceding commit, `handle_builtin()` does not
> properly track lifetimes of the `argv` array and its strings. As it may
> end up modifying the array this can lead to memory leaks in case it
> contains allocated strings.
>
> Refactor the function to use a `struct strvec` instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git.c                  | 66 ++++++++++++++++++++++++--------------------------
>  t/t0211-trace2-perf.sh |  2 +-
>  2 files changed, 32 insertions(+), 36 deletions(-)
>
> diff --git a/git.c b/git.c
> index 88356afe5fb568ccc147f055e3ab253c53a1befa..159dd45b08204c4a89d1dc4ab6990978e2454eb6 100644
> --- a/git.c
> +++ b/git.c
> @@ -696,63 +696,57 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
>  }
>  
>  #ifdef STRIP_EXTENSION
> -static void strip_extension(const char **argv)
> +static void strip_extension(struct strvec *args)
>  {
>  	size_t len;
>  
> -	if (strip_suffix(argv[0], STRIP_EXTENSION, &len))
> -		argv[0] = xmemdupz(argv[0], len);
> +	if (strip_suffix(args->v[0], STRIP_EXTENSION, &len)) {
> +		char *stripped = xmemdupz(args->v[0], len);
> +		strvec_replace(args, 0, stripped);
> +		free(stripped);
> +	}
>  }
>  #else
>  #define strip_extension(cmd)
>  #endif
>  
> -static void handle_builtin(int argc, const char **argv)
> +static void handle_builtin(struct strvec *args)
>  {
> -	struct strvec args = STRVEC_INIT;
> -	const char **argv_copy = NULL;
>  	const char *cmd;
>  	struct cmd_struct *builtin;
>  
> -	strip_extension(argv);
> -	cmd = argv[0];
> +	strip_extension(args);
> +	cmd = args->v[0];
>  
>  	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
> -	if (argc > 1 && !strcmp(argv[1], "--help")) {
> -		int i;
> -
> -		argv[1] = argv[0];
> -		argv[0] = cmd = "help";
> -
> -		for (i = 0; i < argc; i++) {
> -			strvec_push(&args, argv[i]);
> -			if (!i)
> -				strvec_push(&args, "--exclude-guides");
> -		}
> +	if (args->nr > 1 && !strcmp(args->v[1], "--help")) {
> +		const char *exclude_guides_arg[] = { "--exclude-guides" };
> +
> +		strvec_replace(args, 1, args->v[0]);
> +		strvec_replace(args, 0, "help");
> +		cmd = "help";
> +		strvec_splice(args, 2, 0, exclude_guides_arg,
> +			      ARRAY_SIZE(exclude_guides_arg));
> +	}
>  
> -		argc++;
> +	builtin = get_builtin(cmd);
> +	if (builtin) {
> +		const char **argv_copy = NULL;
> +		int ret;
>  
>  		/*
>  		 * `run_builtin()` will modify the argv array, so we need to
>  		 * create a shallow copy such that we can free all of its
>  		 * strings.
>  		 */
> -		CALLOC_ARRAY(argv_copy, argc + 1);
> -		COPY_ARRAY(argv_copy, args.v, argc);
> +		if (args->nr)
> +			DUP_ARRAY(argv_copy, args->v, args->nr + 1);
>  
> -		argv = argv_copy;
> -	}
> -
> -	builtin = get_builtin(cmd);
> -	if (builtin) {
> -		int ret = run_builtin(builtin, argc, argv, the_repository);
> -		strvec_clear(&args);
> +		ret = run_builtin(builtin, args->nr, argv_copy, the_repository);
> +		strvec_clear(args);
>  		free(argv_copy);
>  		exit(ret);
>  	}
> -
> -	strvec_clear(&args);
> -	free(argv_copy);
>  }

Just want to give you a little shout out how you've reorganized the code
and it now makes a lot more sense how `argv_copy` is used by putting
it inside the `if (builtin)` code block.

-- 
Toon
