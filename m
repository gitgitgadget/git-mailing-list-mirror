Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7DC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 07:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbiEUHq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354876AbiEUHqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 03:46:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876D12A97
        for <git@vger.kernel.org>; Sat, 21 May 2022 00:46:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10DCC1A0943;
        Sat, 21 May 2022 03:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3D/MzfeVu+M5qvr3qOYc09KqGSQL/t0ilmWocqI7Jdw=; b=vIWj
        8jrHNdP+MtZ/26ir49PgjESGZoonURJCTmPLsL/wyzjHWpcDxK3YtpHtKc5INrdm
        2jM0tfdLcFbarvO89BBZgayy0vTbLv1UznCeev0/VLSblOVOfNXOIpg+hkTqZVpo
        siPG0hPLO/eA9zsKvYZtxUAfceHMXUAnrJ52ZUs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09E041A0942;
        Sat, 21 May 2022 03:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2C5D1A0940;
        Sat, 21 May 2022 03:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 00:45:57 -0700
Message-ID: <xmqqsfp3coqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DC08AE2-D8DA-11EC-88A3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (pl && !pl->use_cone_patterns) {
>  		pl = NULL;
> +	} else {
> +		/*
> +		 * We might contract file entries into sparse-directory
> +		 * entries, and for that we will need the cache tree to
> +		 * be recomputed.
> +		 */
> +		cache_tree_free(&istate->cache_tree);
> +
> +		/*
> +		 * If there is a problem creating the cache tree, then we
> +		 * need to expand to a full index since we cannot satisfy
> +		 * the current request as a sparse index.
> +		 */
> +		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
> +			pl = NULL;
> +	}

So, if the current index has some irrelevant (i.e. do not match the
pattern list) subtrees in collapsed form, presense of an unmerged
entry, presumably inside the cone(s) we are interested in, makes us
lose the pattern list here, and we end up expanding everything?

I suspect that is a situation that is not so uncommon.  Working
inside a narrow cone of a wide tree, performing a merge would
hopefully allow many subtrees that are outside of the cones of our
interest merged without getting expanded at all (e.g. only the other
side touched these subtrees we are not working on, so their version
will become the merge result), while changes to some paths in the
cone of our interest may result in true conflicts represented as
cache entries at higher stages, needing conflict resolution
concluded with "git add".  Having to expand these subtrees that we
managed to merge while still collapsed, only because we have
conflicts in some other parts of the tree, feels somewhat sad.

By the way, why are we passing the "--missing-ok" option to "git
write-tree" here?

> @@ -330,11 +352,22 @@ void expand_to_pattern_list(struct index_state *istate,
>  		struct cache_entry *ce = istate->cache[i];
>  		struct tree *tree;
>  		struct pathspec ps;
> +		int dtype;
>  
>  		if (!S_ISSPARSEDIR(ce->ce_mode)) {
>  			set_index_entry(full, full->cache_nr++, ce);
>  			continue;
>  		}
> +
> +		/* We now have a sparse directory entry. Should we expand? */
> +		if (pl &&
> +		    path_matches_pattern_list(ce->name, ce->ce_namelen,
> +					      NULL, &dtype,
> +					      pl, istate) == NOT_MATCHED) {
> +			set_index_entry(full, full->cache_nr++, ce);
> +			continue;
> +		}
> +
>  		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
>  			warning(_("index entry is a directory, but not sparse (%08x)"),
>  				ce->ce_flags);
> @@ -360,7 +393,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  	/* Copy back into original index. */
>  	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
>  	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
> -	istate->sparse_index = 0;
> +	istate->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
>  	free(istate->cache);
>  	istate->cache = full->cache;
>  	istate->cache_nr = full->cache_nr;
> @@ -374,7 +407,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  
>  	/* Clear and recompute the cache-tree */
>  	cache_tree_free(&istate->cache_tree);
> -	cache_tree_update(istate, 0);
> +	cache_tree_update(istate, WRITE_TREE_MISSING_OK);

The same question here.  We didn't say "missing trees are OK".  What
made it OK in this change?

