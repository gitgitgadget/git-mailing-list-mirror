Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA14C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 00:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C00B61074
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 00:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhITAo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 20:44:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53802 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhITAo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 20:44:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DFF8F0B33;
        Sun, 19 Sep 2021 20:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MhSMP86GtzHwtSSyjxRdgX0FGEWMLkVBd3qZ+1XeRqY=; b=xma0
        honsQ6439o0O1ohIuJNj921WW3tGHz/9m56kXuPptgmZ/rtPmTtpmpDVwZItOWfR
        EXUpBNwxbVs9kFbwZIsF1i0mBdijn7Jx+Gqd/iAp/1qknT206xBRNrUmN/u0/s36
        PHMweMiJTTlcuuA3GlxFi79kdeiALRJL7jffrow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 542AAF0B32;
        Sun, 19 Sep 2021 20:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AAF1F0B31;
        Sun, 19 Sep 2021 20:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
        <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
Date:   Sun, 19 Sep 2021 17:42:57 -0700
Message-ID: <xmqq8rzsdqlq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3B1D6A2-19AB-11EC-B2D3-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/repo-settings.c b/repo-settings.c
> index 309577f6bc..d00b675687 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -2,6 +2,8 @@
>  #include "config.h"
>  #include "repository.h"
>  
> +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
> +
>  void prepare_repo_settings(struct repository *r)
>  {
>  	int value;
> @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
>  		r->settings.core_commit_graph = value;
>  	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>  		r->settings.gc_write_commit_graph = value;
> +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
> +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);


This is a "review comment" that is more than 2 years late X-<, but I
noticed that this is used to muck with a structure that was
initialized by filling it with \0377 bytes.

+           /* Defaults */
+           memset(&r->settings, -1, sizeof(r->settings));

but the structure is is full of "int" and "enum", so apparently this
works only on 2's complement architecture.

        struct repo_settings {
                int initialized;

                int core_commit_graph;
                int commit_graph_read_changed_paths;
                int gc_write_commit_graph;
                int fetch_write_commit_graph;

                int index_version;
                enum untracked_cache_setting core_untracked_cache;

                int pack_use_sparse;
                enum fetch_negotiation_setting fetch_negotiation_algorithm;

                int core_multi_pack_index;

                unsigned command_requires_full_index:1,
                         sparse_index:1;
        };

I see that the earliest iteration of this series [*1*] set the
default explicitly using assignments of the correct types, like
this:


+void prepare_repo_settings(struct repository *r)
+{
+       if (r->settings)
+          return;
+
+       r->settings = xmalloc(sizeof(*r->settings));
+
+       /* Defaults */
+       r->settings->core_commit_graph = -1;
+       r->settings->gc_write_commit_graph = -1;
+       r->settings->pack_use_sparse = -1;
+       r->settings->index_version = -1;
+ ...

which I think should be a reasonable starting point to fix the
current code.

Another thing I noticed is that while it may have been only for
setting the default value for a boolean variable initially, other
changes abuse the macro to set an arbitrary integer values to
integer members of the structure, e.g. c6cc4c5a (repo-settings:
create feature.manyFiles setting, 2019-08-13) sets 4 to the
index_version (naturally, the choice between 0 and 1 does not make
much sense for the member), and ad0fb659 (repo-settings: parse
core.untrackedCache, 2019-08-13) stuffs UNTRACKED_CACHE_* enum to
core_untracked_cache.  The UPDATE_DEFAULT_BOOL() macro should be
renamed to UPDATE_DEFAULT_INT() at least, I would think, to save
readers from confusion.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/72f652b89c71526cc423e7812de66f41a079f181.1563818059.git.gitgitgadget@gmail.com/
