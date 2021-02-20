Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28084C433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47FB64EE0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTDgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:36:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51636 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTDgx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:36:53 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49BAA1073FC;
        Fri, 19 Feb 2021 22:36:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PJV90s5iN/YBSzsZonz7jP29mYA=; b=RJbwca
        DQQDVCJFXN984IfbL0qGZ+ePnocPhtrMsAbg+IsXlMvfGNO6R2EfNS7IkABdWs6N
        IJKlTMzBjnS9Hbj/3wTYlQ2mgrV2ByDdDFdTEp8O/Et4uDP7U9iACLcf9CWFMtoM
        OzEHWpkFOxTQMFTEG45AN1cfWEC/iEvFKwqLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uI1Lhee97Z1xKbTRrO6nGEItuwRy5Y70
        6Jc0sZKH7ae2BrUlz3q5tDBrRs8f+6qkjupTLgQpJdqAOPfdJT7Tdpvx3hzf+LV7
        ZspmYhjFZcbRRQ0cAWrLZhP1shZoI9A+9HsUb7tJDEY5d3RyV1vFkcKV4UJPViXx
        Z9gxAK8CNQU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4219C1073FB;
        Fri, 19 Feb 2021 22:36:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A57D1073F8;
        Fri, 19 Feb 2021 22:36:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] commit-graph: avoid leaking topo_levels slab in
 write_commit_graph()
References: <pull.881.git.1613765590412.gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 19:36:02 -0800
In-Reply-To: <pull.881.git.1613765590412.gitgitgadget@gmail.com> (Andrzej Hunt
        via GitGitGadget's message of "Fri, 19 Feb 2021 20:13:10 +0000")
Message-ID: <xmqqa6rz9zrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C29E2F74-732C-11EB-AF88-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> write_commit_graph initialises topo_levels using init_topo_level_slab(),
> next it calls compute_topological_levels() which can cause the slab to
> grow, we therefore need to clear the slab again using
> clear_topo_level_slab() when we're done.
>
> First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which
> is currently only in master and not on maint.

Thanks.  

Forwarding to those who were involved in the said commit for
insights.



> LeakSanitizer output:
>
> ==1026==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x498ae9 in realloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3
>     #1 0xafbed8 in xrealloc /src/git/wrapper.c:126:8
>     #2 0x7966d1 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
>     #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
>     #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
>     #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
>     #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
>     #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
>     #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
>     #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
>     #10 0x4cd084 in run_argv /src/git/git.c:771:4
>     #11 0x4ca424 in cmd_main /src/git/git.c:902:19
>     #12 0x707fb6 in main /src/git/common-main.c:52:11
>     #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>
> Indirect leak of 524256 byte(s) in 1 object(s) allocated from:
>     #0 0x498942 in calloc /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
>     #1 0xafc088 in xcalloc /src/git/wrapper.c:140:8
>     #2 0x796870 in topo_level_slab_at_peek /src/git/commit-graph.c:71:1
>     #3 0x7965e0 in topo_level_slab_at /src/git/commit-graph.c:71:1
>     #4 0x78fbf5 in compute_topological_levels /src/git/commit-graph.c:1472:12
>     #5 0x78c5c3 in write_commit_graph /src/git/commit-graph.c:2456:2
>     #6 0x535c5f in graph_write /src/git/builtin/commit-graph.c:299:6
>     #7 0x5350ca in cmd_commit_graph /src/git/builtin/commit-graph.c:337:11
>     #8 0x4cddb1 in run_builtin /src/git/git.c:453:11
>     #9 0x4cabe2 in handle_builtin /src/git/git.c:704:3
>     #10 0x4cd084 in run_argv /src/git/git.c:771:4
>     #11 0x4ca424 in cmd_main /src/git/git.c:902:19
>     #12 0x707fb6 in main /src/git/common-main.c:52:11
>     #13 0x7fee4249383f in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>
> SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).
>
> Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
> ---
>     commit-graph: avoid leaking topo_levels slab in write_commit_graph()
>     
>     write_commit_graph initialises topo_levels using init_topo_level_slab(),
>     next it calls compute_topological_levels() which can cause the slab to
>     grow, we therefore need to clear the slab again using
>     clear_topo_level_slab() when we're done.
>     
>     First introduced in 72a2bfcaf01860ce8dd6921490d903dc0ad59c89 - which is
>     currently only in master and not on maint.
>     
>     LeakSanitizer output:
>     
>     ==1026==ERROR: LeakSanitizer: detected memory leaks
>     
>     Direct leak of 8 byte(s) in 1 object(s) allocated from: #0 0x498ae9 in
>     realloc
>     /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:164:3 #1
>     0xafbed8 in xrealloc /src/git/wrapper.c:126:8 #2 0x7966d1 in
>     topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
>     topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
>     compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
>     in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
>     graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
>     cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
>     run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
>     /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
>     0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
>     /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
>     (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>     
>     Indirect leak of 524256 byte(s) in 1 object(s) allocated from: #0
>     0x498942 in calloc
>     /src/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3 #1
>     0xafc088 in xcalloc /src/git/wrapper.c:140:8 #2 0x796870 in
>     topo_level_slab_at_peek /src/git/commit-graph.c:71:1 #3 0x7965e0 in
>     topo_level_slab_at /src/git/commit-graph.c:71:1 #4 0x78fbf5 in
>     compute_topological_levels /src/git/commit-graph.c:1472:12 #5 0x78c5c3
>     in write_commit_graph /src/git/commit-graph.c:2456:2 #6 0x535c5f in
>     graph_write /src/git/builtin/commit-graph.c:299:6 #7 0x5350ca in
>     cmd_commit_graph /src/git/builtin/commit-graph.c:337:11 #8 0x4cddb1 in
>     run_builtin /src/git/git.c:453:11 #9 0x4cabe2 in handle_builtin
>     /src/git/git.c:704:3 #10 0x4cd084 in run_argv /src/git/git.c:771:4 #11
>     0x4ca424 in cmd_main /src/git/git.c:902:19 #12 0x707fb6 in main
>     /src/git/common-main.c:52:11 #13 0x7fee4249383f in __libc_start_main
>     (/lib/x86_64-linux-gnu/libc.so.6+0x2083f)
>     
>     SUMMARY: AddressSanitizer: 524264 byte(s) leaked in 2 allocation(s).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-881%2Fahunt%2Fcommit-graph-leak-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-881/ahunt/commit-graph-leak-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/881
>
>  commit-graph.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index ed31843fa522..9529ec552139 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2471,6 +2471,7 @@ int write_commit_graph(struct object_directory *odb,
>  	free(ctx->graph_name);
>  	free(ctx->commits.list);
>  	oid_array_clear(&ctx->oids);
> +	clear_topo_level_slab(&topo_levels);
>  
>  	if (ctx->commit_graph_filenames_after) {
>  		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
>
> base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
