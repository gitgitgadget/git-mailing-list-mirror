Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23D413D8F
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421639; cv=none; b=F5aWsLplzuSryJlJEDBNgs3c3+Ilg71ku6IJkxXS8VH/S0kFQHkHRmJGruCAGODbk2OQQlPwQwiwHGVkz8iL4TWBs4d6WVX4C2iuhvQxOKAZKgV3XbO5mPrwXzlCZ1RuxvDwp/XsCSR0P9siFQBw0NKQcCJFkjfeLFGlVbJRGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421639; c=relaxed/simple;
	bh=yjQDAAQNDRw+fzfBMhClGt7joiNAcw8BX+YkLvVjD6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEsRF055v6cuI/amXO5v7e1DxA9qG6bwX/xxrpL4b5OZSV9wrQr6+7IJr7KDt/iUnk0w2keZd2ez2Xxc03wfJMgLNrs/GB4GBXYAufGgzzx/Uqw9/5eMrNcLM2vba3sqEkCfONxQZIkhr2yVkl5SrLRNtm54pS99qC9885OjJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WdMkl3M6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WdMkl3M6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785421632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EIhnX9jUXnZhSlJSobjKy0VYn66kj8YakP1Xn8eoSDY=;
	b=WdMkl3M6weTHOdNWoMzMvc0XN+lm9DvCiAg/yG8Xtw52M26w7S1aPF3Rf6kQUNCY2irAAg
	IWgUKVauzCRxLNw0nJJRmL4If/JHwQrLwW1idCcDimwItkDuwHdUUAOkKSrdPnpEzzfBsS
	5W/fiG1HG9F34uPFOGSnGrdSnqf563M=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: detangle loading of loose object maps
In-Reply-To: <amkOb3rvWFUpnT28@denethor>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
 <amkOb3rvWFUpnT28@denethor>
Date: Thu, 30 Jul 2026 16:27:05 +0200
Message-ID: <87pl04d03q.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> On 26/07/24 05:48AM, Patrick Steinhardt wrote:
>> When a repository is configured to use a compatibility hash function
>> then we load the loose object map when we initialize the repository.
>> This object map provides the mappings between the canonical object hash
>> and the compatibility object hash.
>> 
>> Loading the object map happens in `repo_set_compat_hash_algo()`, which
>> calls `repo_read_loose_object_map()` in case the compatibility object
>> hash is non-zero. This setup sequence has two major downsides:
>> 
>>   - We assume that the primary object database is the "files" object
>>     database so that we can extract its "loose" backend. This stops
>>     working with pluggable object databases.
>
> So IIUC, does this mean that `repo_set_compat_hash_algo()` is directly
> reaching into the loose object source to load the compatibility object
> map? I suppose it should be the responsibility of the respective ODB
> backend to handle object compatibility.
>
>>   - We require the object database to already have been initialized when
>>     configuring the object database. This means that we must intermix
>>     configuration of the repository and initialization of its
>>     sub-structures in a weird way.
>
> If there any reason we need to eagerly load compatibility object
> mappings?
>
>> Refactor the logic so that we instead load the loose object map via the
>> "loose" backend, which fixes both of the above issues.
>
> Sounds reasonable.
>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  loose.c            | 11 +++++------
>>  loose.h            |  1 +
>>  odb/source-loose.c |  2 ++
>>  repository.c       |  2 --
>>  setup.c            |  5 +++--
>>  5 files changed, 11 insertions(+), 10 deletions(-)
>> 
>> diff --git a/loose.c b/loose.c
>> index 9dad75373b..a3b2dcedc2 100644
>> --- a/loose.c
>> +++ b/loose.c
>> @@ -61,7 +61,7 @@ static int insert_loose_map(struct odb_source_loose *loose,
>>  	return inserted;
>>  }
>>  
>> -static int load_one_loose_object_map(struct odb_source_loose *loose)
>> +int loose_object_map_load(struct odb_source_loose *loose)
>>  {
>>  	struct repository *repo = loose->base.odb->repo;
>>  	struct strbuf buf = STRBUF_INIT;
>> @@ -69,6 +69,9 @@ static int load_one_loose_object_map(struct odb_source_loose *loose)
>>  	FILE *fp;
>>  	int ret = -1;
>>  
>> +	if (!should_use_loose_object_map(repo))
>> +		return 0;
>
> Previously the above condition has asserted in
> `repo_read_loose_object_map()` which calls `loose_object_map_load()` for
> each source. Do we expect each source to potentially answer differently
> though?

I've been wondering about this as well. The reason for this change is to
also have this guard when odb_source_loose_new(), in source-loose.c (see
further down in the patch), calls this function too.

>> +
>>  	if (!loose->map)
>>  		loose_object_map_init(&loose->map);
>>  	if (!loose->cache) {
>> @@ -112,14 +115,10 @@ int repo_read_loose_object_map(struct repository *repo)
>>  {
>>  	struct odb_source *source;
>>  
>> -	if (!should_use_loose_object_map(repo))
>> -		return 0;
>> -
>>  	odb_prepare_alternates(repo->objects);
>> -
>>  	for (source = repo->objects->sources; source; source = source->next) {
>>  		struct odb_source_files *files = odb_source_files_downcast(source);
>> -		if (load_one_loose_object_map(files->loose) < 0)
>> +		if (loose_object_map_load(files->loose) < 0)
>>  			return -1;
>>  	}
>>  
>> diff --git a/loose.h b/loose.h
>> index 6c9b3f4571..ed663ac550 100644
>> --- a/loose.h
>> +++ b/loose.h
>> @@ -13,6 +13,7 @@ struct loose_object_map {
>>  
>>  void loose_object_map_init(struct loose_object_map **map);
>>  void loose_object_map_clear(struct loose_object_map **map);
>> +int loose_object_map_load(struct odb_source_loose *loose);
>>  int repo_loose_object_map_oid(struct repository *repo,
>>  			      const struct object_id *src,
>>  			      const struct git_hash_algo *dest_algo,
>> diff --git a/odb/source-loose.c b/odb/source-loose.c
>> index 3f7d04a56e..812ca1c138 100644
>> --- a/odb/source-loose.c
>> +++ b/odb/source-loose.c
>> @@ -727,5 +727,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
>>  	if (!is_absolute_path(loose->base.path))
>>  		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
>>  
>> +	loose_object_map_load(loose);
>
> Now we load the loose object map for the specific source when its
> created.

Here.

-- 
Cheers,
Toon
