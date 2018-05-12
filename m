Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6859C1F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeELJHv (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:07:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:37082 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750791AbeELJHu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:07:50 -0400
Received: (qmail 24112 invoked by uid 109); 12 May 2018 09:07:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:07:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13586 invoked by uid 111); 12 May 2018 09:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:07:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:07:48 -0400
Date:   Sat, 12 May 2018 05:07:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/12] shallow.c: use commit-slab for commit depth
 instead of commit->util
Message-ID: <20180512090748.GB28279@sigill.intra.peff.net>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180512080028.29611-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512080028.29611-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:00:19AM +0200, Nguyễn Thái Ngọc Duy wrote:

> @@ -82,25 +84,29 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  	struct object_array stack = OBJECT_ARRAY_INIT;
>  	struct commit *commit = NULL;
>  	struct commit_graft *graft;
> +	struct commit_depth depths;
>  
> +	init_commit_depth(&depths);
>  	while (commit || i < heads->nr || stack.nr) {
>  		struct commit_list *p;
>  		if (!commit) {
>  			if (i < heads->nr) {
> +				int **depth_slot;
>  				commit = (struct commit *)
>  					deref_tag(heads->objects[i++].item, NULL, 0);
>  				if (!commit || commit->object.type != OBJ_COMMIT) {
>  					commit = NULL;
>  					continue;
>  				}
> -				if (!commit->util)
> -					commit->util = xmalloc(sizeof(int));
> -				*(int *)commit->util = 0;
> +				depth_slot = commit_depth_at(&depths, commit);
> +				if (!*depth_slot)
> +					*depth_slot = xmalloc(sizeof(int));
> +				**depth_slot = 0;

It looks like we could save ourselves an extra layer of indirection (and
tiny heap allocations) by just storing an "int" directly in the slab.
Do we ever use the NULL as a sentinel value?

Here we just allocate it if not set. Let's see if we can find some
others...

> @@ -116,25 +122,32 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
>  		}
>  		commit->object.flags |= not_shallow_flag;
>  		for (p = commit->parents, commit = NULL; p; p = p->next) {
> -			if (!p->item->util) {
> -				int *pointer = xmalloc(sizeof(int));
> -				p->item->util = pointer;
> -				*pointer =  cur_depth;
> +			int **depth_slot = commit_depth_at(&depths, p->item);
> +			if (!*depth_slot) {
> +				*depth_slot = xmalloc(sizeof(int));
> +				**depth_slot = cur_depth;
>  			} else {
> -				int *pointer = p->item->util;
> -				if (cur_depth >= *pointer)
> +				if (cur_depth >= **depth_slot)
>  					continue;
> -				*pointer = cur_depth;
> +				**depth_slot = cur_depth;
>  			}

Here we malloc again if it's not set. But we do behave slightly
differently when we see NULL, in that we do not bother to even compare
against cur_depth. So if we were to directly store ints, we'd see "0" as
the sentinel depth here, which would not match our "cur_depth >=
depth_slot" check.

So no, it wouldn't work to directly store depths with the code as
written.  I'm not sure if the depth can ever be 0. If not, then it would
be a suitable sentinel as:

  int *slot = commit_depth_at(&depths, p->item);
  if (!*slot || cur_depth < *slot)
	*slot = cur_depth;

But somebody would have to dig into the possible values of cur_depth
there (which would make sense to do as a separate patch anyway, since
the point of this is to be a direct conversion).

-Peff
