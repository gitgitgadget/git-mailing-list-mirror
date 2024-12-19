Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6171A9B5C
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636633; cv=none; b=qXPNpXT1VL8b0Iho8+dfUDDBWuhvdnuTSAgIGrx/IFzCXVCR/ojyMVGemSHBe/gjAtaOSNwv8y/3+tv72WE8TQFZG6ANbkzj4Wql+XLxm/PTI6Oy9f3aSHeQw2DUQBj200hwdCB/hpavQ5O7/iYp+dxUP+Y/4/6cCXCWQpKoLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636633; c=relaxed/simple;
	bh=asadosLsJW5YywEDIDC95aLtGILAbs8ZrebHHrkbRVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P55os5AMaTGNvsv0RS6BdNag0Um1uUlTutQ67wG9+5Pzfa5OfgNNWuxs48UWU3pMOo9TnWxekUbSZ6syTtBudzNnjKgyEWuEyZwvt4Gmg6VlrDVyifSjT9DwnftBGoPv7PWtw/uuqre7PL7u6op5FsDgpzAdGyN0I+2+O24xwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3X2LtvE3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3X2LtvE3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMlWndlfrniOlv+t9tPtPvN/TDq7qxiCKCXdDhipszE=;
	b=3X2LtvE3O9PzujIt4T9R5bNXrC44EHDkMWlfkGifFr16Kj/yDearwsAyRXE74+TqsXDPZI
	ddWF69FjH8OBEqDSLpdSejZYzkTeSRNt1/4RBbHdxTlsCHWGtutI0inljNn+GxJn2Dsa12
	+Tbf/9UtF7N9P8hbQGD+BPD2wis7eWk=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/8] refs: add `committer_info` to
 `ref_transaction_add_update()`
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-5-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-5-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:30:10 +0100
Message-ID: <878qsbh3nh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The `ref_transaction_add_update()` creates the `ref_update` struct. To
> facilitate addition of reflogs in the next commit, the function needs to
> accommodate setting the `committer_info` field in the struct. So modify
> the function to also take `committer_info` as an argument and set it
> accordingly.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  |  7 +++++--
>  refs/files-backend.c    | 14 ++++++++------
>  refs/refs-internal.h    |  1 +
>  refs/reftable-backend.c |  6 ++++--
>  4 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801..782bf1090af65196263a3c35ed18d878bb4f2967 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1166,6 +1166,7 @@ struct ref_update *ref_transaction_add_update(
>  		const struct object_id *new_oid,
>  		const struct object_id *old_oid,
>  		const char *new_target, const char *old_target,
> +		const char *committer_info,
>  		const char *msg)
>  {
>  	struct ref_update *update;
> @@ -1190,8 +1191,10 @@ struct ref_update *ref_transaction_add_update(
>  		oidcpy(&update->new_oid, new_oid);
>  	if ((flags & REF_HAVE_OLD) && old_oid)
>  		oidcpy(&update->old_oid, old_oid);
> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
> +		update->committer_info = xstrdup_or_null(committer_info);

Why only include the committer_info when we're not skipping reflog
updates?

-- 
Toon

