Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E64A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGRU0V (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:26:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:51562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729316AbeGRU0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:26:21 -0400
Received: (qmail 15543 invoked by uid 109); 18 Jul 2018 19:46:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 19:46:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2673 invoked by uid 111); 18 Jul 2018 19:47:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 15:47:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 15:46:57 -0400
Date:   Wed, 18 Jul 2018 15:46:57 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
Message-ID: <20180718194657.GC7778@sigill.intra.peff.net>
References: <pull.11.git.gitgitgadget@gmail.com>
 <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 08:15:41AM -0700, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Create new method commit_graph_compatible(r) to check if a given
> repository r is compatible with the commit-graph feature. Fill the
> method with a check to see if replace-objects exist. Test this
> interaction succeeds, including ignoring an existing commit-graph and
> failing to write a new commit-graph.

I think this approach is sensible. These are optimizations, and it's not
a big deal to just punt no cases we can't handle.

I do have one complaint about the implementation, though:

> +static int commit_graph_compatible(struct repository *r)
> +{
> +	prepare_replace_object(r);
> +	if (hashmap_get_size(&r->objects->replace_map->map))
> +		return 0;
> +
> +	return 1;
> +}

If I'm reading the code correctly, this will predicate the decision
entirely on the presence of refs in refs/replace/. But you may have a
situation where those refs exist, but you are not respecting them in
this run.

For instance, imagine[1] a server that hosts arbitrary repositories, but
wants to use commit graphs to speed up server-side operations (e.g.,
serving fetches, but also perhaps a web interface doing --contains,
etc). If it runs all of the server-side commands with
GIT_NO_REPLACE_OBJECTS=1, then there should be no problem. But if a user
pushes anything to refs/replace (because they _do_ use replace refs
locally, and want to share them with other clients), that would disable
graphs on the server.

So I think this should at least be loosened to:

  if (check_replace_refs) {
	prepare_replace_object(r);
	if (...)
  }

which would make this case work. I'd even go so far as to say that for
writing, we should just always ignore replace refs and generate the full
graph (just like pack-objects does so when writing a pack). Then the
resulting graph can be used selectively by disabling replace refs for
particular commands. But for the scenario I described above, the
distinction is mostly academic, as replacements would be disabled anyway
during the write command anyway.

-Peff

[1] You can probably guess that this is how GitHub handles replace refs.
    We ran into this long ago because replacements and grafts mess up
    any other caches external to Git that rely on the immutability of
    the hash.

    We do it with a config option, though, which requires a trivial
    patch. I'll post that momentarily.
