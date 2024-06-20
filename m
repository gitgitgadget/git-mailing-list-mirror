Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18536126
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922374; cv=none; b=OQpvcZSN1sthA2lUUw5jHZ/UzQkHK26zfAIZVdc/Jcwu67XM0vvH55B+2l7evR5+htoYueu9EVQVerdyAop9vCvOO/EOYuginMI7DZYeRh2JOD5XxdQfGBuFDmpliGTV1mu1symqmhKEl1YHEm4QruqZ0jbg9N7YkiM/tMoJ1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922374; c=relaxed/simple;
	bh=qCLlk4HVTAa57f8FHmdg3BLfrpyrsJDsQ1lSvK4+gPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLn7oP0WwjjSUPfU7P8b/Nrzso7Kl+vtMq4cH1erL+IGY6Y7JfhrBShHlSbOAx+0t8DA3Yyhu5WLsJlTFFksClo8ZkEOFPLvUwC9cvxjUBl34ininfNnbJ5ZnD6BF8z5k0Bq8eGUrpz7vYe8C4ptTI1U6ZJwTu0qW6NJjqucOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZtjjhM8; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZtjjhM8"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C7B51F0C6;
	Thu, 20 Jun 2024 18:26:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qCLlk4HVTAa57f8FHmdg3BLfrpyrsJDsQ1lSvK
	4+gPA=; b=PZtjjhM8wxTawmJfUF8kc5HrW9Ghm/50cMu7mGbUtf7Po45aBtjNjz
	6dHiy7DAMa3KHYmir5xobJ76SbQHKGZdRUpMZ7AwHi5oAzTLJDQg1vmzZaE0wN/q
	xSyjR8gFrSuTMU0N/5JARZqJtM4YffkcJQWhrc1AyNNJZ0+LqLomU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 851221F0C5;
	Thu, 20 Jun 2024 18:26:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E84F91F0C4;
	Thu, 20 Jun 2024 18:26:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 12/17] mktree: create tree using an in-core index
In-Reply-To: <2333775ba5bd71766a6aece87e39a6d189aeaead.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:58:00
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<2333775ba5bd71766a6aece87e39a6d189aeaead.1718834285.git.gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 15:26:09 -0700
Message-ID: <xmqqtthnqmim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18AFB432-2F54-11EF-837F-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -60,17 +66,25 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
>  	if (literally) {
>  		FLEX_ALLOC_MEM(ent, name, path, len);
>  	} else {
> +		size_t len_to_copy = len;
> +
>  		/* Normalize and validate entry path */
>  		if (S_ISDIR(mode)) {
> -			while(len > 0 && is_dir_sep(path[len - 1]))
> -				len--;
> +			while(len_to_copy > 0 && is_dir_sep(path[len_to_copy - 1]))

Let's fix the style issue while at it, as we are doing other changes
in this step anyway.  "while(" -> "while (".

> +				len_to_copy--;
> +			len = len_to_copy + 1; /* add space for trailing slash */

Do we need to do st_add() here?  Perhaps not, but I just noticed the
careful use of st_add3() below, so...

> +		ent = xcalloc(1, st_add3(sizeof(struct tree_entry), len, 1));

> +		memcpy(ent->name, path, len_to_copy);
>  
>  		if (!verify_path(ent->name, mode))
>  			die(_("invalid path '%s'"), path);
>  		if (strchr(ent->name, '/'))
>  			die("path %s contains slash", path);
> +
> +		/* Add trailing slash to dir */
> +		if (S_ISDIR(mode))
> +			ent->name[len - 1] = '/';

OK.

> @@ -88,11 +102,14 @@ static int ent_compare(const void *a_, const void *b_, void *ctx)
>  	struct tree_entry *b = *(struct tree_entry **)b_;
>  	int ignore_mode = *((int *)ctx);
>  
> -	if (ignore_mode)
> -		cmp = name_compare(a->name, a->len, b->name, b->len);
> -	else
> -		cmp = base_name_compare(a->name, a->len, a->mode,
> -					b->name, b->len, b->mode);
> +	size_t a_len = a->len, b_len = b->len;
> +
> +	if (ignore_mode) {
> +		a_len = df_path_len(a_len, a->mode);
> +		b_len = df_path_len(b_len, b->mode);
> +	}
> +
> +	cmp = name_compare(a->name, a_len, b->name, b_len);
>  	return cmp ? cmp : b->order - a->order;
>  }

OK, now the "mode" is sort of "encoded" already in the "name" by the
slash at the end, the way "ignore-mode" works needs to be redesigned.

If we are ignoring mode, we are dropping the trailing '/' and
otherwise we just feed the name with possible trailing '/', and the
same name_compare() can be used.  OK.

> @@ -108,8 +125,8 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
>  	for (size_t i = 0; i < count; i++) {
>  		struct tree_entry *curr = arr->entries[i];
>  		if (prev &&
> -		    !name_compare(prev->name, prev->len,
> -				  curr->name, curr->len)) {
> +		    !name_compare(prev->name, df_path_len(prev->len, prev->mode),
> +				  curr->name, df_path_len(curr->len, curr->mode))) {
>  			FREE_AND_NULL(curr);

And here is the matching adjustment for the dedup comparison, which
makes sense.

> @@ -122,24 +139,43 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
>  	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
>  }
>  
> +static int add_tree_entry_to_index(struct index_state *istate,
> +				   struct tree_entry *ent)
> +{
> +	struct cache_entry *ce;
> +	struct strbuf ce_name = STRBUF_INIT;
> +	strbuf_add(&ce_name, ent->name, ent->len);
> +

Perhaps swap the first statement (which is strbuf_add()) and the
blank line that ought to separate the decls and the first statement?

> +	ce = make_cache_entry(istate, ent->mode, &ent->oid, ent->name, 0, 0);
> +	if (!ce)
> +		return error(_("make_cache_entry failed for path '%s'"), ent->name);
> +
> +	add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
> +	strbuf_release(&ce_name);
> +	return 0;
> +}

This is only to append; presumably the caller drives this function
out of a sorted list.

>  static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
>  {
> +	struct index_state istate = INDEX_STATE_INIT(the_repository);
> +	istate.sparse_index = 1;
>  
>  	sort_and_dedup_tree_entry_array(arr);
>  
> +	/* Construct an in-memory index from the provided entries */
>  	for (size_t i = 0; i < arr->nr; i++) {
>  		struct tree_entry *ent = arr->entries[i];
> +
> +		if (add_tree_entry_to_index(&istate, ent))
> +			die(_("failed to add tree entry '%s'"), ent->name);
>  	}
> +	/* Write out new tree */
> +	if (cache_tree_update(&istate, WRITE_TREE_SILENT | WRITE_TREE_MISSING_OK))
> +		die(_("failed to write tree"));

Hmph.  Are we doing any run-time verification of what we produce
(e.g., if sort_and_dedup_tree_entry_array() fails to dedup or sort
correctly due to a bug or two, would cache_tree_update() notice that
the in-core index array is fishy)?  I am not suggesting to add an
unconditional "we appended to the index, so we should sort the
entries in it" step before cache_tree_update() call.  It is the
opposite---if we have extra checks in cache_tree_udpate() to slow us
down and if we are confident that the loop that added tree entries
to the index is correct, if we can bypass such checks.

> +	oidcpy(oid, &istate.cache_tree->oid);
> +
> +	release_index(&istate);
>  }

This is the gem of the whole series.  Clever.

What is so satisfying is that it takes not that much of code to
replace the "here is a flat buffer of what the contents of a single
tree object ought to look like" with "let's build in-core index and
write it out just like write-tree would".  Nice.
