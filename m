Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EAD1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeFERhK (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:37:10 -0400
Received: from avasout01.plus.net ([84.93.230.227]:45836 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeFERhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:37:09 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id QFtLfu9GieLIJQFtMfRLKq; Tue, 05 Jun 2018 18:37:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Y6bWTCWN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=BlJxay1-xPnvxFXJ1dEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/6] unpack-tress: convert clear_ce_flags* to avoid
 the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
 <20180605154334.22613-5-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <567d24d8-538e-3e0e-efc6-0d01dcc8e89e@ramsayjones.plus.com>
Date:   Tue, 5 Jun 2018 18:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605154334.22613-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJXrLPCPWFXNMH75I3Mpb+ueJxm5H1wBTYvqJuBo2w2Tzch2BPwTgsJWAIYHFNLh55rFjLh5rBrFAePHL0cKUdb8dWMtY9+/R6OWSr7kN7PRllVdj2IX
 o2/R+ypjG9ufv1ysi5Un8Ji3oYnksnO4yqoLpH1BbbiwyNzz5H6A/NkTQOwEvbuwSBYGhDGsd/IUdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/06/18 16:43, Nguyễn Thái Ngọc Duy wrote:
> Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
> the_index when running the exclude machinery. fba92be8f7 helps show
> this problem clearer because unpack-trees operation is supposed to
> work on whatever index the caller specifies... not specifically
> the_index.
> 
> Update the code to use "istate" argument that's originally from
> mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
> you can see that this function works on two separate indexes:
> o->src_index and o->result. The second mark_new_skip_worktree() so far
> has incorecctly applied exclude rules on o->src_index instead of
> o->result. It's unclear what is the consequences of this, but it's
> definitely wrong.
> 
> [1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
>     2017-05-05)
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  unpack-trees.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 60d1138e08..5268de7af5 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1085,13 +1085,15 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>  	return mask;
>  }
>  
> -static int clear_ce_flags_1(struct cache_entry **cache, int nr,
> +static int clear_ce_flags_1(struct index_state *istate,
> +			    struct cache_entry **cache, int nr,
>  			    struct strbuf *prefix,
>  			    int select_mask, int clear_mask,
>  			    struct exclude_list *el, int defval);
>  
>  /* Whole directory matching */
> -static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
> +static int clear_ce_flags_dir(struct index_state *istate,
> +			      struct cache_entry **cache, int nr,
>  			      struct strbuf *prefix,
>  			      char *basename,
>  			      int select_mask, int clear_mask,
> @@ -1100,7 +1102,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
>  	struct cache_entry **cache_end;
>  	int dtype = DT_DIR;
>  	int ret = is_excluded_from_list(prefix->buf, prefix->len,
> -					basename, &dtype, el, &the_index);
> +					basename, &dtype, el, istate);
>  	int rc;
>  
>  	strbuf_addch(prefix, '/');
> @@ -1122,7 +1124,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
>  	 * calling clear_ce_flags_1(). That function will call
>  	 * the expensive is_excluded_from_list() on every entry.
>  	 */
> -	rc = clear_ce_flags_1(cache, cache_end - cache,
> +	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
>  			      prefix,
>  			      select_mask, clear_mask,
>  			      el, ret);
> @@ -1145,7 +1147,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
>   *   cache[0]->name[0..(prefix_len-1)]
>   * Top level path has prefix_len zero.
>   */
> -static int clear_ce_flags_1(struct cache_entry **cache, int nr,
> +static int clear_ce_flags_1(struct index_state *istate,
> +			    struct cache_entry **cache, int nr,
>  			    struct strbuf *prefix,
>  			    int select_mask, int clear_mask,
>  			    struct exclude_list *el, int defval)
> @@ -1179,7 +1182,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
>  			len = slash - name;
>  			strbuf_add(prefix, name, len);
>  
> -			processed = clear_ce_flags_dir(cache, cache_end - cache,
> +			processed = clear_ce_flags_dir(istate, cache, cache_end - cache,
>  						       prefix,
>  						       prefix->buf + prefix->len - len,
>  						       select_mask, clear_mask,
> @@ -1193,7 +1196,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
>  			}
>  
>  			strbuf_addch(prefix, '/');
> -			cache += clear_ce_flags_1(cache, cache_end - cache,
> +			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
>  						  prefix,
>  						  select_mask, clear_mask, el, defval);
>  			strbuf_setlen(prefix, prefix->len - len - 1);
> @@ -1203,7 +1206,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
>  		/* Non-directory */
>  		dtype = ce_to_dtype(ce);
>  		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
> -					    name, &dtype, el, &the_index);
> +					    name, &dtype, el, istate);
>  		if (ret < 0)
>  			ret = defval;
>  		if (ret > 0)
> @@ -1213,15 +1216,17 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
>  	return nr - (cache_end - cache);
>  }
>  
> -static int clear_ce_flags(struct cache_entry **cache, int nr,
> -			    int select_mask, int clear_mask,
> -			    struct exclude_list *el)
> +static int clear_ce_flags(struct index_state *istate,
> +			  int select_mask, int clear_mask,
> +			  struct exclude_list *el)

OK, so that last hunk of patch #3 should be moved to the
end of this patch. (A 'git rebase -i' problem?)

ATB,
Ramsay Jones

