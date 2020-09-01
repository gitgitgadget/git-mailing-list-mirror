Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C90C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13322207D3
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MHfVOSEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgIAVGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:06:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63654 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgIAVGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 17:06:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2946476E5E;
        Tue,  1 Sep 2020 17:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1C7x1pzwWQoeocW5qgkrEtmBtPE=; b=MHfVOS
        Ekaymo+FFS9nRR/8A2J/8bujdeSiJiA2V2QkPgZ5aeF5Zsh6+VwXuu9NVaW1GJbX
        utPHdmp5/EDYdVxy5LEz/3VPoo5oqw8xv9Vo/zXe+nTOAA00Ht+eAO2qjeBkpKGN
        olBwtidtAYU495YCm0JZKOvTAvcisOiK/dIqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOWksT7J5dELcx8jZS/5uLHgyXNBHg1O
        DzsbUy/hw8ygfSRQLyLqxYznvGWqsujXnDuRDpchtrOLMDE/fDXyRPV5ol7LxHeZ
        XRDDM0R6tJmG8GAU2HiV3Kd83wMYvGAiSkrRb+mmn/XwwfznLBGVqvKEgZ+elUSz
        U5lAaHkhXOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E9C276E5C;
        Tue,  1 Sep 2020 17:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E73B76E5B;
        Tue,  1 Sep 2020 17:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 02/11] merge-one-file: rewrite in C
References: <20200625121953.16991-1-alban.gruin@gmail.com>
        <20200901105705.6059-1-alban.gruin@gmail.com>
        <20200901105705.6059-3-alban.gruin@gmail.com>
Date:   Tue, 01 Sep 2020 14:06:09 -0700
In-Reply-To: <20200901105705.6059-3-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 1 Sep 2020 12:56:56 +0200")
Message-ID: <xmqqk0xdcim6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F61E2C68-EC96-11EA-B829-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> new file mode 100644
> index 0000000000..306a86c2f0
> --- /dev/null
> +++ b/builtin/merge-one-file.c
> @@ -0,0 +1,85 @@
> +/*
> + * Builtin "git merge-one-file"
> + *
> + * Copyright (c) 2020 Alban Gruin
> + *
> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
> + *
> + * This is the git per-file merge utility, called with
> + *
> + *   argv[1] - original file SHA1 (or empty)
> + *   argv[2] - file in branch1 SHA1 (or empty)
> + *   argv[3] - file in branch2 SHA1 (or empty)
> + *   argv[4] - pathname in repository
> + *   argv[5] - original file mode (or empty)
> + *   argv[6] - file in branch1 mode (or empty)
> + *   argv[7] - file in branch2 mode (or empty)
> + *
> + * Handle some trivial cases. The _really_ trivial cases have been
> + * handled already by git read-tree, but that one doesn't do any merges
> + * that might change the tree layout.
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "lockfile.h"
> +#include "merge-strategies.h"
> +
> +static const char builtin_merge_one_file_usage[] =
> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
> +	"<orig mode> <our mode> <their mode>\n\n"
> +	"Blob ids and modes should be empty for missing files.";
> +
> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
> +{
> +	struct object_id orig_blob, our_blob, their_blob,
> +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
> +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
> +	struct lock_file lock = LOCK_INIT;
> +
> +	if (argc != 8)
> +		usage(builtin_merge_one_file_usage);
> +
> +	if (repo_read_index(the_repository) < 0)
> +		die("invalid index");
> +
> +	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);

I do understand why we would want merge_strategies_one_file() helper
introduced by this step so that the helper can work in an arbitrary
repository (hence taking a pointer to repository structure as one of
its parameters).

But the "merge-one-file" command will always work in the_repository.
I do not see a point in using helpers that can work in an arbitrary
repository, like repo_read_index() or repo_hold_locked_index(), in
the above.  I only see downsides --- it is longer to read, makes
readers wonder if there is something tricky involving another
repository going on, etc.

> +	if (!get_oid(argv[1], &orig_blob)) {
> +		p_orig_blob = &orig_blob;
> +		orig_mode = strtol(argv[5], NULL, 8);

Write a wrapper around strtol(...,...,8) to reduce repetition, and
make sure you do not pass NULL as the second parameter to strtol()
to always check you parsed the string to the end.

> +	ret = merge_strategies_one_file(the_repository,
> +					p_orig_blob, p_our_blob, p_their_blob, argv[4],
> +					orig_mode, our_mode, their_mode);

Here, as I said above, it is perfectly fine to pass
the_repository().

> +	if (ret) {
> +		rollback_lock_file(&lock);
> +		return ret;
> +	}
> +
> +	return write_locked_index(the_repository->index, &lock, COMMIT_LOCK);

Likewise, I do not see much point in saying the_repository->index; the_index
is a perfectly fine short-hand.

> diff --git a/merge-strategies.c b/merge-strategies.c
> new file mode 100644
> index 0000000000..f2af4a894d
> --- /dev/null
> +++ b/merge-strategies.c
> @@ -0,0 +1,199 @@
> +#include "cache.h"
> +#include "dir.h"
> +#include "ll-merge.h"
> +#include "merge-strategies.h"
> +#include "xdiff-interface.h"
> +
> +static int add_to_index_cacheinfo(struct index_state *istate,
> +				  unsigned int mode,
> +				  const struct object_id *oid, const char *path)
> +{
> +	struct cache_entry *ce;
> +	int len, option;
> +
> +	if (!verify_path(path, mode))
> +		return error(_("Invalid path '%s'"), path);
> +
> +	len = strlen(path);
> +	ce = make_empty_cache_entry(istate, len);
> +
> +	oidcpy(&ce->oid, oid);
> +	memcpy(ce->name, path, len);
> +	ce->ce_flags = create_ce_flags(0);
> +	ce->ce_namelen = len;
> +	ce->ce_mode = create_ce_mode(mode);
> +	if (assume_unchanged)
> +		ce->ce_flags |= CE_VALID;
> +	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
> +	if (add_index_entry(istate, ce, option))
> +		return error(_("%s: cannot add to the index"), path);
> +
> +	return 0;
> +}
> +
> +static int checkout_from_index(struct index_state *istate, const char *path)
> +{
> +	struct checkout state = CHECKOUT_INIT;
> +	struct cache_entry *ce;
> +
> +	state.istate = istate;
> +	state.force = 1;
> +	state.base_dir = "";
> +	state.base_dir_len = 0;
> +
> +	ce = index_file_exists(istate, path, strlen(path), 0);
> +	if (checkout_entry(ce, &state, NULL, NULL) < 0)
> +		return error(_("%s: cannot checkout file"), path);
> +	return 0;
> +}
> +
> +static int merge_one_file_deleted(struct index_state *istate,
> +				  const struct object_id *orig_blob,
> +				  const struct object_id *our_blob,
> +				  const struct object_id *their_blob, const char *path,
> +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +	if ((our_blob && orig_mode != our_mode) ||
> +	    (their_blob && orig_mode != their_mode))
> +		return error(_("File %s deleted on one branch but had its "
> +			       "permissions changed on the other."), path);
> +
> +	if (our_blob) {
> +		printf(_("Removing %s\n"), path);
> +
> +		if (file_exists(path))
> +			remove_path(path);
> +	}
> +
> +	if (remove_file_from_index(istate, path))
> +		return error("%s: cannot remove from the index", path);
> +	return 0;
> +}

These functions we see above all are now easy to write these days,
thanks to the previous work that built many helpers to perform ommon
operations (e.g. remove_path()).  Reusing them is very good.

> +static int do_merge_one_file(struct index_state *istate,
> +			     const struct object_id *orig_blob,
> +			     const struct object_id *our_blob,
> +			     const struct object_id *their_blob, const char *path,
> +			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
> +{
> +	int ret, i, dest;
> +	mmbuffer_t result = {NULL, 0};
> +	mmfile_t mmfs[3];
> +	struct ll_merge_options merge_opts = {0};
> +	struct cache_entry *ce;
> +
> +	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
> +		return error(_("%s: Not merging symbolic link changes."), path);
> +	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
> +		return error(_("%s: Not merging conflicting submodule changes."), path);
> +
> +	read_mmblob(mmfs + 1, our_blob);
> +	read_mmblob(mmfs + 2, their_blob);
> +
> +	if (orig_blob) {
> +		printf(_("Auto-merging %s\n"), path);
> +		read_mmblob(mmfs + 0, orig_blob);
> +	} else {
> +		printf(_("Added %s in both, but differently.\n"), path);
> +		read_mmblob(mmfs + 0, &null_oid);
> +	}
> +
> +	merge_opts.xdl_opts = XDL_MERGE_ZEALOUS_ALNUM;
> +	ret = ll_merge(&result, path,
> +		       mmfs + 0, "orig",
> +		       mmfs + 1, "our",
> +		       mmfs + 2, "their",
> +		       istate, &merge_opts);
> +
> +	for (i = 0; i < 3; i++)
> +		free(mmfs[i].ptr);
> +
> +	if (ret > 127 || !orig_blob)
> +		ret = error(_("content conflict in %s"), path);

The original only checked if ret is zero or non-zero; here we
require ret to be large.  Intended?  

ll_merge() that called ll_xdl_merge() (i.e. the most common case)
would return the value returned from xdl_merge(), which can be -1
when we got an error before calling xdl_do_merge().  xdl_do_merge()
in turn can return -1.  The most common case returns the value
returned from xdl_cleanup_merge(), which is 0 for clean merge, and
any positive integer (not clipped to 127 or 128) for conflicted one.

> +	/* Create the working tree file, using "our tree" version from
> +	   the index, and then store the result of the merge. */

Style. (cf. Documentation/CodingGuidelines).

> +	ce = index_file_exists(istate, path, strlen(path), 0);
> +	if (!ce)
> +		BUG("file is not present in the cache?");
> +
> +	unlink(path);
> +	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
> +	write_in_full(dest, result.ptr, result.size);

If open() fails, we write to a bogus file descriptor here.

> +	close(dest);
> +
> +	free(result.ptr);
> +
> +	if (ret && our_mode != their_mode)
> +		return error(_("permission conflict: %o->%o,%o in %s"),
> +			     orig_mode, our_mode, their_mode, path);
> +	if (ret)
> +		return 1;

What is the error returning convention around here?  Our usual
convention is that 0 signals a success, and negative reports an
error.  Returning the value returned from add_file_to_index() below,
and error() above, are consistent with the convention, but this one
returns 1 that is not.  When deviating from convention, it needs to
be documented for the callers in a comment before the function
definition.

> +
> +	return add_file_to_index(istate, path, 0);
> +}



> +int merge_strategies_one_file(struct repository *r,
> +			      const struct object_id *orig_blob,
> +			      const struct object_id *our_blob,
> +			      const struct object_id *their_blob, const char *path,
> +			      unsigned int orig_mode, unsigned int our_mode,
> +			      unsigned int their_mode)
> +{
> +	if (orig_blob &&
> +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
> +	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
> +		/* Deleted in both or deleted in one and unchanged in
> +		   the other */
> +		return merge_one_file_deleted(r->index,
> +					      orig_blob, our_blob, their_blob, path,
> +					      orig_mode, our_mode, their_mode);
> +	else if (!orig_blob && our_blob && !their_blob) {
> +		/* Added in one.  The other side did not add and we
> +		   added so there is nothing to be done, except making
> +		   the path merged. */
> +		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
> +	} else if (!orig_blob && !our_blob && their_blob) {
> +		printf(_("Adding %s\n"), path);
> +
> +		if (file_exists(path))
> +			return error(_("untracked %s is overwritten by the merge."), path);
> +
> +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
> +			return 1;
> +		return checkout_from_index(r->index, path);
> +	} else if (!orig_blob && our_blob && their_blob &&
> +		   oideq(our_blob, their_blob)) {
> +		/* Added in both, identically (check for same
> +		   permissions). */
> +		if (our_mode != their_mode)
> +			return error(_("File %s added identically in both branches, "
> +				       "but permissions conflict %o->%o."),
> +				     path, our_mode, their_mode);
> +
> +		printf(_("Adding %s\n"), path);
> +
> +		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
> +			return 1;
> +		return checkout_from_index(r->index, path);
> +	} else if (our_blob && their_blob)
> +		/* Modified in both, but differently. */
> +		return do_merge_one_file(r->index,
> +					 orig_blob, our_blob, their_blob, path,
> +					 orig_mode, our_mode, their_mode);
> +	else {
> +		char *orig_hex = "", *our_hex = "", *their_hex = "";
> +
> +		if (orig_blob)
> +			orig_hex = oid_to_hex(orig_blob);
> +		if (our_blob)
> +			our_hex = oid_to_hex(our_blob);
> +		if (their_blob)
> +			their_hex = oid_to_hex(their_blob);

Prepare three char [] buffers and use oid_to_hex_r() instead,
instead of relying that we'd have sufficient number of entries in
the rotating buffer.

> +		return error(_("%s: Not handling case %s -> %s -> %s"),
> +			     path, orig_hex, our_hex, their_hex);
> +	}
> +
> +	return 0;
> +}
> diff --git a/merge-strategies.h b/merge-strategies.h
> new file mode 100644
> index 0000000000..b527d145c7
> --- /dev/null
> +++ b/merge-strategies.h
> @@ -0,0 +1,13 @@
> +#ifndef MERGE_STRATEGIES_H
> +#define MERGE_STRATEGIES_H
> +
> +#include "object.h"
> +
> +int merge_strategies_one_file(struct repository *r,
> +			      const struct object_id *orig_blob,
> +			      const struct object_id *our_blob,
> +			      const struct object_id *their_blob, const char *path,
> +			      unsigned int orig_mode, unsigned int our_mode,
> +			      unsigned int their_mode);
> +
> +#endif /* MERGE_STRATEGIES_H */
> diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
> index 2eddcc7664..5fb74e39a0 100755
> --- a/t/t6415-merge-dir-to-symlink.sh
> +++ b/t/t6415-merge-dir-to-symlink.sh
> @@ -94,7 +94,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
>  	test -h a/b
>  '
>  
> -test_expect_failure 'do not lose untracked in merge (resolve)' '
> +test_expect_success 'do not lose untracked in merge (resolve)' '
>  	git reset --hard &&
>  	git checkout baseline^0 &&
>  	>a/b/c/e &&
