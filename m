Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C991F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeFERLl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:11:41 -0400
Received: from avasout01.plus.net ([84.93.230.227]:44070 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753737AbeFERLX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:11:23 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id QFUOfu7U2eLIJQFUPfRJuz; Tue, 05 Jun 2018 18:11:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Y6bWTCWN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=KtJevrwMMORDL3VQ5scA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/6] unpack-trees: don't shadow global var the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
 <20180605154334.22613-4-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3db23386-5c9f-5e0d-5a26-311184d11bc7@ramsayjones.plus.com>
Date:   Tue, 5 Jun 2018 18:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605154334.22613-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfH0dGsFDEN8pLWUhrGscZsxBmoVRO6lJ7/DFX3mxzBsLmDmimv2AcH4fhqVF7bgEihwxEDV2WmSHa6eBgwd0x4w+3ey/2wc51J4Yyen1DAkT9Yo/gRQW
 ILJ6YKqoq9FLSZFy8iLxy+A+kcNYtZpnIKsmhiEPZnMt8rJe0M6iPU4yVUKM+KOszWvXt9PH3dDiIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/06/18 16:43, Nguyễn Thái Ngọc Duy wrote:
> This function mark_new_skip_worktree() has an argument named the_index
> which is also the name of a global variable. While they have different
> types (the global the_index is not a pointer) mistakes can easily
> happen and it's also confusing for readers. Rename the function
> argument to something other than the_index.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  unpack-trees.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5d06aa9c98..60d1138e08 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1231,7 +1231,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
>   * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
>   */
>  static void mark_new_skip_worktree(struct exclude_list *el,
> -				   struct index_state *the_index,
> +				   struct index_state *istate,
>  				   int select_flag, int skip_wt_flag)
>  {
>  	int i;
> @@ -1240,8 +1240,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
>  	 * 1. Pretend the narrowest worktree: only unmerged entries
>  	 * are checked out
>  	 */
> -	for (i = 0; i < the_index->cache_nr; i++) {
> -		struct cache_entry *ce = the_index->cache[i];
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		struct cache_entry *ce = istate->cache[i];
>  
>  		if (select_flag && !(ce->ce_flags & select_flag))
>  			continue;
> @@ -1256,8 +1256,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
>  	 * 2. Widen worktree according to sparse-checkout file.
>  	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
>  	 */
> -	clear_ce_flags(the_index->cache, the_index->cache_nr,
> -		       select_flag, skip_wt_flag, el);
> +	clear_ce_flags(istate, select_flag, skip_wt_flag, el);

This looks a bit suspect. The clear_ce_flags() function has
not been modified to take a 'struct index_state *' as its first
parameter, right? (If you look back at the first hunk header, you
will see that it still takes 'struct cache_entry **, int, ...') ;-)

ATB,
Ramsay Jones

