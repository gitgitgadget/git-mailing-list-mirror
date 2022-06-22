Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 13:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiFVNEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 09:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVNEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 09:04:36 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2917046
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 06:04:34 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 42B6E3F4808;
        Wed, 22 Jun 2022 09:04:34 -0400 (EDT)
Received: from jeffhost-mbp.local (addr-66.249.231.194.nptpop-cmts01-cable-sub.rdns-bnin.net [66.249.231.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2A0363F4807;
        Wed, 22 Jun 2022 09:04:33 -0400 (EDT)
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <cover.1655817253.git.dyroneteng@gmail.com>
 <8735ae99798a43650acb9a1df7ba2072c7758476.1655817253.git.dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4176c5af-43fd-b7a1-346c-4d4aa9dbd4ae@jeffhostetler.com>
Date:   Wed, 22 Jun 2022 09:04:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8735ae99798a43650acb9a1df7ba2072c7758476.1655817253.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/21/22 9:25 AM, Teng Long wrote:
> It's supported for a repo to use bitmap in both single-pack bitmap
> way or a multi-pack(MIDX) bitmap. Either of two bitmap kinds can
> exist in the repository, or both can be stored but let the config
> controls which kind of bitmap is used (like "core.multipackIndex",
> etc.). Because of this, sometimes the bitmap debug path is not
> obvious enough, for example, when executing:
> 
>   $ git rev-list  --test-bitmap  HEAD
>   fatal: failed to load bitmap indexes
> 
> When the output look like this, it's unclear which kind(s) of
> .bitmap exist, and which were read. For example, it's possible a MIDX
> bitmap exists, but was not read (e.g., because
> core.multiPackIndex=false), among many other scenarios.
> 
> Therefore, we added some trace2 code so that when we read the bitmap
> we can be more clear about the decision path, such as whether it is
> working on MIDX or single-pack bitmap at present, or the related config
> is enabled or not. This may help with logging, user troubleshooting, and
> development debugging.
> 
> Here are some brief output (omitted some unrelated or repetitive rows
> and columns, using "..." instead of) examples on two scenarios when
> executing:
> 
>    $ GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD
> 
> Scenario 1:
>    core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [N]
> 
>    ...
>    ... | main                     | data         | r1  | ... | config       | core.multipackindex:false
>    ... | d0 | main                | region_enter | r1  | ... | pack-bitmap  | label:open_bitmap
>    ... | d0 | main                | data         | r1  | ... | bitmap       | ..path:.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
>    ... | main                     | region_leave | r1  | ... | pack-bitmap  | label:open_bitmap
>    ... | main                     | error        |     | ... |              | failed to load bitmap indexes
>    fatal: failed to load bitmap indexes
>    ... | d0 | main                | exit         |     | ... |              | code:128
>    ...
> 
> Scenario 2:
>    core.multipackIndex [false], MIDX bitmap exists [Y], single-pack bitmap exists [Y]
> 
>    ... | d0 | main                | region_enter | r0  | ... | pack-bitmap  | label:open_bitmap
>    ... | d0 | main                | data         | r0  | ... | bitmap       | ..path:/home/tenglong.tl/test/dyrone_bitmap/.git/objects/pack/pack-e9eb18e6a423057f4424a762069e13804a75d01e.bitmap
>    ... | main                     | region_leave | r0  | ... | pack-bitmap  | label:open_bitmap
>    Bitmap v1 test (1 entries loaded)
>    Found bitmap for d864fefa87415d6cd289c72aa9ffd45b4a8ffd84. 64 bits / 11030517 checksum
>    ... | main                     | region_enter | r0  | ... | progress     | label:Verifying bitmap entries
>    Verifying bitmap entries: 100% (3/3), done.
>    ... | main                     | data         | r0  | ... | progress     | ..total_objects:3
>    ... | main                     | region_leave | r0  | ... | progress     | label:Verifying bitmap entries
>    OK!
>    ... | d0 | main                | exit         |     | ... |              | code:0
>    ...
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>   pack-bitmap.c   | 21 ++++++++++++++++-----
>   repo-settings.c | 22 ++++++++++++----------
>   2 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index a54d5a0c9f..c39d722592 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -312,9 +312,12 @@ char *pack_bitmap_filename(struct packed_git *p)
>   static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>   			      struct multi_pack_index *midx)
>   {
> +	int fd;
>   	struct stat st;
> +
>   	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	trace2_data_string("midx", the_repository, "path", bitmap_name);
> +	fd = git_open(bitmap_name);
>   
>   	free(bitmap_name);
>   
> @@ -346,8 +349,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>   	if (load_bitmap_header(bitmap_git) < 0)
>   		goto cleanup;
>   
> -	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
> +	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum)) {
> +		error(_("midx and bitmap checksum don't match"));
>   		goto cleanup;
> +	}
>   
>   	if (load_midx_revindex(bitmap_git->midx) < 0) {
>   		warning(_("multi-pack bitmap is missing required reverse index"));
> @@ -374,6 +379,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>   		return -1;
>   
>   	bitmap_name = pack_bitmap_filename(packfile);
> +	trace2_data_string("bitmap", the_repository, "path", bitmap_name);
>   	fd = git_open(bitmap_name);
>   	free(bitmap_name);
>   
> @@ -509,11 +515,16 @@ static int open_midx_bitmap(struct repository *r,
>   static int open_bitmap(struct repository *r,
>   		       struct bitmap_index *bitmap_git)
>   {
> -	assert(!bitmap_git->map);
> +	int ret = 0;
>   
> +	assert(!bitmap_git->map);
> +	trace2_region_enter("pack-bitmap", "open_bitmap", r);
>   	if (!open_midx_bitmap(r, bitmap_git))
> -		return 0;
> -	return open_pack_bitmap(r, bitmap_git);
> +		goto done;
> +	ret = open_pack_bitmap(r, bitmap_git);
> +done:
> +	trace2_region_leave("pack-bitmap", "open_bitmap", r);
> +	return ret;
>   }
>   
>   struct bitmap_index *prepare_bitmap_git(struct repository *r)
> diff --git a/repo-settings.c b/repo-settings.c
> index b4fbd16cdc..115d96ece3 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -4,10 +4,12 @@
>   #include "midx.h"
>   
>   static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
> -			  int def)
> +			  int def, int trace)
>   {
>   	if (repo_config_get_bool(r, key, dest))
>   		*dest = def;
> +	if (trace)
> +		trace2_data_string("config", r, key, *dest ? "true" : "false");
>   }
>   

(I just sent a response to your V2 before I saw your V3, so I'll
my response here so that it doesn't get lost.)


We should not be doing this.  This would dump every repo-related
boolean value on every command.  I see that in V3 that you have
a "trace" flag to control this.  But again, this seems wrong here.

I already have a GIT_TRACE2_CONFIG_PARAMS and trace2.configparams
that will dump "interesting" config values to the trace2 log.
Just set one of them to a list of regex's.  Look at the comment above
trace2_cmd_list_config() in trace2.h for details.

We also have GIT_TRACE2_ENV_VARS and trace2.envvars that will dump
the values of "interesting" env vars.

You can use these in your testing to log the config and env var
values that you are interested in.


>   void prepare_repo_settings(struct repository *r)
> @@ -29,8 +31,8 @@ void prepare_repo_settings(struct repository *r)
>   	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>   
>   	/* Booleans config or default, cascades to other settings */
> -	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> -	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
> +	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0, 0);
> +	repo_cfg_bool(r, "feature.experimental", &experimental, 0, 0);
>   
>   	/* Defaults modified by feature.* */
>   	if (experimental) {
> @@ -42,13 +44,13 @@ void prepare_repo_settings(struct repository *r)
>   	}
>   
>   	/* Boolean config or default, does not cascade (simple)  */
> -	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> -	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
> -	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
> -	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
> -	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
> -	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
> -	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
> +	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1, 0);
> +	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1, 0);
> +	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1, 0);
> +	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0, 0);
> +	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1, 0);
> +	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1, 1);
> +	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0, 0);

So if I'm reading this right, this will only print the value of
"core.multipackindex".

You can get this without the changes here using

GIT_TRACE2_CONFIG_PARAMS="core.multipackindex,...any_other_values_of_interest..."
before running the command (or use the config setting) before running
your commandss.

Alternatively, just emit a "trace2_data_intmax()" on the one value your
want to print here.

Jeff


>   
>   	/*
>   	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
> 
