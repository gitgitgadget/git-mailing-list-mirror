Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E2BC25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiHDXXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 19:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiHDXXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 19:23:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF14B48B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 16:23:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D94321BFEF4;
        Thu,  4 Aug 2022 19:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cQ53B9g1Oax8ilx977HCqumrZ2uZ78Zhc5D6+2
        +q9og=; b=aR/GvmFCXNUZGpamUxk6tprjbn6Pi4lX1IXTKqWbsJsJ1KVVlAyadJ
        QOZLsOMkx0sEaeCjgVinCT3wpmiF0xXZtobkWSTKtOK7mlAs7b9NDz27BKFe+46e
        Nm4pwgFqcLFnXGamp91IIPyodOpgw935tcNvcph3nEOVgUa66iHqM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D15021BFEF3;
        Thu,  4 Aug 2022 19:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 835FE1BFEF2;
        Thu,  4 Aug 2022 19:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 4/4] unpack-trees: handle missing sparse directories
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <016971a67112efe2d15fe7908e86c5d2631f8e66.1659645967.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 16:23:12 -0700
In-Reply-To: <016971a67112efe2d15fe7908e86c5d2631f8e66.1659645967.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Thu, 04 Aug 2022 20:46:07
        +0000")
Message-ID: <xmqqa68j1tlr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69542640-144C-11ED-B709-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> If a sparse directory does not exist in the index, unpack it at the
> directory level rather than recursing into it an unpacking its contents
> file-by-file. This helps keep the sparse index as collapsed as possible in
> cases such as 'git reset --hard' restoring a sparse directory.

My reading hiccuped at "does not exist in".  After reading the above
twice, I think the situation is that there is a directory A/B in
which a file C sits, and A/ is marked as sparse and the paragraph is
talking about directory A/B.  Because the index has A/ as a tree in
index, A/B does not exist in the index.

When we _somehow_ need to ensure that A/B exists in the index for
_unknown_ reason, we could flatten the index fully and have A/B/C as
a blob (without A or A/B in the index proper, even though they may
appear in cache-tree), but if we stop at removing A and adding A/B
still as a tree without showing A/B/C in the index, we may gain
efficiency, under the assumption that we do not have to access A/B/C
and its siblings.

Did I read the intention correctly?  I suspect future readers of the
commit that would result from this patch would also wonder what the
"somehow" and "unknown" above are.

> A directory is determined to be truly non-existent in the index (rather than
> the parent of existing index entries), if 1) its path is outside the sparse
> cone and 2) there are no children of the directory in the index. This check
> is performed by 'missing_dir_is_sparse()' in 'unpack_single_entry()'. If the
> directory is a missing sparse dir, 'unpack_single_entry()'  will proceed
> with unpacking it. This determination is also propagated back up to
> 'unpack_callback()' via 'is_missing_sparse_dir' to prevent further tree
> traversal into the unpacked directory.

Makes sense.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 8a454e03bff..aa62cef20fe 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1069,6 +1069,53 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
>  	return ce;
>  }
>  
> +/*
> + * Determine whether the path specified corresponds to a sparse directory
> + * completely missing from the index. This function is assumed to only be
> + * called when the named path isn't already in the index.
> + */
> +static int missing_dir_is_sparse(const struct traverse_info *info,
> +				 const struct name_entry *p)
> +{
> +	int res, pos;
> +	struct strbuf dirpath = STRBUF_INIT;
> +	struct unpack_trees_options *o = info->data;
> +
> +	/*
> +	 * First, check whether the path is in the sparse cone. If it is,
> +	 * then this directory shouldn't be sparse.
> +	 */
> +	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
> +	strbuf_add(&dirpath, p->path, p->pathlen);
> +	strbuf_addch(&dirpath, '/');
> +	if (path_in_cone_mode_sparse_checkout(dirpath.buf, o->src_index)) {
> +		res = 0;
> +		goto cleanup;
> +	}

OK.

> +	/*
> +	 * Given that the directory is not inside the sparse cone, it could be
> +	 * (partially) expanded in the index. If child entries exist, the path
> +	 * is not a missing sparse directory.
> +	 */
> +	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
> +	if (pos >= 0)
> +		BUG("cache entry '%s%s' shouldn't exist in the index",
> +		    info->traverse_path, p->path);

So, we fed 'p' to this function, and we didn't expect it to exist in
the index if it is outside the sparse cone.

> +	pos = -pos - 1;

This is the location that a cache entry for the dirpath.buf would
sit in the index if it were a sparse entry.

> +	if (pos >= o->src_index->cache_nr) {
> +		res = 1;
> +		goto cleanup;
> +	}
> +	res = strncmp(o->src_index->cache[pos]->name, dirpath.buf, dirpath.len);

So, we found where dirpath.buf would be inserted.  If we (can) look
at the cache entry that is currently sitting at that position, and
find that it is a path inside it, then res becomes zero.  IOW, we
found that the sparse directory is missing in the index, but there
is a path that is in the directory recorded in the index.

The current entry, on the other hand, is outside the dirpath.buf,
then res becomes non-zero.  We are asked to yield true (i.e.
nonzero) if and only if the given directory and all paths in that
directory are missing from the index, so that is what happens here.
Sounds OK.

And the "out of bounds" check just means that the entries that sit
near the end of the index sort strictly before our dirpath.buf, so
they cannot be inside our directory, which is also the case where we
are expected to yield "true".

OK.

> +
> +cleanup:
> +	strbuf_release(&dirpath);
> +	return res;
> +}
> +
>  /*
>   * Note that traverse_by_cache_tree() duplicates some logic in this function
>   * without actually calling it. If you change the logic here you may need to
> @@ -1078,21 +1125,40 @@ static int unpack_single_entry(int n, unsigned long mask,
>  			       unsigned long dirmask,
>  			       struct cache_entry **src,
>  			       const struct name_entry *names,
> -			       const struct traverse_info *info)
> +			       const struct traverse_info *info,
> +			       int *is_missing_sparse_dir)
>  {
>  	int i;
>  	struct unpack_trees_options *o = info->data;
>  	unsigned long conflicts = info->df_conflicts | dirmask;
> +	const struct name_entry *p = names;
>  
> -	if (mask == dirmask && !src[0])
> -		return 0;
> +	*is_missing_sparse_dir = 0;
> +	if (mask == dirmask && !src[0]) {
> +		/*
> +		 * If the directory is completely missing from the index but
> +		 * would otherwise be a sparse directory, we should unpack it.
> +		 * If not, we'll return and continue recursively traversing the
> +		 * tree.
> +		 */
> +		if (!o->src_index->sparse_index)
> +			return 0;
> +
> +		/* Find first entry with a real name (we could use "mask" too) */
> +		while (!p->mode)
> +			p++;
> +
> +		*is_missing_sparse_dir = missing_dir_is_sparse(info, p);
> +		if (!*is_missing_sparse_dir)
> +			return 0;

Interesting.  Nobody checked if the name in 'p' is a directory up to
this point, but missing_dir_is_sparse() does not care?  The only
thing we know is that !src[0], so the name represented by 'p' does
not exist in the index.  IIRC, the function only checked if p names
a path inside or outside the sparse cone and if there are or are not
paths that would be inside the path if p _were_ a directory but I
didn't read it carefully what it did when the caller fed a path to a
non-directory to the function.  As long as it will say "no" to such
a situation, I won't complain, but I have to wonder how the logic
around here tells apart a case where a sparse directory is
completely hidden (which missing_dir_is_sparse() gives us) from a
case where there is absolutely nothing, not a directory and not a
blob, at the path in the index.  Or perhaps it works correctly
without having to tell them apart?  I dunno.

By the way, there is a comment before the function that reminds us
that traverse_by_cache_tree() may need a matching change whenever a
change is made to this function.  Does this require such a matching
change?
