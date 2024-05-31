Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A301CD23
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165423; cv=none; b=XBDsyuBqcm4c8Nwsz8qQqz+ruMqEmF1zXG16k3AV8li/Hfa1vm5Jpjg4IjZhVb4xbFxoB33q3HkHYXrylllprt8EmRe9hPKSL37YjNftnSt1mQr++NlxZHxeGjT852yl2icPk1m7aljV33jeQc+3c3KHxDNwJekxz1N5ze32qfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165423; c=relaxed/simple;
	bh=Yb+geB+BAP3JPHpHrGzI2AhCY1tVeUPmdmNwqlSdCG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaKsV4zF2KsSIrTfquaGAceN+wOjVhVhkQ+sgp0rfDnuTLSzB+KK8eazHfC9/RZHrXEDZrd1Id9qYg3evevVvbmjUIRPsaR/6Psut39KYNE5pjxSaMfC1tSGOLWLZ/pykcE4xYcKOlFzV5OES6il6QHEx7raxDrM78Xk9KQYj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=unCDcZj7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="unCDcZj7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E5721A1F5;
	Fri, 31 May 2024 10:23:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Yb+geB+BAP3JPHpHrGzI2AhCY1tVeUPmdmNwql
	SdCG0=; b=unCDcZj7O6gs0qZrvAt/Rb703YqYuXYZZTWOI03fNqvmKl2UIFLY8M
	GkkGjfr8i88Kb2zTVX96ibTS1wRQuqmbpK/6McPuTk7vVcVQ/YNc1zzmj+Pap3Tb
	o4yrlxjG2DMIQV9OV2WLSc+SNHO5+GOc6/iim8A6WEccrsUTRlxgA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 26E7D1A1F4;
	Fri, 31 May 2024 10:23:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51A5A1A1F3;
	Fri, 31 May 2024 10:23:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 2/2] refs: add name and content check for file
 backend
In-Reply-To: <20240530122753.1114818-3-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Thu, 30 May 2024 20:27:53 +0800")
References: <20240530122753.1114818-1-shejialuo@gmail.com>
	<20240530122753.1114818-3-shejialuo@gmail.com>
Date: Fri, 31 May 2024 07:23:31 -0700
Message-ID: <xmqqa5k6jc0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BBD6004-1F59-11EF-B61F-8F8B087618E4-77302942!pb-smtp21.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> +static int files_fsck_refs_content(const char *refs_check_dir,
> +				struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;

The caller makes sure that this gets called only on a regular file,
so ...

> +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {

... the use of strbuf_read_file() is fine (i.e. we do not have to
worry about the iter->path to be pointing at a symbolic link) here.

> +		error(_("%s/%s: unable to read the ref"), refs_check_dir, iter->basename);
> +		goto clean;
> +	}
> +
> +	/*
> +	 * Case 1: check if the ref content length is valid and the last
> +	 * character is a newline.
> +	 */
> +	if (ref_content.len != the_hash_algo->hexsz + 1 ||
> +			ref_content.buf[ref_content.len - 1] != '\n') {

Funny indentation.

	if (ref_content.len != the_hash_algo->hexsz + 1 ||
	    ref_content.buf[ref_content.len - 1] != '\n') {

Also, we do not want {braces} around a single statement block.

In any case, the two checks are good ONLY for regular refs and not
for symbolic refs.  The users are free to create symbolic refs next
to their branches, e.g. here is a way to say, "among the maintenance
tracks maint-2.30, maint-2.31, ... maint-2.44, maint-2.45, what I
consider the primary maintenance track is currently maint-2.45":

    $ git symbolic-ref refs/heads/maint
    refs/heads/maint-2.45

and if your directory walk encounters such a symbolic ref, your
strbuf_read_file() will read something like:

    $ cat .git/refs/heads/maint
    ref: refs/heads/maint-2.45

Also, the caller also needs to be prepared to find a real symbolic
link that is used as a symbolic ref, but for them you'd need to do a
readlink() and the expected contents would not have "ref: " prefix,
so the code to implement actual check would have to be different.
The way how refs/files-backend.c:read_ref_internal() handles S_ISLNK
would be illuminating.

> +		goto failure;
> +	}
> +	/*
> +	 * Case 2: the content should be range of [0-9a-f].
> +	 */
> +	for (size_t i = 0; i < the_hash_algo->hexsz; i++) {
> +		if (!isdigit(ref_content.buf[i]) &&
> +				(ref_content.buf[i] < 'a' || ref_content.buf[i] > 'f')) {
> +			goto failure;

I do not think it is a good idea to suddenly redefine what a valid
way to write object names in a loose ref file after ~20 years.
Given the popularity of Git, I would not be surprised at all if a
third-party tool or two have been writing their own refs with
uppercase hexadecimal and we have been happily using them as
everybody expects.  It is a good idea to be strict when you are a
producer, and we do write object names always in lowercase hex, but
we are lenient when consuming what is possibly written by others.
As long as the hexadecimal string names an existing object
(otherwise we have a dangling ref which would be another kind of
error, I presume), it should be at most FSCK_WARN when it does not
look like what _we_ wrote (e.g., if it uses uppercase hex, or if it
has extra bytes after the 40-hex (or 64-hex) other than the final
LF).  If it is shorter, of course that is an outright FSCK_ERROR.

How well does this interact with the fsck error levels (aka
fsck_msg_type), by the way?  It should be made to work well if the
current design does not.

> +		}
> +	}
> +
> +	strbuf_release(&ref_content);
> +	return 0;
> +
> +failure:
> +	error(_("%s/%s: invalid ref content"), refs_check_dir, iter->basename);

In addition, when we honor fsck error levels, such an unconditional
call to "error" may become an issue.  If the user says a certain
kind of anomaly is tolerated by setting a specific finding to
FSCK_IGNORE, we should be silent about our finding.

> +clean:
> +	strbuf_release(&ref_content);
> +	return -1;
> +}
> +
> +static int files_fsck_refs(struct ref_store *ref_store,
> +				const char* refs_check_dir,
> +				files_fsck_refs_fn *fsck_refs_fns)
> +{
> +	struct dir_iterator *iter;
> +	struct strbuf sb = STRBUF_INIT;
> +	int ret = 0;
> +	int iter_status;
> +
> +	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
> +
> +	iter = dir_iterator_begin(sb.buf, 0);
> +
> +	/*
> +	 * The current implementation does not care about the worktree, the worktree
> +	 * may have no refs/heads or refs/tags directory. Simply return 0 now.
> +	*/
> +	if (!iter) {
> +		return 0;
> +	}
> +
> +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> +		if (S_ISDIR(iter->st.st_mode)) {
> +			continue;
> +		} else if (S_ISREG(iter->st.st_mode)) {
> +			for (files_fsck_refs_fn *fsck_refs_fn = fsck_refs_fns;
> +					*fsck_refs_fn; fsck_refs_fn++) {

Funny indentation (again---the patch 2/2 has funny "two extra HT"
indentation style all over the place).  Write it like so:

			for (files_fsck_refs_fn *fn = fsck_refs_fns;
			     fn;
                             fn++)

> +				ret |= (*fsck_refs_fn)(refs_check_dir, iter);

A pointer to a function does not need to be dereferenced explicitly
like so.  Also, writing

				if (fn(refs_check_dir, iter))
					ret = -1;

would be more consistent with the rest of the code around here,
which does not OR int ret but explicitly set it to -1 when any
helper function detects an error.

> +			}
> +		} else {
> +			error(_("unexpected file type for '%s'"), iter->basename);
> +			ret = -1;

This is wrong.  A symbolic link is a valid symbolic ref, even though
we no longer create such a symbolic ref by default.

> +		}
> +	}
> +
> +	if (iter_status != ITER_DONE) {
> +		ret = -1;
> +		error(_("failed to iterate over '%s'"), sb.buf);
> +	}
> +
> +	strbuf_release(&sb);
> +
> +	return ret;
> +}
> +
> +static int files_fsck(struct ref_store *ref_store)
> +{
> +	int ret = 0;
> +
> +	files_fsck_refs_fn fsck_refs_fns[] = {
> +		files_fsck_refs_name,
> +		files_fsck_refs_content,
> +		NULL
> +	};
> +
> +	ret = files_fsck_refs(ref_store, "refs/heads",fsck_refs_fns)

Missing SP after a comma.

> +	    | files_fsck_refs(ref_store, "refs/tags", fsck_refs_fns);

Why only these two hierarchies?  Shouldn't it also be checking the
remote tracking branches and notes?

> +	return ret;
> +}
> +
>  struct ref_storage_be refs_be_files = {
>  	.name = "files",
>  	.init = files_ref_store_create,
