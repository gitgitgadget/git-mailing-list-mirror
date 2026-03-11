Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E517A586
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232887; cv=none; b=dQEupv3WUsrxatP3iCelgXTM5z3+NEfh4MReV6uQCO9VYUkUO+hBDtx28QJgNnN6suyvkn/+3mVHYeLYLT09MEUcR8PK/2hW5NVUWRCkCLhjUeHrhlo97xZSC0gvup4UgTvn0GruZMV+KmPyc7xGjoOa+9hPjhoiFxh6BE+9yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232887; c=relaxed/simple;
	bh=ZyOwJxqkTxCViHCRpiNrGXUXchJgd2u2Znr8IC/asgs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G6a+Q2jxQ2KrHnFOhJFdy7DgmpolntqooOkdyBaEp4F2aPCbqtGYIvRZ7TUVUV1WL1NqKy1GxJze/seDZN3s7wp9PJ1ZgjSUUIyeSvh++jgSdSKABXFDBj1pQ8lFtnjGurlPkhk+eUjnPqJMJsc1PQjtxJwIfFHJ6VhwsdrJ4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=b8YM7T3p; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="b8YM7T3p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773232882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfxKjOyBXuazSfJDP2VdroE/Hqn/Mm5eglWzIJEjdPI=;
	b=b8YM7T3pDnJNjVco4lth+eKktHsRnrtBeo0C3zn3wLXeYvWp/sNYi775/aGixJh+ydZ5kO
	BgaHi3Nf3shKrT9DuHYik0dWki9juMmy/J6NU0M7nQLTdUmCbXXplacRGyOSDSMikE6qpH
	XmTO9icwlDfitFlRoLAkZTVx5d0oFao=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] packfile: extract logic to count number of objects
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-2-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-2-109e07d425f4@pks.im>
Date: Wed, 11 Mar 2026 13:41:05 +0100
Message-ID: <871phqmtcu.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we're about to introduce a new
> `odb_source_count_objects()` function so that we can make the logic
> pluggable. Prepare for this change by extracting the logic that we have
> to count packed objects into a standalone function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 45 +++++++++++++++++++++++++++++++++++----------
>  packfile.h |  9 +++++++++
>  2 files changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 215a23e42b..1ee5dd3da3 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1101,6 +1101,36 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
>  	return store->packs.head;
>  }
>  
> +int packfile_store_count_objects(struct packfile_store *store,
> +				 unsigned long *out)
> +{
> +	struct packfile_list_entry *e;
> +	struct multi_pack_index *m;
> +	unsigned long count = 0;
> +	int ret;
> +
> +	m = get_multi_pack_index(store->source);
> +	if (m)
> +		count += m->num_objects + m->num_objects_in_base;

To make sure I understand correctly:

`m->num_objects` indicates how many objects are in the current pack, and
`m->num_objects_in_base` how many are in it's base (and that accumulates
what's in the bases of the base?).

> +	for (e = packfile_store_get_packs(store); e; e = e->next) {
> +		if (e->pack->multi_pack_index)
> +			continue;

Because we added the count through the midx already, we skip any
packfile that's included in the midx.

But some packfiles are not in the midx so we fall through for those.

Makes sense.


-- 
Cheers,
Toon
