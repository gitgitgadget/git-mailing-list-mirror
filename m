Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101383AF66E
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029781; cv=none; b=ca5YpL7Kz0LX3zrwniX9fDwc71AW5R3IvovxGdIcNn2rVAVCW+ThXNsJ2pGoCQYBiVE3EUoYkHBDgFIildvsYrMo3dV68GJOpWFQzDzaZ2DAq5JHGGFiVcoLWYyJsI98NpA2d67/OPF/Hvd6yas42wB2Z3P63ckRIng/8NxAxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029781; c=relaxed/simple;
	bh=GshV6UaviJ4BOmPcT/UWuzihKRqdcA2bi+1yHZpeZQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+d1xjLl2Q0MYvUb7i4Jt5KwGZP3mIOeXuHALi7d3qvvC6gzlb40gf007U4QOF6cRCdN7QUa08k3evnQWnXVpwHPFPuwE0QmBuEyrohfRaBl6vfJTxzHBJGSdTin/16gzfh/FlHIc1T38K7yGtqPsQ3VuPt0ID2Z7raMzLACCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=u9MsMlIK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="u9MsMlIK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777029774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=grWEVEEGaapHIdgGd1KCNJwsuYw6NMsxrSS3ZpsM3bs=;
	b=u9MsMlIKaQjlNi3v66D6q3SqrdBVS+BCcDuuOHQQqOaUPCjuwjjUy5Lw/+HjKhwr4BLB9R
	9bKhc/2jVihE8taEpk6+/kpCHIHmwCN2A1sHurv+Safhtj3eOgTJzjdNRHy6ddwAFO5syz
	Ty9wt5wQXPEjsAYk3bkT1Qmj/BkYCCI=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v2 6/9] update-ref: handle rejections while adding updates
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com>
Date: Fri, 24 Apr 2026 13:22:46 +0200
Message-ID: <87340keh6h.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> When using git-update-ref(1) with the '--batch-updates' flag, updates
> rejected by the reference backend are displayed to the user while other
> updates are applied. This only applies during the commit phase of the
> transaction.
>
> In the following commits, we'll also extend `ref_transaction_update()`
> to reject updates before a transaction is prepared/committed. In
> preparation, modify the code in update-ref to also handle non-generic
> rejections from `ref_transaction_update()`. This involves propagating
> information to each of the commands on whether updates are allowed to be
> rejected, and also checking for rejections and only dying for generic
> failures.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/update-ref.c | 100 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 71 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 5259cc7226..99deaac6db 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -25,6 +25,15 @@ static unsigned int default_flags;
>  static unsigned create_reflog_flag;
>  static const char *msg;
>  
> +struct command_options {
> +	/*
> +	 * Individual updates are allowed to fail without causing
> +	 * update-ref to exit. This is set when using the
> +	 * '--batch-updates' flag.
> +	 */
> +	bool allow_update_failures;
> +};
> +
>  /*
>   * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
>   * and append the result to arg.  Return a pointer to the terminator.
> @@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
>   */
>  
>  static void parse_cmd_update(struct ref_transaction *transaction,
> -			     const char *next, const char *end)
> +			     const char *next, const char *end,
> +			     struct command_options *opts)
>  {
>  	struct strbuf err = STRBUF_INIT;
>  	char *refname;
>  	struct object_id new_oid, old_oid;
> +	enum ref_transaction_error tx_err;
>  	int have_old;
>  
>  	refname = parse_refname(&next);
> @@ -289,12 +300,20 @@ static void parse_cmd_update(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	if (ref_transaction_update(transaction, refname,
> -				   &new_oid, have_old ? &old_oid : NULL,
> -				   NULL, NULL,
> -				   update_flags | create_reflog_flag,
> -				   msg, &err))
> +	tx_err = ref_transaction_update(transaction, refname,
> +					&new_oid, have_old ? &old_oid : NULL,
> +					NULL, NULL,
> +					update_flags | create_reflog_flag,
> +					msg, &err);
> +
> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
> +	    opts->allow_update_failures) {
> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
> +				    &new_oid, NULL, NULL, tx_err, err.buf,
> +				    NULL);
> +	} else if (tx_err) {
>  		die("%s", err.buf);

Why die() only on an ERROR_GENERIC? Is GENERIC the only error that stops
processing of other refs? Why? Would there be more errors in the future
that could be added to the pile of "fatal" errors like GENERIC?

I would rather see something that gives a more clear indication this
current ref is rejected. Maybe have a range in the enum:

enum ref_transaction_error {
	/* Default error code */
	REF_TRANSACTION_ERROR_GENERIC = -1,

        /* Ref rejected error range start */
	REF_TRANSACTION_REF_REJECTED = -100,

	/* Ref name conflict like A vs A/B */
	REF_TRANSACTION_ERROR_NAME_CONFLICT = -101,
	/* Ref to be created already exists */
	REF_TRANSACTION_ERROR_CREATE_EXISTS = -102,
	/* ref expected but doesn't exist */
	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -103,
	/* Provided old_oid or old_target of reference doesn't match actual */
	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -104,
	/* Provided new_oid or new_target is invalid */
	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -105,
	/* Expected ref to be symref, but is a regular ref */
	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -106,
	/* Cannot create ref due to case-insensitive filesystem */
	REF_TRANSACTION_ERROR_CASE_CONFLICT = -107,
};

statis inline bool ref_rejected(enum ref_transaction_error err)
{
	return err < REF_TRANSACTION_REF_REJECTED;
}

The thing is, now you have this checking on GENERIC in two places, I'm
worried one or the other might be forgotten in the future.

Now maybe this is a bit of an overkill, so feel free to reject that
suggestion. But if you want to keep looking at GENERIC, how do you feel
about this version:

	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
		die("%s", err.buf);

	if (tx_err && opts->allow_update_failures)
		print_rejected_refs(refname, have_old ? &old_oid : NULL,
				    &new_oid, NULL, NULL, tx_err, err.buf,
				    NULL);

And a little line of comment saying why to die() on GENERIC wouldn't
hurt I think.

> @@ -341,13 +362,21 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("symref-update %s: extra input: %s", refname, next);
>  
> -	if (ref_transaction_update(transaction, refname, NULL,
> -				   have_old_oid ? &old_oid : NULL,
> -				   new_target,
> -				   have_old_oid ? NULL : old_target,
> -				   update_flags | create_reflog_flag,
> -				   msg, &err))
> +	tx_err = ref_transaction_update(transaction, refname, NULL,
> +					have_old_oid ? &old_oid : NULL,
> +					new_target,
> +					have_old_oid ? NULL : old_target,
> +					update_flags | create_reflog_flag,
> +					msg, &err);
> +
> +	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
> +	    opts->allow_update_failures) {
> +		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
> +				    NULL, have_old_oid ? NULL : old_target,
> +				    new_target, tx_err, err.buf, NULL);
> +	} else if (tx_err) {
>  		die("%s", err.buf);
> +	}

Obviously the same suggestion could be applied here.

-- 
Cheers,
Toon
