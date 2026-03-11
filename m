Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6622B5AC
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233253; cv=none; b=bcf4aYVzrOawNvC9/vMSZkx1E6zS1Tmdw4zvm3jzkRAXkG5xk2vW6xBLL7dObpDG9D/z2daPU9Eq3fixPp3u+EF6HT1SI2SLDco8/BGfMB7cj/kclkH4S74iVzoBZKl8563KM238tHK7lTzV+OB0Z1pyEwpajXLfVneXKORSR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233253; c=relaxed/simple;
	bh=CBoT9C2y1aV2fXZlyqhzpOyPa/LDLJgTOJ0KbfajDeI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QdT/nZ7mO69Ch7MyLafN9jYvZSQLSwZSywaxD1hNLtYcY+HRIQpGZs4Hg5QxzpWz8B2WbhzoaLmdDu0FdsYhTazJJ9dFN0Rv1a7+ztlQ4uGeQxdHLO+tTr7Rsisht966QjeVcNOZtZBNRLHfQUi6OowVIDswn0Sj7fpDPCEOiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2GXCG/Gf; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2GXCG/Gf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773233250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9pO2fCjcuALyDyCIgtiY16/WS2LSEUDFEF6Hh5QWFI=;
	b=2GXCG/GfP26PD0XfleRUHaGLC1igtuFwVOeTXq1v2G1B/HtBViY+K0FxSSClaRAyUX9lVB
	tvLQlz3Is85aechQ7629efsNOKh30Q8RXMx45Ti3YDg+nMHwCD9INa1Qa6GvSRuA3EYGHO
	3rWZvePOdyjQuL/CSsg0oHoYjPe7etA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] object-file: extract logic to approximate object count
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
Date: Wed, 11 Mar 2026 13:47:13 +0100
Message-ID: <87v7f2lei6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In "builtin/gc.c" we have some logic that checks whether we need to
> repack objects. This is done by counting the number of objects that we
> have and checking whether it exceeds a certain threshold. We don't
> really need an accurate object count though, which is why we only
> open a single object diretcroy shard and then extrapolate from there.

s/diretcroy/directory/

>
> Extract this logic into a new function that is owned by the loose object
> database source. This is done to prepare for a subsequent change, where
> we'll introduce object counting on the object database source level.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c  | 37 +++++++++----------------------------
>  object-file.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  object-file.h | 13 +++++++++++++
>  3 files changed, 63 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index fb329c2cff..a08c7554cb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -467,37 +467,18 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
>  static int too_many_loose_objects(int limit)
>  {
>  	/*
> -	 * Quickly check if a "gc" is needed, by estimating how
> -	 * many loose objects there are.  Because SHA-1 is evenly
> -	 * distributed, we can check only one and get a reasonable
> -	 * estimate.
> +	 * This is weird, but stems from legacy behaviour: the GC auto
> +	 * threshold was always essentially interpreted as if it was rounded up
> +	 * to the next multiple 256 of, so we retain this behaviour for now.
>  	 */
> -	DIR *dir;
> -	struct dirent *ent;
> -	int auto_threshold;
> -	int num_loose = 0;
> -	int needed = 0;
> -	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
> -	char *path;
> -
> -	path = repo_git_path(the_repository, "objects/17");
> -	dir = opendir(path);
> -	free(path);
> -	if (!dir)
> +	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
> +	unsigned long loose_count;
> +
> +	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
> +						      &loose_count) < 0)
>  		return 0;
>  
> -	auto_threshold = DIV_ROUND_UP(limit, 256);
> -	while ((ent = readdir(dir)) != NULL) {
> -		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
> -		    ent->d_name[hexsz_loose] != '\0')
> -			continue;
> -		if (++num_loose > auto_threshold) {
> -			needed = 1;
> -			break;
> -		}
> -	}
> -	closedir(dir);
> -	return needed;
> +	return loose_count > auto_threshold;
>  }
>  
>  static struct packed_git *find_base_packs(struct string_list *packs,
> diff --git a/object-file.c b/object-file.c
> index a3ff7f586c..da67e3c9ff 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1868,6 +1868,47 @@ int odb_source_loose_for_each_object(struct odb_source *source,
>  					     NULL, NULL, &data);
>  }
>  
> +int odb_source_loose_approximate_object_count(struct odb_source *source,
> +					      unsigned long *out)
> +{
> +	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
> +	unsigned long count = 0;
> +	struct dirent *ent;
> +	char *path = NULL;
> +	DIR *dir = NULL;
> +	int ret;
> +
> +	path = xstrfmt("%s/17", source->path);
> +
> +	dir = opendir(path);
> +	if (!dir) {
> +		if (errno == ENOENT) {
> +			*out = 0;
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = error_errno("cannot open object shard '%s'", path);
> +		goto out;
> +	}
> +
> +	while ((ent = readdir(dir)) != NULL) {
> +		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> +		    ent->d_name[hexsz] != '\0')
> +			continue;
> +		count++;
> +	}
> +
> +	*out = count * 256;

This makes the number way larger, but I don't think we need to worry
getting anywhere near ULONG_MAX, because I would expect to have Git
coming to a grind way before that happens (not to mention filesystems
would get unhappy about it too).

-- 
Cheers,
Toon
