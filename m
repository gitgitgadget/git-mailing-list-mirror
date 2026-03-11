Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA53D6462
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241434; cv=none; b=uuiLurKDI/bFBTmdMGTURVreyYtms/lNF24jdP2xIi0pyLdKQfJjwx+ONhQACGc15EOn31f3iDEBL8lzg43XSQE4mBE1pPYx+q3m387kE293ct+1ozVVVaTdvPp3cJD5YgtCDju737RjfCjCMQwlyv2CSHpW7dhHl3gfQkwDFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241434; c=relaxed/simple;
	bh=W2R18GIzsq0og9AbzJGp94xfbcGzKnIbKZv67GXfOps=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=svI4GT5gil00ivLCNdjRTRbiZCc6rMSy8O91nVcz76oWMAFX+oPKEkHwPygzt15rbYIr3s9gAM6P2iBSKx0J+7tXTtHORWUul1+YXTVd2hhoUIXwVGbTKkZAx4rhD9WxVMVNetCAn/vBvF03TJvuSXSNKTqvgq+PaPjAQkh2v1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=mpN2sBtk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="mpN2sBtk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773241426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfXFkIVOyKzZbivi91IiTQRp2l1CsUj8CMjdWv3H2a8=;
	b=mpN2sBtkCak/HvZHZt4z0m+bE5jXQ1rTHI4D8CKQ5WQKOJc0c9NnmysfoCsvVNRXJt49B8
	qDN9w4crRCSvLgG56iX9jvgeHUOvDYqaAAmemt39xhRodb+XSXeN5kPSRs3yfazqWSiX4r
	P8Zpd6f7IUnKkpqry6jDIEhiDgRhGZ0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb/source: introduce generic object counting
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
Date: Wed, 11 Mar 2026 16:03:36 +0100
Message-ID: <87ldfyl86v.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Introduce generic object counting on the object database source level
> with a new backend-specific callback function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 30 ++++++++++++++++++++++++++++++
>  odb/source.h       | 27 +++++++++++++++++++++++++++
>  packfile.c         |  4 ++--
>  packfile.h         |  1 +
>  4 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 14cb9adeca..c08d8993e3 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -93,6 +93,35 @@ static int odb_source_files_for_each_object(struct odb_source *source,
>  	return 0;
>  }
>  
> +static int odb_source_files_count_objects(struct odb_source *source,
> +					  enum odb_count_objects_flags flags,
> +					  unsigned long *out)
> +{
> +	struct odb_source_files *files = odb_source_files_downcast(source);

I didn't read the other series this depends on, but good to see
odb_source_files_downcast() BUGs when the source isn't a 'files'
source.

> +	unsigned long count;
> +	int ret;
> +
> +	ret = packfile_store_count_objects(files->packed, flags, &count);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
> +		unsigned long loose_count;
> +
> +		ret = odb_source_loose_count_objects(source, flags, &loose_count);
> +		if (ret < 0)
> +			goto out;
> +
> +		count += loose_count;
> +	}
> +
> +	*out = count;
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}
> +
>  static int odb_source_files_freshen_object(struct odb_source *source,
>  					   const struct object_id *oid)
>  {
> @@ -220,6 +249,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	files->base.read_object_info = odb_source_files_read_object_info;
>  	files->base.read_object_stream = odb_source_files_read_object_stream;
>  	files->base.for_each_object = odb_source_files_for_each_object;
> +	files->base.count_objects = odb_source_files_count_objects;
>  	files->base.freshen_object = odb_source_files_freshen_object;
>  	files->base.write_object = odb_source_files_write_object;
>  	files->base.write_object_stream = odb_source_files_write_object_stream;
> diff --git a/odb/source.h b/odb/source.h
> index a1fd9dd920..96c906e7a1 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -142,6 +142,21 @@ struct odb_source {
>  			       void *cb_data,
>  			       unsigned flags);
>  
> +	/*
> +	 * This callback is expected to count objects in the given object
> +	 * database source. The callback function does not have to guarantee
> +	 * that only unique objects are counted. The result shall be assigned
> +	 * to the `out` pointer.
> +	 *
> +	 * Accepts `enum odb_count_objects_flag` flags to alter the behaviour.
> +	 *
> +	 * The callback is expected to return 0 on success, or a negative error
> +	 * code otherwise.
> +	 */
> +	int (*count_objects)(struct odb_source *source,
> +			     enum odb_count_objects_flags flags,
> +			     unsigned long *out);
> +
>  	/*
>  	 * This callback is expected to freshen the given object so that its
>  	 * last access time is set to the current time. This is used to ensure
> @@ -333,6 +348,18 @@ static inline int odb_source_for_each_object(struct odb_source *source,
>  	return source->for_each_object(source, request, cb, cb_data, flags);
>  }
>  
> +/*
> + * Count the number of objects in the given object database source.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int odb_source_count_objects(struct odb_source *source,
> +					   enum odb_count_objects_flags flags,
> +					   unsigned long *out)
> +{
> +	return source->count_objects(source, flags, out);
> +}
> +
>  /*
>   * Freshen an object in the object database by updating its timestamp.
>   * Returns 1 in case the object has been freshened, 0 in case the object does
> diff --git a/packfile.c b/packfile.c
> index 1ee5dd3da3..8ee462303a 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1102,6 +1102,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
>  }
>  
>  int packfile_store_count_objects(struct packfile_store *store,
> +				 enum odb_count_objects_flags flags UNUSED,
>  				 unsigned long *out)
>  {
>  	struct packfile_list_entry *e;
> @@ -1146,10 +1147,9 @@ unsigned long repo_approximate_object_count(struct repository *r)
>  
>  		odb_prepare_alternates(r->objects);
>  		for (source = r->objects->sources; source; source = source->next) {
> -			struct odb_source_files *files = odb_source_files_downcast(source);
>  			unsigned long c;
>  
> -			if (!packfile_store_count_objects(files->packed, &c))
> +			if (!odb_source_count_objects(source, ODB_COUNT_OBJECTS_APPROXIMATE, &c))
>  				count += c;
>  		}
>  
> diff --git a/packfile.h b/packfile.h
> index 1da8c729cb..74b6bc58c5 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -275,6 +275,7 @@ enum kept_pack_type {
>   * Return 0 on success, a negative error code otherwise.
>   */
>  int packfile_store_count_objects(struct packfile_store *store,
> +				 enum odb_count_objects_flags flags,
>  				 unsigned long *out);
>  
>  /*
>
> -- 
> 2.53.0.880.g73c4285caa.dirty
>

Okay.

-- 
Cheers,
Toon
