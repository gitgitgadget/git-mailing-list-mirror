Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F181C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F420768
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgDHTNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:13:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:37967 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgDHTNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:13:21 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jMG8T-0001pN-98; Wed, 08 Apr 2020 20:13:18 +0100
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7b23c659-56b4-5ed1-eb66-eb112cbde8a3@iee.email>
Date:   Wed, 8 Apr 2020 20:13:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling nit.

On 08/04/2020 17:38, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The changed-path Bloom filters record an entry in the filter for
> every path that was changed. This includes every add and delete,
> regardless of whther a rename was detected. Detecting renames
whether
> causes significant performance issues, but also will trigger
> downloading missing blobs in partial clone.
>
> The simple fix is to disable rename detection when computing a
> changed-path Bloom filter.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     bloom: ignore renames when computing changed paths
>     
>     I promised [1] I would adapt the commit that was dropped from
>     gs/commit-graph-path-filter [2] on top of gs/commit-graph-path-filter
>     and jt/avoid-prefetch-when-able-in-diff. However, I noticed that the
>     change was extremely simple and has value without basing it on
>     jt/avoid-prefetch-when-able-in-diff.
>     
>     This change applied to gs/commit-graph-path-filter has obvious CPU time
>     improvements for computing changed-path Bloom filters (that I did not
>     measure). The partial clone improvements require
>     jt/avoid-prefetch-when-able-in-diff to be included, too, but the code
>     does not depend on it at compile time.
>     
>     Thanks, -Stolee
>     
>     [1] 
>     https://lore.kernel.org/git/7de2f54b-8704-a0e1-12aa-0ca9d3d70f6f@gmail.com/
>     [2] 
>     https://lore.kernel.org/git/55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-601%2Fderrickstolee%2Fdiff-and-bloom-filters-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-601/derrickstolee/diff-and-bloom-filters-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/601
>
>  bloom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/bloom.c b/bloom.c
> index c5b461d1cfe..dd9bab9bbd6 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -189,6 +189,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  
>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
> +	diffopt.detect_rename = 0;
>  	diffopt.max_changes = max_changes;
>  	diff_setup_done(&diffopt);
>  
>
> base-commit: d5b873c832d832e44523d1d2a9d29afe2b84c84f
Philip
