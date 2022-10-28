Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AC0ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJ1QuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJ1QuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 12:50:07 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748854CBC
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:50:04 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A0F2ECA1261;
        Fri, 28 Oct 2022 12:50:03 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 472BCCC8327;
        Fri, 28 Oct 2022 12:50:03 -0400 (EDT)
Subject: Re: [PATCH v2] index: add trace2 region for clear skip worktree
To:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, Anh Le <anh@canva.com>
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
 <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ff5d79c9-35f8-8881-8349-63977732c422@jeffhostetler.com>
Date:   Fri, 28 Oct 2022 12:50:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/27/22 8:46 PM, Anh Le via GitGitGadget wrote:
[...]
> diff --git a/sparse-index.c b/sparse-index.c
> index e4a54ce1943..dbf647949c1 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -493,24 +493,38 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
>   	int dir_found = 1;
>   
>   	int i;
> +	int path_counts[2] = {0, 0};
> +	int restarted = 0;
>   
>   	if (!core_apply_sparse_checkout ||
>   	    sparse_expect_files_outside_of_patterns)
>   		return;
>   
> +	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
>   restart:
>   	for (i = 0; i < istate->cache_nr; i++) {
>   		struct cache_entry *ce = istate->cache[i];
>   
> -		if (ce_skip_worktree(ce) &&
> -		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> -			if (S_ISSPARSEDIR(ce->ce_mode)) {
> -				ensure_full_index(istate);
> -				goto restart;
> +		if (ce_skip_worktree(ce)) {
> +			path_counts[restarted]++;
> +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
> +				if (S_ISSPARSEDIR(ce->ce_mode)) {
> +					ensure_full_index(istate);
> +					restarted = 1;
> +					goto restart;
> +				}
> +				ce->ce_flags &= ~CE_SKIP_WORKTREE;
>   			}
> -			ce->ce_flags &= ~CE_SKIP_WORKTREE;
>   		}
>   	}
> +
> +	if (path_counts[0] > 0) {
> +		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
> +	}
> +	if (restarted) {
> +		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
> +	}
> +	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
>   }

This looks good.  And I think it sets us up to later
answer some of our earlier perf questions after you
get some data.

For example, if the path_count[0] phase is expensive,
does the restart always need to restart the loop at i=0?
Granted, the `ensure_full_index()` may create a new cache-entry
array, so the value of `i` prior to the call may not correspond
to the same cell after the call at the `goto`, but we could
cache the strdup the pathname of cache[i] before the call and
do a find on the new cache[] afterwards to get the corresponding
i-prime value and let the restart start the loop on i-prime.
That's just an idea, but let's wait for the data to see if that
would be helpful.


Thanks!
Jeff

