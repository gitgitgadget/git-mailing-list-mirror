Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64EC6202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 23:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfDDXIC (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:08:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47368 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730275AbfDDXIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:08:02 -0400
Received: (qmail 1224 invoked by uid 109); 4 Apr 2019 23:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:08:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20292 invoked by uid 111); 4 Apr 2019 23:08:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:08:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:08:00 -0400
Date:   Thu, 4 Apr 2019 19:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2] rev-list: exclude promisor objects at walk time
Message-ID: <20190404230759.GA26623@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 03:53:56PM -0700, Josh Steadmon wrote:

> For large repositories, enumerating the list of all promisor objects (in
> order to exclude them from a rev-list walk) can take a significant
> amount of time).
> 
> When --exclude-promisor-objects is passed to rev-list, don't enumerate
> the promisor objects. Instead, filter them (and any children objects)
> during the actual graph walk.

Yeah, this is definitely the approach I was thinking of.

Did you (or anybody else) have any thoughts on the case where a given
object is referred to both by a promisor and a non-promisor (and we
don't have it)? That's the "shortcut" I think we're taking here: we
would no longer realize that it's available via the promisor when we
traverse to it from the non-promisor. I'm just not clear on whether that
can ever happen.

> Helped-By: Jonathan Tan <jonathantanmy@google.com>
> Helped-By: Jeff King <peff@peff.net>
> Helped-By: Jonathan Nieder <jrnieder@gmail.com>
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Minor nit, but these should all be part of the same block.

> diff --git a/list-objects.c b/list-objects.c
> index dc77361e11..d1eaa0999e 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -30,6 +30,7 @@ static void process_blob(struct traversal_context *ctx,
>  	struct object *obj = &blob->object;
>  	size_t pathlen;
>  	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +	struct object_info oi = OBJECT_INFO_INIT;
>  
>  	if (!ctx->revs->blob_objects)
>  		return;
> @@ -37,6 +38,11 @@ static void process_blob(struct traversal_context *ctx,
>  		die("bad blob object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
> +	if (ctx->revs->exclude_promisor_objects &&
> +	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
> +	    oi.whence == OI_PACKED &&
> +	    oi.u.packed.pack->pack_promisor)
> +		return;

This conditional gets repeated a lot in your patch. Perhaps it's worth a
helper so we can say:

  if (skip_promisor_object(&ctx->revs, &obj->oid))
	return;

in each place?

One other possible small optimization: we don't look up the object
unless the caller asked to exclude promisors, which is good. But we
could also keep a single flag for "is there a promisor pack at all?".
When there isn't, we know there's no point in looking for the object.

It might not matter much in practice. The main caller here is going to
be check_connected(), and it only passes --exclude-promisor-objects if
it's in a partial clone.

> [...]

I didn't see any tweaks to the callers, which makes sense; we're already
passing --exclude-promisor-objects as necessary. Which means by itself,
this patch should be making things faster, right? Do you have timings to
show that off?

-Peff
