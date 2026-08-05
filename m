Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AD37E5F1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939720; cv=none; b=r0yOs9jL45JjIlj03fbOAyHiN4Ir4hRFFW5GZw5lUII49NqdZQCYmKXzAyQC0IRffEwVjhWHjdKeK/PQm1TF5KOt4IRZ/7VorICW16eVuwg27Da2j+Jsmk0UtyP8PutW6Gqwo5JKd/I5Gc+uwLN/21HSxOFayO7S9IuvO2RGntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939720; c=relaxed/simple;
	bh=lt9DqqYPQLjpOH0MmxBkCiCG0I7IFCoqKqrPpU57WTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD7Rd0dNCTd0UAm1nhhaTBEkR2TmaKWzUlV3hjgTarTg11s7wGuoS9rTgL3X//96AJd3JsXGBUEv5DPsMOGlcGoaIHkgN53AJ81hF1V8cjWRw/QHtMmXb1SO5Qj8xA6OvFydP5nb5A7SAWHN+vd05oUIZugb+iV/uylnFPpIX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1wO81RQB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1wO81RQB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785939706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DhZVPrKPw/HS+F5aM/PjFtRNoT5CL2Oh3aI5xKa0DU=;
	b=1wO81RQBvOJUKFTZxfuLcN65FPVxl4Bimt7VqYvsYLeIAl93ltftVODVh4mhLvdTJOYv8m
	0Axa6KcpJN6YrQGWZ4A9HrWumkd4ehOhrB6GAI5GMOqFT2YaHkwNehZVZyaMzXcGWPTsbN
	zBwAwhsR5vXhLIiAnUF1XWeOG1Fkq0w=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 4/6] setup: defer object database creation
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-4-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
 <20260805-pks-odb-create-on-disk-v3-4-c0ee3ac5141f@pks.im>
Date: Wed, 05 Aug 2026 16:21:39 +0200
Message-ID: <8733ws6424.fsf@emacs.iotcl.com>
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
> Defer the object database creation so that we handle both steps in the
> same function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 24 +++++++++++++++---------
>  setup.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 5dfab3e79e..d85171f3b6 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
>  			    enum apply_repository_format_flags flags,
>  			    struct strbuf *err)
>  {
> -	enum odb_new_flags odb_new_flags = 0;
> -
>  	if (verify_repository_format(format, err) < 0)
>  		return -1;
>  
> @@ -1801,9 +1799,12 @@ int apply_repository_format(struct repository *repo,
>  	repo->repository_format_precious_objects =
>  		format->precious_objects;
>  
> -	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
> -		odb_new_flags |= ODB_NEW_HONOR_ENV;
> -	repo->objects = odb_new(repo, odb_new_flags);
> +	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)) {
> +		enum odb_new_flags odb_new_flags = 0;
> +		if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
> +			odb_new_flags |= ODB_NEW_HONOR_ENV;
> +		repo->objects = odb_new(repo, odb_new_flags);
> +	}
>  
>  	return 0;
>  }
> @@ -2651,11 +2652,13 @@ static int create_default_files(struct repository *repo,
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
> @@ -2864,9 +2867,10 @@ int init_db(struct repository *repo,
>  	 */
>  	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
>  	repository_format_configure(&repo_fmt, hash, ref_storage_format);
> -	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
> +	if (apply_repository_format(repo, &repo_fmt,
> +				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
> +				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
>  		die("%s", err.buf);
> -	startup_info->have_repository = 1;
>  
>  	/*
>  	 * Ensure `core.hidedotfiles` is processed. This must happen after we
> @@ -2882,7 +2886,9 @@ int init_db(struct repository *repo,
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
> diff --git a/setup.h b/setup.h
> index 654f10e059..e55d647b70 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -241,6 +241,15 @@ enum apply_repository_format_flags {
>  	 * relate to the object database.
>  	 */
>  	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
> +
> +	/*
> +	 * Usually, the object database is created after the repository format
> +	 * was applied. This step is skipped if this flag is set, which leaves
> +	 * us with a partially-working repository.
> +	 *
> +	 * This is useful when initializing a new repository.
> +	 */
> +	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
>  };
>  
>  /*
>
> -- 
> 2.55.0.679.g6767b8d81c.dirty
>

With [PATCH v3 3/6], Justin's objection[1] is stronger now:

> Naive question: would it be simpler to just require invoking `odb_new()`
> explicitly after `apply_repository_format()` in all cases? There doesn't
> appear to be too many callsites.

As a matter of fact, I've given this a try and see these changes on top
of this series below.

[1]: <amkXcmwzbBYsMgjc@denethor>

--- >8 ---

diff --git a/repository.c b/repository.c
index 6d633002b4..9eee74113c 100644
--- a/repository.c
+++ b/repository.c
@@ -295,6 +295,8 @@ int repo_init(struct repository *repo,
 		goto error;
 	}
 
+	repo->objects = odb_new(repo, 0);
+
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/setup.c b/setup.c
index af02cd965c..1106f38bb0 100644
--- a/setup.c
+++ b/setup.c
@@ -1799,13 +1799,6 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)) {
-		enum odb_new_flags odb_new_flags = 0;
-		if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
-			odb_new_flags |= ODB_NEW_HONOR_ENV;
-		repo->objects = odb_new(repo, odb_new_flags);
-	}
-
 	return 0;
 }
 
@@ -1889,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
+		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 		startup_info->have_repository = 1;
 
 		clear_repository_format(&fmt);
@@ -2092,6 +2086,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
 
+			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
+
 			clear_repository_format(&discovery.format);
 			strbuf_release(&err);
 		}
@@ -2870,8 +2866,7 @@ int init_db(struct repository *repo,
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt,
-				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
-				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 
 	/*
diff --git a/setup.h b/setup.h
index e55d647b70..654f10e059 100644
--- a/setup.h
+++ b/setup.h
@@ -241,15 +241,6 @@ enum apply_repository_format_flags {
 	 * relate to the object database.
 	 */
 	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
-
-	/*
-	 * Usually, the object database is created after the repository format
-	 * was applied. This step is skipped if this flag is set, which leaves
-	 * us with a partially-working repository.
-	 *
-	 * This is useful when initializing a new repository.
-	 */
-	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
 };
 
 /*


