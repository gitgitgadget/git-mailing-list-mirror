Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9968034DB55
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732586; cv=none; b=RIPpqHIRMmTE5aPS+c1bliKuj0sBHhEx3qOCXmlEG3QrfauKX45q5fJfclsdqzQPgwl5/lSDVACoz4evmT5SGGBT10wVQj33TojoYUfu1JZuXsP+jt/1qCq224d8V31f+0Y5Y0z9Fij4uiB0uQql4g+jA2jFX0H1F5G4S44Y0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732586; c=relaxed/simple;
	bh=V8HokEjcx/RPFhVCthx8jZxOV32DCkTZbnGICcpGY/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcQ+ILUSwWFXvRksDHfwEvFAiDsoaRxjbhdI2ko7Xe94GM4y9/qVKy/ZSM5TGsAxXnTs7ETI/9zwuitnFUaY9NiAvnmqlI0D2z0kWRQCQmy0t7JfoP0B4ChQWyzDbNKRhuwUbdhzYJavo0lKyNp7CcEd+zmXdMQ1IvKJ2DnoV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wJniY+uC; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wJniY+uC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1763732579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aGqNh3Dbu7y8thxR750fkfEFFNIMCUAPNLuBgwOhWE=;
	b=wJniY+uCa058aUJXN6EPvX8CiPYy0Iq/m4xDSez7Rz1nbzM6UaE42kOMbs5XJAjnuj0rUz
	SwTdLC3BAXPjENmjmtmHgWD4xRbRONhp38CWQggcrdzVPh6WeXZVXlmDC4RtdMoLJ/Jh0y
	/tExtWwcCp6SFXjZSqLXohQVzPNOEHQ=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
Date: Fri, 21 Nov 2025 14:42:27 +0100
Message-ID: <87pl9b5wos.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
> This asymmetry makes it difficult to test different reference backends
> or use alternative reference storage locations without modifying the
> repository structure.
>
> Add a new environment variable 'GIT_REF_URI' that specifies both the
> reference backend and directory path using a URI format:
>
>     <ref_backend>://<path>

I like this idea. This would allow us in the future to also do something
like:

    reftable+nfs://10.11.12.13/ref-dir

> When set, this variable is used to obtain the main reference store for
> all Git commands. The variable is checked in `get_main_ref_store()`
> when lazily assigning `repo->refs_private`. We cannot initialize this
> earlier in `repo_set_gitdir()` because the repository's hash algorithm
> isn't known at that point, and the reftable backend requires this
> information during initialization.
>
> When used with worktrees, the specified directory is treated as the
> reference directory for all worktree operations.
>
> Add a new test file 't1423-ref-backend.sh' to test this environment
> variable.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git.adoc |   8 ++++
>  environment.h          |   1 +
>  refs.c                 |  53 +++++++++++++++++++++++-
>  t/meson.build          |   1 +
>  t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 171 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index ce099e78b8..a1d1078f42 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	repositories will be set to this value. The default is "files".
>  	See `--ref-format` in linkgit:git-init[1].
>  
> +`GIT_REF_URI`::
> +    Specify which reference backend and path to be used, if not specified the
> +    backend is inferred from the configuration and $GIT_DIR is used as the
> +    path.
> ++
> +Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
> +reference backend and the 'path' specifies the directory used by the backend.
> +
>  Git Commits
>  ~~~~~~~~~~~
>  `GIT_AUTHOR_NAME`::
> diff --git a/environment.h b/environment.h
> index 51898c99cd..9bc380bba4 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -42,6 +42,7 @@
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
> +#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
>  
>  /*
>   * Environment variable used to propagate the --no-advice global option to the
> diff --git a/refs.c b/refs.c
> index 23f46867f2..0922f08c9f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2186,15 +2186,66 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>  }
>  
> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
> +						const char *uri)
> +{
> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
> +	enum ref_storage_format format;
> +	struct ref_store *store = NULL;
> +	char *format_string;
> +	char *dir;
> +
> +	if (!uri || !uri[0]) {
> +		error("reference backend uri is empty");

I see no localization on any of the error() or die() messages. I think
it's worth to make them translatable.

> +		goto cleanup;
> +	}
> +
> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
> +		error("invalid reference backend uri format '%s'", uri);
> +		goto cleanup;
> +	}
> +
> +	format_string = ref_backend_info.items[0].string;
> +	dir = ref_backend_info.items[1].string + 2;

Length check before jumping to the third char would be adviced. Also I
think it's worth to check if the first two chars are "//".

-- 
Cheers,
Toon
