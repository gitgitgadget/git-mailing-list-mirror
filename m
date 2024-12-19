Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1087E1A42C4
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636768; cv=none; b=fCkbgMdnyHnZ2b5Gr/Ts8TyldAKqi5g21m9L8Vuz1CNusoFDk8xN+QXKMvf0nqYteSBptx+zjgozrjCdp16erQ2CG//BKHwsJDEbgWPRp8qf1D2hd9dgV8FvRoljyoK9IwtBNUNDayA6uMvvl4JdMwdlYSs06w8nJGkpqioorbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636768; c=relaxed/simple;
	bh=xOEf35IMGtKRO3p1wQK2pflbQHNXxMnyMssvJ438hJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QTh6Tj26Y5pFgg8m/1upFyoHAf+b2NMkf/iJyFEWnUURZprUlBF9w0AXMIoEJ3h+KEDCgv/taMQ809Bag8i6cKV068cVQEp11uwRSjZ4bzbEmF9GRanjXjUG+cpBTJW/uH3R7p7drGuDtWeUVL9Sxy/aJEppCvCxQh2wT+dMpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=0a9x7cFx; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="0a9x7cFx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yEICAVsJGpHH2auAxDYgKdO4VuXQgJxlFOSB7cvE0w4=;
	b=0a9x7cFxbAKoJqKs5WB9ysIBduFUYrGI5fwr4BhIrxSRUe2o3a6p9CuVZp2YXVaaJxHWzq
	7oQvCs+mWOnSXlybEp37jnNqxarj9g7eLu6rF/y6IgZY22ZOmWvf6q/LMux4VgZ5rE3WCP
	vKld1019AIDlxKJTQBeAGVhtCLid41g=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 6/8] refs: introduce the
 `ref_transaction_update_reflog` function
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-6-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-6-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:32:35 +0100
Message-ID: <8734ijh3jg.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce a new function `ref_transaction_update_reflog`, for clients to
> add a reflog update to a transaction. While the existing function
> `ref_transaction_update` also allows clients to add a reflog entry, this
> function does a few things more, It:
>   - Enforces that only a reflog entry is added and does not update the
>   ref itself.
>   - Allows the users to also provide the committer information. This
>   means clients can add reflog entries with custom committer
>   information.
>
> The `transaction_refname_valid()` function also modifies the error
> message selectively based on the type of the update. This change also
> affects reflog updates which go through `ref_transaction_update()`.
>
> A follow up commit will utilize this function to add reflog support to
> `git refs migrate`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c               | 39 +++++++++++++++++++++++++++++++++++----
>  refs.h               | 14 ++++++++++++++
>  refs/files-backend.c | 24 ++++++++++++++++--------
>  3 files changed, 65 insertions(+), 12 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 782bf1090af65196263a3c35ed18d878bb4f2967..8b3882cff17e5e3b0376f75654e32f81a23e5cb2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1207,14 +1207,14 @@ static int transaction_refname_valid(const char *refname,
>  		return 1;
>  
>  	if (is_pseudo_ref(refname)) {
> -		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
> -			    refname);
> +		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";

These strings are not localized.

> +		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
>  		return 0;
>  	} else if ((new_oid && !is_null_oid(new_oid)) ?
>  		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
>  		 !refname_is_safe(refname)) {
> -		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
> -			    refname);
> +		const char *what = flags & REF_LOG_ONLY ? "reflog with bad name" : "ref with bad name";

Also these strings are not localized.

-- 
Toon
