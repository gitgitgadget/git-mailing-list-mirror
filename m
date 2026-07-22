Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD233B96B
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726728; cv=none; b=eXKTSuswqUw3st+uCH/nucDz7q5WxZKSkj5oXRFzWB+Cd8xg43pOivP16X/YLy6kC+ZNVMhNfSaHKcwkm/zWqh8WhmIJHnfpUktu9vQFUmaikalsEObLmULrFOxkPBTiwaGfTiFc/28dXdJzRwEXxlv0WNt4rHz9A+dDxdJvvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726728; c=relaxed/simple;
	bh=lOApklQn1xEOSpa2436oq6mtb3cwlhAgu3tqkM44Kt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSTv1z1QrDAR0waeljbggWdamravcs0SSjRKHSIY5ndTkmnle4syXTXttvxvpVUSJeEOYMOI83G5shf5YoYMcAWFHIZGYxMJjE0LHVsN9i57+A1FklQ/AZPFcyO9xD0bxSNQ9m9iVXSxNUcUlTdVXR5C0VXl1da2R3hAhJD9Tow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fr3G09US; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fr3G09US"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784726720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1ABzH5NSzhldvEgji21up61iJ7oHVNsECwXiNGm0+k=;
	b=fr3G09USXGZhOj0d9nyP+sog/S9XoDkrV8IsFBU3mlPtepP8KH/7pyM6kiSleG5nGFdtll
	/c4sz7ll2g9EhId96XBys0MBRkPU+qBum0kQ/vJeIJAO/xHvcxnCkgtFMFA4OgFkBbLzsy
	sYmTnnrISC+S5Pa2rPVZCuq0Oy05vak=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 4/9] odb: lift object existence check out of the "loose"
 backend
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-4-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
 <20260717-pks-odb-move-loose-object-writing-v1-4-46446a3cb5b7@pks.im>
Date: Wed, 22 Jul 2026 15:25:06 +0200
Message-ID: <87jyqnp365.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Before writing a new loose object we first check whether the object
> already exists in any of the sources attached to the object database.
> This results in a couple of issues:
>
>   - We have a layering violation, where the source needs to be aware of
>     objects stored in any of the other sources.
>
>   - Every backend would have to reimplement this check, which feels
>     somewhat pointless.
>
>   - It is not possible to easily write an object into a source in case
>     the same object already exists in another source.
>
> Refactor the code and lift up the object existence check from the
> "loose" backend into the generic ODB layer. No callers need adjustment
> as none of them write via a specific source, but via the ODB layer.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c              | 7 +++++++
>  odb/source-loose.c | 8 ++------
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 4adbdf8a64..bfeca76f4e 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -997,6 +997,13 @@ int odb_write_object_ext(struct object_database *odb,
>  
>  	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
>  
> +	/*
> +	 * We can skip the write in case we already have the object available.
> +	 * In that case, we only freshen its mtime.
> +	 */
> +	if (odb_freshen_object(odb, oid))
> +		return 0;
> +

For the loose backend, this calls check_and_freshen_file(), which code
comment says:

    /*
     * All of the check_and_freshen functions return 1 if the file exists and was
     * freshened (if freshening was requested), 0 otherwise. If they return
     * 0, you should not assume that it is safe to skip a write of the object (it
     * either does not exist on disk, or has a stale mtime and may be subject to
     * pruning).
     */

And I see similar logic in the packed backend. So a non-zero value skips
the write and the file was freshened. Makes sense.

-- 
Cheers,
Toon
