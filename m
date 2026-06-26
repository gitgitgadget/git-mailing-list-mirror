Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B223750BD
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475841; cv=none; b=So0KemOe+hz/IZfePvV6Xkn1HPYeuJwQgeNhW8DsOB0PyIpJgKX9r9kNWhhHSQNBHBVD3+VykatXSne6Nu6FPCww1rONt8uyb32DreF7YOrfuXAXhEWK0TnVntKuhypLb+t4n/4LJPX4IBwWVXYXfcf6zaEWOrPE3L5h2j0JGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475841; c=relaxed/simple;
	bh=317GqdVJIM7QC9939NxlmVHISq2iRXQhvorKTS3XxeQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Phyxrr7HPOyMS3pjlJaq7XUeqZpd5Cpwy5NQ6Hs8P6K+TgLmgV74USHkYAicPubtmbbdhsQDK0wqfKzpprLyP04KlnAsvGHHJmNu3QOP0GTX3hH3zGCcLziHgZo/A5kXyW6X1HI8WH1Y9aTnZ41YkyxBfXld1AQFOsBoTHp1pwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=g0luI8kB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="g0luI8kB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782475836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhSet+Z42QLm43MagSjNoKH4SNtjxqfM2vrmpyIDsqc=;
	b=g0luI8kBSyGMyTpGcwZ91YEzD2F+J1zib9PwkPBgf6TdnzVTFZLX8baYCoxwBuDGeCK0k0
	PrFIzOWzs9TJLUyeg/hLNl5dCk6hSdJogaWDN5KlaOapH5lEslLldI6IxnJ/CGE86Jypbb
	m6MkjXPMcRTDzyqu+a7a7AMFLSIpD2Q=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] odb/source: generalize `reprepare()` callback
In-Reply-To: <20260622-b4-pks-odb-generalize-prepare-v1-1-d2a5c5d13144@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-1-d2a5c5d13144@pks.im>
Date: Fri, 26 Jun 2026 14:10:32 +0200
Message-ID: <87ldc14i4n.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `reprepare()` callback function can be used to flush caches of a
> given object source and then prepare it anew. This is for example used
> when a concurrent process may have written new objects. Ultimately, this
> can be seen as doing two separate steps:
>
>   1. We drop any caches.
>
>   2. We prepare the source.
>
> We have one callsite in git-grep(1) though that really only want to do
> (2). This is done by reaching into the "files" backend directly and then
> calling `odb_source_packed_prepare()`, which of course may not work with
> alternate backends.
>
> We could in theory just call `reprepare()` here, and that would likely
> not have any significant downside. But this would certainly feel like a
> code smell.
>
> Instead, generalize the `reprepare()` callback to `prepare()` with a
> flag that optionally instructs the backend to also flush the caches,
> which allows us to drop the external `odb_source_packed_prepare()`
> declaration.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c        |  9 +++------
>  midx.c                |  2 +-
>  odb.c                 |  2 +-
>  odb.h                 |  8 ++++++++
>  odb/source-files.c    |  9 +++++----
>  odb/source-inmemory.c |  5 +++--
>  odb/source-loose.c    |  8 +++++---
>  odb/source-packed.c   | 34 ++++++++++++++++------------------
>  odb/source-packed.h   |  9 ---------
>  odb/source.h          | 16 +++++++++-------
>  packfile.c            |  2 +-
>  11 files changed, 52 insertions(+), 52 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 8080d1bf5e..7361bf071e 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -25,12 +25,11 @@
>  #include "setup.h"
>  #include "submodule.h"
>  #include "submodule-config.h"
> -#include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
> +#include "odb/source.h"
>  #include "oid-array.h"
>  #include "oidset.h"
> -#include "packfile.h"
>  #include "pager.h"
>  #include "path.h"
>  #include "promisor-remote.h"
> @@ -1361,10 +1360,8 @@ int cmd_grep(int argc,
>  			struct odb_source *source;
>  
>  			odb_prepare_alternates(the_repository->objects);
> -			for (source = the_repository->objects->sources; source; source = source->next) {
> -				struct odb_source_files *files = odb_source_files_downcast(source);

So you're downcasting inside the implementation by the backends itself.
That makes sense, but would it be worth to say something about that in
the commit message?

> -				odb_source_packed_prepare(files->packed);
> -			}
> +			for (source = the_repository->objects->sources; source; source = source->next)
> +				odb_source_prepare(source, 0);
>  		}
>  
>  		start_threads(&opt);
> diff --git a/midx.c b/midx.c
> index cc6b94f9dd..76c3f92cc3 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -101,7 +101,7 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
>  
>  struct multi_pack_index *get_multi_pack_index(struct odb_source_packed *source)
>  {
> -	odb_source_packed_prepare(source);
> +	odb_source_prepare(&source->base, 0);
>  	return source->midx;
>  }
>  
> diff --git a/odb.c b/odb.c
> index 965ef68e4e..7b45390e12 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1086,7 +1086,7 @@ void odb_reprepare(struct object_database *o)
>  	odb_prepare_alternates(o);
>  
>  	for (source = o->sources; source; source = source->next)
> -		odb_source_reprepare(source);
> +		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
>  
>  	o->object_count_valid = 0;
>  
> diff --git a/odb.h b/odb.h
> index 0030467a52..c14c9030e4 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -124,6 +124,14 @@ void odb_free(struct object_database *o);
>   */
>  void odb_close(struct object_database *o);
>  
> +enum odb_prepare_flags {
> +	/*
> +	 * Flush caches, reload alternates and then re-prepare each object
> +	 * source so that new objects may become accessible.
> +	 */
> +	ODB_PREPARE_FLUSH_CACHES = (1 << 0),
> +};
> +
>  /*
>   * Clear caches, reload alternates and then reload object sources so that new
>   * objects may become accessible.
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 3bc6419dd7..ad9e0b52f9 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -41,11 +41,12 @@ static void odb_source_files_close(struct odb_source *source)
>  	odb_source_close(&files->packed->base);
>  }
>  
> -static void odb_source_files_reprepare(struct odb_source *source)
> +static void odb_source_files_prepare(struct odb_source *source,
> +				     enum odb_prepare_flags flags)
>  {
>  	struct odb_source_files *files = odb_source_files_downcast(source);
> -	odb_source_reprepare(&files->loose->base);
> -	odb_source_reprepare(&files->packed->base);
> +	odb_source_prepare(&files->loose->base, flags);
> +	odb_source_prepare(&files->packed->base, flags);
>  }
>  
>  static int odb_source_files_read_object_info(struct odb_source *source,
> @@ -273,7 +274,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  
>  	files->base.free = odb_source_files_free;
>  	files->base.close = odb_source_files_close;
> -	files->base.reprepare = odb_source_files_reprepare;
> +	files->base.prepare = odb_source_files_prepare;
>  	files->base.read_object_info = odb_source_files_read_object_info;
>  	files->base.read_object_stream = odb_source_files_read_object_stream;
>  	files->base.for_each_object = odb_source_files_for_each_object;
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index e004566d76..cc5e9e62cb 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -325,7 +325,8 @@ static void odb_source_inmemory_close(struct odb_source *source UNUSED)
>  {
>  }
>  
> -static void odb_source_inmemory_reprepare(struct odb_source *source UNUSED)
> +static void odb_source_inmemory_prepare(struct odb_source *source UNUSED,
> +					enum odb_prepare_flags flags UNUSED)
>  {
>  }
>  
> @@ -365,7 +366,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
>  
>  	source->base.free = odb_source_inmemory_free;
>  	source->base.close = odb_source_inmemory_close;
> -	source->base.reprepare = odb_source_inmemory_reprepare;
> +	source->base.prepare = odb_source_inmemory_prepare;
>  	source->base.read_object_info = odb_source_inmemory_read_object_info;
>  	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
>  	source->base.for_each_object = odb_source_inmemory_for_each_object;
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 7d7ea2fb84..af46316e35 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -672,10 +672,12 @@ static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
>  	       sizeof(loose->subdir_seen));
>  }
>  
> -static void odb_source_loose_reprepare(struct odb_source *source)
> +static void odb_source_loose_prepare(struct odb_source *source,
> +				     enum odb_prepare_flags flags)
>  {
>  	struct odb_source_loose *loose = odb_source_loose_downcast(source);
> -	odb_source_loose_clear_cache(loose);
> +	if (flags & ODB_PREPARE_FLUSH_CACHES)
> +		odb_source_loose_clear_cache(loose);
>  }
>  
>  static void odb_source_loose_close(struct odb_source *source UNUSED)
> @@ -716,7 +718,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
>  
>  	loose->base.free = odb_source_loose_free;
>  	loose->base.close = odb_source_loose_close;
> -	loose->base.reprepare = odb_source_loose_reprepare;
> +	loose->base.prepare = odb_source_loose_prepare;
>  	loose->base.read_object_info = odb_source_loose_read_object_info;
>  	loose->base.read_object_stream = odb_source_loose_read_object_stream;
>  	loose->base.for_each_object = odb_source_loose_for_each_object;
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 42c28fba0e..fa5a072488 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -15,7 +15,7 @@ static int find_pack_entry(struct odb_source_packed *store,
>  {
>  	struct packfile_list_entry *l;
>  
> -	odb_source_packed_prepare(store);
> +	odb_source_prepare(&store->base, 0);

Why are you not using ODB_PREPARE_FLUSH_CACHES here? It used to do
before?

>  	if (store->midx && fill_midx_entry(store->midx, oid, e))
>  		return 1;
>  
> @@ -47,7 +47,7 @@ static int odb_source_packed_read_object_info(struct odb_source *source,
>  	 * been added since the last time we have prepared the packfile store.
>  	 */
>  	if (flags & OBJECT_INFO_SECOND_READ)
> -		odb_source_reprepare(source);
> +		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);

I think the new code is correct, but why wasn't `packed` used here in
the past? The old odb_source_reprepare() expected a downcasted, didn't
it?

>  
>  	if (!find_pack_entry(packed, oid, &e))
>  		return 1;
> @@ -668,27 +668,25 @@ static int sort_pack(const struct packfile_list_entry *a,
>  	return -1;
>  }
>  
> -void odb_source_packed_prepare(struct odb_source_packed *source)
> +static void odb_source_packed_prepare(struct odb_source *source,
> +				      enum odb_prepare_flags flags)
>  {
> -	if (source->initialized)
> +	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> +
> +	if (flags & ODB_PREPARE_FLUSH_CACHES)
> +		packed->initialized = false;
> +	if (packed->initialized)
>  		return;
>  
> -	prepare_multi_pack_index_one(source);
> -	prepare_packed_git_one(source);
> +	prepare_multi_pack_index_one(packed);
> +	prepare_packed_git_one(packed);
>  
> -	sort_packs(&source->packs.head, sort_pack);
> -	for (struct packfile_list_entry *e = source->packs.head; e; e = e->next)
> +	sort_packs(&packed->packs.head, sort_pack);
> +	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
>  		if (!e->next)
> -			source->packs.tail = e;
> +			packed->packs.tail = e;
>  
> -	source->initialized = true;
> -}
> -
> -static void odb_source_packed_reprepare(struct odb_source *source)
> -{
> -	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> -	packed->initialized = false;
> -	odb_source_packed_prepare(packed);
> +	packed->initialized = true;
>  }
>  
>  static void odb_source_packed_reparent(const char *name UNUSED,
> @@ -744,7 +742,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
>  
>  	packed->base.free = odb_source_packed_free;
>  	packed->base.close = odb_source_packed_close;
> -	packed->base.reprepare = odb_source_packed_reprepare;
> +	packed->base.prepare = odb_source_packed_prepare;
>  	packed->base.read_object_info = odb_source_packed_read_object_info;
>  	packed->base.read_object_stream = odb_source_packed_read_object_stream;
>  	packed->base.for_each_object = odb_source_packed_for_each_object;
> diff --git a/odb/source-packed.h b/odb/source-packed.h
> index 88994098c1..d5230ac68c 100644
> --- a/odb/source-packed.h
> +++ b/odb/source-packed.h
> @@ -82,13 +82,4 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
>  	return container_of(source, struct odb_source_packed, base);
>  }
>  
> -/*
> - * Prepare the source by loading packfiles and multi-pack indices for
> - * all alternates. This becomes a no-op if the source is already prepared.
> - *
> - * It shouldn't typically be necessary to call this function directly, as
> - * functions that access the source know to prepare it.
> - */
> -void odb_source_packed_prepare(struct odb_source_packed *source);
> -
>  #endif
> diff --git a/odb/source.h b/odb/source.h
> index b9a7642b2c..bbf1da3819 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -83,11 +83,12 @@ struct odb_source {
>  	void (*close)(struct odb_source *source);
>  
>  	/*
> -	 * This callback is expected to clear underlying caches of the object
> -	 * database source. The function is called when the repository has for
> -	 * example just been repacked so that new objects will become visible.
> +	 * This callback is expected to prepare the source so that it becomes
> +	 * ready for use. It optionally clears underlying caches of the object
> +	 * database source.
>  	 */
> -	void (*reprepare)(struct odb_source *source);
> +	void (*prepare)(struct odb_source *source,
> +			enum odb_prepare_flags flags);
>  
>  	/*
>  	 * This callback is expected to read object information from the object
> @@ -308,13 +309,14 @@ static inline void odb_source_close(struct odb_source *source)
>  }
>  
>  /*
> - * Reprepare the object database source and clear any caches. Depending on the
> + * Prepare the object database source and clear any caches. Depending on the
>   * backend used this may have the effect that concurrently-written objects
>   * become visible.
>   */
> -static inline void odb_source_reprepare(struct odb_source *source)
> +static inline void odb_source_prepare(struct odb_source *source,
> +				      enum odb_prepare_flags flags)
>  {
> -	source->reprepare(source);
> +	source->prepare(source, flags);
>  }
>  
>  /*
> diff --git a/packfile.c b/packfile.c
> index 59cee7925d..d78fae981a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -855,7 +855,7 @@ void for_each_file_in_pack_dir(const char *objdir,
>  
>  struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *store)
>  {
> -	odb_source_packed_prepare(store);
> +	odb_source_prepare(&store->base, 0);
>  
>  	if (store->midx) {
>  		struct multi_pack_index *m = store->midx;
>
> -- 
> 2.55.0.rc1.745.g43192e7977.dirty
>
>

-- 
Cheers,
Toon
