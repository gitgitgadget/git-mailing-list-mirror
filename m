Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29490C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D66616EA
	for <git@archiver.kernel.org>; Tue, 11 May 2021 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEKQSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 12:18:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:51910 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhEKQSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 12:18:17 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 45B933F4139;
        Tue, 11 May 2021 12:17:10 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F27DC3F4098;
        Tue, 11 May 2021 12:17:09 -0400 (EDT)
Subject: Re: [PATCH v3 1/8] [RFC] dir: convert trace calls to trace2
 equivalents
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <96679919-f6ea-adcc-b8fc-9eaa0134c876@jeffhostetler.com>
Date:   Tue, 11 May 2021 12:17:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/8/21 3:58 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   dir.c                             |  34 ++++--
>   t/t7063-status-untracked-cache.sh | 193 +++++++++++++++++-------------
>   t/t7519-status-fsmonitor.sh       |   8 +-
>   3 files changed, 135 insertions(+), 100 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 3474e67e8f3c..9f7c8debeab3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2760,12 +2760,29 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>   	return root;
>   }
>   
> +static void trace2_read_directory_statistics(struct dir_struct *dir,
> +					     struct repository *repo)
> +{
> +	if (!dir->untracked)
> +		return;

Is there value to also printing the path?
The existing `trace_performance_leave()` calls were, but
I'm familiar enough with this code to say if the output
wasn't always something like ".".

> +	trace2_data_intmax("read_directory", repo,
> +			   "node-creation", dir->untracked->dir_created);
> +	trace2_data_intmax("read_directory", repo,
> +			   "gitignore-invalidation",
> +			   dir->untracked->gitignore_invalidated);
> +	trace2_data_intmax("read_directory", repo,
> +			   "directory-invalidation",
> +			   dir->untracked->dir_invalidated);
> +	trace2_data_intmax("read_directory", repo,
> +			   "opendir", dir->untracked->dir_opened);
> +}
> +

The existing code was quite tangled and I think this helps
make things more clear.


>   int read_directory(struct dir_struct *dir, struct index_state *istate,
>   		   const char *path, int len, const struct pathspec *pathspec)
>   {
>   	struct untracked_cache_dir *untracked;
>   
> -	trace_performance_enter();
> +	trace2_region_enter("dir", "read_directory", istate->repo);
>   
>   	if (has_symlink_leading_path(path, len)) {
>   		trace_performance_leave("read directory %.*s", len, path);

This `trace_performance_leave()` inside the `if` needs to be
converted too.


> @@ -2784,23 +2801,13 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   	QSORT(dir->entries, dir->nr, cmp_dir_entry);
>   	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
>   
> -	trace_performance_leave("read directory %.*s", len, path);
> +	trace2_region_leave("dir", "read_directory", istate->repo);

Can we put the call to `trace2_read_directory_statistics()` before
the above `trace2_region_leave()` call?   Then those stats will
appear indented between the begin- and end-region events in the output.

That way, the following `if (dir-untracked) {...}` is only
concerned with the untracked cache and/or freeing that data.

>   	if (dir->untracked) {
>   		static int force_untracked_cache = -1;
> -		static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
>   
>   		if (force_untracked_cache < 0)
>   			force_untracked_cache =
>   				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
> -		trace_printf_key(&trace_untracked_stats,
> -				 "node creation: %u\n"
> -				 "gitignore invalidation: %u\n"
> -				 "directory invalidation: %u\n"
> -				 "opendir: %u\n",
> -				 dir->untracked->dir_created,
> -				 dir->untracked->gitignore_invalidated,
> -				 dir->untracked->dir_invalidated,
> -				 dir->untracked->dir_opened);
>   		if (force_untracked_cache &&
>   			dir->untracked == istate->untracked &&
>   		    (dir->untracked->dir_opened ||
> @@ -2811,6 +2818,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>   			FREE_AND_NULL(dir->untracked);
>   		}
>   	}
> +
> +	if (trace2_is_enabled())
> +		trace2_read_directory_statistics(dir, istate->repo);

Also, I think it'd be ok to move the `trace2_is_enabled()` call
inside the function.  Since we're also testing `!dir->untracked`
inside the function.

The more that I look at the before and after versions, the
more I think the `trace2_read_directory_statistics()` call
should be up before the `trace2_region_leave()`.  Here at the
bottom of the function, we may have already freed `dir->untracked`.
I'm not familiar enough with this code to know if that is a
good or bad thing.


>   	return dir->nr;
>   }
>   
...


Thanks,
Jeff
