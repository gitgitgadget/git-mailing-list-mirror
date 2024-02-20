Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03DE15B1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708388068; cv=none; b=YxTLYSi2y/f3heGpp6D+xFPqdqB/MIaLuUdLWws1+LKX67GJDEp4E+LrpTw8HwGgOsNupUw3Am09HATeO2JY76oMjA0GJl0mOtNH3vsA/O1z+YbNdTHlGKIAzM1cMmVPeFhRKpPAIWCVjufLcXHrtKmkdrt/AoUzC56W3vKxa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708388068; c=relaxed/simple;
	bh=u0AACNGmcueDIk/ObEPPllDcwpw/Rayx+R1apmKZpoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cftquPJ4RdE2krWo3au58pAGvDErCz73ksVbgy3Jw+23AwkUcgIXAXXMt8UFcuNikbQvnCrgtX3Tvp+ogrmIaI6slZBNwzg3AWcKqBYX7Urm4SinpwXrpVE0qQrps4CIbdebxTOZLi5qist109ZQB1ET42d0QQbKgZMpNY7b9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HcuIWV+K; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HcuIWV+K"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 83A1126ADA;
	Mon, 19 Feb 2024 19:14:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u0AACNGmcueDIk/ObEPPllDcwpw/Rayx+R1apm
	KZpoI=; b=HcuIWV+K165KLC0KbzmB5M7pJ7y3M0U1958Qmn3jI673DLmuXchKM5
	qAD0LZai5jHT9gDY+v4VfgzbOcM3d8bszc/6+eY/jc72/BMv7e1YzN6MKnPanQpR
	K0trOCfG2AYXedkfDfvPVGzpHdW0HIDUy7l6FDkhXJMPFgPK1mO+Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C66526AD9;
	Mon, 19 Feb 2024 19:14:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E808026AD8;
	Mon, 19 Feb 2024 19:14:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] refs: stop resolving ref corresponding to reflogs
In-Reply-To: <a7459b9483660d1a44df500aaee85ad38146eb02.1708353264.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 19 Feb 2024 15:35:35 +0100")
References: <cover.1708353264.git.ps@pks.im>
	<a7459b9483660d1a44df500aaee85ad38146eb02.1708353264.git.ps@pks.im>
Date: Mon, 19 Feb 2024 16:14:21 -0800
Message-ID: <xmqqjzn0yote.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FFD1C04C-CF84-11EE-B9AF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the code to call `check_refname_format()` directly instead of
> trying to resolve the ref. This is significantly more efficient given
> that we don't have to hit the object database anymore to list reflogs.
> And second, it ensures that we end up showing reflogs of broken refs,
> which will help to make the reflog more useful.

And the user would notice corrupt ones among those reflogs listed
when using "rev-list -g" on the reflog anyway?  Which sounds like a
sensible thing to do.

> Note that this really only impacts the case where the corresponding ref
> is corrupt. Reflogs for nonexistent refs would have been returned to the
> caller beforehand already as we did not pass `RESOLVE_REF_READING` to
> the function, and thus `refs_resolve_ref_unsafe()` would have returned
> successfully in that case.

What do "Reflogs for nonexistent refs" really mean?  With the files
backend, if "git branch -d main" that removed the "main" branch
somehow forgot to remove the ".git/logs/refs/heads/main" file, the
reflog entries in such a file is for nonexistent ref.  Is that what
you meant?  As a tool to help diagnosing and correcting minor repo
breakages, finding such a leftover file that should not exist is a
good idea, I would think.

Would we see missing reflog for a ref that exists in the iteration?
I guess we shouldn't, as the reflog iterator that recursively
enumerates files under "$GIT_DIR/logs/" would not see such a missing
reflog by definition.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 2b3c99b00d..741148087d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2130,17 +2130,9 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
>  	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
>  		if (!S_ISREG(diter->st.st_mode))
>  			continue;
> -		if (diter->basename[0] == '.')
> +		if (check_refname_format(diter->basename,
> +					 REFNAME_ALLOW_ONELEVEL))
>  			continue;

A tangent.

I've never liked the code arrangement in the check_refname_format()
that assumes that each level can be separately checked with exactly
the same logic, and the only thing ALLOW_ONELEVEL does is to include
pseudorefs and HEAD; this makes such assumption even more ingrained.
I am not sure what to think about it, but let's keep reading.

> -		if (ends_with(diter->basename, ".lock"))
> -			continue;

This can safely go, as it is rejected by check_refname_format().

> -		if (!refs_resolve_ref_unsafe(iter->ref_store,
> -					     diter->relative_path, 0,
> -					     NULL, NULL)) {
> -			error("bad ref for %s", diter->path.buf);
> -			continue;
> -		}

This is the focus of this step in the series.  We did not abort the
iteration before, but now we no longer issue any error message.

>  		iter->base.refname = diter->relative_path;
>  		return ITER_OK;
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 889bb1f1ba..efbbf23c72 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1659,11 +1659,9 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
>  		if (iter->last_name && !strcmp(iter->log.refname, iter->last_name))
>  			continue;
>  
> -		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
> -					     0, NULL, NULL)) {
> -			error(_("bad ref for %s"), iter->log.refname);
> +		if (check_refname_format(iter->log.refname,
> +					 REFNAME_ALLOW_ONELEVEL))
>  			continue;
> -		}

This side is much more straight-forward.  Looking good.

>  
>  		free(iter->last_name);
>  		iter->last_name = xstrdup(iter->log.refname);
