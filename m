Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AA191F92
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164494; cv=none; b=aHOvACTKx4CX1QVyOya/V+eMgAvG06nBUAIeCBx9oIqqfEes4WwwYfOcAw5dp+RJxcKXgJmOnr2PD+QvZZCsbwPu3GwnTDI0j90dwD9Tu7Yx3c5ISvAdf1nWgYLbyf7Tat8r/su0bfc2nCL2iT3FN3PQ20q51ShTzGHb9f2PdpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164494; c=relaxed/simple;
	bh=HtbJ+6NdvQHL2y4qsVJDMe+qBM7s7zBqheseayp07N0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZ0ynxS63Xa/Jca6Ib1pQ+BO/tfPpTsc/72jxS0s1pLgZy58nAXFCOrE1hOUcJ+IX1sLNkooTfnTgt+7X9W/3KDtSMquFVjxVnUlrYggdVhsnXifTWZYGusfGHuXnZ5ofGR27uW1zqy4jh9+gPPR5nRl1VIRspnCJcJFk420x5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FTvgTHMM; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FTvgTHMM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747164489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zb9NBFRtsozEBHul9H7p5+Kcte0uoIZe6aVYik/CIHQ=;
	b=FTvgTHMMaIQvXngIcvZWMmuq7Uf1pgc2CKf171DToGrG/mw2zz1pGM7O3oDQEy8bFVPMiy
	Io4hgWwpVSBOxEwKA1RWj5t4VeFpyQAR9XagypQ7NzN0g0UQDPoyhZO0cnQCq65KP9cHlZ
	z4nyJIeOyqHFmd7ed2hTT1r6LbCchBk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/17] object-store: rename `object_directory` to
 `odb_alternate`
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-2-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-2-103f59bf8e28@pks.im>
Date: Tue, 13 May 2025 21:28:00 +0200
Message-ID: <87bjrwjoov.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `object_directory` structure is used as an access point for a single
> object directory like ".git/objects". While the structure isn't yet
> fully self-contained, the intent is for it to eventually contain all
> information required to access objects in one specific location.
>
> While the name "object directory" is a good fit for now, this will
> change over time as we continue with the agenda to make pluggable object
> databases a thing. Eventually, objects may not be accessed via any kind
> of directory at all anymore, but they could instead be backed by any
> kind of durable storage mechanism. While it seems quite far-fetched for
> now, it is thinkable that eventually this might even be some form of a
> database, for example.
>
> As such, the current name of this structure will become worse over time
> as we evolve into the direction of pluggable ODBs. Immediate next steps
> will start to carve out proper self-contained object directories, which
> requires us to pass in these object directories as parameters. Based on
> our modern naming schema this means that those functions should then be
> named after their subsystem, which means that we would start to bake the
> current name into the codebase more and more.
>
> Let's preempt this by renaming the structure to `odb_alternate` now
> already. This name is agnostic of how exactly objects are stored while
> still specifically pinpointing that this is about an alternate object
> database. In the future, it allows us to easily introduce e.g. a
> `odb_files_alternate` and other specific implementations over time.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/commit-graph.c      |  18 +++----
>  builtin/count-objects.c     |   4 +-
>  builtin/fetch.c             |   2 +-
>  builtin/fsck.c              |  14 ++---
>  builtin/gc.c                |  14 ++---
>  builtin/grep.c              |   2 +-
>  builtin/multi-pack-index.c  |   4 +-
>  builtin/submodule--helper.c |   6 +--
>  bundle.c                    |   2 +-
>  commit-graph.c              |  94 +++++++++++++++++-----------------
>  commit-graph.h              |  14 ++---
>  diagnose.c                  |   8 +--
>  http-walker.c               |   2 +-
>  http.c                      |   4 +-
>  loose.c                     |  42 +++++++--------
>  midx.c                      |   6 +--
>  object-file.c               |  80 ++++++++++++++---------------
>  object-file.h               |   8 +--
>  object-name.c               |   6 +--
>  object-store.c              | 122 ++++++++++++++++++++++----------------------
>  object-store.h              |  25 +++++----
>  packfile.c                  |  16 +++---
>  path.c                      |   2 +-
>  refs.c                      |   2 +-
>  repository.c                |  14 ++---
>  submodule-config.c          |   2 +-
>  t/helper/test-read-graph.c  |   6 +--
>  tmp-objdir.c                |  24 ++++-----
>  28 files changed, 273 insertions(+), 270 deletions(-)

[snip]

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 53da2116ddf..cd7db11d825 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1582,7 +1582,7 @@ static const char alternate_error_advice[] = N_(
>  );
>  
>  static int add_possible_reference_from_superproject(
> -		struct object_directory *odb, void *sas_cb)
> +		struct odb_alternate *alt_odb, void *sas_cb)
>  {
>  	struct submodule_alternate_setup *sas = sas_cb;
>  	size_t len;
> @@ -1591,12 +1591,12 @@ static int add_possible_reference_from_superproject(
>  	 * If the alternate object store is another repository, try the

This comment reads weirdly if an "alternate" is a location where objects
are stored. Maybe say something like:

    * It the alternate resides in another repository, try the

>  	 * standard layout with .git/(modules/<name>)+/objects
>  	 */
> -	if (strip_suffix(odb->path, "/objects", &len)) {
> +	if (strip_suffix(alt_odb->path, "/objects", &len)) {
>  		struct repository alternate;
>  		char *sm_alternate;
>  		struct strbuf sb = STRBUF_INIT;
>  		struct strbuf err = STRBUF_INIT;
> -		strbuf_add(&sb, odb->path, len);
> +		strbuf_add(&sb, alt_odb->path, len);
>  
>  		if (repo_init(&alternate, sb.buf, NULL) < 0)
>  			die(_("could not get a repository handle for gitdir '%s'"),

[snip]

> diff --git a/object-file.h b/object-file.h
> index a85b2e5b494..f1601200938 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -24,23 +24,23 @@ enum {
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
>  int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
>  
> -struct object_directory;
> +struct odb_alternate;
>  
>  /*
>   * Populate and return the loose object cache array corresponding to the
>   * given object ID.
>   */
> -struct oidtree *odb_loose_cache(struct object_directory *odb,
> +struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
>  				const struct object_id *oid);
>  
>  /* Empty the loose object cache for the specified object directory. */

Also here s/directory/alternate/ ? Or database?

> -void odb_clear_loose_cache(struct object_directory *odb);
> +void odb_clear_loose_cache(struct odb_alternate *alternate);
>  
>  /*
>   * Put in `buf` the name of the file in the local object database that
>   * would be used to store a loose object with the specified oid.
>   */

Not sure if we should use "alternate" here?

> -const char *odb_loose_path(struct object_directory *odb,
> +const char *odb_loose_path(struct odb_alternate *alternate,
>  			   struct strbuf *buf,
>  			   const struct object_id *oid);
>  
> diff --git a/object-name.c b/object-name.c
> index 9288b2dd245..b83ba882b9e 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -112,10 +112,10 @@ static enum cb_next match_prefix(const struct object_id *oid, void *arg)
>  
>  static void find_short_object_filename(struct disambiguate_state *ds)
>  {
> -	struct object_directory *odb;
> +	struct odb_alternate *alternate;
>  
> -	for (odb = ds->repo->objects->odb; odb && !ds->ambiguous; odb = odb->next)
> -		oidtree_each(odb_loose_cache(odb, &ds->bin_pfx),
> +	for (alternate = ds->repo->objects->alternates; alternate && !ds->ambiguous; alternate = alternate->next)
> +		oidtree_each(odb_loose_cache(alternate, &ds->bin_pfx),
>  				&ds->bin_pfx, ds->len, match_prefix, ds);
>  }

[snip]

> diff --git a/object-store.h b/object-store.h
> index 34b8efbbb83..2dda6e85388 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -12,8 +12,11 @@ struct oidtree;
>  struct strbuf;
>  struct repository;
>  
> -struct object_directory {
> -	struct object_directory *next;
> +/*
> + * An alternate part of an object database that stores the actual objects.

I'm having a hard time trying to understand what you're saying here.
What do you think about:

    * The alternate is the part of the object database that stores the actual objects.

> + */
> +struct odb_alternate {
> +	struct odb_alternate *next;
>  
>  	/*
>  	 * Used to store the results of readdir(3) calls when we are OK
> @@ -52,8 +55,8 @@ struct object_directory {
>  void prepare_alt_odb(struct repository *r);
>  int has_alt_odb(struct repository *r);
>  char *compute_alternate_path(const char *path, struct strbuf *err);
> -struct object_directory *find_odb(struct repository *r, const char *obj_dir);
> -typedef int alt_odb_fn(struct object_directory *, void *);
> +struct odb_alternate *find_odb(struct repository *r, const char *obj_dir);
> +typedef int alt_odb_fn(struct odb_alternate *, void *);
>  int foreach_alt_odb(alt_odb_fn, void*);
>  typedef void alternate_ref_fn(const struct object_id *oid, void *);
>  void for_each_alternate_ref(alternate_ref_fn, void *);
> @@ -75,12 +78,12 @@ void add_to_alternates_memory(const char *dir);
>   * Replace the current writable object directory with the specified temporary
>   * object directory; returns the former primary object directory.
>   */
> -struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
> +struct odb_alternate *set_temporary_primary_odb(const char *dir, int will_destroy);
>  
>  /*
>   * Restore a previous ODB replaced by set_temporary_main_odb.
>   */
> -void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
> +void restore_primary_odb(struct odb_alternate *restore_alternate, const char *old_path);
>  
>  struct packed_git;
>  struct multi_pack_index;
> @@ -88,7 +91,7 @@ struct cached_object_entry;
>  
>  /*
>   * The object database encapsulates access to objects in a repository. It
> - * manages one or more backends that store the actual objects which are
> + * manages one or more alternates that store the actual objects which are
>   * configured via alternates.
>   */
>  struct object_database {
> @@ -97,16 +100,16 @@ struct object_database {
>  	 * cannot be NULL after initialization). Subsequent directories are
>  	 * alternates.
>  	 */

The full original comment can use some love too:

    *
    * Set of all object directories; the main directory is first (and
    * cannot be NULL after initialization). Subsequent directories are
    * alternates.
    */

How about:

    *
    * Set of all alternates, storing the actual objects.
    * The primary alternate is first (and cannot be NULL after
    * & initialization). More alternates are optional.
    */


> -	struct object_directory *odb;
> -	struct object_directory **odb_tail;
> -	struct kh_odb_path_map *odb_by_path;
> +	struct odb_alternate *alternates;
> +	struct odb_alternate **alternates_tail;
> +	struct kh_odb_path_map *alternate_by_path;
>  
>  	int loaded_alternates;
>  
>  	/*
>  	 * A list of alternate object directories loaded from the environment;
>  	 * this should not generally need to be accessed directly, but will
> -	 * populate the "odb" list when prepare_alt_odb() is run.
> +	 * populate the "alternates" list when prepare_alt_odb() is run.
>  	 */
>  	char *alternate_db;
>  

[snip]

Huge patch, I scrolled through the changes, but focused on some naming
and comments.

--
Toon
