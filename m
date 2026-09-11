Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0A3C553F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125340; cv=none; b=l+/sGvhzk9hbqCtC1T6FLKl/r3dAEZGMN5lAVC+uud7wSEhxFGNW5BMCsaONNB8YEDEPxdKe452+/hLpgNTiDncgh/upD6G7XT6In9o9kTqYodHRgDYj3AiiEmNmtyb7UkHYxrCPuNo3beqIciVh3sxPYqdbA7OU/Ow0Pf/tVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125340; c=relaxed/simple;
	bh=XA4m7FAg1fu5NymKk2b4YQmpbc/ElT7owusE63jBL94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LjVDsPLjWEs5CLiZl0V6EgW9WqGxNpJVpCXOjLuBtupBjjkKv8Vj0g834U6JjlQpVhEZIcATLFlMTOywNlzeLoKnWrgmh47vSSA+mh9u2wHex/I9Ke8UN35cKBentzukCYijUFGe9gwINddernb9PP1Pd77RbX5AKCOmdC6Ci8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Rl3qmJqw; arc=none smtp.client-ip=91.218.175.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Rl3qmJqw"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XA4m7FAg1fu5NymKk2b4YQmpbc/ElT7owusE63jBL94=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789125322; v=1; x=1789730122;
 b=Rl3qmJqwyFmcmW+7tsHmBuKp1cQBGi7PvbJDgYksYsejXLB67Xk9L+7/g38EenFm12SYPL1Q
 M9HQIdQ1s75IzFUpDolETYEJWaFR8cEFAd1VffXNYxDFw0MCgM4973C6eWQGlgy0PcAwPZeTGJE
 /jfzmo8zvNWagrVnt8gDXGd0=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ca0ca1e15345bce6;
	Fri, 11 Sep 2026 11:15:13 +0000
X-Mizu-Trace-ID: ca0ca1e15345bce6
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/10] builtin/fsck: move loose object verification
 into the loose source
In-Reply-To: <20260831-pks-odb-source-fsck-v2-10-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-10-f9b16ef4957b@pks.im>
Date: Fri, 11 Sep 2026 13:15:06 +0200
Message-ID: <875x0cnio5.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The consistency checks for loose objects are hosted by "builtin/fsck.c".
> These checks are obviously specific to the "loose" backend.
>
> Move the logic into `odb_source_loose_fsck()`. Introduce a new "verbose"
> flag so that we can properly retain semantics around whether or not we
> want to print some status messages.
>
> Note that this fixes a bug as a side effect: the progress meter was
> captured in the callback data before `start_progress()` was even called,
> so the per-subdirectory progress updates always operated on a NULL
> pointer and the meter jumped straight from 0 to 256 upon completion. The
> new code only sets up the callback data's progress meter after it has
> been created, so the progress display now advances incrementally again.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c     | 91 ++----------------------------------------------------
>  odb.h              |  3 ++
>  odb/source-loose.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 93 insertions(+), 90 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 7eaea340b0..4af1d874cc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -12,7 +12,6 @@
>  #include "parse-options.h"
>  #include "progress.h"
>  #include "packfile.h"
> -#include "object-file.h"
>  #include "object-name.h"
>  #include "odb.h"
>  #include "odb/streaming.h"
> @@ -695,88 +694,6 @@ static void process_refs(struct repository *repo, struct snapshot *snap)
>  	}
>  }
>  
> -struct for_each_loose_cb {
> -	struct repository *repo;
> -	struct progress *progress;
> -};
> -
> -static int fsck_loose(const struct object_id *oid, const char *path,
> -		      void *cb_data)
> -{
> -	struct for_each_loose_cb *data = cb_data;
> -	enum object_type type = OBJ_NONE;
> -	size_t size;
> -	void *contents = NULL;
> -	int eaten;
> -	struct object_info oi = OBJECT_INFO_INIT;
> -	struct object_id real_oid = *null_oid(data->repo->hash_algo);
> -	int err = 0;
> -
> -	oi.sizep = &size;
> -	oi.typep = &type;
> -
> -	if (read_loose_object(data->repo, path, oid, &real_oid, &contents, &oi) < 0) {
> -		if (contents && !oideq(&real_oid, oid))
> -			err = error(_("%s: hash-path mismatch, found at: %s"),
> -				    oid_to_hex(&real_oid), path);
> -		else
> -			err = error(_("%s: object corrupt or missing: %s"),
> -				    oid_to_hex(oid), path);
> -	}
> -	if (err < 0) {
> -		errors_found |= ERROR_OBJECT;
> -		free(contents);
> -		return 0; /* keep checking other objects */
> -	}
> -
> -	if (!contents && type != OBJ_BLOB)
> -		BUG("read_loose_object streamed a non-blob");
> -
> -	if (fsck_obj_buffer(oid, type, size, contents, &eaten, data->repo))
> -		errors_found |= ERROR_OBJECT;
> -
> -	if (!eaten)
> -		free(contents);
> -	return 0; /* keep checking other objects, even if we saw an error */
> -}
> -
> -static int fsck_cruft(const char *basename, const char *path,
> -		      void *data UNUSED)
> -{
> -	if (!starts_with(basename, "tmp_obj_"))
> -		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
> -	return 0;
> -}
> -
> -static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *data)
> -{
> -	struct for_each_loose_cb *cb_data = data;
> -	struct progress *progress = cb_data->progress;
> -	display_progress(progress, nr + 1);
> -	return 0;
> -}
> -
> -static void fsck_source(struct repository *repo, struct odb_source *source)
> -{
> -	struct progress *progress = NULL;
> -	struct for_each_loose_cb cb_data = {
> -		.repo = source->odb->repo,
> -		.progress = progress,
> -	};
> -
> -	if (verbose)
> -		fprintf_ln(stderr, _("Checking object directory"));
> -
> -	if (show_progress)
> -		progress = start_progress(repo,
> -					  _("Checking object directories"), 256);
> -
> -	for_each_loose_file_in_source(source, fsck_loose,
> -				      fsck_cruft, fsck_subdir, &cb_data);
> -	display_progress(progress, 256);
> -	stop_progress(&progress);
> -}
> -
>  static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const char *index_path)
>  {
>  	int i;
> @@ -978,8 +895,10 @@ int cmd_fsck(int argc,
>  
>  	if (show_progress == -1)
>  		show_progress = isatty(2);
> -	if (verbose)
> +	if (verbose) {
>  		show_progress = 0;
> +		odb_fsck_opts.flags |= ODB_FSCK_VERBOSE;
> +	}
>  	if (show_progress)
>  		odb_fsck_opts.flags |= ODB_FSCK_PROGRESS;
>  
> @@ -1012,10 +931,6 @@ int cmd_fsck(int argc,
>  		odb_for_each_object(repo->objects, NULL,
>  				    mark_object_for_connectivity, repo, 0);
>  	} else {
> -		for (source = repo->objects->sources; source; source = source->next)
> -			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
> -				fsck_source(repo, source);
> -
>  		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
>  			errors_found |= ERROR_OBJECT;
>  
> diff --git a/odb.h b/odb.h
> index 0bf6c8d7d2..b87f281cbd 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -218,6 +218,9 @@ enum odb_fsck_flags {
>  
>  	/* Display a progress meter, if sensible. */
>  	ODB_FSCK_PROGRESS = (1 << 1),
> +
> +	/* Be extra verbose when checking the database. */
> +	ODB_FSCK_VERBOSE = (1 << 2),

Shall we document this one is mutually exclusive with ODB_FSCK_PROGRESS?

>  };
>  
>  /* Options that shall be passed to `odb_fsck()`. */
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index f68d3c4d6c..efef9ca61f 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -12,6 +12,7 @@
>  #include "odb/streaming.h"
>  #include "oidtree.h"
>  #include "path.h"
> +#include "progress.h"
>  #include "repository.h"
>  #include "strbuf.h"
>  #include "tempfile.h"
> @@ -1031,12 +1032,96 @@ static void odb_source_loose_free(struct odb_source *source)
>  	free(loose);
>  }
>  
> -static int odb_source_loose_fsck(struct odb_source *source UNUSED,
> -				 struct odb_fsck_options *opts UNUSED)
> +struct fsck_loose_data {
> +	struct odb_source_loose *source;
> +	struct odb_fsck_options *opts;
> +	struct progress *progress;
> +	bool error_found;
> +};
> +
> +static int fsck_loose(const struct object_id *oid, const char *path,
> +		      void *cb_data)
>  {
> +	struct fsck_loose_data *data = cb_data;
> +	enum object_type type = OBJ_NONE;
> +	size_t size;
> +	void *contents = NULL;
> +	int eaten = 0;
> +	struct object_info oi = OBJECT_INFO_INIT;
> +	struct object_id real_oid = *null_oid(data->source->base.odb->repo->hash_algo);
> +	int err = 0;
> +
> +	oi.sizep = &size;
> +	oi.typep = &type;
> +
> +	if (read_loose_object(data->source->base.odb->repo,
> +			      path, oid, &real_oid, &contents, &oi) < 0) {
> +		if (contents && !oideq(&real_oid, oid))
> +			err = error(_("%s: hash-path mismatch, found at: %s"),
> +				    oid_to_hex(&real_oid), path);
> +		else
> +			err = error(_("%s: object corrupt or missing: %s"),
> +				    oid_to_hex(oid), path);
> +	}
> +	if (err < 0)
> +		goto out;
> +
> +	if (!contents && type != OBJ_BLOB)
> +		BUG("read_loose_object streamed a non-blob");
> +
> +	if (data->opts->object_cb(oid, type, size, contents, &eaten,
> +				  data->opts->object_payload)) {

Should we guard data->opts->object_cb being NULL?

> +		err = -1;
> +		goto out;
> +	}
> +
> +out:
> +	if (err)
> +		data->error_found = true;
> +	if (!eaten)
> +		free(contents);
> +	return 0; /* keep checking other objects, even if we saw an error */

Okay, this function is called by for_each_loose_file_in_source() so we
need to return 0 to keep that loop going. I'm not a huge fan of the
error_found construct, but that isn't changed, so it's fine.

> +}
> +
> +static int fsck_cruft(const char *basename, const char *path,
> +		      void *data UNUSED)
> +{
> +	if (!starts_with(basename, "tmp_obj_"))
> +		fprintf_ln(stderr, _("bad sha1 file: %s"), path);
> +	return 0;
> +}
> +
> +static int fsck_subdir(unsigned int nr, const char *path UNUSED, void *cb_data)
> +{
> +	struct fsck_loose_data *data = cb_data;
> +	display_progress(data->progress, nr + 1);
>  	return 0;
>  }
>  
> +static int odb_source_loose_fsck(struct odb_source *source,
> +				 struct odb_fsck_options *opts)
> +{
> +	struct odb_source_loose *loose = odb_source_loose_downcast(source);
> +	struct fsck_loose_data data = {
> +		.source = loose,
> +		.opts = opts,
> +	};
> +
> +	if (opts->flags & ODB_FSCK_VERBOSE)
> +		fprintf_ln(stderr, _("Checking object directory"));
> +
> +	if (opts->flags & ODB_FSCK_PROGRESS)
> +		data.progress = start_progress(source->odb->repo,
> +					       _("Checking object directories"), 256);
> +
> +	for_each_loose_file_in_source(source, fsck_loose,
> +				      fsck_cruft, fsck_subdir, &data);
> +	display_progress(data.progress, 256);
> +	stop_progress(&data.progress);
> +
> +	return data.error_found ? -1 : 0;
> +}
> +
>  struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
>  					      const char *path,
>  					      bool local)
>
> -- 
> 2.55.0.979.g7e5102b832.dirty
>
>

-- 
Laters,
Toon
