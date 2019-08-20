Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25021F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHTVLr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:11:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:11:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5082C16515A;
        Tue, 20 Aug 2019 17:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rxwBNiYrb6ckfw76xrXnwNYovOw=; b=n+M7OK
        rErA+sjEieQcdb2j6Tdlht/5ww28edorgF1re0kLn3+S9PiKG+IJwwPt/Zyrgs+h
        VrijQwBVBv8xxVysRhUx8pn2Dg7lSOm0zriiwgGmKP/gXRI68F/1G0DIkOx7ddje
        v+P1rKStE2rDgHb4eLG4PdaR5+nNQjnfVS7nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rsVd8Yjfd9TWYu8OwCe0ffu7po+vwT4z
        hSnO5naA/cyzNmexKt3IJaTImSwXedVA7rETts+KkOssvz6YT+pzpNzfORNtVUaR
        Nvu6UVbGdjZ8t09G64VVAsjlx9AeZgWq9MGV7EsuMnfHyT82DN+FtajRlN2uYfc0
        4Z3h5upOSOM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4932C165159;
        Tue, 20 Aug 2019 17:11:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2167165157;
        Tue, 20 Aug 2019 17:11:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: add --[no-]progress to write and verify.
References: <pull.315.git.gitgitgadget@gmail.com>
        <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Aug 2019 14:11:43 -0700
In-Reply-To: <da89f7dadb0be2d4ada22dd3e2d1f5524c73f70d.1566326275.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Tue, 20 Aug 2019 11:37:56
        -0700 (PDT)")
Message-ID: <xmqqftlvtucw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D198402-C38F-11E9-B647-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Add --[no-]progress to git commit-graph write and verify.
> The progress feature was introduced in 7b0f229
> ("commit-graph write: add progress output", 2018-09-17) but
> the ability to opt-out was overlooked.

Nicely described.

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 38027b83d9..71796910fc 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -6,17 +6,18 @@
>  #include "repository.h"
>  #include "commit-graph.h"
>  #include "object-store.h"
> +#include "unistd.h"

Please do not contaminate *.c files with #include of system headers.

Often, various platforms require system include files in specific
order, and the project convention is to include them in
git-compat-util.h in the right order (with #ifdef and friends as
necessary).  *.c files are required to include git-compat-util.h (or
one of the well known headers that include git-compat-util.h as the
first one) as the first file.

In fact, "builtin.h" includes "git-compat-util.h" as the first
thing, and "git-compat-util.h" in turn includes unistd reasonably
early.  Do you really need to include it again here?

> @@ -48,16 +50,20 @@ static int graph_verify(int argc, const char **argv)
>  	int fd;
>  	struct stat st;
>  	int flags = 0;
> -
> +	int defaultProgressState = isatty(2);

As you can see from the naming of other variables, we do not do
camelCase variable names.

In fact you do not need this variable, do you?

>  	static struct option builtin_commit_graph_verify_options[] = {
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
>  			   N_("dir"),
>  			   N_("The object directory to store the graph")),
>  		OPT_BOOL(0, "shallow", &opts.shallow,
>  			 N_("if the commit-graph is split, only verify the tip file")),
> +		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_END(),
>  	};
>  
> +	opts.progress = defaultProgressState;

... as you can assign isatty(2) to opts.progress here directly.

> @@ -154,8 +162,9 @@ static int graph_write(int argc, const char **argv)
>  	struct string_list *commit_hex = NULL;
>  	struct string_list lines;
>  	int result = 0;
> -	unsigned int flags = COMMIT_GRAPH_PROGRESS;
> -
> +	unsigned int flags = 0;
> +	int defaultProgressState = isatty(2);

Likewise.

> diff --git a/commit-graph.c b/commit-graph.c
> index fe954ab5f8..b10d47f99a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1986,14 +1986,17 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;
>  
> -	progress = start_progress(_("Verifying commits in commit graph"),
> -				  g->num_commits);
> +	if (flags & COMMIT_GRAPH_PROGRESS)
> +		progress = start_progress(_("Verifying commits in commit graph"),
> +					g->num_commits);

Makes sense.

>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
>  		uint32_t max_generation = 0;
>  
>  		display_progress(progress, i + 1);
> +
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);

Drop this change---I do not see a reason for the extra blank line here.
