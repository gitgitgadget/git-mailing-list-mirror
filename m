Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24F3BADBD
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032403; cv=none; b=oGsc5Nk8xX6NirGmKQiGe9wV71Iex0N7t/fN0nPLQX4rKLwLvrieSj0pW301a8cSCac7k8CEjMOv9koFMLZYXczsP6C7E6PN4V46aXMVGZu4pg+jTPpcZTcHWsuWABSr8Qxc1oOOVUgAV5JMt1kROkISB47wLMJ8MYDfpHJnjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032403; c=relaxed/simple;
	bh=Rah5BZIhvxWbfaihTniLZdgAGeWV+e2vxqf7NaeJLXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwMv3B3RzZ8NeQzDWwCDQkdgkrRv4lCtPpJRq6pbrVYMGPRYEV0wk04FFqxi6iBrRIwfDvlR3fLnKoGqDzPxgGN0ZK5btASLLBl62KHv7h8FMHeaFUzyEcuBWPn8ldK5YTPM0P3NqH5k6LXY00ippNZCw/gmvzPfY+GWdM/5mGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lMLyn6EC; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lMLyn6EC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777032397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbgbrglhkXByHP4Gw3xkTr/TGhcRV1rAl1me2Fh7Po4=;
	b=lMLyn6ECn8e3AMfKXXOuP+eD1SReFpde9dbYQoh3rqpcSUEClHfQetHQy6iVITME88giiG
	Rh+oUcoD9ZU7aXFO6czwVgPeHnw5/xxzao/Qaj/DfZAZ2lCYjWfMgywcevkY4jyI+HCi9J
	JtLiYKigJRF6fkC1UdL07qcdYW6jBFc=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v2 7/9] refs: move object parsing to the generic layer
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-7-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-7-ae5a4f146d7d@gmail.com>
Date: Fri, 24 Apr 2026 14:06:24 +0200
Message-ID: <87zf2sd0lb.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Regular reference updates made via reference transactions validate that
> the provided object ID exists in the object database, which is done by
> calling 'parse_object()'. This check is done independently by the
> backends which leads to duplicated logic.
>
> Let's move this to the generic layer, ensuring the backends only have to
> care about reference storage and not about validation of the object IDs.
> With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
> error type as its no longer used.
>
> Since we don't iterate over individual references in
> `ref_transaction_prepare()`, we add this check to
> `ref_transaction_update()`. This means that the validation is done as
> soon as an update is queued, without needing to prepare the
> transaction. It can be argued that this is more ideal, since this
> validation has no dependency on the reference transaction being
> prepared.
>
> It must be noted that the change in behavior means that this error
> cannot be ignored even with usage of batched updates, since this happens
> when the update is being added to the transaction. But since the caller
> gets specific error codes, they can either abort the transaction or
> continue adding other updates to the transaction.
>
> Modify 'builtin/receive-pack.c' to now capture the error type so that
> the error propagated to the client stays the same. Also remove two of
> the tests which validates batch-updates with invalid new_oid.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/receive-pack.c  | 22 +++++++++++++---------
>  refs.c                  | 18 ++++++++++++++++++
>  refs/files-backend.c    | 28 ++--------------------------
>  refs/reftable-backend.c | 19 -------------------
>  4 files changed, 33 insertions(+), 54 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 878aa7f0ed..0fb3d57de8 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  			ret = NULL; /* good */
>  		}
>  		strbuf_release(&err);
> -	}
> -	else {
> +	} else {
> +		enum ref_transaction_error err_type;

Shall we also use `tx_err` like in builtin/update-ref.c?

> diff --git a/refs.c b/refs.c
> index efa16b739d..662a9e6f9e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1416,6 +1416,24 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
>  	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
>  	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
>  
> +	if ((flags & REF_HAVE_NEW) && !new_target && !is_null_oid(new_oid) &&
> +	    !(flags & REF_SKIP_OID_VERIFICATION) && !(flags & REF_LOG_ONLY)) {

Compared to the version we used to have in refs/reftable-backend.c,
you've added `!new_target`. Why is that? If I understand correctly, that
only happens when `new_oid` is set. Wouldn't `!is_null_oid(new_oid)`
guard for that?

-- 
Cheers,
Toon
