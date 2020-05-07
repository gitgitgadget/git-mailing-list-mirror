Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62007C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44332206B9
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEGUkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:40:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726093AbgEGUkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:40:06 -0400
Received: (qmail 2598 invoked by uid 109); 7 May 2020 20:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21827 invoked by uid 111); 7 May 2020 20:40:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:40:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:40:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <20200507204005.GE29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:14:03PM -0600, Taylor Blau wrote:

> If callers do wish to retain this behavior, they can easily work around
> this change by doing the following:
> 
>     git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
>     awk '/commit/ { print $1 }' |
>     git commit-graph write --stdin-commits

I know this came from my earlier email, but I think that recipe actually
shows how to make your input work even if --check-oids were the default.
If you really want the --check-oids behavior, you'd want the opposite:
to complain about those ones. So it's something like:

     git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
     awk '
       !/commit/ { print "not-a-commit:"$1 }
        /commit/ { print $1 }
     ' |
     git commit-graph write --stdin-commits

> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 53a650225a..fcac7d12e1 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -47,8 +47,10 @@ with `--stdin-commits` or `--reachable`.)
>  +
>  With the `--stdin-commits` option, generate the new commit graph by
>  walking commits starting at the commits specified in stdin as a list
> -of OIDs in hex, one OID per line. (Cannot be combined with
> -`--stdin-packs` or `--reachable`.)
> +of OIDs in hex, one OID per line. OIDs that resolve to non-commits
> +(either directly, or by peeling tags) are silently ignored. OIDs that
> +are malformed, or do not exist generate an error. (Cannot be combined
> +with `--stdin-packs` or `--reachable`.)

Yeah, I think these semantics are good.

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 9eec68572f..3637d079fb 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -153,13 +153,14 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
>  
>  	display_progress(progress, oidset_size(commits) + 1);
>  
> +	if (oid_object_info(the_repository, &oid, NULL) < 0) {
> +		error(_("object %s does not exist"), hash);
> +		return 1;
> +	}
> +
>  	result = lookup_commit_reference_gently(the_repository, &oid, 1);
>  	if (result)
>  		oidset_insert(commits, &result->object.oid);
> -	else {
> -		error(_("invalid commit object id: %s"), hash);
> -		return 1;
> -	}
>  	return 0;
>  }

We can avoid the object-existence check entirely if
lookup_commit_reference_gently() gives us an answer. And we'd expect
that to be the common path.

Also, using has_object_file() is cheaper than oid_object_info(), since
it doesn't have to resolve the type for deltas.

So perhaps:

  result = lookup_commit_reference_gently(...);
  if (result)
          oidset_insert(...);
  else if (has_object_file(&oid))
          ; /* not a commit; quietly ignore;
  else
          return error(no such object...);

That said, I think this technique misses some cases of corruption.
You're checking that the outer-most object exists, but not any
intermediate peeled objects. I.e., lookup_commit_reference_gently()
might have failed for two reasons:

  - an object it peeled to didn't exist

  - an object it peeled to wasn't a commit

To do it thoroughly, I think you'd have to call deref_tag() yourself and
distinguish NULL there (an error) from a result where obj->type isn't
OBJ_COMMIT (quietly ignore).

>  enum commit_graph_write_flags {
> -	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
> -	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
> -	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
> -	/* Make sure that each OID in the input is a valid commit OID. */
> -	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
> -	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
> +	COMMIT_GRAPH_WRITE_APPEND        = (1 << 0),
> +	COMMIT_GRAPH_WRITE_PROGRESS      = (1 << 1),
> +	COMMIT_GRAPH_WRITE_SPLIT         = (1 << 2),
> +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3)

As much as I love looking at matched-indentation lists, I think this
diff is a good example of why it's not worth doing. It's much easier to
see what's going on if the first three items aren't touched. I'd
actually even leave BLOOM_FILTERS where it is, and accept the hole which
could be refilled later.

Your patch also loses the trailing comma after the final BLOOM_FILTERS
entry.

-Peff
