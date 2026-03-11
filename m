Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA313DF018
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243068; cv=none; b=rvF2MWb3v483NMNsF+dKhnSCqnMOkXFNcxr/Zabuowph1PilXxTqy6fs8VdsLhR28Vym3fsjBtR1KR32NlkIaRC0KqmBW6IH79i6DYLuygB9UT+sGR/zSOCoQW2vQgpCVcKDF47Htrt3q5x3DxGyRY3SJ8TLMD3KYg/9TVzP7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243068; c=relaxed/simple;
	bh=5Powp0sTAdWbDrh5e3iNiCGmUpklNNIeYaobtMeXT2o=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vr1GVl78n7++KCy28iUAzKPh0fsdYNlc1V9TnIqt5h6W5DjO0n66XUo7VRkPK66QO8BvXDA5tPyuEE8bTa0TuOJQfQT/3xGaCvjrH2D1pjsz6h9B32jE0u/9NxCYiBjmUMITQf0ty97Txxpf9TL6DL8qOqPEgEEsEFdGq/pc4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2AGQ8XrS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2AGQ8XrS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773243062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ICmsYBxdWp/pcdIuBAxmZDLOE9E26Kw6BJzmgK7W7Eg=;
	b=2AGQ8XrSPNp2Sl9lhmwCcES9lhadf8TiIZtmPCoEEKBotuPUmUI3knXWAY6GF7R7sFLzmI
	eROlfrmtpm1CoTMGWujWhDJF2iMZBxZT2/xlL770ntgeLLiUu+x0C8zJMv5B2qHwTTDG4K
	tR1/sEFrtuvmT18JKZCZCe5efYuclh4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb: introduce generic object counting
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-6-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-6-109e07d425f4@pks.im>
Date: Wed, 11 Mar 2026 16:30:50 +0100
Message-ID: <87fr66l6xh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Similar to the preceding commit, introduce counting of objects on the
> object database level, replacing the logic that we have in
> `repo_approximate_object_count()`.
>
> Note that the function knows to cache the object count. It's unclear
> whether this cache is really required as we shouldn't have that many
> cases where we count objects repeatedly. But to be on the safe side the
> caching mechanism is retained, with the only excepting being that we
> also have to use the passed flags as caching key.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c   |  6 +++++-
>  commit-graph.c |  3 ++-
>  object-name.c  |  6 +++++-
>  odb.c          | 37 ++++++++++++++++++++++++++++++++++++-
>  odb.h          | 17 +++++++++++++++--
>  packfile.c     | 27 ---------------------------
>  packfile.h     |  6 ------
>  7 files changed, 63 insertions(+), 39 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3a64d28da8..cb9ca89a97 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -574,9 +574,13 @@ static uint64_t total_ram(void)
>  static uint64_t estimate_repack_memory(struct gc_config *cfg,
>  				       struct packed_git *pack)
>  {
> -	unsigned long nr_objects = repo_approximate_object_count(the_repository);
> +	unsigned long nr_objects;
>  	size_t os_cache, heap;
>  
> +	if (odb_count_objects(the_repository->objects,
> +			      ODB_COUNT_OBJECTS_APPROXIMATE, &nr_objects) < 0)
> +		return 0;
> +
>  	if (!pack || !nr_objects)
>  		return 0;
>  
> diff --git a/commit-graph.c b/commit-graph.c
> index f8e24145a5..c030003330 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2607,7 +2607,8 @@ int write_commit_graph(struct odb_source *source,
>  			replace = ctx.opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
>  	}
>  
> -	ctx.approx_nr_objects = repo_approximate_object_count(r);
> +	if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &ctx.approx_nr_objects) < 0)
> +		ctx.approx_nr_objects = 0;
>  
>  	if (ctx.append && g) {
>  		for (i = 0; i < g->num_commits; i++) {
> diff --git a/object-name.c b/object-name.c
> index 7b14c3bf9b..e5adec4c9d 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -837,7 +837,11 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>  	const unsigned hexsz = algo->hexsz;
>  
>  	if (len < 0) {
> -		unsigned long count = repo_approximate_object_count(r);
> +		unsigned long count;
> +
> +		if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &count) < 0)
> +			count = 0;
> +
>  		/*
>  		 * Add one because the MSB only tells us the highest bit set,
>  		 * not including the value of all the _other_ bits (so "15"
> diff --git a/odb.c b/odb.c
> index 84a31084d3..350e23f3c0 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -917,6 +917,41 @@ int odb_for_each_object(struct object_database *odb,
>  	return 0;
>  }
>  
> +int odb_count_objects(struct object_database *odb,
> +		      enum odb_count_objects_flags flags,
> +		      unsigned long *out)
> +{
> +	struct odb_source *source;
> +	unsigned long count = 0;
> +	int ret;
> +
> +	if (odb->object_count_valid && odb->object_count_flags == flags) {
> +		*out = odb->object_count;
> +		return 0;
> +	}
> +
> +	odb_prepare_alternates(odb);
> +	for (source = odb->sources; source; source = source->next) {
> +		unsigned long c;
> +
> +		ret = odb_source_count_objects(source, flags, &c);
> +		if (ret < 0)
> +			goto out;
> +
> +		count += c;
> +	}
> +
> +	odb->object_count = count;
> +	odb->object_count_valid = 1;
> +	odb->object_count_flags = flags;
> +
> +	*out = count;
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}
> +
>  void odb_assert_oid_type(struct object_database *odb,
>  			 const struct object_id *oid, enum object_type expect)
>  {
> @@ -1030,7 +1065,7 @@ void odb_reprepare(struct object_database *o)
>  	for (source = o->sources; source; source = source->next)
>  		odb_source_reprepare(source);
>  
> -	o->approximate_object_count_valid = 0;
> +	o->object_count_valid = 0;
>  
>  	obj_read_unlock();
>  }
> diff --git a/odb.h b/odb.h
> index e6057477f6..7b004f1cf4 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -112,8 +112,9 @@ struct object_database {
>  	 * These two fields are not meant for direct access. Use
>  	 * repo_approximate_object_count() instead.

This comment needs updating now.

Otherwise no comments here.

-- 
Cheers,
Toon
