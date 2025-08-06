Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF623F424
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498438; cv=none; b=DTGHJsSorX8XP/YUPtFXix7l6O2tKiliMIKRpxdf1JjTot4NOAYw+D6NI3l+1AVwAeuq9Yu1v6+0kgbjZHjs1eeRo67Y//NypU+ddvnlzXyvyaPF38iOlkkNJgmG+OFgyVz5u9p95K1X1OTegL5CBvnWkCkfbPK4Ml+7BTb74EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498438; c=relaxed/simple;
	bh=ecmapRE8Ae9ccHxSh3j/GtzACsOhqJ9D+kW3tJA4/5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLBFys6a4D6cDGL9kjsWFYYFNyZ/XFaixPKXc9M+em8IveoHsdJO0NKsxLhZFtJlO1FE0Bup55UwaIszKn5MdN1SZMGLzoaJ8UGB4JwcADfO5+PfdUSy+zQANq2EWrG40ygX4nXamwrM0tspiFtZhVtmxJy0Dr1GtncMwBm+iQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fIFPkhxU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fIFPkhxU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754498433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0L5oahAeW44wZlVWOGLGBuRY6NNUN+w9ZiRmVt+O6FA=;
	b=fIFPkhxUkTiqzfLT40aDEtvSN3m8x2aGt7PtQX4w0pHMFN7Rh3MTMPvuFZpNC2YcXsRm7F
	BR2Shtp0foOqt+BKS0RllQk0BBe+ogThz8uoUzISd1J5SChtfc+xCHpyUfnqCPwuPvdPMb
	+xoa87CIDXJ4jNqxOqjaoHFHyyuCG0E=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] odb: return newly created in-memory sources
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
Date: Wed, 06 Aug 2025 18:40:23 +0200
Message-ID: <87ectotnd4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Callers have no trivial way to obtain the newly created object database
> source when adding it to the in-memory list of alternates. While not yet
> needed anywhere, a subsequent commit will want to obtain that pointer.
>
> Refactor the function to return the source to make it easily accessible.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 37 +++++++++++++++++++++----------------
>  odb.h |  4 ++--
>  2 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 61104b7cb8..7793816f81 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -139,23 +139,22 @@ static void read_info_alternates(struct object_database *odb,
>  				 const char *relative_base,
>  				 int depth);
>  
> -static int link_alt_odb_entry(struct object_database *odb,
> -			      const struct strbuf *entry,
> -			      const char *relative_base,
> -			      int depth,
> -			      const char *normalized_objdir)
> +static struct odb_source *link_alt_odb_entry(struct object_database *odb,
> +					     const char *entry,
> +					     const char *relative_base,
> +					     int depth,
> +					     const char *normalized_objdir)
>  {
> -	struct odb_source *alternate;
> +	struct odb_source *alternate = NULL;
>  	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
> -	int ret = -1;
>  
> -	if (!is_absolute_path(entry->buf) && relative_base) {
> +	if (!is_absolute_path(entry) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
>  		strbuf_addch(&pathbuf, '/');
>  	}
> -	strbuf_addbuf(&pathbuf, entry);
> +	strbuf_addstr(&pathbuf, entry);
>  
>  	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
>  		error(_("unable to normalize alternate object path: %s"),
> @@ -189,11 +188,11 @@ static int link_alt_odb_entry(struct object_database *odb,
>  
>  	/* recursively add alternates */
>  	read_info_alternates(odb, alternate->path, depth + 1);
> -	ret = 0;
> +
>   error:
>  	strbuf_release(&tmp);
>  	strbuf_release(&pathbuf);
> -	return ret;
> +	return alternate;
>  }
>  
>  static const char *parse_alt_odb_entry(const char *string,
> @@ -246,7 +245,7 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
>  		if (!entry.len)
>  			continue;
> -		link_alt_odb_entry(odb, &entry,
> +		link_alt_odb_entry(odb, entry.buf,
>  				   relative_base, depth, objdirbuf.buf);
>  	}
>  	strbuf_release(&entry);
> @@ -316,17 +315,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
>  	free(alts);
>  }
>  
> -void odb_add_to_alternates_memory(struct object_database *odb,
> -				  const char *reference)
> +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> +						const char *reference)
>  {
> +	struct odb_source *alternate;
> +	char *objdir;
> +
>  	/*
>  	 * Make sure alternates are initialized, or else our entry may be
>  	 * overwritten when they are.
>  	 */
>  	odb_prepare_alternates(odb);
>  
> -	link_alt_odb_entries(odb, reference,
> -			     '\n', NULL, 0);
> +	objdir = real_pathdup(odb->sources->path, 1);
> +	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);

If I understand correctly, instead of using real_pathdup() we could
instead call:

    alternate = link_alt_odb_entry(odb, reference, "/", 0, odb->sources->path);

I did not test this, but it would avoid duplicating the path here. I'm
not sure though whether it's easier to read.

> +
> +	free(objdir);
> +	return alternate;
>  }
>  
>  struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
> diff --git a/odb.h b/odb.h
> index 387b117c87..ac7ee05188 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -265,8 +265,8 @@ void odb_add_to_alternates_file(struct object_database *odb,
>   * recursive alternates it points to), but do not modify the on-disk alternates
>   * file.
>   */
> -void odb_add_to_alternates_memory(struct object_database *odb,
> -				  const char *dir);
> +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> +						const char *dir);
>  
>  /*
>   * Read an object from the database. Returns the object data and assigns object
>
> -- 
> 2.50.1.619.g074bbf1d35.dirty
>
>

-- 
Cheers,
Toon
