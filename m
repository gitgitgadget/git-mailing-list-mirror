Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD9C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A8220898
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nGFkGvlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKUIG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:06:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59137 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKUIG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 03:06:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0709F2FB45;
        Thu, 21 Nov 2019 03:06:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nMCWoKrsWqYvqvIMGNmR9+bg9kg=; b=nGFkGv
        lfnMfXvO5CrM41UgQjrBI2xYbrzmPDmGY5vIPKgxCwdHgTzMdfNAFdXRVzn2xNNu
        eFiIUe3DjSqkN0G5P7UFPfw7RSMhD9cbOdgog8sHrvz5Bu2IDqpBeZKg9UjfZFJX
        OIeUpAvrhfIxNgC+0joSIgATZ3NrQ8QmcZf6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1sVjuEjdQ+YImyzP7enL4FlpMXhF4jj
        60fsWVVv/LWZaDsjcOdQBGiOJcqyW76UWD91jdPD0kMiHYa0C2ylQ/KAr+LnjP9u
        NM1z5TZo/TT8cXeYGKa1EARXUoZx3tBui31oIoX0AGzf7hEO7Ittahs6iWk7SVNj
        O+4ta48bQJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1D592FB44;
        Thu, 21 Nov 2019 03:06:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AF0C2FB43;
        Thu, 21 Nov 2019 03:06:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/8] built-in add -i: allow filtering the modified files list
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <1844c4d55e21c40cbdbfdd73c82b4a1a074ff184.1573821382.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 17:06:25 +0900
In-Reply-To: <1844c4d55e21c40cbdbfdd73c82b4a1a074ff184.1573821382.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 15 Nov 2019
        12:36:15 +0000")
Message-ID: <xmqqeey18xha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0C93DB4-0C35-11EA-8279-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +enum modified_files_filter {
> +	NO_FILTER = 0,
> +	WORKTREE_ONLY = 1,
> +	INDEX_ONLY = 2,
> +};
> +
> +static int get_modified_files(struct repository *r,
> +			      enum modified_files_filter filter,
> +			      struct string_list *files,
>  			      const struct pathspec *ps)
>  {
>  	struct object_id head_oid;
>  	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
>  					     &head_oid, NULL);
>  	struct collection_status s = { FROM_WORKTREE };

Will have a comment on this later.

> +	int i;
>  
>  	if (discard_index(r->index) < 0 ||
>  	    repo_read_index_preload(r, ps, 0) < 0)
> @@ -411,10 +424,16 @@ static int get_modified_files(struct repository *r, struct string_list *files,
>  	s.files = files;
>  	hashmap_init(&s.file_map, pathname_entry_cmp, NULL, 0);
>  
> -	for (s.phase = FROM_WORKTREE; s.phase <= FROM_INDEX; s.phase++) {
> +	for (i = 0; i < 2; i++) {
>  		struct rev_info rev;
>  		struct setup_revision_opt opt = { 0 };
>  
> +		if (filter == INDEX_ONLY)
> +			s.phase = i ? FROM_WORKTREE : FROM_INDEX;
> +		else
> +			s.phase = i ? FROM_INDEX : FROM_WORKTREE;
> +		s.skip_unseen = filter && i;

;-)

Looks somewhat crazy but it works---when the caller wants to do
'index-only' for example we are not interested in paths that did not
appear in the INDEX side of the diff, so we run FROM_INDEX diff first
and then the let next one (i.e. FROM_WORKTREE diff) be skipped for
paths that are not in the result of the first one.  To me personally,
I would find the tertially expession written like this

	s.phase = (i == 0) ? FROM_INDEX : FROM_WORKTREE;

much easier to follow, as it matches the order which ones are done
first.

Also I notice two things.

 - It used to make 100% sense to call this field .phase because we
   always processed the first phase and then on to the second phase,
   where the first one was called WORKTREE and the second one was
   called INDEX.  In the new world order after this step, the name
   .phase no longer makes any sense.  Sometimes we run diff-files in
   phase 0 and diff-index in phase 1, but some other times we run
   diff-index in phase 0 and diff-files in phase 0.  The variable
   that has the closest meaning to the 'phase' is the newly
   introduced 'i'.

 - The initialization of the local "struct collection_status s" at
   the beginning of the function still uses .phase = FROM_WORKTREE
   which might be somewhat misleading.  We cannot remove the whole
   initialization, as the original used to nul initialize the other
   fields in this structure and I suspect the code still relies on
   it, but the initialization of .phase in particular no longer has
   any effect; it always is assigned inside the loop before the
   field gets used.


>  		opt.def = is_initial ?
>  			empty_tree_oid_hex() : oid_to_hex(&head_oid);

By the way, this is not a new issue introduced by this patch, but I
notice copy_pathspec() is used twice on the same rev.prune_data in
this functino.  Who is responsible for releasing the resource held
in this struct?
