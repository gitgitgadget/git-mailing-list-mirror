Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10840C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDDE2192A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGUOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:14:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:40870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726320AbgEGUOU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:14:20 -0400
Received: (qmail 2410 invoked by uid 109); 7 May 2020 20:14:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:14:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21668 invoked by uid 111); 7 May 2020 20:14:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:14:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:14:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 5/8] builtin/commit-graph.c: dereference tags in builtin
Message-ID: <20200507201419.GC29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <513a634f14e90ec0c2e80a6aaf8cb66bbedf8966.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:13:49PM -0600, Taylor Blau wrote:

> When given a list of commits, the commit-graph machinery calls
> 'lookup_commit_reference_gently()' on each element in the set and treats
> the resulting set of OIDs as the base over which to close for
> reachability.
> 
> In an earlier collection of commits, the 'git commit-graph write
> --reachable' case made the inner-most call to
> 'lookup_commit_reference_gently()' by peeling references before they
> were passed over to the commit-graph internals.
> 
> Do the analog for 'git commit-graph write --stdin-commits' by calling
> 'lookup_commit_reference_gently()' outside of the commit-graph
> machinery, making the inner-most call a noop.

Yep, I think this is a good direction.

> @@ -148,7 +151,15 @@ static int read_one_commit(struct oidset *commits, char *hash)
>  		return 1;
>  	}
>  
> -	oidset_insert(commits, &oid);
> +	display_progress(progress, oidset_size(commits) + 1);

Most of our meters increment progress _after_ doing work.

This is especially important for meters with percentages (if we knew we
had 1 commit, we'd print "100%" and _then_ start to peel it, which is
silly).

For this instance we don't know the total number, so we're just counting
up. But I think we should be consistent about when we update meters.
Plus it's shorter to say:

  display_progress(progress, oidset_size(commits));

after having done the work. ;)

> +	result = lookup_commit_reference_gently(the_repository, &oid, 1);

Would we want to pass quiet==0 here? If we see an error we're going to
bail loudly below, so getting more details from the low-level functions
is helpful (I think the only one you'd really get is "I'm looking for a
commit, but it's a tree" or similar).

lookup_commit_reference_gently() is pretty aggressive about parsing
objects. We'll have to parse commits eventually, but we could possibly
do so using their graph representations. It may not be worth optimizing,
because it would only matter if you fed a lot of --stdin-commits inputs
that were already graphed. (And if it is worth optimizing, it should
probably come in a separate commit anyway; this is just about moving the
existing peeling).

> +	if (result)
> +		oidset_insert(commits, &result->object.oid);
> +	else {
> +		error(_("invalid commit object id: %s"), hash);
> +		return 1;
> +	}

If you follow my "return -1" suggestion from earlier, this would need
it, too.

>  		while (strbuf_getline(&buf, stdin) != EOF) {
>  			char *line = strbuf_detach(&buf, NULL);
>  			if (opts.stdin_commits) {
> -				int result = read_one_commit(&commits, line);
> +				int result = read_one_commit(&commits, progress,
> +							     line);
>  				if (result)
>  					return result;
>  			} else
>  				string_list_append(&pack_indexes, line);
>  		}
>  
> +		if (progress)
> +			stop_progress(&progress);

If we return early in the loop, we'd leave this progress meter hanging.
It might be worth converting that return to a break or goto that handles
cleanup (it also needs to handle releasing the strbuf).

-Peff
