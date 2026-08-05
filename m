Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B073481236
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945464; cv=none; b=egF5ITYbWhr9xOqGahRIUXSC9O5CFF9PQ/wk9gjEHkYLO0RAJdVRgEiHbXETJgFAbTY+RHP4dFIOrx1T5deB0YPRzhVtq3UbZ1FtOaSx1LebLT9MLNpD5ShkC9mbeAzCf8TQHs6fSL+Mt14XG6bsigSMt9muC3xe/+cRjb287UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945464; c=relaxed/simple;
	bh=agmwmEIxDPy0ahMSJOndBnJyxs/m+HbAR35be/bmtZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMWvSkqUWUjL9lOVhRUPkLZ2Pu6AG9OEb2p8Eud4w9jguP3nmIYuo/Np+QjWPENZQLbF0TVqF8TiPTxaC5kX8CrWRMrujduh7eM8zXebLUTUbaYNHer6Aof/pZgMMpFEBjknucUdAtnWG5d0wNViGQhmmX7CNfu8csEAutT5Bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=BmADu69u; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="BmADu69u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785945458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaLUaFRycDiSfU1aRaWtCUelRQpeLlbUEtcNgpCPpkY=;
	b=BmADu69uLSmxNConWgWx42kB9NgQbxl3j/aI9RqrramL8Sp8O6A4WtYgR3a6hA5MsSJoYV
	T9UlKxmgIAR1G9ZUXSAPWWDYDecdZOCtEW7LORrvlOugpDI2rr/GJ72dY1nQ9qeVUxkerv
	vVx1duBZ08zl39WwHzImmQ/Fqkmlv4A=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 6/6] odb: make creation of on-disk structures pluggable
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-6-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
 <20260805-pks-odb-create-on-disk-v3-6-c0ee3ac5141f@pks.im>
Date: Wed, 05 Aug 2026 17:57:30 +0200
Message-ID: <87zez04l1x.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new "files" object database source we have to create a
> couple of directories. These directories are of course specific to this
> particular backend, and a different backend may require a setup that is
> completely different.
>
> Make the creation of on-disk structures pluggable to accommodate for
> this.
>
> Note that there is one exception though: the "objects" directory must
> exist in a repository regardless of which backend is in use. If it
> doesn't exist then the repository is not treated as a Git repository at
> all. Consequently, we create this directory regardless of the backend.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 19 +++++++++++++++++++
>  odb/source.h       | 23 +++++++++++++++++++++++
>  setup.c            | 34 ++++++++++++++++++----------------
>  3 files changed, 60 insertions(+), 16 deletions(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 4138758511..0db6e681fe 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -9,6 +9,7 @@
>  #include "odb/source-files.h"
>  #include "odb/source-loose.h"
>  #include "packfile.h"
> +#include "path.h"
>  #include "strbuf.h"
>  #include "write-or-die.h"
>  
> @@ -41,6 +42,23 @@ static void odb_source_files_close(struct odb_source *source)
>  	odb_source_close(&files->packed->base);
>  }
>  
> +static int odb_source_files_create_on_disk(struct odb_source *source)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +
> +	safe_create_dir(source->odb->repo, source->path, 1);
> +
> +	strbuf_addf(&path, "%s/pack", source->path);
> +	safe_create_dir(source->odb->repo, path.buf, 1);
> +
> +	strbuf_reset(&path);
> +	strbuf_addf(&path, "%s/info", source->path);
> +	safe_create_dir(source->odb->repo, path.buf, 1);
> +
> +	strbuf_release(&path);
> +	return 0;
> +}
> +
>  static void odb_source_files_prepare(struct odb_source *source,
>  				     enum odb_prepare_flags flags)
>  {
> @@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  
>  	files->base.free = odb_source_files_free;
>  	files->base.close = odb_source_files_close;
> +	files->base.create_on_disk = odb_source_files_create_on_disk;
>  	files->base.prepare = odb_source_files_prepare;
>  	files->base.read_object_info = odb_source_files_read_object_info;
>  	files->base.read_object_stream = odb_source_files_read_object_stream;
> diff --git a/odb/source.h b/odb/source.h
> index ab16d152f4..4abc418bdd 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -89,6 +89,18 @@ struct odb_source {
>  	 */
>  	void (*close)(struct odb_source *source);
>  
> +	/*
> +	 * This callback is expected to create on-disk data structures that are
> +	 * required for this source to operate.
> +	 *
> +	 * The callback is expected to return 0 on success, a negative error
> +	 * code otherwise.
> +	 *
> +	 * This callback may be NULL in case the source does not need any
> +	 * on-disk setup.
> +	 */
> +	int (*create_on_disk)(struct odb_source *source);
> +
>  	/*
>  	 * This callback is expected to prepare the source so that it becomes
>  	 * ready for use. It optionally clears underlying caches of the object
> @@ -316,6 +328,17 @@ static inline void odb_source_close(struct odb_source *source)
>  	source->close(source);
>  }
>  
> +/*
> + * Create on-disk data structures that are required for this source to operate
> + * correctly. Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int odb_source_create_on_disk(struct odb_source *source)
> +{
> +	if (!source->create_on_disk)
> +		return 0;
> +	return source->create_on_disk(source);
> +}
> +
>  /*
>   * Prepare the object database source and clear any caches. Depending on the
>   * backend used this may have the effect that concurrently-written objects
> diff --git a/setup.c b/setup.c
> index d85171f3b6..af02cd965c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2654,25 +2654,27 @@ static int create_default_files(struct repository *repo,
>  
>  static void create_object_database(struct repository *repo)
>  {
> -	struct strbuf path = STRBUF_INIT;
> -	size_t baselen;
> +	/*
> +	 * Create the "objects" directory in the common directory. This is done
> +	 * so that the repository can be discovered regardless of the backend
> +	 * used.
> +	 *
> +	 * Note that we only do this in case the object directory wasn't
> +	 * overwritten via an environment variable. If it _is_ being overridden
> +	 * then we skip this step, as the repository won't be discoverable
> +	 * anyway without the environment variable.
> +	 */
> +	if (!getenv(DB_ENVIRONMENT)) {

It's a bit sad that [PATCH 3/6] removed the use of DB_ENVIRONMENT from
this file, and now we're re-adding it. Although, I don't see how else we
can do this.

> +		struct strbuf objects_dir = STRBUF_INIT;
> +		repo_common_path_append(repo, &objects_dir, "objects");
> +		safe_create_dir(repo, objects_dir.buf, 1);
> +		strbuf_release(&objects_dir);
> +	}
>  
>  	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
>  
> -	strbuf_addstr(&path, repo_get_object_directory(repo));
> -	baselen = path.len;
> -
> -	safe_create_dir(repo, path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/pack");
> -	safe_create_dir(repo, path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/info");
> -	safe_create_dir(repo, path.buf, 1);
> -
> -	strbuf_release(&path);
> +	if (odb_source_create_on_disk(repo->objects->sources) < 0)
> +		die("failed creating object database");

This error isn't translatable.

>  }
>  
>  static void separate_git_dir(const char *git_dir, const char *git_link)
>
> -- 
> 2.55.0.679.g6767b8d81c.dirty
>

-- 
Cheers,
Toon
