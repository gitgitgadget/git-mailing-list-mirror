Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990D37DE87
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125270; cv=none; b=QWlw+iAuEUthq6vbK/y/bvXmVgomj4QhkY6yB8fZh0jif4bTj1n2gJyjALY6CDMdhrmFWYOwOBYkOtOu96MCdzxf2NX7RPvynrgKhnMv3j3MagVlD/CVN91H5TBdYNOuHuHK4E39YVmZtRE+cqeSmznRizwwc3hT4hTEy4eIfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125270; c=relaxed/simple;
	bh=2UgjHwdGuH3/08A3Rj0cfdTWxc6qnUD7rJ14p1QAVKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sT6ZPQZB+bFF8Lk8eXvLIbjy4r8fh5UKBvT0Swt1v1S9kMCFvlHIzJnsVkEJnciNlWi8lshmuorLLnGxczl5XLG5HZdfy2sGnqlJ3LDCqlB7sIHNWq7q/bkQWfZgqow1cvZErpZb0mcEq2xsR3bji/rUK6Fr9pwlWrpNi2Ozi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rVAoBcWs; arc=none smtp.client-ip=91.218.175.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rVAoBcWs"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2UgjHwdGuH3/08A3Rj0cfdTWxc6qnUD7rJ14p1QAVKA=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789125262; v=1; x=1789730062;
 b=rVAoBcWsF9VvWGmzp9Tamrmm/pttkaldbFQMobCiVWv1QJXIxfKEP6qT9jDphUCcQO16HxUb
 hkfrmAxe6vnFI7c2iYpclTOcaHRZT14yPQ+AQt7ETcrsvv3QacwWw5aZDP11WyfqgkaY02/VaGL
 3cfwOHBQDna4VgwxSRltSm9A=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f785882fbeaf30b9;
	Fri, 11 Sep 2026 11:14:12 +0000
X-Mizu-Trace-ID: f785882fbeaf30b9
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/10] odb: provide infrastructure for pluggable fsck
 checks
In-Reply-To: <20260831-pks-odb-source-fsck-v2-5-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-5-f9b16ef4957b@pks.im>
Date: Fri, 11 Sep 2026 13:14:03 +0200
Message-ID: <87a4ponipw.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The on-disk consistency checks in git-fsck(1) are conceptually
> backend-specific: while connectivity checks and object-level parsing
> checks are generic, verifying the physical integrity of packfiles and
> loose objects is meaningful only to backends that use these formats:
> Having these checks live in "builtin/fsck.c" violates that layering,
> because it forces the command to reach directly into format-specific
> internals.
>
> Provide new infrastructure to make these format-specific checks
> pluggable and implement stubs for the different source types we already
> have. In subsequent commits we'll move functionality over piece by
> piece.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c        | 16 +++++++++++-----
>  odb.c                 |  9 +++++++++
>  odb.h                 | 23 +++++++++++++++++++++++
>  odb/source-files.c    | 13 +++++++++++++
>  odb/source-inmemory.c |  8 ++++++++
>  odb/source-loose.c    |  7 +++++++
>  odb/source-packed.c   |  8 ++++++++
>  odb/source.h          | 21 +++++++++++++++++++++
>  8 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 3f6056535f..adbe192e56 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -965,7 +965,9 @@ int cmd_fsck(int argc,
>  	     const char *prefix,
>  	     struct repository *repo)
>  {
> -	int check_full = 1;
> +	struct odb_fsck_options odb_fsck_opts = {
> +		.flags = ODB_FSCK_FULL,
> +	};
>  	int keep_cache_objects = 0;
>  	int name_objects = 0;
>  	int check_references = 1;
> @@ -977,7 +979,8 @@ int cmd_fsck(int argc,
>  		OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
>  		OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
>  		OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
> -		OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
> +		OPT_BIT(0, "full", &odb_fsck_opts.flags,
> +			N_("also consider packs and alternate objects"), ODB_FSCK_FULL),
>  		OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
>  		OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
>  		OPT_BOOL(0, "lost-found", &write_lost_and_found,
> @@ -1018,7 +1021,7 @@ int cmd_fsck(int argc,
>  		show_progress = 0;
>  
>  	if (write_lost_and_found) {
> -		check_full = 1;
> +		odb_fsck_opts.flags |= ODB_FSCK_FULL;
>  		include_reflogs = 0;
>  	}
>  
> @@ -1047,10 +1050,13 @@ int cmd_fsck(int argc,
>  				    mark_object_for_connectivity, repo, 0);
>  	} else {
>  		for (source = repo->objects->sources; source; source = source->next)
> -			if (check_full || source->local)
> +			if ((odb_fsck_opts.flags & ODB_FSCK_FULL) || source->local)
>  				fsck_source(repo, source);
>  
> -		if (check_full) {
> +		if (odb_fsck(repo->objects, &odb_fsck_opts) < 0)
> +			errors_found |= ERROR_OBJECT;
> +
> +		if (odb_fsck_opts.flags & ODB_FSCK_FULL) {
>  			struct packed_git *p;
>  			uint32_t total = 0, count = 0;
>  			struct progress *progress = NULL;
> diff --git a/odb.c b/odb.c
> index 1fe20808eb..766043b685 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -1177,3 +1177,12 @@ void odb_reprepare(struct object_database *o)
>  {
>  	odb_prepare(o, ODB_PREPARE_FLUSH_CACHES);
>  }
> +
> +int odb_fsck(struct object_database *odb, struct odb_fsck_options *options)
> +{
> +	int ret = 0;
> +	for (struct odb_source *source = odb->sources; source; source = source->next)
> +		if ((options->flags & ODB_FSCK_FULL) || source->local)
> +			ret |= odb_source_fsck(source, options);

Shouldn't it be the responsibility of the source to determine whether it
should be included due to the `--full` flag? In the future there might
be other types of sources which have possibly a different meaning for
"local". So would it make sense to have them check for ODB_FSCK_FULL
themselves.

-- 
Laters,
Toon
