Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B50C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352645AbiETSSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352686AbiETSSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:18:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8E32ED58
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:18:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 610FE19BE45;
        Fri, 20 May 2022 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F2bC98FXUokHOEomOyNpIZ6ng1AzGJJzzTNTIj
        O42/I=; b=bjkUIxM3+vbaD/gHnbYVTDp54vq/0aah8G5uZc298SHb7JsGVvwHK1
        0Ijt98NqGGuqEYm0NTs/knUmZ65XaMwcdlCmafCWhKJll6kz1JpYcDMQazS14Dzw
        KTiXyLHsupMR/tuyRLn6DhEESExt3/sWTlostB3wPjjQt0zPADJsQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5915619BE44;
        Fri, 20 May 2022 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01F0519BE43;
        Fri, 20 May 2022 14:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 07/10] sparse-index: partially expand directories
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <346c56bf2560c5a89850ef4f8a58fbe17cde10fc.1652982759.git.gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 11:17:32 -0700
In-Reply-To: <346c56bf2560c5a89850ef4f8a58fbe17cde10fc.1652982759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 May 2022
        17:52:35 +0000")
Message-ID: <xmqqbkvshxvn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EB90F2A-D869-11EC-A11D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -231,18 +236,41 @@ static int add_path_to_index(const struct object_id *oid,
>  			     struct strbuf *base, const char *path,
>  			     unsigned int mode, void *context)
>  {

OK, this function is a callback of read_tree_at(), whose caller is
walking the source (=current) index, and while it is copying
existing non-directory entries to the destination (=ctx->write)
index, it found a tree in the source in-core index that does not
match the cone pattern (or we are expanding fully).  Our job is to
expand the given tree as a "subdirectory" in the project into the
destination index.

We used to just let the calling read_tree_at() fully and recursively
walk the tree while adding any non-tree entries to the destination.
Now, we have the pattern list in the context, we go more selective.

The design makes sense.

> +	struct modify_index_context *ctx = (struct modify_index_context *)context;
>  	struct cache_entry *ce;
>  	size_t len = base->len;
>  
> +	if (S_ISDIR(mode)) {
> +		int dtype;
> +		size_t baselen = base->len;
> +		if (!ctx->pl)
> +			return READ_TREE_RECURSIVE;

Fully recursive case.  We can do without any match, just like the
caller (i.e. expand_to_pattern_list) did, when the pattern list is
NULL.

> +		/*
> +		 * Have we expanded to a point outside of the sparse-checkout?
> +		 */
> +		strbuf_addstr(base, path);
> +		strbuf_add(base, "/-", 2);
> +
> +		if (path_matches_pattern_list(base->buf, base->len,
> +					      NULL, &dtype,
> +					      ctx->pl, ctx->write)) {

If that sample path in the directory matches (MATCHED or
MATCHED_RECURSIVE) the patterns, we recurse into the tree to expand.

Can the function return UNDECIDED here?  If so what should happen?
As written, the code will behave as if it matched, and it is not
quite clear if that is the behaviour intended by this patch or an
accident.

> +			strbuf_setlen(base, baselen);
> +			return READ_TREE_RECURSIVE;
> +		}

The caller found a tree at path <path> in the index.  We check if
our patterns match a fictitious path <path> + "/-", which may exist
if the <path> is a directory and if there is a funny named file or
directory "-" in it.

Why "-"?  Are we trying ot see if "ctx->pl" matches "anything" in
the directory that is at <path>?  Is the assumption here that pl
only names directories literally without blobs (I presume that is
the same thing as assuming the cone mode)?

I am trying to see if there is a way that expresses the intention of
this code more clearly than using an arbitrary path "-" (and trying
to figure out if I got the intention right in the first place ;-)..

> +		/*
> +		 * The path "{base}{path}/" is a sparse directory. Create the correct
> +		 * name for inserting the entry into the index.
> +		 */
> +		strbuf_setlen(base, base->len - 1);

This removes that phoney "-" while keeping the trailing "/".  Just
like "-" was unclear, understanding this "- 1" requires that the
reader understands why "/-" was used earlier.

The resulting "base" is used in the newly created cache entry to
represent the (unexpanded) directory below, and such a cache entry
is supposed to have a path with a trailing slash, so it makes sense.

> +	} else {
> +		strbuf_addstr(base, path);

For any non-tree thing, we use the given path for the cache entry to
represent it.

> +	}
> +
> +	ce = make_cache_entry(ctx->write, mode, oid, base->buf, 0, 0);
>  	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
> -	set_index_entry(istate, istate->cache_nr++, ce);
> +	set_index_entry(ctx->write, ctx->write->cache_nr++, ce);

And the cache entry (newly created) is added to the destination.
Unlike what happens in the caller (i.e. expand_to_pattern_list) that
moves the cache entry taken from the source index to the destination
index, the caller will discard the cache entry taken from the source
index after read_tree_at() returns, and we create a new instance for
ourselves here, even if we _could_ have reused it (by passing it in
the context structure, for example).

>  	strbuf_setlen(base, len);

And we restore the length of the path in the base to the original
before we return.

>  	return 0;

Returning 0 as opposed to READ_TREE_RECURSIVE here means "we've
dealt with the entry; don't recurse into subtree even if you called
us with a tree", which is the right thing to do here, as we did have
done all we need to here.

OK, except for that "/-" thing, all of the above makes sense to me.

Thanks.

> @@ -254,6 +282,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  	int i;
>  	struct index_state *full;
>  	struct strbuf base = STRBUF_INIT;
> +	struct modify_index_context ctx;
>  
>  	/*
>  	 * If the index is already full, then keep it full. We will convert
> @@ -294,6 +323,9 @@ void expand_to_pattern_list(struct index_state *istate,
>  	full->cache_nr = 0;
>  	ALLOC_ARRAY(full->cache, full->cache_alloc);
>  
> +	ctx.write = full;
> +	ctx.pl = pl;
> +
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		struct cache_entry *ce = istate->cache[i];
>  		struct tree *tree;
> @@ -319,7 +351,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  		strbuf_add(&base, ce->name, strlen(ce->name));
>  
>  		read_tree_at(istate->repo, tree, &base, &ps,
> -			     add_path_to_index, full);
> +			     add_path_to_index, &ctx);
>  
>  		/* free directory entries. full entries are re-used */
>  		discard_cache_entry(ce);
