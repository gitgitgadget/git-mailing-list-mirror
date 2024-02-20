Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291A76C76
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449763; cv=none; b=UxDydDhxnr+W7j0zGAS7OGoyT09v1FDo/cMMMvw4kLBPBzY56g80pe5DyvuFQDoGqXatdYw88L7oo4frAY9sQT4gOayUKWUangsrbe3KZdlMFW6Pj3QQng087ZDL+vF9xjgQbKPlAMFkqu36yeq0hZsYqsM+WxGzU72+HyctfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449763; c=relaxed/simple;
	bh=mp5VCMW3lNLLGl1pUV1F/8JfGfZYT+PRKsJBdLzTR1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqhJ7TnVsY26PgQBQPSH9HUn3U0w+P9xJK0g1RNDSsRqQAYGcd2eNTRXTFOyvkwHxXODRFbbnAQWcf3XWAxBXaBDDWdI80hjOJ0zSaUVCjZdRmaQ6CzarrTdbESFhIH5jjxHZZ1QXXR7wumhVdlvBpzX7Ouihaeu21FAcIPsCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WNfdwO3G; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WNfdwO3G"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DB062C9E1;
	Tue, 20 Feb 2024 12:22:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mp5VCMW3lNLLGl1pUV1F/8JfGfZYT+PRKsJBdL
	zTR1s=; b=WNfdwO3GlArIi4QO2HGA5sZ4BszucpxP0h7hTFqSL1djHAVB2+lpID
	Vslfri/j/baD3yG9VEmhftk02XIwLODBRVXvU4DSv0dzST21nwxydBqG/n548icc
	qTs9xfwvMWbsT6CUlXdwFymXmKDPtBsYXJHqw51B4dJe04o8FSLoI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 669762C9E0;
	Tue, 20 Feb 2024 12:22:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 125842C9DF;
	Tue, 20 Feb 2024 12:22:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] reflog: introduce subcommand to list reflogs
In-Reply-To: <cover.1708418805.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 20 Feb 2024 10:06:16 +0100")
References: <cover.1708353264.git.ps@pks.im> <cover.1708418805.git.ps@pks.im>
Date: Tue, 20 Feb 2024 09:22:36 -0800
Message-ID: <xmqq34tnrqxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4FB2B96-D014-11EE-8333-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>       struct dir_iterator_level {
>       	DIR *dir;
>     + 
>     ++	/*
>     ++	 * The directory entries of the current level. This list will only be
>     ++	 * populated when the iterator is ordered. In that case, `dir` will be
>     ++	 * set to `NULL`.
>     ++	 */
>      +	struct string_list entries;
>      +	size_t entries_idx;

Reads well.  Nice.

>     ++static int next_directory_entry(DIR *dir, const char *path,
>     ++				struct dirent **out)
>     ++{
>     ++	struct dirent *de;
>     ++
>     ++repeat:
>     ++	errno = 0;
>     ++	de = readdir(dir);
>     ++	if (!de) {
>     ++		if (errno) {
>     ++			warning_errno("error reading directory '%s'",
>     ++				      path);
>     ++			return -1;
>     ++		}
>     ++
>     ++		return 1;
>     ++	}
>     ++
>     ++	if (is_dot_or_dotdot(de->d_name))
>     ++		goto repeat;
>     ++
>     ++	*out = de;
>     ++	return 0;
>     ++}

Very nice to encapsulate the common readdir() loop into this helper.

> 3:  e4e4fac05c ! 3:  32b24a3d4b refs/files: sort reflogs returned by the reflog iterator
>     @@ refs/files-backend.c: static struct ref_iterator *reflog_iterator_begin(struct r
>       	iter->dir_iterator = diter;
>       	iter->ref_store = ref_store;
>       	strbuf_release(&sb);
>     +@@ refs/files-backend.c: static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
>     + 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
>     + 	} else {
>     + 		return merge_ref_iterator_begin(
>     +-			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
>     ++			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
>     + 			reflog_iterator_begin(ref_store, refs->gitcommondir),
>     + 			reflog_iterator_select, refs);
>     + 	}

This hunk is new.  Is there a downside to force merged iterators to
always be sorted?  The ones that are combined are all sorted so it
is natural to force sorting like this code does?  It might deserve
explaining, and would certainly help future readers who runs "blame"
on this code to figure out what made us think always sorting is a
good direction forward.

> -:  ---------- > 4:  4254f23fd4 refs: always treat iterators as ordered

This one is new, and deserves a separate review.

> 4:  be512ef268 ! 5:  240334df6c refs: drop unused params from the reflog iterator callback
>     @@ refs/reftable-backend.c: static int reftable_reflog_iterator_advance(struct ref_
>       	}
>      @@ refs/reftable-backend.c: static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct reftabl
>       	iter = xcalloc(1, sizeof(*iter));
>     - 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable, 1);
>     + 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable);
>       	iter->refs = refs;
>      -	iter->base.oid = &iter->oid;
>       
> 5:  a7459b9483 = 6:  7928661318 refs: stop resolving ref corresponding to reflogs
> 6:  cddb2de939 = 7:  d7b9cff4c3 builtin/reflog: introduce subcommand to list reflogs

Looking good from a cursory read.

Thanks for a quick reroll.
