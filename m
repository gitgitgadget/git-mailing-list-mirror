Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270E248F5A
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600895; cv=none; b=pIdCSZ8qvjz7ZyxKXicRljx8MJ1IpliCAdhOTEBK2CWRA0T1LT0dT6GBGJLxmdoneoGOmXvsQQ3BS/npXYNzbaSonfUV/YH3/MfNYrS0yJoJYHHfA3XisSvJP6aPUDkWnaMd7QrtNI40Uznuznf78wGjvb5hp04bi+SgYcrVfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600895; c=relaxed/simple;
	bh=CPAB6NpGZ2+wsx2Ahc71IbOCNM0l76F54kvcgXkekOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZyFfZsi4O3TbhF6F0JOtvBR9tOXPS5F2n9aRiqzcfw+tdnJotyQiGg6bNwN/BREEN7MVONscY4Q0mTTQeJVqq8b0vGPf+qDCv21Q/PUv+C8yrOCQ6Bh8sd/LCqw97GiZmglH/yOiheUQKG97f1n9dkoRP8Z745i5j8KOn2PWfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=XrdZk4hP; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="XrdZk4hP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771600889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc97eKcG+iDDpBhBuzeCKXVVgsVi/6rbjVUdOSXb0Ac=;
	b=XrdZk4hP4iayyKpHWAdh3RuQ+aNCvPdhK+9M59qAD3/fg9DsaF0wV100/FlvAuBpPqTpi0
	L4JiHpQQevbRnR6mUOTpNvtRyQdX+BNtNtRhDTqXqrS+cFOuZJ4AGisZ5jJWgS+BnyiViA
	gslWQ3McnmM1MbY34LlO7CJyRIsXM+o=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v7 3/6] refs: move out stub modification to generic layer
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-3-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-3-16f27860dbdf@gmail.com>
Date: Fri, 20 Feb 2026 16:21:08 +0100
Message-ID: <877bs7fnkr.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> When creating the reftable reference backend on disk, we create stubs to
> ensure that the directory can be recognized as a Git repository. This is
> done by calling `refs_create_refdir_stubs()`. Move this to the generic
> layer as this is needed for all backends excluding from the files
> backends. In an upcoming commit where we introduce alternate reference
> backend locations, we'll have to also create stubs in the $GIT_DIR
> irrespective of the backend being used. This commit builds the base to
> add that logic.
>
> Similarly, move the logic for deletion of stubs to the generic layer.
> The files backend recursively calls the remove function of the
> 'packed-backend', here skip calling the generic function since that
> would try to delete stubs.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  refs/files-backend.c    |  6 +++++-
>  refs/reftable-backend.c | 27 ---------------------------
>  3 files changed, 50 insertions(+), 30 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 77b93d655b..c83af63dc5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2189,12 +2189,55 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>  /* backend functions */
>  int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
>  {
> -	return refs->be->create_on_disk(refs, flags, err);
> +	int ret = refs->be->create_on_disk(refs, flags, err);
> +
> +	if (!ret &&
> +	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
> +		struct strbuf msg = STRBUF_INIT;
> +
> +		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
> +		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> +		strbuf_release(&msg);

To me it would feel nicer to have an early return instead of wrapping
this code inside the if block. But because we only need the strbuf
instead this block, having a block to scope it makes more sense.

Looks good to me.

-- 
Cheers,
Toon
