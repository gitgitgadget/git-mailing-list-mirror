Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E336215F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869334; cv=none; b=ZAlrxH/a4gFj0VpTZ1Tld55Pbm9ZirSUxBOLd04ES0Yan3H2D/xi4MCrWXc2yt+c3oduwSlSQO+oJEBO7XchsU6I0BYKXfX77AtI6N+MHrHZ7VSTuTALY953XzvQCrLpv5GYAHlimp80n12R2Ajxed4EE0p7M8NXWt+DEIo43S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869334; c=relaxed/simple;
	bh=RQrIF0DJUOzg2Wnr5g9tWXXFg2CWDT51pcX+wdBJs3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M3eHr2qLSDZdm7nO0npZwzIlJietYPCpHFUrldeeKWoWRkJDmWvlEJyy8bSt1EZJmA/2b5g2F+fHVLYKyf+W2CDQeo1S+5dXw7JBUSu3YwRRDbGZ36Pc4FrKwzEFRj8YyIFjChpsnUqPWNtgy5qTitGigUF7W/7JPREgUBC11eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=FswzAm2T; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="FswzAm2T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785869328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL+EGp64yVpNINKkaM6H6cFXD/ITuNdNW6N/MfRUnE0=;
	b=FswzAm2Tg6PHSBm2gBaMD/967vFKx99MOG6aA2Fl+t45IZtMpVtBcx1fzdOneH2gVq5xnH
	PQ5Fn+zSPrrjFeYchLLf/0DUdj4mYUjBI66+l+FpBF6B7jvFol13RcjR5D3rIiNWrRiizo
	k2ThsFZFf7I0U31/X6Y/Z/+XUDCYIcA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 3/5] setup: defer object database creation
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-3-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
 <20260804-pks-odb-create-on-disk-v2-3-ddf8b59bd207@pks.im>
Date: Tue, 04 Aug 2026 20:48:42 +0200
Message-ID: <87bjbh67sl.fsf@emacs.iotcl.com>
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
>  setup.c | 35 +++++++++++++++++++++++++++--------
>  setup.h |  9 +++++++++
>  2 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 825572f5f1..a7b1b9eaef 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1760,6 +1760,13 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
>  	return result;
>  }
>  
> +static void get_object_directories(char **object_directory,
> +				   char **alternate_object_directories)
> +{
> +	*object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> +	*alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> +}

Would it make sense to wrap these in a APPLY_REPOSITORY_FORMAT_HONOR_ENV
guard?

I mean, below we call this function *only* when flags has that bit set.
But the return values of that function are used at the bottom of
apply_repository_format(), that's a bit awkard.

So can I suggest the following patch instead? That would remove the
weird double pointer passing around, which feels a bit unneeded.


--- >8 ---
Subject: [PATCH] setup: defer object database creation

In a subsequent commit we'll make the creation of the on-disk data
structures of an object database pluggable. This will lead to an
in-between state where we have already configured the repository's
object database, but it's not usable yet until we eventually call
`create_object_directory()`.

Defer the object database creation so that we handle both steps in the
same function.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 setup.c | 35 +++++++++++++++++++++++++++--------
 setup.h |  9 +++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 825572f5f1..2e9bc92481 100644
--- a/setup.c
+++ b/setup.c
@@ -1760,13 +1760,28 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+static void setup_objects_odb_new(struct repository *repo,
+				  bool from_env)
+{
+	char *object_directory = NULL, *alternate_object_directories = NULL;
+
+	if (from_env) {
+		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
+
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
+
+	free(alternate_object_directories);
+	free(object_directory);
+}
+
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	char *object_directory = NULL, *alternate_object_directories = NULL;
-
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
@@ -1779,8 +1794,6 @@ int apply_repository_format(struct repository *repo,
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		const char *shallow_file;
 
-		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
-		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 		if (shallow_file)
 			set_alternate_shallow_file(repo, shallow_file);
@@ -1803,11 +1816,11 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
+	if (flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)
+		return 0;
+
+	setup_objects_odb_new(repo, flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 
-	free(alternate_object_directories);
-	free(object_directory);
 	return 0;
 }
 
@@ -2654,11 +2667,13 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_directory(struct repository *repo)
+static void create_object_database(struct repository *repo)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
+	setup_objects_odb_new(repo, true);
+
 	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
@@ -2867,9 +2882,10 @@ int init_db(struct repository *repo,
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
-	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+	if (apply_repository_format(repo, &repo_fmt,
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
+				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
 		die("%s", err.buf);
-	startup_info->have_repository = 1;
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2885,7 +2901,9 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
diff --git a/setup.h b/setup.h
index 654f10e059..e55d647b70 100644
--- a/setup.h
+++ b/setup.h
@@ -241,6 +241,15 @@ enum apply_repository_format_flags {
 	 * relate to the object database.
 	 */
 	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+
+	/*
+	 * Usually, the object database is created after the repository format
+	 * was applied. This step is skipped if this flag is set, which leaves
+	 * us with a partially-working repository.
+	 *
+	 * This is useful when initializing a new repository.
+	 */
+	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
 };
 
 /*
-- 
2.55.0.629.g250fe7f194

