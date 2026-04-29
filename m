Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C007175A69
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465469; cv=none; b=ZmAd4CrDeB5kI9ygYLE9pBQxkroPhARDfwlvLm7crjonoHUyRp9Oy8imxcncU4X5sucAnSG+dEz4wbGL8/sdAlBCoqyepmXHOBdbqIt9Ozr/LV3QS/hIEzzcy8ue/+sVl9aEfAHlGjJ4KHQS//dSB34ooGdKyJt2JlnRBFt+s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465469; c=relaxed/simple;
	bh=Ak/l5r1I6Xcydfhe4SPoOd8witNn6zlnuxIt2KJGvFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bVOX2YoGEN/b4wK0gOOM1aknnYCTmXDlTclZHmF9QPAvA9vebwI0LyDxhIIjYWikekH1une7F+3TGg6pHUKskhjlUhu5M5byyKoKxlYyPrQik5U8QtPZYV9mXhkRoC5gzWLujGTxrI9UKKbrZZVgHVGQoMOhDECQ1QAnkvcRNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=b039fOVV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="b039fOVV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777465461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncz+hZWGLCYR2EDFYbDUCrq/XKRoPGMw9caQSPG+su0=;
	b=b039fOVV0F2lIWijQ/3feXPKxlC5r+brM3iBkA8KSHoWu5/bJ3EiIwt9gkAmI67blevYm6
	YmNOTXWB7s/yK5bOSogt0X+o0tgjlEk9QBllI4QWpMS1U/JZc62+RGrkykVCckme6asORk
	xp3b2OuSSwYI6y8/XdbSqYX+2QjgMbc=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im
Subject: Re: [PATCH v3 6/9] update-ref: handle rejections while adding updates
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-6-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
 <20260427-refs-move-to-generic-layer-v3-6-e4638dfb7897@gmail.com>
Date: Wed, 29 Apr 2026 14:24:15 +0200
Message-ID: <87v7dagdjk.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -289,22 +300,35 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
> +	/*
> +	 * Generic errors are non-recoverable, so we cannot skip the update
> +	 * or mark it as rejected.
> +	 */
> +	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
>  		die("%s", err.buf);
>  
> +	if (tx_err && opts->allow_update_failures)
> +		print_rejected_refs(refname, have_old ? &old_oid : NULL,
> +				    &new_oid, NULL, NULL, tx_err, err.buf,
> +				    NULL);

I realize I've made this suggestion, but I think I've made a mistake.
When opts->allow_update_failures is falsey and tx_err is truthy we
should die also. Don't we?

I'm not sure what the nicest way is to write this, but maybe:

        if (tx_err) {
            if (tx_err == REF_TRANSACTION_ERROR_GENERIC || !opts->allow_update_failures)
                die("%s", err.buf);

            print_rejected_refs(refname, have_old ? &old_oid : NULL,
                                &new_oid, NULL, NULL, tx_err, err.buf,
                                NULL);
        }

How did test coverage not find this?

-- 
Cheers,
Toon
