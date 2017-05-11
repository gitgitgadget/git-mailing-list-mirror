Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DC8E1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbdEKJql (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:46:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:49411 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbdEKJqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:46:40 -0400
Received: (qmail 3980 invoked by uid 109); 11 May 2017 09:46:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 09:46:38 +0000
Received: (qmail 12081 invoked by uid 111); 11 May 2017 09:47:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 05:47:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 05:46:36 -0400
Date:   Thu, 11 May 2017 05:46:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org
Subject: Re: [PATCH v3] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511094635.ljpwg3bxkqj2wmgc@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170510221157.8971-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170510221157.8971-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 03:11:57PM -0700, Jonathan Tan wrote:

> After looking at ways to solve jrnieder's performance concerns, if we're
> going to need to manage one more item of state within the function, I
> might as well use my earlier idea of storing unmatched refs in its own
> list instead of immediately freeing them. This version of the patch
> should have much better performance characteristics.

Hrm. So the problem in your original was that the loop became quadratic
in the number of refs when fetching all of them (because the original
relies on the sorting to essentially do a list-merge). Are there any
quadratic bits left?

> @@ -649,6 +652,25 @@ static void filter_refs(struct fetch_pack_args *args,
>  
>  		if ((allow_unadvertised_object_request &
>  		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
> +			can_append = 1;
> +		} else {
> +			struct ref *u;
> +			/* Check all refs, including those already matched */
> +			for (u = unmatched; u; u = u->next) {
> +				if (!oidcmp(&ref->old_oid, &u->old_oid)) {
> +					can_append = 1;
> +					goto can_append;
> +				}
> +			}

This is inside the nr_sought loop. So if I were to do:

  git fetch origin $(git ls-remote origin | awk '{print $1}')

we're back to being quadratic. I realize that's probably a silly thing
to do, but in the general case, you're O(m*n), where "n" is number of
unmatched remote refs and "m" is the number of SHA-1s you're looking
for.

Doing better would require either sorting both lists, or storing the
oids in something that has better than linear-time lookup.  Perhaps a
sha1_array or an oidset? We don't actually need to know anything about
the unmatched refs after the first loop. We just need the list of oids
that let us do can_append.

AIUI, you could also avoid creating the unmatched list entirely when the
server advertises tip/reachable sha1s. That's a small optimization, but
I think it may actually make the logic clearer.

-Peff
