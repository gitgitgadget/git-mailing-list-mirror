Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E51B2195
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636582; cv=none; b=RpOtCvbGApNIxX7SZyfglLT/yxB8jqPVyC73R+IKXvn5MBF5jFAG5JMdLYH+nniqirjIdGW/i/lF+XPkmh592w+JUsEouysc1ZJnpeyffzLzTUCYxSuMdXSZ832CfNDCxQPt4pLtRxqPQlb5GHO9hAPmPjFQnsPGDLnStqpyZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636582; c=relaxed/simple;
	bh=n8EgE4sLpnzt2cEUxL0NR8TYOCCicDjJULt42P8SJgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEUEgR8gc33NzJJJJf5BlmZkBowLssFMhdZ2HYEjUh1oI7fb9oGw/5NIrz+jS2n10jmjQBtbyzTg3WLrE93zzdJN0+v9/mh/pg+nKUkgJ//lAV0KiN7AtKiAZzmS4Yf07G4SI52cX1sKIOmbusgoo5rtNTuZOTJJD2jJlIc9AMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hB8FlwhV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hB8FlwhV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Wl36/TrAbjjyHYFepPd8AWi5gazqUzgu5HSsraLV4g=;
	b=hB8FlwhVHDC1aQi+Dv5p43M/5G+agc91saMm5a74haLfhTXtIVMadxnHspp4cGbd7mRE4y
	uwPc7zNJlKlLiAngs3rlnxvCGKcEwy/t0j2rYyHJyMahTu4PR07muXpqk8R3ObBXhVOzAJ
	IX8FyiPEg+SeIiHuYkYVx4EV7m2kOgE=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 4/8] refs: extract out refname verification in
 transactions
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-4-d7cd3f197453@gmail.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-4-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:29:17 +0100
Message-ID: <87a5crh3oy.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Unless the `REF_SKIP_REFNAME_VERIFICATION` flag is set for an update,
> the refname of the update is verified for:
>
>   - Ensuring it is not a pseudoref.
>   - Checking the refname format.
>
> These checks will also be needed in a following commit where the
> function to add reflog updates to the transaction is introduced. Extract
> the code out into a new static function.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index f003e51c6bf5229bfbce8ce61ffad7cdba0572e0..9c9f4940c60d3cdd34ce8f1e668d17b9da3cd801 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1196,6 +1196,28 @@ struct ref_update *ref_transaction_add_update(
>  	return update;
>  }
>  
> +static int transaction_refname_valid(const char *refname,
> +				     const struct object_id *new_oid,
> +				     unsigned int flags, struct strbuf *err)
> +{
> +	if (flags & REF_SKIP_REFNAME_VERIFICATION)
> +		return 1;
> +
> +	if (is_pseudo_ref(refname)) {
> +		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
> +			    refname);
> +		return 0;

With this early return you don't need the `else` below? Why did you add
it?

> +	} else if ((new_oid && !is_null_oid(new_oid)) ?
> +		 check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
> +		 !refname_is_safe(refname)) {
> +		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
> +			    refname);
> +		return 0;
> +	}

I see you've swapped order of checking whether it's a pseudoref with
checking whether the format is okay. I think this shouldn't make a big
difference, but it will give a different error message when attempting
to update an illformatted pseudoref. For me it makes more sense how
you've done it now. But because you mention both checks as bullet points
in the commit message, do you think it would make sense to say something
about them being swapped?

-- 
Toon
