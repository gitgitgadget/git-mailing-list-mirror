Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900384E15
	for <git@vger.kernel.org>; Wed,  1 May 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607568; cv=none; b=TJrQtMXWv4MkFiYzUCnPj/C5JouSTSTpBawye4vMFElcgU492TGdDNzygRGDrn8HYLXdqqxkcNJOsRDpMchF/3n30QYMTO/OKH3GEkv4LZ13buz5k6vBWj/lgZNp5Dewy3zPgdAgdxIIzHXHogVRcbgmX/94LYNQutMkqOqIG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607568; c=relaxed/simple;
	bh=GOuzEF/haOxiO7vEacZHK+1HRopYqwsgEGqh3P2WCts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tv/x9CAZAWTbDErNxZCrWcj9UzKj0VcpfwR7OE6iNeJELeV1BpapKro3i2NjS/9UpJJTK2i38L1VPMpXPMjglA089S8l0y09ebR9zE6E5E1LrmxSUUabSf34H71ZpjCWiSjgMoW6kvXyGVJVD2MOLdVQRfFrRLGtAhYS2kzOzwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xIjBvVSw; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIjBvVSw"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F9C2BEC0;
	Wed,  1 May 2024 19:52:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GOuzEF/haOxiO7vEacZHK+1HRopYqwsgEGqh3P
	2WCts=; b=xIjBvVSwj1KV9qUvM1bJEUEfcR+vEp20ZPvEfTnJrSY0wnTKX5ysBk
	KYoEMZbeC7ZsytWx0SeKJGSkFlCvWpTpMa4LFXldjtU+nx/AsA/FLAKss6K7Y67c
	cUZ3VQr3ZhMrj4v1dvkEoZzZy1aH6YXptW6cxVdh1/CTMFaV/gx2g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 416162BEBF;
	Wed,  1 May 2024 19:52:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1CC7F2BEBE;
	Wed,  1 May 2024 19:52:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
In-Reply-To: <20240501202229.2695774-5-knayak@gitlab.com> (Karthik Nayak's
	message of "Wed, 1 May 2024 22:22:26 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-5-knayak@gitlab.com>
Date: Wed, 01 May 2024 16:52:39 -0700
Message-ID: <xmqqbk5pgke0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E59C6DE8-0815-11EF-A431-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The reference backends currently support transactional reference
> updates. While this is exposed to users via 'git-update-ref' and its
> '--stdin' mode, it is also used internally within various commands.
>
> However, we never supported transactional updates of symrefs. Let's add
> support for symrefs in both the 'files' and the 'reftable' backend.
>
> Here, we add and use `ref_update_is_null_new_value()`, a helper function
> which is used to check if there is a new_value in a reference update.

I know you want to express a condition where you answer yes to "Is
the new value specified in this ref update NULL?", but "is" at that
position in the name somehow sounds awkward.  Any of

	ref_update_has_null_new_value
        ref_update_with_no_new_value
        ref_update_without_new_value

might be nicer to ears.

> We do not add reflog for dangling symref updates, because currently
> 'git-symbolic-ref' doesn't add reflog for dangling symref updates and it
> would be best to keep this behavior consistent as we would move it to
> start using transaction based updates in the following commit.

If we are not changing the behaviour, does it deserve a four-line
paragraph?  It is not like we describe every no changes (i.e. "we
could break the behaviour by introducing this and that bugs, but we
did not" is not something we usually say in proposed log messages).

At most, if you want to highlight that behaviour, I would expect a
brief mention like:

    Note that a dangling symref update does not record a new reflog
    entry, which is unchanged before and after this commit.

As a reflog entry records name of the object that is pointed by the
ref (either directly or indirectly) before and after an operation,
an operation that involve a dangling reflog that does not point at
any object cannot be expressed in a reflog, no?  It is way too late
to change this, but it would have been interesting if the design of
reflog had a room to log the change of symbolic ref target as well
as object names.  It would have allowed us to say "HEAD at time T
pointed at refs/heads/main (which did not exist)", "HEAD at time T+1
directly pointed at commit X (detached)", "HEAD at time T+2 pointed
at refs/heads/next", etc. and allowed us to much more cleanly
support "previous branch".

> @@ -1247,10 +1249,15 @@ struct ref_update *ref_transaction_add_update(
>  
>  	update->flags = flags;
>  
> -	if (flags & REF_HAVE_NEW)
> +	if (new_target)
> +		update->new_target = xstrdup(new_target);
> +	if (old_target)
> +		update->old_target = xstrdup(old_target);

"Is the assumption that *update is 0-initialized?" was the first
question that came to my mind.

Doing an unconditional

	update->new_target = xstrdup_or_null(new_target);
	update->old_target = xstrdup_or_null(old_target);

would convey the intention much more clearly without having readers
guess the answer to the above question.

> +	if (new_oid && flags & REF_HAVE_NEW)

Even though syntactically not required, 

	if (new_oid && (flags & REF_HAVE_NEW))

or better yet

	if ((flags & REF_HAVE_NEW) && new_oid)

would be easier to see.

>  		oidcpy(&update->new_oid, new_oid);

Again is the expectation that update->new_oid is initialized to
all-0?  I am wondering if we want an else clause, i.e.

	if (!(flags & REF_HAVE_NEW))
		oidcpy(&update->new_oid, null_oid());
	else
		oidcpy(&update->new_oid, new_oid ? new_oid : null_oid());

to clarify the intention of the code, since the way you wrote the
consumer of thes two members and REF_HAVE_NEW bit in the previous
step implied that the new_oid member gets used even when REF_HAVE_*
bit is off, only for its null_oid() value.

I'll stop here for now.

Thanks.
