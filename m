Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1AC20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 08:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeLNIpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 03:45:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:41738 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbeLNIpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 03:45:30 -0500
Received: (qmail 22208 invoked by uid 109); 14 Dec 2018 08:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 08:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1419 invoked by uid 111); 14 Dec 2018 08:45:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 03:45:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 03:45:28 -0500
Date:   Fri, 14 Dec 2018 03:45:28 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3] revision: use commit graph in get_reference()
Message-ID: <20181214084528.GC11777@sigill.intra.peff.net>
References: <20181204224238.50966-1-jonathantanmy@google.com>
 <20181213185450.230953-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213185450.230953-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 10:54:50AM -0800, Jonathan Tan wrote:

> -static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
> +static struct commit *parse_commit_in_graph_one(struct repository *r,
> +						struct commit_graph *g,
> +						const struct object_id *oid)

Making sure I understand the new logic...

>  {
> +	struct object *obj;
> +	struct commit *commit;
>  	uint32_t pos;
>  
> -	if (item->object.parsed)
> -		return 1;
> +	obj = lookup_object(r, oid->hash);
> +	commit = obj && obj->type == OBJ_COMMIT ? (struct commit *) obj : NULL;
> +	if (commit && obj->parsed)
> +		return commit;

OK, so if it's a commit and we have it parsed, we return that. By using
lookup_object(), if it's a non-commit, we haven't changed anything.
Good.

> -	if (find_commit_in_graph(item, g, &pos))
> -		return fill_commit_in_graph(item, g, pos);
> +	if (commit && commit->graph_pos != COMMIT_NOT_FROM_GRAPH)
> +		pos = commit->graph_pos;
> +	else if (bsearch_graph(g, oid, &pos))
> +		; /* bsearch_graph sets pos */
> +	else
> +		return NULL;

And then we try to find it in the commit graph. If we didn't, then we'll
end up returning NULL. Good.

> -	return 0;
> +	if (!commit) {
> +		commit = lookup_commit(r, oid);
> +		if (!commit)
> +			return NULL;
> +	}

And at this point we found it in the commit graph, so we know it's a
commit. lookup_commit() should succeed, but in the off chance that it's
in the commit graph _and_ we previously found it as a non-commit
(yikes!), we'll return NULL. That's equivalent to just pretending we
didn't find it in the commit graph, and the caller can sort it out (when
they read the object, either it will match the previous type, or it
really will be a commit and they'll follow the normal complaining path).
Good.

So this all makes sense. The one thing we don't do here is actually
parse an unparsed commit that isn't in the graph, and instead leave that
to the caller. E.g. get_reference() now does:

> -	object = parse_object(revs->repo, oid);
> +	object = (struct object *) parse_commit_in_graph(revs->repo, oid);
> +	if (!object)
> +		object = parse_object(revs->repo, oid);

In theory we could save another lookup_object() in parse_object() by
combining these steps, but I don't think it's really worth worrying too
much about.

So overall this looks good to me.

-Peff
