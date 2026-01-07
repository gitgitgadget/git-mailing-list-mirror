Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E1315D47
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791501; cv=none; b=JTbHQRmfVJjPLckfyzDonxNehOaWSH3U9/0fTytQxlN8gGEH+eZerhvjeQV9FdRlF0fTGj8fUk8vLtZEgZtpaGAeZOnqCkcEu80sUzD1oDCWHaNZk8vEscQIlcvf5qay8xBASm0V3fsS/1OZYkCMVsnxb1yRt4CKeisnt37zvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791501; c=relaxed/simple;
	bh=zn+s3P76r2w/eLCA2BOaNMg5RWIqSLt3092vBQk7Gu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8LUBb6TaJ9d8V3ViGvgx9R+T/SmW2vOmXp0XlEUgj9Q7hEFa0Pdg2O+Z38l+2PsWA2PKALLsocEukmUlg/3WvqToD7up0QRLr4wPPPuGQsCwyB8C8S0UnKpXz1itq1aAFQMFZehsSfRZOHBZSklWEDSIWzUuoGW9pjHGT6vy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ce8a/4+q; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ce8a/4+q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767791494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8hDy1OoyexcUP/4hE4hJmO1/gBQr+UeA0nE1vFbp4A=;
	b=Ce8a/4+q9ZOf6qw0QbZaFz0GJqie+qxq4CpfgpdNb3/HlK3tiSvsNCqIPFRnLXbEZmcgqx
	91T0JII2S9fglnDI9CHBl7eOdVVSV2pUnFt9m43hFjC8qzE8BMZFoEuG6d1Bvstp1NOpTU
	VWMMVH8HlKo/7aVGh6te7J8T19zZda4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 05/10] packfile: move packfile store into object source
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-5-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-5-62849007ce21@pks.im>
Date: Wed, 07 Jan 2026 14:11:17 +0100
Message-ID: <87bjj5pnyi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The packfile store is a member of `struct object_database`, which means
> that we have a single store per database. This doesn't really make much
> sense though: each source connected to the database has its own set of
> packfiles, so there is a conceptual mismatch here. This hasn't really
> caused much of a problem in the past, but with the advent of pluggable
> object databases this is becoming more of a problem because some of the
> sources may not even use packfiles in the first place.
>
> Move the packfile store down by one level from the object database into
> the object database source. This ensures that each source now has its
> own packfile store, and we can eventually start to abstract it away
> entirely so that the caller doesn't even know what kind of store it
> uses.
>
> Note that we only need to adjust a relatively small number of callers,
> way less than one might expect. This is because most callers are using
> `repo_for_each_pack()`, which handles enumeration of all packfiles that
> exist in the repository. So for now, none of these callers need to be
> adapted. The remaining callers that iterate through the packfiles
> directly and that need adjustment are those that are a bit more tangled
> with packfiles. These will be adjusted over time.
>
> Note that this patch only moves the packfile store, and there is still a
> bunch of functions that seemingly operate on a packfile store but that
> end up iterating over all sources. These will be adjusted in subsequent
> commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fast-import.c  |  37 ++++++++------
>  builtin/grep.c         |   6 ++-
>  builtin/index-pack.c   |   2 +-
>  builtin/pack-objects.c |  96 +++++++++++++++++++------------------
>  http.c                 |   2 +-
>  midx.c                 |   5 +-
>  odb.c                  |  36 +++++++-------
>  odb.h                  |   6 +--
>  odb/streaming.c        |   9 ++--
>  packfile.c             | 127 +++++++++++++++++++++++++++++++------------------
>  packfile.h             |  62 ++++++++++++++++++++----
>  11 files changed, 243 insertions(+), 145 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 7849005ccb..b8a7757cfd 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -900,7 +900,7 @@ static void end_packfile(void)
>  		idx_name = keep_pack(create_index());
>  
>  		/* Register the packfile with core git's machinery. */
> -		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
> +		new_p = packfile_store_load_pack(pack_data->repo->objects->sources->packfiles,
>  						 idx_name, 1);
>  		if (!new_p)
>  			die(_("core Git rejected index %s"), idx_name);
> @@ -955,7 +955,7 @@ static int store_object(
>  	struct object_id *oidout,
>  	uintmax_t mark)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
> +	struct odb_source *source;
>  	void *out, *delta;
>  	struct object_entry *e;
>  	unsigned char hdr[96];
> @@ -979,7 +979,11 @@ static int store_object(
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[type]++;
>  		return 1;
> -	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
> +	}
> +
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
> +			continue;
>  		e->type = type;
>  		e->pack_id = MAX_PACK_ID;
>  		e->idx.offset = 1; /* just not zero! */
> @@ -1096,10 +1100,10 @@ static void truncate_pack(struct hashfile_checkpoint *checkpoint)
>  
>  static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  {
> -	struct packfile_store *packs = the_repository->objects->packfiles;
>  	size_t in_sz = 64 * 1024, out_sz = 64 * 1024;
>  	unsigned char *in_buf = xmalloc(in_sz);
>  	unsigned char *out_buf = xmalloc(out_sz);
> +	struct odb_source *source;
>  	struct object_entry *e;
>  	struct object_id oid;
>  	unsigned long hdrlen;
> @@ -1179,24 +1183,29 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>  	if (e->idx.offset) {
>  		duplicate_count_by_type[OBJ_BLOB]++;
>  		truncate_pack(&checkpoint);
> +		goto out;
> +	}
>  
> -	} else if (packfile_list_find_oid(packfile_store_get_packs(packs), &oid)) {
> +	for (source = the_repository->objects->sources; source; source = source->next) {
> +		if (!packfile_list_find_oid(packfile_store_get_packs(source->packfiles), &oid))
> +			continue;
>  		e->type = OBJ_BLOB;
>  		e->pack_id = MAX_PACK_ID;
>  		e->idx.offset = 1; /* just not zero! */
>  		duplicate_count_by_type[OBJ_BLOB]++;
>  		truncate_pack(&checkpoint);
> -
> -	} else {
> -		e->depth = 0;
> -		e->type = OBJ_BLOB;
> -		e->pack_id = pack_id;
> -		e->idx.offset = offset;
> -		e->idx.crc32 = crc32_end(pack_file);
> -		object_count++;
> -		object_count_by_type[OBJ_BLOB]++;
> +		goto out;
>  	}
>  
> +	e->depth = 0;
> +	e->type = OBJ_BLOB;
> +	e->pack_id = pack_id;
> +	e->idx.offset = offset;
> +	e->idx.crc32 = crc32_end(pack_file);
> +	object_count++;
> +	object_count_by_type[OBJ_BLOB]++;
> +
> +out:
>  	free(in_buf);
>  	free(out_buf);
>  }
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 53cccf2d25..4855b871dd 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1213,8 +1213,12 @@ int cmd_grep(int argc,
>  		 */
>  		if (recurse_submodules)
>  			repo_read_gitmodules(the_repository, 1);
> +		/*
> +		 * Note: `packfile_store_prepare()` prepares stores from all
> +		 * sources. This will be fixed in a subsequent commit.

I assume you mean the opposite. But no problem since this will be
addressed in a later commit.

-- 
Cheers,
Toon
