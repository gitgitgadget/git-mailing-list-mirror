Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034934BA5A
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730421; cv=none; b=skUpVaDYbBzJDZcNl1MLXtz551BDhE/29MXWEfCh6tR8iFnv2eFkq0TNVDxQ3/FVJry0p1+tVMAuvRT1r2Yw6baDzoElLN36CcKeUVGK8d4kfVNSFi05Jqm80NhmVq0bVC8qY7bQHEsch0CBxcDMD5F20kd5ocrLx2V+BfWo19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730421; c=relaxed/simple;
	bh=pyfib9kLTy7THYvvy776+vVffF15qYMMuuPRQoRPork=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r23DoF/VYxIuTv6hBii+r1cHqlOzH+NPa9GPAR2waDPj8F32S+jZNcJ5u6rdkmbeqnT0B6BG6px6M5QuVeYkCEYMaFdbTN8uGck9u79r+K+0tSmlk0TTaGfg32Hmr6H0n4RLbu7I3zmMM+N30XYtQSdclflFN/l9YulNqwz5ZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YaZiVHLx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YaZiVHLx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784730411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o77px+rIYbQLmtTUWvK8NFOx+hnnXh2Fng780dZFaB4=;
	b=YaZiVHLx65Lhwpb8H2JuhRIX0RnsQ+tT+COdcEYGj5DZPP3eO63rcnR0DoBsnHhrHEMaKn
	/xnQf8mUqFE8pNR0fMm4+rgZF3y8G1JR2CD7xk41Dh7ULSGXiOf/8Fe4VBkTjlIo47MHXE
	GkFVL0lEltz3UknvIkYPWyiTv7gOerY=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 9/9] object-file: move logic to write loose objects
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-9-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
 <20260717-pks-odb-move-loose-object-writing-v1-9-46446a3cb5b7@pks.im>
Date: Wed, 22 Jul 2026 16:26:41 +0200
Message-ID: <87fr1bp0bi.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The logic to write loose objects is split up across "object-file.c" and
> "odb/source-loose.c". This split is somewhat weird, but it is the result
> of two things:
>
>   - `force_object_loose()` used to reach into internals of how exactly
>     we write objects.
>
>   - The logic of writing objects is intertwined with potentially
>     starting a transaction.
>
> We have refactored `force_object_loose()` over preceding commits to work
> via generic interfaces now, so this reason doesn't exist anymore. But
> the second reason still does, as our management of "files" transactions
> and their ad-hoc creation is still very messy. This area definitely
> requires further work, and that work is indeed ongoing.
>
> That being said, we can already move the writing logic into the "loose"
> backend rather easily. All we have to do is to expose two functions that
> relate to the transactions.

I'm a bit on the fence that should have gone in a separte commit, but
it's fine.

> Expose these two functions and move the writing logic into the "loose"
> backend accordingly so that it becomes more self-contained. Note that
> this requires us to drop a reference to `the_repository` in favor of
> using the source's repository in `start_loose_object_common()`.

Yay! Thanks for calling that out, it standed out in the zebra diff.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c      | 360 +----------------------------------------------------
>  object-file.h      |  22 +---
>  odb/source-loose.c | 354 +++++++++++++++++++++++++++++++++++++++++++++++++++-

That's a pretty large diff, but luckily the zebra diff helps a lot.

> -int write_loose_object(struct odb_source_loose *loose,
> -		       const struct object_id *oid, char *hdr,
> -		       int hdrlen, const void *buf, unsigned long len,
> -		       const time_t *mtime, unsigned flags)

This line is not colored being moved because it was made static, which
makes sense.

> diff --git a/object-file.h b/object-file.h
> index 31781a9c53..805f2cfa28 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -24,20 +24,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
>  struct object_info;
>  struct odb_source;
>  
> -/*
> - * Write the given stream into the loose object source. The only difference
> - * from the generic implementation of this function is that we don't perform an
> - * object existence check here.
> - *
> - * TODO: We should stop exposing this function altogether and move it into
> - * "odb/source-loose.c". This requires a couple of refactorings though to make
> - * `force_object_loose()` generic and is thus postponed to a later point in
> - * time.
> - */

This was added by you on 2026-06-01, so thanks for addressing this.

> @@ -611,12 +849,120 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
>  						size_t len,
>  						struct object_id *oid)
>  {
> +	struct odb_source_loose *loose = odb_source_loose_downcast(source);
> +	const struct git_hash_algo *compat = loose->base.odb->repo->compat_hash_algo;
> +	struct object_id compat_oid;
> +	int fd, ret, err = 0, flush = 0;
> +	unsigned char compressed[4096];
> +	git_zstream stream;
> +	struct git_hash_ctx c, compat_c;
> +	struct strbuf tmp_file = STRBUF_INIT;
> +	struct strbuf filename = STRBUF_INIT;
> +	unsigned char buf[8192];
> +	int dirlen;
> +	char hdr[MAX_HEADER_LEN];
> +	int hdrlen;
> +
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		odb_transaction_files_prepare(loose->base.odb->transaction);
> +
> +	/* Since oid is not determined, save tmp file to odb path. */
> +	strbuf_addf(&filename, "%s/", loose->base.path);
> +	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> +
>  	/*
> -	 * TODO: the implementation should be moved here, see the comment on
> -	 * the called function in "object-file.h".

So this is what you did, as suggested, by yourself.

> +	 * Common steps for write_loose_object and stream_loose_object to
> +	 * start writing loose objects:
> +	 *
> +	 *  - Create tmpfile for the loose object.
> +	 *  - Setup zlib stream for compression.
> +	 *  - Start to feed header to zlib stream.
>  	 */
> -	struct odb_source_loose *loose = odb_source_loose_downcast(source);
> -	return odb_source_loose_write_stream(loose, in_stream, len, oid);

This line is marked as removed in the zebra diff, but that's because the
code is being inlined into this odb_source_loose_write_object_stream()
function.

All good.


-- 
Cheers,
Toon
