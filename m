Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDF39FC9
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167556; cv=none; b=IfftRWykYuPvPI+xIwV6O5+bsVm0zayV1DDln+CuGkbHGCOXQ/73b5EviAAEpIfdCQ5fhUqhN7Q7OwBOD2yIrofqaSsQQZS6sYJFBmNm+mULivqcHIkeD3Gv2m4WnDpJMdMpt8kS919HdKA3eSZjO83YwARBgpe5PdcH2+xJzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167556; c=relaxed/simple;
	bh=h3rwADGfxjsHH2QSlpzi1zLW+CAACv0SYCY7aVGi+OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgbVac3ZA23IYEmC/oqNmFH605a5/UiUD0pxwqzPgoKMP2zcDWSR0uNTdgdq/3YkTflM86UDQzOtc4DOFg95BNlYPdyGrjV7m2sJ6ZxhfrPPjSVA7VQpzDKwPsIIqlTTITKuQsGyfq0uAwQSPB5lGcnCX9hbaued745xF1gWO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iMW1j5sD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMW1j5sD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D62D61FF2B;
	Fri, 26 Apr 2024 17:39:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h3rwADGfxjsHH2QSlpzi1zLW+CAACv0SYCY7aV
	Gi+OY=; b=iMW1j5sDsb+pBN/UL05R7ioYw9vEIRxTJT+86gSmI+NG1LiCSDFMsO
	U79X4pMMiersJLxzpdQw4/j26pgRi0xoGOiXnrlE2nfBae3C/z6mnu6zagchbK8A
	94maBkgxNZLsx0JmTOOdB1S15OTlFlembWpLTdy1Bvh+xa2YADOCw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE3711FF2A;
	Fri, 26 Apr 2024 17:39:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D19D81FF22;
	Fri, 26 Apr 2024 17:39:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v4 2/7] files-backend: extract out `create_symref_lock`
In-Reply-To: <20240426152449.228860-3-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 26 Apr 2024 17:24:44 +0200")
References: <20240423212818.574123-1-knayak@gitlab.com>
	<20240426152449.228860-1-knayak@gitlab.com>
	<20240426152449.228860-3-knayak@gitlab.com>
Date: Fri, 26 Apr 2024 14:39:08 -0700
Message-ID: <xmqqmspf9537.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6A76A98E-0415-11EF-9BAA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The function `create_symref_locked` creates a symref by creating a
> '<symref>.lock' file and then committing the symref lock, which creates
> the final symref.
>
> Split this into two individual functions `create_and_commit_symref` and
> `create_symref_locked`. This way we can create the symref lock and
> commit it at different times. This will be used to provide symref
> support in `git-update-ref(1)`.

It is a confusing way to describe what this patch did, though.  If
you truly splitted create_symref_locked() into two, you would have
functions A and B, and existing callers of create_symref_locked()
would be changed to call A() and then B().  I do not think such a
split would make sense in this case, but the above description gives
an impression that it was what you did.

In reality, an early part of create_symref_locked() was made into a
separate helper function that can be called from callers other than
create_symref_locked(), and because the helper got a name too
similar to the original, you had to rename create_symref_locked() to
create_and_commit_symref().  The existing callers of it are not
affected, modulo the name change.

Perhaps

    Split the early half of create_symref_locked() into a new helper
    funciton create_symref_lock().  Because the name of the new
    function is too similar to the original, rename the original to
    create_and_commit_symref() to avoid confusion.

    The new helper will be used to ...

or something?

> -static int create_symref_locked(struct files_ref_store *refs,
> -				struct ref_lock *lock, const char *refname,
> -				const char *target, const char *logmsg)
> +static int create_symref_lock(struct files_ref_store *refs,
> +			      struct ref_lock *lock, const char *refname,
> +			      const char *target)
>  {
> +	if (!fdopen_lock_file(&lock->lk, "w"))
> +		return error("unable to fdopen %s: %s",
> +			     get_lock_file_path(&lock->lk), strerror(errno));
> +
> +	/* no error check; commit_ref will check ferror */
> +	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);

This was a bit puzzling (see below).

> +	return 0;
> +}
> +
> +static int create_and_commit_symref(struct files_ref_store *refs,
> +				    struct ref_lock *lock, const char *refname,
> +				    const char *target, const char *logmsg)
> +{
> +	int ret;
> +
>  	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
>  		update_symref_reflog(refs, lock, refname, target, logmsg);
>  		return 0;
>  	}

    Offtopic: we might want to start planning to deprecate creation
    of "symlink refs".  Linus originally used a symlink for
    .git/HEAD, but 9f0bb90d (core.prefersymlinkrefs: use symlinks
    for .git/HEAD, 2006-05-02) made it default not to use of
    symbolic links.  As long as we preserve the ability to work on a
    repository whose HEAD still uses a symbolic link, I'd hope
    nothing would break (#leftoverbits).

Let me rearrange this hunk to show the original first:

> -	if (!fdopen_lock_file(&lock->lk, "w"))
> -		return error("unable to fdopen %s: %s",
> -			     get_lock_file_path(&lock->lk), strerror(errno));
> -	update_symref_reflog(refs, lock, refname, target, logmsg);
> -	/* no error check; commit_ref will check ferror */
> -	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
> -	if (commit_ref(lock) < 0)
> -		return error("unable to write symref for %s: %s", refname,
> -			     strerror(errno));

The original in create_symref_locked() created a lockfile, called
update_symref_reflog(), and called commit_ref() to commit the thing.

The "no error check" comment is about detecting an error while
writing into the lock file.  It came from 370e5ad6 (create_symref:
use existing ref-lock code, 2015-12-29).  Because the fprintf() call
was immediately followed by commit_ref(), and the code assumed that
commit_ref() will check ferror(), we do not bother checking if the
fprintf() call fails to write the contents correctly.

> +	ret = create_symref_lock(refs, lock, refname, target);
> +	if (!ret) {
> +		update_symref_reflog(refs, lock, refname, target, logmsg);
>  
> +		if (commit_ref(lock) < 0)
> +			return error("unable to write symref for %s: %s", refname,
> +				     strerror(errno));
> +	}

The new code lets create_symref_lock() to create a lockfile, and
does the rest here.  commit_ref() does call commit_lock_file(),
which eventually passes the control to close_tempfile() and a
write error can be detected there.

But the point of this patch is that the creation of the locked
symref file PLUS writing its new contents (which is done by
create_symref_lock()) can be done way ahead of the remainder that
eventually does commit_ref().  So it smells a bit[*] dubious that we
still leave the error from fprintf() ignored in the "early half" in
the rearranged code.

	Side note: it is a "bit", as it is unlikely that we will do
	something to clear the ferror() from the (FILE *) in the
	meantime.

> @@ -1960,7 +1973,8 @@ static int files_create_symref(struct ref_store *ref_store,
>  		return -1;
>  	}
>  
> -	ret = create_symref_locked(refs, lock, refname, target, logmsg);
> +	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
> +
>  	unlock_ref(lock);
>  	return ret;
>  }

This hunk shows the "original function was renamed; there is no
other changes visible to the caller" nature of this rearrangement.

The extra blank line is probably a nice touch.
