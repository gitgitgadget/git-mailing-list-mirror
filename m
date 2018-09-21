Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDDA1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeIVFrm (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:47:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:55770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeIVFrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:47:41 -0400
Received: (qmail 8752 invoked by uid 109); 21 Sep 2018 23:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 23:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10075 invoked by uid 111); 21 Sep 2018 23:56:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 19:56:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 19:56:28 -0400
Date:   Fri, 21 Sep 2018 19:56:28 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/2] commit-reach: properly peel tags
Message-ID: <20180921235628.GA3437@sigill.intra.peff.net>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
 <pull.39.v3.git.gitgitgadget@gmail.com>
 <0a1e661271660b1fab317aac3997589a94b7c98f.1537542323.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a1e661271660b1fab317aac3997589a94b7c98f.1537542323.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 08:05:26AM -0700, Derrick Stolee via GitGitGadget wrote:

> diff --git a/commit-reach.c b/commit-reach.c
> index 86715c103c..e748414d04 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -544,20 +544,42 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  {
>  	struct commit **list = NULL;
>  	int i;
> +	int nr_commits;
>  	int result = 1;
>  
>  	ALLOC_ARRAY(list, from->nr);
> +	nr_commits = 0;
>  	for (i = 0; i < from->nr; i++) {
> -		list[i] = (struct commit *)from->objects[i].item;
> +		struct object *from_one = from->objects[i].item;
>  
> -		if (parse_commit(list[i]) ||
> -		    list[i]->generation < min_generation)
> -			return 0;
> +		if (!from_one || from_one->flags & assign_flag)
> +			continue;
> +
> +		from_one = deref_tag(the_repository, from_one,
> +				     "a from object", 0);
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			/* no way to tell if this is reachable by
> +			 * looking at the ancestry chain alone, so
> +			 * leave a note to ourselves not to worry about
> +			 * this object anymore.
> +			 */

A minor nit, but the original comment you restored here has a style
violation. Might be worth fixing up (but certainly not worth a re-roll
on its own).

> +			from->objects[i].item->flags |= assign_flag;

OK, so here we mark the original tag with a flag...

> +
> +		list[nr_commits] = (struct commit *)from_one;
> +		if (parse_commit(list[nr_commits]) ||
> +		    list[nr_commits]->generation < min_generation) {
> +			result = 0;
> +			goto cleanup;
> +		}

And we jump to the cleanup here, but...

> @@ -600,7 +622,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  	}
>  
>  cleanup:
> -	for (i = 0; i < from->nr; i++) {
> +	for (i = 0; i < nr_commits; i++) {
>  		clear_commit_marks(list[i], RESULT);
>  		clear_commit_marks(list[i], assign_flag);

This walks over the items in the list array, which don't include the tag
we marked. Did we decide that's OK? I think it's actually how the
original code behaved, too, but it seems funny. At the least we might
want to call it out in the commit message.

Should we also be walking from->objects and clearing the flags from
there (maybe not RESULT, but assign_flag)? It's not clear to me if it's
unintentional for those to be marked after the function leaves or not.

Also, a minor aside, but I think it would be slightly more efficient for
those final two lines to do:

  clear_commit_marks(list[i], RESULT | assign_flag);

Of course, that's totally orthogonal to this patch, but it may make you
feel better to offset the other round of clearing I'm suggesting. ;)

> diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> index eb21103998..08d2ea68e8 100644
> --- a/t/helper/test-reach.c
> +++ b/t/helper/test-reach.c

These bits all looked good to me.

-Peff
