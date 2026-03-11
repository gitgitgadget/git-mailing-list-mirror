Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C671A6817
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237221; cv=none; b=qVjFadr9enmsIqrHEKEgmsHIF88no+77apSJ9MO/yetG4RMJEYXdN3G+omEJ/fklJzwAfmLWegL08db7qYfmxhqVFqcmxDDWqxRTXaA90ra6cDwkKh4mLP7lseycHpP7Ye18lh/mumxzytBbGSiEJYatQPDowZF3RaTng7TSSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237221; c=relaxed/simple;
	bh=qYfmyY/TUG+a5aoEAVKs1oAmSvOT+lpCeszdDmSDVgs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2pa/78ap0dq+C/Qse8Xu0o5a6CZvzs7amt1B/EtWGnZWcaO0gdc5OjCXj5xvUb/Gh79m8PFgH86z3NaDDvdI9A4LVlj0Ayfhqc57k7DjPfbRmmqI2i1MpWBw2w8dXxlgmsugAPE3vGqpAkVzOQALEN55O0/5ZOsy5AtKXaHO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=sgk1yPZs; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="sgk1yPZs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773237211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qvnaQA6zGZ8+UWpropWOqgLjqUtvlBxn1EydfUBxMAo=;
	b=sgk1yPZsPqKvF2oULs8iEVE5to+TmpJszCIAW1uiZD0+eikjYtB+X7m0rdtXXo/nGXLXPR
	GEUOE3qRiUgPVNNJNrRZ3GSFzkoJCtD1vE+vnYb14B51thRTorQx9g+bDCIXLvoLVb1nTp
	mcadC6NW4DtGgsEEi+P7YQlCEVoQhHg=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] object-file: generalize counting objects
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-4-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-4-109e07d425f4@pks.im>
Date: Wed, 11 Mar 2026 14:53:20 +0100
Message-ID: <87pl5albfz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Generalize the function introduced in the preceding commit to not only
> be able to approximate the number of loose objects, but to also provide
> an accurate count. The behaviour can be toggled via a new flag.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c  |  5 +++--
>  object-file.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
>  object-file.h |  5 +++--
>  odb.h         |  9 +++++++++
>  4 files changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index a08c7554cb..3a64d28da8 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -474,8 +474,9 @@ static int too_many_loose_objects(int limit)
>  	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
>  	unsigned long loose_count;
>  
> -	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
> -						      &loose_count) < 0)
> +	if (odb_source_loose_count_objects(the_repository->objects->sources,
> +					   ODB_COUNT_OBJECTS_APPROXIMATE,
> +					   &loose_count) < 0)
>  		return 0;
>  
>  	return loose_count > auto_threshold;
> diff --git a/object-file.c b/object-file.c
> index da67e3c9ff..d35cec201f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1868,40 +1868,56 @@ int odb_source_loose_for_each_object(struct odb_source *source,
>  					     NULL, NULL, &data);
>  }
>  
> -int odb_source_loose_approximate_object_count(struct odb_source *source,
> -					      unsigned long *out)
> +static int count_loose_object(const struct object_id *oid UNUSED,
> +			      struct object_info *oi UNUSED,
> +			      void *payload)
> +{
> +	unsigned long *count = payload;
> +	(*count)++;
> +	return 0;
> +}
> +
> +int odb_source_loose_count_objects(struct odb_source *source,
> +				   enum odb_count_objects_flags flags,
> +				   unsigned long *out)
>  {
>  	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
> -	unsigned long count = 0;
> -	struct dirent *ent;
>  	char *path = NULL;
>  	DIR *dir = NULL;
>  	int ret;
>  
> -	path = xstrfmt("%s/17", source->path);
> +	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
> +		unsigned long count = 0;
> +		struct dirent *ent;
>  
> -	dir = opendir(path);
> -	if (!dir) {
> -		if (errno == ENOENT) {
> -			*out = 0;
> -			ret = 0;
> +		path = xstrfmt("%s/17", source->path);
> +
> +		dir = opendir(path);
> +		if (!dir) {
> +			if (errno == ENOENT) {
> +				*out = 0;
> +				ret = 0;
> +				goto out;
> +			}
> +
> +			ret = error_errno("cannot open object shard '%s'", path);
>  			goto out;
>  		}
>  
> -		ret = error_errno("cannot open object shard '%s'", path);
> -		goto out;
> -	}
> +		while ((ent = readdir(dir)) != NULL) {
> +			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> +			    ent->d_name[hexsz] != '\0')
> +				continue;
> +			count++;
> +		}
>  
> -	while ((ent = readdir(dir)) != NULL) {
> -		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> -		    ent->d_name[hexsz] != '\0')
> -			continue;
> -		count++;
> +		*out = count * 256;
> +		ret = 0;
> +	} else {
> +		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
> +						       out, 0);

Isn't `*out` uninitialized here? Should we add `*out = 0;` before this
line?

>  	}
>  
> -	*out = count * 256;
> -	ret = 0;
> -
>  out:
>  	if (dir)
>  		closedir(dir);
> diff --git a/object-file.h b/object-file.h
> index b870ea9fa8..f8d8805a18 100644
> --- a/object-file.h
> +++ b/object-file.h
> @@ -149,8 +149,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
>   *
>   * Returns 0 on success, a negative error code otherwise.
>   */
> -int odb_source_loose_approximate_object_count(struct odb_source *source,
> -					      unsigned long *out);
> +int odb_source_loose_count_objects(struct odb_source *source,
> +				   enum odb_count_objects_flags flags,
> +				   unsigned long *out);
>  
>  /**
>   * format_object_header() is a thin wrapper around s xsnprintf() that
> diff --git a/odb.h b/odb.h
> index 7a583e3873..e6057477f6 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -500,6 +500,15 @@ int odb_for_each_object(struct object_database *odb,
>  			void *cb_data,
>  			unsigned flags);
>  
> +enum odb_count_objects_flags {
> +	/*
> +	 * Instead of providing an accurate count, allow the number of objects
> +	 * to be approximated. Details of how this approximation works are
> +	 * subject to the specific source's implementation.
> +	 */
> +	ODB_COUNT_OBJECTS_APPROXIMATE = (1 << 0),
> +};
> +
>  enum {
>  	/*
>  	 * By default, `odb_write_object()` does not actually write anything
>
> -- 
> 2.53.0.880.g73c4285caa.dirty
>
>

-- 
Cheers,
Toon
