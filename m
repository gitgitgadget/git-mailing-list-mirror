Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719861F461
	for <e@80x24.org>; Sun, 25 Aug 2019 13:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfHYNRJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 09:17:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36229 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfHYNRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 09:17:09 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id CD9E240003;
        Sun, 25 Aug 2019 13:17:04 +0000 (UTC)
Date:   Sun, 25 Aug 2019 18:47:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v9 5/9] rebase: refactor can_fast_forward into goto tower
Message-ID: <20190825130235.bsbknf7sky44kwt7@localhost.localdomain>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
 <9bd34b4a404136c974b71975c7a3d809a874cc3d.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd34b4a404136c974b71975c7a3d809a874cc3d.1566724236.git.liu.denton@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/08/19 05:12AM, Denton Liu wrote:
> Before, can_fast_forward was written with an if-else statement. However,
> in the future, we may be adding more termination cases which would lead
> to deeply nested if statements.
> 
> Refactor to use a goto tower so that future cases can be easily
> inserted.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/rebase.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..22c4f1ff93 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1264,21 +1264,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
>  			    struct object_id *merge_base)
>  {
>  	struct commit *head = lookup_commit(the_repository, head_oid);
> -	struct commit_list *merge_bases;
> -	int res;
> +	struct commit_list *merge_bases = NULL;
> +	int res = 0;
>  
>  	if (!head)
> -		return 0;
> +		goto done;
>  
>  	merge_bases = get_merge_bases(onto, head);
> -	if (merge_bases && !merge_bases->next) {
> -		oidcpy(merge_base, &merge_bases->item->object.oid);
> -		res = oideq(merge_base, &onto->object.oid);
> -	} else {
> +	if (!merge_bases || merge_bases->next) {
>  		oidcpy(merge_base, &null_oid);
> -		res = 0;
> +		goto done;
>  	}
> -	free_commit_list(merge_bases);
> +
> +	oidcpy(merge_base, &merge_bases->item->object.oid);
> +	if (!oideq(merge_base, &onto->object.oid))
> +		goto done;
> +
> +	res = 1;
> +
> +done:
> +	if (merge_bases)
> +		free_commit_list(merge_bases);

free_commit_list() returns immediately when a NULL pointer is passed in, 
so I'm not sure if this check is really necessary. I think it is a 
reasonable assumption to make that free* functions work well with NULL 
inputs.

>  	return res && is_linear_history(onto, head);
>  }
>  

Out of curiosity, since you are going with a goto tower, why not do 
something like:

done_merge_bases:
free_commit_list(merge_bases);
done:
return res && is_linear_history(onto, head);

You jump to done_merge_bases after you have initialized merge_bases, and 
directly to done before initializing it.

I'm not advocating for either way, just curious if there is a specific 
reason to do it your way. Anyway, if you drop the if (merge_bases), then 
it doesn't really matter I suppose.

-- 
Regards,
Pratyush Yadav
