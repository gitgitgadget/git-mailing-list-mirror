Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDDC433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352AA20702
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgF3TSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:18:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgF3TSg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:18:36 -0400
Received: (qmail 14277 invoked by uid 109); 30 Jun 2020 19:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 19:18:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26024 invoked by uid 111); 30 Jun 2020 19:18:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 15:18:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 15:18:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
Message-ID: <20200630191834.GC1888406@coredump.intra.peff.net>
References: <cover.1593536481.git.me@ttaylorr.com>
 <4cfa086e503e19763a9d581fcb6a2ef818776dfc.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cfa086e503e19763a9d581fcb6a2ef818776dfc.1593536481.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 01:17:48PM -0400, Taylor Blau wrote:

> Git uses the 'core.commitGraph' configuration value to control whether
> or not the commit graph is used when parsing commits or performing a
> traversal.

I think this is a good thing to have, and the patch itself makes sense
to me (this is actually my first time reviewing it, despite its intended
use within GitHub :) ).

If I may bikeshed for a moment:

> Introduce 'core.useBloomFilters' to control whether or not Bloom filters
> are read. Note that this configuration is independent from both:
> 
>   - 'core.commitGraph', to allow flexibility in using all parts of a
>     commit-graph _except_ for its Bloom filters.
> 
>   - The '--changed-paths' option for 'git commit-graph write', to allow
>     reading and writing Bloom filters to be controlled independently.

Should we avoid exposing the user to the words "Bloom filter"?

The command-line option for writing them was genericized to
"changed-paths", which I think is good. The use of Bloom filters is an
implementation detail. What the user cares about is whether we can
optimize queries of which paths changed in a commit.

When we introduced reachability bitmaps long ago, we made the mistake of
just calling them "bitmaps". That jargon is well understood by people
who work with that code, but it's confusing outside of that (even within
other parts of Git) because bitmaps are just a generic data structure.
You can have a bitmap of just about anything (and indeed we do use other
bitmaps these days). Consistently calling them "reachability bitmaps",
especially in the user facing bits, would have reduced confusion over
the years.

Similarly, Bloom filters are a generic structure we might use elsewhere.
I don't really care if we use the word "Bloom" internally to refer to
this feature, but we'll be stuck with this config option for all time. I
think it's worth picking something more clear.

It might even be worth considering whether "changed paths" needs more
context (or would if we add new features in the future). On a "git
commit-graph write" command-line it is perfectly clear, but would
core.commitGraphChangedPaths be worth it? It's definitely more specific,
but it's also way more ugly. ;)

> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 6d0c962438..5f585a1725 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
>  	setup_git_directory();
>  	odb = the_repository->objects->odb;
>  
> +	prepare_repo_settings(the_repository);
> +
>  	graph = read_commit_graph_one(the_repository, odb);

I wondered why we would need this prepare_repo_settings() now, when it
should have been needed already to cover core.commitGraph already. I
strongly suspect the answer is: "test-tool read-graph" never properly
respected core.commitGraph in the first place.

And now presumably it would. If true, I don't think any tests need
adjusted because the only places we set it are:

  - on a "git -c" command line, which wouldn't run a test-tool helper

  - when we do set it, it is always to "true", which is the default
    anyway

>  	if (!graph)
>  		return 1;
>  
> -
>  	printf("header: %08x %d %d %d %d\n",
>  		ntohl(*(uint32_t*)graph->data),
>  		*(unsigned char*)(graph->data + 4),

Oh good, I happened to be looking at this code earlier today for an
unrelated reason and was bothered by this extra newline. :)

-Peff
