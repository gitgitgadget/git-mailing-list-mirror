Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABCE279DAF
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251198; cv=none; b=m5TDUzWZkMzf/yKgLYls4+Dm37D/8jKDIH4fxrEQTyKT30xFjl9eNblhRa55eb6E2tQ5NMGfOobfrxsb1sDxS5ehPzKwKAl7PhbOlO52EEGTaKzadvun5iqe1hTRJH/oCKzrIPRxkg6EbLhwIwJ6Ykvz7xh2lfPXDqco9qSG3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251198; c=relaxed/simple;
	bh=epoQWuMpRrQadf6A6IxG0ayB4n30Y5VHfmkotW6HEIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDowPjrPCWtyMbtB5OyAG1QMNcwvJ2rAd15Q3XWl6oDDPxIS0KIsrMPjR7Bvmw/yf/0rsapLjjvB6O0BLq47P0jtwEfL3M26MPxGBfGr49ZYT7tCJK8mfflJG4b0omvjFIUxPHJQkNIi2dhgwXoxLK2EYmfg6WpMsOoxa67K3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sVmuSCmD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sVmuSCmD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781251192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKbRCQuchQFG4saOFuD1+CiMO9SrhUDCcKqIGKmtvo8=;
	b=sVmuSCmD11klssW+ewFsMdXrGgWdVEveR/1JAgWW+Y1MIvhAMtn7XuOoveFToIchw7Fmx2
	O0JIr2CB8lapYuHjCyWIGW3seIJb8oR1QUvynplYeHl7sqkaPZTEcIXZmTghEeutwRXHjR
	jguPzw0edTe9SWaZ4CsmLga+CWkWGMs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-5-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-5-a6f7269c841d@pks.im>
Date: Fri, 12 Jun 2026 09:59:42 +0200
Message-ID: <87wlw4yys1.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `is_bare_repository_cfg` variable tracks two different pieces of
> information:
>
>   - It tracks whether the user has invoked git with the "--bare" flag,
>     which makes us treat any discovered Git repository as if it was a
>     bare repository.
>
>   - Otherwise it tracks whether the discovered `the_repository` is bare.
>
> This makes the flag extremely confusing and creates a bit of a challenge
> when handling multiple repositories in the same process.
>
> Split up the concerns of this variable into two pieces:
>
>   - `startup_info.force_bare_repository` tracks whether the user has
>     passed the "--bare" flag. This is used as a hint to treat newly set
>     up repositories as bare regardless of whether or not they have a
>     worktree.
>
>   - `struct repository::bare_cfg` tracks whether or not a repository is
>     considered bare. This takes into account both whether the user has
>     passed "--bare" and the discovered state of the repository itself.
>
> Whether or not a repository is bare is now resolved when checking the
> repository's format, and is then later applied to the repository itself
> via `apply_repository_format()`.
>
> This enables a subsequent change where we make `is_bare_repository()`
> not depend on global state anymore.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/init-db.c |  2 +-
>  environment.c     |  5 ++---
>  environment.h     |  1 -
>  git.c             |  2 +-
>  repository.c      |  1 +
>  repository.h      |  7 +++++++
>  setup.c           | 27 ++++++++++++++++++++-------
>  setup.h           |  6 ++++++
>  worktree.c        |  2 +-
>  9 files changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 52aa92fb0a..566732c9f4 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -81,7 +81,7 @@ int cmd_init_db(int argc,
>  	const char *template_dir = NULL;
>  	char *template_dir_to_free = NULL;
>  	unsigned int flags = 0;
> -	int bare = is_bare_repository_cfg;
> +	int bare = startup_info->force_bare_repository ? 1 : -1;
>  	const char *object_format = NULL;
>  	const char *ref_format = NULL;
>  	const char *initial_branch = NULL;
> diff --git a/environment.c b/environment.c
> index 4e86335f25..9d7c908c55 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -48,7 +48,6 @@ int has_symlinks = 1;
>  int minimum_abbrev = 4, default_abbrev = -1;
>  int ignore_case;
>  int assume_unchanged;
> -int is_bare_repository_cfg = -1; /* unspecified */
>  int warn_on_object_refname_ambiguity = 1;
>  char *git_commit_encoding;
>  char *git_log_output_encoding;
> @@ -136,7 +135,7 @@ const char *getenv_safe(struct strvec *argv, const char *name)
>  int is_bare_repository(void)
>  {
>  	/* if core.bare is not 'false', let's see if there is a work tree */
> -	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
> +	return the_repository->bare_cfg && !repo_get_work_tree(the_repository);
>  }
>  
>  int have_git_dir(void)
> @@ -342,7 +341,7 @@ int git_default_core_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "core.bare")) {
> -		is_bare_repository_cfg = git_config_bool(var, value);
> +		the_repository->bare_cfg = git_config_bool(var, value);
>  		return 0;
>  	}
>  
> diff --git a/environment.h b/environment.h
> index 5d6e4e6c1b..afb5bcf197 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -147,7 +147,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
>   */
>  int have_git_dir(void);
>  
> -extern int is_bare_repository_cfg;
>  int is_bare_repository(void);
>  
>  /* Environment bits from configuration mechanism */
> diff --git a/git.c b/git.c
> index 36f08891ef..387eabe38c 100644
> --- a/git.c
> +++ b/git.c
> @@ -255,7 +255,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--bare")) {
>  			char *cwd = xgetcwd();
> -			is_bare_repository_cfg = 1;
> +			startup_info->force_bare_repository = true;
>  			setenv(GIT_DIR_ENVIRONMENT, cwd, 0);
>  			free(cwd);
>  			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
> diff --git a/repository.c b/repository.c
> index 187dd471c4..c1e91eb0da 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -73,6 +73,7 @@ void initialize_repository(struct repository *repo)
>  	ALLOC_ARRAY(repo->index, 1);
>  	index_state_init(repo->index, repo);
>  	repo->check_deprecated_config = true;
> +	repo->bare_cfg = -1;
>  	repo_config_values_init(&repo->config_values_private_);
>  
>  	/*
> diff --git a/repository.h b/repository.h
> index 36e2db2633..7d649e32e7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -117,6 +117,13 @@ struct repository {
>  	bool worktree_initialized;
>  	bool worktree_config_is_bogus;
>  
> +	/*
> +	 * Whether the repository is bare, as set by "core.bare" config or
> +	 * inferred during repository discovery. -1 means unset/unknown, 0
> +	 * means non-bare, 1 means bare.
> +	 */
> +	int bare_cfg;
> +
>  	/*
>  	 * Path from the root of the top-level superproject down to this
>  	 * repository.  This is only non-NULL if the repository is initialized
> diff --git a/setup.c b/setup.c
> index 71fc6b33da..32f14a8688 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -795,10 +795,22 @@ static int check_repository_format_gently(const char *gitdir,
>  		has_common = 0;
>  	}
>  
> -	if (!has_common) {
> -		if (candidate->is_bare != -1)
> -			is_bare_repository_cfg = candidate->is_bare;
> -	} else {
> +	if (startup_info->force_bare_repository) {
> +		candidate->is_bare = 1;
> +		FREE_AND_NULL(candidate->work_tree);
> +	} else if (has_common) {
> +		/*
> +		 * When sharing a common dir with another repository (e.g. a
> +		 * linked worktree), do not let this repository's config
> +		 * dictate bareness; it is inherited from the main worktree.
> +		 */
> +		candidate->is_bare = -1;
> +
> +		/*
> +		 * Furthermore, "core.worktree" is supposed to be ignored when
> +		 * we have a commondir configured, unless it comes from the
> +		 * per-worktree configuration.
> +		 */
>  		FREE_AND_NULL(candidate->work_tree);
>  	}

Looking at the diff, this is really hard to understand. But your
refactor makes sense and the after state is easier to comprehend.

> @@ -1138,7 +1150,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
>  	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
>  	if (work_tree_env)
>  		set_git_work_tree(repo, work_tree_env);
> -	else if (is_bare_repository_cfg > 0) {
> +	else if (repo_fmt->is_bare > 0) {
>  		if (repo_fmt->work_tree) {
>  			/* #22.2, #30 */
>  			warning("core.bare and core.worktree do not make sense");
> @@ -1225,7 +1237,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
>  	}
>  
>  	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
> -	if (is_bare_repository_cfg > 0) {
> +	if (repo_fmt->is_bare > 0) {
>  		set_git_dir(repo, gitdir, (offset != cwd->len));
>  		if (chdir(cwd->buf))
>  			die_errno(_("cannot come back to cwd"));
> @@ -1762,6 +1774,7 @@ int apply_repository_format(struct repository *repo,
>  		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
>  	}
>  
> +	repo->bare_cfg = format->is_bare;
>  	repo_set_hash_algo(repo, format->hash_algo);
>  	repo->objects = odb_new(repo, object_directory,
>  				alternate_object_directories);
> @@ -2571,7 +2584,7 @@ static int create_default_files(struct repository *repo,
>  		repo_settings_set_shared_repository(repo,
>  						    init_shared_repository);
>  
> -	is_bare_repository_cfg = !work_tree;
> +	repo->bare_cfg = !work_tree;

I'm curious, do we still need this? If I'm not mistaken, this function
is called after check_and_apply_repository_format(), which calls
apply_repository_format() and sets repo->bare_cfg too (see the diff
above). Or is it explained by what Justin said[1]?

[1]: <airTpB8Pm6TYoMhx@denethor>

-- 
Cheers,
Toon
