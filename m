Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BB3B5E19
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026211; cv=none; b=fb46SVh7IQ17duTO5Mnxz25Ky7YbCysO5RN3uYyHwlAAqw9jbtsMjQFKeJBHNSst6fkKnbVkZmsHeqEGe1FFK0YY291j0rinfLkhVc/fWbTaEyUVDpCJ0lZ79SsRw9z8QQ92FiT4lqCP6Wbl80U5//AOn7oAdaoSjtZbGql5LdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026211; c=relaxed/simple;
	bh=2tqDy2THMmU18ykTgQQ4qXgL/JvYUSIjJEZtoUDDSi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fs2JPcSefWUEWr2RcAII0f8ynGd9CTIBRVuQau5Li1ZP6tTcg6/KTza7xFnVQlQHDlWlS8Tq3172mtd7yxActjm1ofIAb6sXDZ8VtG7vz7/InwPou26cMrBIdAdiwYv6Rnev/KmL3uK/7LVySxF7vwdokUi5Ew8+/FQco/q69kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=4dc2Ru4H; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="4dc2Ru4H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786026205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qm75Zsyb9JxActJDapd7aCsTipQYEQG5AQ2YXbSm1Rk=;
	b=4dc2Ru4HujDCHtvfTQZUI7XLOGRqE/GXD/5DHTCVPe2cHWggOtM/JO3NPT6vFs2arJB5Zy
	9DHzYDw9GjljRbgiUimQuyawNl07r8EMwSaHqrbP0b9CtFaYyihtG6LCrTxvoB4BT0QI7M
	VAoa47DxgTJHOo+zbrbHkZHNLhlhZMA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 4/6] setup: defer object database creation
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-4-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
 <20260806-pks-odb-create-on-disk-v4-4-ba8b4fdd2e3c@pks.im>
Date: Thu, 06 Aug 2026 16:23:17 +0200
Message-ID: <87tsp749be.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we'll make the creation of the on-disk data
> structures of an object database pluggable. This will lead to an
> in-between state where we have already configured the repository's
> object database, but it's not usable yet until we eventually call
> `create_object_directory()`.
>
> Lift the call to `odb_new()` out of `apply_repository_format()` so that
> callers have more wiggle room with when exactly they call it, and adapt
> them accordingly. The only exception is `init_db()`, where we now defer
> creating the object database until we call `create_object_database()`.
>
> With this change, initializing and creating the object database on disk
> is now neatly encapsulated in a single function, which will make it
> easier for a subsequent commit to move creation of the on-disk data
> structures into the `struct odb_source` backends.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  repository.c |  1 +
>  setup.c      | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/repository.c b/repository.c
> index 6d633002b4..5ec264e607 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -294,6 +294,7 @@ int repo_init(struct repository *repo,
>  		warning("%s", err.buf);
>  		goto error;
>  	}
> +	repo->objects = odb_new(repo, 0);
>  
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);
> diff --git a/setup.c b/setup.c
> index 5dfab3e79e..e39a1646bb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
>  			    enum apply_repository_format_flags flags,
>  			    struct strbuf *err)

I've noticed the docs in setup.h say:

    /*
     * Apply the given repository format to the repo. This initializes extensions
     * and basic data structures required for normal operation. Returns 0 on
     * success, a negative error code when the format is not valid as determined by
     * `verify_repository_format()`.
     */

I'm not sure that's still applicable, now odb_new() isn't called no
more.

>  {
> -	enum odb_new_flags odb_new_flags = 0;
> -
>  	if (verify_repository_format(format, err) < 0)
>  		return -1;
>  
> @@ -1801,10 +1799,6 @@ int apply_repository_format(struct repository *repo,
>  	repo->repository_format_precious_objects =
>  		format->precious_objects;
>  
> -	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
> -		odb_new_flags |= ODB_NEW_HONOR_ENV;
> -	repo->objects = odb_new(repo, odb_new_flags);
> -
>  	return 0;
>  }
>  
> @@ -1888,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
>  		read_and_verify_repository_format(&fmt, ".", NULL);
>  		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  			die("%s", err.buf);
> +		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
>  		startup_info->have_repository = 1;
>  
>  		clear_repository_format(&fmt);
> @@ -2090,6 +2085,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  			if (apply_repository_format(repo, &discovery.format,
>  						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  				die("%s", err.buf);
> +			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
>  
>  			clear_repository_format(&discovery.format);
>  			strbuf_release(&err);
> @@ -2651,11 +2647,13 @@ static int create_default_files(struct repository *repo,
>  	return reinit;
>  }
>  
> -static void create_object_directory(struct repository *repo)
> +static void create_object_database(struct repository *repo)
>  {
>  	struct strbuf path = STRBUF_INIT;
>  	size_t baselen;
>  
> +	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
> +
>  	strbuf_addstr(&path, repo_get_object_directory(repo));
>  	baselen = path.len;
>  
> @@ -2864,9 +2862,9 @@ int init_db(struct repository *repo,
>  	 */
>  	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
>  	repository_format_configure(&repo_fmt, hash, ref_storage_format);
> -	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
> +	if (apply_repository_format(repo, &repo_fmt,
> +				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)

Nit: Not sure why this formatting change was needed. I would have
assumed to have all apply_repository_format() calls formatted the same,
but I've noticed at line 1883 in enter_repo() it's still a single-line
call.

>  		die("%s", err.buf);
> -	startup_info->have_repository = 1;
>  
>  	/*
>  	 * Ensure `core.hidedotfiles` is processed. This must happen after we
> @@ -2882,7 +2880,9 @@ int init_db(struct repository *repo,
>  
>  	if (!(flags & INIT_DB_SKIP_REFDB))
>  		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> -	create_object_directory(repo);
> +	create_object_database(repo);
> +
> +	startup_info->have_repository = 1;
>  
>  	if (repo_settings_get_shared_repository(repo)) {
>  		char buf[10];
>
> -- 
> 2.55.0.679.g6767b8d81c.dirty
>

-- 
Cheers,
Toon
