Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128D471407
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936576; cv=none; b=sw1dEMAlgndjElHzx8jF83X+jmv1l/D4qdkKSykIT5YBs6fIz+YX60bQLcauvKSzFQcegbBW+oYdN/awf3OlN18Q9RFkl4NyyF6+Z6UHh2lZWUt0QJXD3bqmOoYicfIH1j8/V6dCnWivBYsKzG8/qnXuk8tLiGk0uQ6EUVpQvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936576; c=relaxed/simple;
	bh=S4yRGbHLbwko0qh8fdTq/JCGKWMl3T/6Vv1UMqd3Z8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8q4flw0DzNHy6DaqGcaJPW3w5d0FqF1Dm5diCfuI1T0LTv3vukHPxEbhs5XWbSwQ7Xp39gYr3SDmsmhubq1u2G8pSmcW6dP+OBZ7mfKJsE9a1IqaM5PZqLZ7P23VhzVNXUCoJ1DPmJzY3BLXVwAY/UvysQuiG0yApZxuiCddBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=PSTvQXi4; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="PSTvQXi4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785936570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mMuQw1RLkoPJUjuSzG8WotGO3ESQ6BSChKNaIQTdvA=;
	b=PSTvQXi492Yi9RGEt3q/h4B2gIDznTcyKs/VqRVz/TrQf0PpJ7ZnHiibatxUNxIORoruB3
	8bPDEHEOfIk6nNbkU/PHk7omH9hZmKaeihaskNyb/Ba6r3ykqh5GiWEbx5ECG0oKPdqji2
	aG4d4e8Sft5/6Pb1Wad5PgGJQ8gyEwc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/6] setup: handle ODB-related environment variables
 in `odb_new()`
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-3-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
 <20260805-pks-odb-create-on-disk-v3-3-c0ee3ac5141f@pks.im>
Date: Wed, 05 Aug 2026 15:29:21 +0200
Message-ID: <878q6k66ha.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When initializing a repository's object database we have to respect the
> GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES environment
> variables, which can be set by the user to override the default location
> of where we write objects to and read objects from.
>
> This is handled in `apply_repository_format()`, which is fine. But in a
> subsequent commit we'll have to defer constructing the object database
> to a later point in some cases, and that will require a second site
> where we call `odb_new()`. And of course, that second site would have to
> handle those environment variables, as well.
>
> It would be somewhat awkward to duplicate the logic though. But there's
> a better alternative: instead of handling this logic in "setup.c", we
> can easily handle environment variables in `odb_new()` itself. This
> ensures that object database creation is neatly self-contained, and we
> don't have to duplicate any of the logic.
>
> Another benefit is that in a future patch series we plan to move
> handling of alternates into the backends themselves [1], and that will
> require us to also handle those environment variables in the "files"
> backend itself. So moving the logic into the ODB level already gets us
> one step closer to that goal.
>
> Refactor the logic accordingly.

I like this!

>
> [1]: https://lore.kernel.org/git/amLgMqkqxR8mKIbT@pks.im/
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c                         | 20 ++++++++++++--------
>  odb.h                         | 17 +++++++++++++++--
>  setup.c                       | 11 ++++-------
>  t/unit-tests/u-odb-inmemory.c |  2 +-
>  4 files changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index cf6e7938c0..b463afa072 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1004,26 +1004,30 @@ int odb_write_object_stream(struct object_database *odb,
>  }
>  
>  struct object_database *odb_new(struct repository *repo,
> -				const char *primary_source,
> -				const char *secondary_sources)
> +				enum odb_new_flags flags)
>  {
> -	struct object_database *o = xmalloc(sizeof(*o));
> -	char *to_free = NULL;
> +	char *primary_source = NULL, *secondary_sources = NULL;
> +	struct object_database *o;
>  
> -	memset(o, 0, sizeof(*o));
> +	CALLOC_ARRAY(o, 1);
>  	o->repo = repo;
>  	pthread_mutex_init(&o->replace_mutex, NULL);
>  	string_list_init_dup(&o->submodule_source_paths);
>  
> +	if (flags & ODB_NEW_HONOR_ENV) {
> +		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> +		secondary_sources = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +	}
>  	if (!primary_source)
> -		primary_source = to_free = xstrfmt("%s/objects", repo->commondir);
> +		primary_source = xstrfmt("%s/objects", repo->commondir);
> +
>  	o->sources = odb_source_new(o, primary_source, true);
>  	o->sources_tail = &o->sources->next;
>  	o->alternate_db = xstrdup_or_null(secondary_sources);

I'd say this xstrdup_or_null() is not needed no more, and so is the
free() of that variable below.

>  	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
>  
> -	free(to_free);
> -
> +	free(secondary_sources);
> +	free(primary_source);
>  	return o;
>  }

-- 
Cheers,
Toon
