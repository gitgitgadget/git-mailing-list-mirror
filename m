Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEE380FD2
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475799; cv=none; b=eFKFe+U3kbvX8ChlmJce1HGzZ2F7HUDNs7a0feSmZTc2+yxABTcrOCW10Oc6LgndRN4Q49jl+hhYzBXLYaIcGHs6R/rtbguwqBLtIEc4FevVsFMfKuzXPK77I51pMZaYjtQuzQ6xMMmA86RvQOiW6Ff32z1dG6Rf36GN8LivRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475799; c=relaxed/simple;
	bh=9jAoRrVurFpr7FBgRynyVEbgPe98c2AErToemFMyuT0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqlAZ4p1GVa+kONTGHnBFsXLMPhGPh/tPhKhmlqEQyZhX8TuR+yDQ8/QDu231Jvvi3ROdqqeEz3mCoREO/SNfj2sHuY87R/2MbJoE/af6vH5x5DJ7OhkvFuJIf2x+ysT1TFwxdaNCUcvCtIPAMwIjhuvuzPD7cqIuYmfo5CV6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=H1QDku4E; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="H1QDku4E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782475791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5SJTi2okCXmm8tsQ+9eIQuFwuxqSkgbkjrwyWXtGNxI=;
	b=H1QDku4Enq9LNBxW/dMv7uQj46EUWMT7ASDu6i+Vd+bnzabppQLshya0Cd0q2j5cHyloNa
	gl2ULa8JAZUqhPtf0pLdTXpXaLkRDsy7vk//Qa3H+69QuG2rZo7Tf6uXRljPWXuxkcqCmi
	MmUiVrLRjFbDbXNgIMwdLlTei11F6jk=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] odb: introduce `odb_prepare()`
In-Reply-To: <20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
Date: Fri, 26 Jun 2026 14:09:47 +0200
Message-ID: <87o6gx4i5w.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Introduce `odb_prepare()` as a simple wrapper to prepare alternates and
> then prepare each individual source. Adapt git-grep(1) to use it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/grep.c |  9 ++-------
>  odb.c          | 18 ++++++++++++------
>  odb.h          |  8 ++++++--
>  3 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 7361bf071e..a7252d56a1 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1356,13 +1356,8 @@ int cmd_grep(int argc,
>  		if (recurse_submodules)
>  			repo_read_gitmodules(the_repository, 1);
>  
> -		if (startup_info->have_repository) {
> -			struct odb_source *source;
> -
> -			odb_prepare_alternates(the_repository->objects);
> -			for (source = the_repository->objects->sources; source; source = source->next)
> -				odb_source_prepare(source, 0);
> -		}
> +		if (startup_info->have_repository)
> +			odb_prepare(the_repository->objects, 0);
>  
>  		start_threads(&opt);
>  	} else {
> diff --git a/odb.c b/odb.c
> index 7b45390e12..11414c49a8 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1070,7 +1070,7 @@ void odb_free(struct object_database *o)
>  	free(o);
>  }
>  
> -void odb_reprepare(struct object_database *o)
> +void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
>  {
>  	struct odb_source *source;
>  
> @@ -1082,13 +1082,19 @@ void odb_reprepare(struct object_database *o)
>  	 * the linked list, so existing odbs will continue to exist for
>  	 * the lifetime of the process.
>  	 */
> -	o->loaded_alternates = 0;
> -	odb_prepare_alternates(o);
> +	if (flags & ODB_PREPARE_FLUSH_CACHES) {
> +		o->loaded_alternates = 0;
> +		o->object_count_valid = 0;
> +	}
>  
> +	odb_prepare_alternates(o);
>  	for (source = o->sources; source; source = source->next)
> -		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
> -
> -	o->object_count_valid = 0;
> +		odb_source_prepare(source, flags);
>  
>  	obj_read_unlock();
>  }
> +
> +void odb_reprepare(struct object_database *o)
> +{
> +	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
> +}
> diff --git a/odb.h b/odb.h
> index c14c9030e4..b1c0f3767b 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -133,9 +133,13 @@ enum odb_prepare_flags {
>  };
>  
>  /*
> - * Clear caches, reload alternates and then reload object sources so that new
> - * objects may become accessible.
> + * Prepare the object database for use. Calling this function is generally not
> + * needed, but can be useful in case the caller wants to pre-open individual
> + * sources.
>   */
> +void odb_prepare(struct object_database *o, enum odb_prepare_flags flags);
> +
> +/* Equivalent to `odb_prepare(o, ODB_PREPARE_FLUSH_CACHES)`. */
>  void odb_reprepare(struct object_database *o);

According to my grep results are there 17 callsites for odb_reprepare(),
then I agree it makes sense to create this wrapper.

-- 
Cheers,
Toon
