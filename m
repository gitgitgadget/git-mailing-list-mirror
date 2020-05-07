Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D1DC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015CC208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEGTyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:54:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:40836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbgEGTym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:54:42 -0400
Received: (qmail 2157 invoked by uid 109); 7 May 2020 19:54:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 19:54:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21521 invoked by uid 111); 7 May 2020 19:54:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 15:54:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 15:54:41 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <20200507195441.GA29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <5ff56feab55b005b4a4d9559909ce7a08e5fa81e.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ff56feab55b005b4a4d9559909ce7a08e5fa81e.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:13:43PM -0600, Taylor Blau wrote:

> While iterating references (to discover the set of commits to write to
> the commit-graph with 'git commit-graph write --reachable'),
> 'add_ref_to_set' can save 'fill_oids_from_commits()' some time by
> peeling the references beforehand.
> 
> Move peeling out of 'fill_oids_from_commits()' and into
> 'add_ref_to_set()' to use 'peel_ref()' instead of 'deref_tag()'. Doing
> so allows the commit-graph machinery to use the peeled value from
> '$GIT_DIR/packed-refs' instead of having to load and parse tags.

Or having to load and parse commits only to find out that they're not
tags. :)

> diff --git a/commit-graph.c b/commit-graph.c
> index 8f61256b0a..5c3fad0dd7 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1327,11 +1327,15 @@ static int add_ref_to_set(const char *refname,
>  			  const struct object_id *oid,
>  			  int flags, void *cb_data)
>  {
> +	struct object_id peeled;
>  	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
>  
>  	display_progress(data->progress, oidset_size(data->commits) + 1);
>  
> -	oidset_insert(data->commits, oid);
> +	if (peel_ref(refname, &peeled))
> +		peeled = *oid;

It may be the old-timer C programmer in me, but I always look slightly
suspicious at struct assignments. We know that object_id doesn't need a
deep copy, so it's obviously OK here. But should we use oidcpy() as a
style thing?

Alternatively, you could do this without a struct copy at all with:

  if (!peel_ref(...))
         oid = peeled;
  oidset_insert(..., oid);

which is actually a bit cheaper.

> +	if (oid_object_info(the_repository, &peeled, NULL) == OBJ_COMMIT)
> +		oidset_insert(data->commits, &peeled);

I probably would have left adding this "if" until a later step, but I
think it's OK here.

-Peff
