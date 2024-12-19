Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABB1AAA0D
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636528; cv=none; b=qHfvmcD+0llTwNQuuKex0yzkjTRFidijkbQC5SNltWqdfntKRBQj/EsdGPQNLyUSfRfYJbswQoP/mwh7RaQWIp79xQTXB0Z52RQ7yX2kz6IlIcInFOfq8pQAPclCE0DNQaK30/PhHOOxjHwooM4AaIXlLVSv4PpzeNzILkeA3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636528; c=relaxed/simple;
	bh=y5GYpoWhrkbSHbOuTH1F3VpkRESOZLrE6H4YT87o5LE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=foU9JiIZlHVa6tWkY1IHCLlYxEWbT8JMgsv567kTY4pb/2SGKUHnNfhEecAemDFzOfS8B44Vei/pfQOVT6JvVOrtVl224yH5/Hv8acYeBjArIg3D1sIdYDQ/qkoe3007cVIAVtW4P/9n7vXWiT9Cr9lwWRqSkNWKMXfcqt1hZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ov8BWTOe; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ov8BWTOe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LbD5jMA5tenpuGS8kW1tV+fOaAyX326V/0NyhPnCSaA=;
	b=Ov8BWTOe8mmQZ1ZYzoLi39IkUiDPftA9PG+mTFXCaX5rQZEohGRI6YpQ837YWplRe+HKjc
	LPjGG5TS5Xt3CgGsyWxPH7OmCwQR30hMYsTAT4v9y1w9tg8hGUXHoQTwA992UmhTla2ih+
	OUC4vbIr6wsdWnsfbXH4DIAcm2V87Lo=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 2/8] refs: add `index` field to `struct ref_udpate`
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-2-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-2-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:28:30 +0100
Message-ID: <87bjx7h3q9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The reftable backend, sorts its updates by refname before applying them,
> this ensures that the references are stored sorted. When migrating
> reflogs from one backend to another, the order of the reflogs must be
> maintained. Add a new `index` field to the `ref_update` struct to
> facilitate this.
>
> This field is used in the reftable backend's sort comparison function
> `transaction_update_cmp`, to ensure that indexed fields maintain their
> order.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/refs-internal.h    |  7 +++++++
>  refs/reftable-backend.c | 13 +++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 0fd95cdacd99e4a728c22f5286f6b3f0f360c110..f5c733d099f0c6f1076a25f4f77d9d5eb345ec87 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -115,6 +115,13 @@ struct ref_update {
>  	char *msg;
>  	char *committer_info;
>  
> +	/*
> +	 * The index overrides the default sort algorithm. This is needed
> +	 * when migrating reflogs and we want to ensure we carry over the
> +	 * same order.
> +	 */
> +	unsigned int index;
> +
>  	/*
>  	 * If this ref_update was split off of a symref update via
>  	 * split_symref_update(), then this member points at that
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index e882602487c66261d586a94101bb1b4e9a2ed60e..c008f20be719fec3af6a8f81c821cb9c263764d7 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1279,8 +1279,17 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
>  
>  static int transaction_update_cmp(const void *a, const void *b)
>  {
> -	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
> -		      ((struct reftable_transaction_update *)b)->update->refname);
> +	struct reftable_transaction_update *update_a = (struct reftable_transaction_update *)a;
> +	struct reftable_transaction_update *update_b = (struct reftable_transaction_update *)b;
> +
> +	/*
> +	 * If there is an index set, it should take preference (default is 0).
> +	 * This ensures that updates with indexes are sorted amongst themselves.
> +	 */
> +	if (update_a->update->index || update_b->update->index)

What if one of both simply isn't set, and the other one is? Then we
compare an unset with one that is set? Or am I being too paranoid?

--
Toon
