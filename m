Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000928A709
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027360; cv=none; b=fB/CW66T37qhTmb2AoLpbNiGhwzicHfLqxlFuFneXR+jsH22ETKijAuWV02SSaMtf4/HrN9tippL9GgipPn50ziyvwkaVuRq2P//yLStMuoODFHW8MTAm2YxLmYJGQ+jdAxUtFTTe9CkPwoQ4xwGKmkF0C5Rg9gSGP0oo/Ls6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027360; c=relaxed/simple;
	bh=Dq7IlrJxGg1uJU7FWSZJhPotztYYoETEby4/X3lGfTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G4HJjEE5W5cP/1vz9q4OIxYqiVn3TSTEYSsBUpULyFzcuJbEc1KaMqiQ7DQwgqeL5CXIis2cjqtZxjKUd74nnvQoAiNcrwDMFCxaZ2CG7lHnd58UWL+UFdpMxYp+EWDd9BiGk3b1yhaxjmuF7jNipUnQHNICh0I4xrB+U3G/xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YiKKReLZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YiKKReLZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749027353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qz68gDg5FJLvOgH1LTLgjwhYJDSCBJaEmUFgSQMC98=;
	b=YiKKReLZIHGa3qnSLPN94rF20/nI0Py2Uk8o671EQtdT91y04uTvcW5xagFicYR/C3vcIK
	bMBCjR+TOuyG7POrVnJgA2VyFOFvFz6mm6S/rwJu1KYUY9BwZdMO9cc9+4B+b1IAhsMuqQ
	mZPEi4iE/U5maSBaI8Ojz+W37vOHHVk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 01/17] object-store: rename `raw_object_store` to
 `object_database`
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-1-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
 <20250602-pks-object-store-wo-the-repository-v4-1-e986804a7c62@pks.im>
Date: Wed, 04 Jun 2025 10:55:40 +0200
Message-ID: <87a56n3myb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `raw_object_store` structure is the central entry point for reading
> and writing objects in a repository. The main purpose of this structure
> is to manage object directories and provide an interface to access and
> write objects in those object directories.
>
> Right now, many of the functions associated with the raw object store
> implicitly rely on `the_repository` to get access to its `objects`
> pointer, which is the `raw_object_store`. As we want to generally get
> rid of using `the_repository` across our codebase we will have to
> convert this implicit dependency on this global variable into an
> explicit parameter.
>
> This conversion can be done by simply passing in an explicit pointer to
> a repository and then using its `->objects` pointer. But there is a
> second effort underway, which is to make the object subsystem more
> selfcontained so that we can eventually have pluggable object backends.
> As such, passing in a repository wouldn't make a ton of sense, and the
> goal is to convert the object store interfaces such that we always pass
> in a reference to the `raw_object_store` instead.
>
> This will expose the `raw_object_store` type to a lot more callers
> though, which surfaces that this type is named somewhat awkwardly. The
> "raw_" prefix makes readers wonder whether there is a non-raw variant of
> the object store, but there isn't. Furthermore, we nowadays want to name
> functions in a way that they can be clearly attributed to a specific
> subsystem, but calling them e.g. `raw_object_store_has_object()` is just
> too unwieldy, even when dropping the "raw_" prefix.
>
> Instead, rename the structure to `object_database`. This term is already
> used a lot throughout our codebase, and it cannot easily be mistaken for
> "object directories", either. Furthermore, its acronym ODB is already
> well-known and works well as part of a function's name, like for example
> `odb_has_object()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  commit-graph.c |  2 +-
>  commit-graph.h |  4 ++--
>  object-store.c | 12 ++++++------
>  object-store.h | 11 ++++++++---
>  packfile.c     |  2 +-
>  packfile.h     |  4 ++--
>  repository.c   |  4 ++--
>  repository.h   |  4 ++--
>  8 files changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index ad3943b6906..905fcbdf0e8 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -829,7 +829,7 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
>  	return NULL;
>  }
>  
> -void close_commit_graph(struct raw_object_store *o)
> +void close_commit_graph(struct object_database *o)
>  {
>  	if (!o->commit_graph)
>  		return;
> diff --git a/commit-graph.h b/commit-graph.h
> index 13f662827d4..20d38c100ce 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -26,7 +26,7 @@ void git_test_write_commit_graph_or_die(void);
>  struct commit;
>  struct bloom_filter_settings;
>  struct repository;
> -struct raw_object_store;
> +struct object_database;
>  struct string_list;
>  
>  char *get_commit_graph_filename(struct object_directory *odb);
> @@ -186,7 +186,7 @@ int write_commit_graph(struct object_directory *odb,
>  
>  int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
>  
> -void close_commit_graph(struct raw_object_store *);
> +void close_commit_graph(struct object_database *);
>  void free_commit_graph(struct commit_graph *);
>  
>  /*
> diff --git a/object-store.c b/object-store.c
> index 58cde0313a5..f4e8f99d90f 100644
> --- a/object-store.c
> +++ b/object-store.c
> @@ -44,7 +44,7 @@ struct cached_object_entry {
>  	} value;
>  };
>  
> -static const struct cached_object *find_cached_object(struct raw_object_store *object_store,
> +static const struct cached_object *find_cached_object(struct object_database *object_store,
>  						      const struct object_id *oid)
>  {
>  	static const struct cached_object empty_tree = {
> @@ -86,7 +86,7 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.
>   */
> -static int alt_odb_usable(struct raw_object_store *o,
> +static int alt_odb_usable(struct object_database *o,
>  			  struct strbuf *path,
>  			  const char *normalized_objdir, khiter_t *pos)
>  {
> @@ -950,9 +950,9 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
>  		    type_name(expect));
>  }
>  
> -struct raw_object_store *raw_object_store_new(void)
> +struct object_database *odb_new(void)
>  {
> -	struct raw_object_store *o = xmalloc(sizeof(*o));
> +	struct object_database *o = xmalloc(sizeof(*o));
>  
>  	memset(o, 0, sizeof(*o));
>  	INIT_LIST_HEAD(&o->packed_git_mru);
> @@ -961,7 +961,7 @@ struct raw_object_store *raw_object_store_new(void)
>  	return o;
>  }
>  
> -static void free_object_directories(struct raw_object_store *o)
> +static void free_object_directories(struct object_database *o)
>  {
>  	while (o->odb) {
>  		struct object_directory *next;
> @@ -974,7 +974,7 @@ static void free_object_directories(struct raw_object_store *o)
>  	o->odb_by_path = NULL;
>  }
>  
> -void raw_object_store_clear(struct raw_object_store *o)
> +void odb_clear(struct object_database *o)
>  {
>  	FREE_AND_NULL(o->alternate_db);
>  
> diff --git a/object-store.h b/object-store.h
> index c5890085352..a3be27d1171 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -87,7 +87,12 @@ struct packed_git;
>  struct multi_pack_index;
>  struct cached_object_entry;
>  
> -struct raw_object_store {
> +/*
> + * The object database encapsulates access to objects in a repository. It
> + * manages one or more backends that store the actual objects which are
> + * configured via alternates.

This still uses /old/ terminology. I think the "backend" should be
called "source", and we can keep the "alternates"?

-- 
Cheers,
Toon
