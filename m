Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BE8211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeLEEyT (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:54:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:59342 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725982AbeLEEyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:54:18 -0500
Received: (qmail 30579 invoked by uid 109); 5 Dec 2018 04:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 04:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27978 invoked by uid 111); 5 Dec 2018 04:53:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 23:53:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 23:54:16 -0500
Date:   Tue, 4 Dec 2018 23:54:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in
 get_reference()
Message-ID: <20181205045416.GB12284@sigill.intra.peff.net>
References: <20181204224238.50966-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 02:42:38PM -0800, Jonathan Tan wrote:

> diff --git a/revision.c b/revision.c
> index b5108b75ab..e7da2c57ab 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -212,7 +212,20 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  {
>  	struct object *object;
>  
> -	object = parse_object(revs->repo, oid);
> +	/*
> +	 * If the repository has commit graphs, repo_parse_commit() avoids
> +	 * reading the object buffer, so use it whenever possible.
> +	 */
> +	if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
> +		struct commit *c = lookup_commit(revs->repo, oid);
> +		if (!repo_parse_commit(revs->repo, c))
> +			object = (struct object *) c;
> +		else
> +			object = NULL;
> +	} else {
> +		object = parse_object(revs->repo, oid);
> +	}

This seems like a reasonable thing to do, but I have sort of a
meta-comment. In several places we've started doing this kind of "if
it's this type of object, do X, otherwise do Y" optimization (e.g.,
handling large blobs for streaming).

And in the many cases we end up doubling the effort to do object
lookups: here we do one lookup to get the type, and then if it's not a
commit (or if we don't have a commit graph) we end up parsing it anyway.

I wonder if we could do better. In this instance, it might make sense
to first see if we actually have a commit graph available (it might not
have this object, of course, but at least we'd expect it to have most
commits). In general, it would be nice if we had a more incremental API
for accessing objects: open, get metadata, then read the data. That
would make these kinds of optimizations "free".

I don't have numbers for how much the extra lookups cost. The lookups
are probably dwarfed by parse_object() in general, so even if we save
only a few full object loads, it may be a win. It just seems a shame
that we may be making the "slow" paths (when our type-specific check
doesn't match) even slower.

-Peff
