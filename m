Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C301F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfA1RBe (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:01:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:51510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732996AbfA1QPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:05 -0500
Received: (qmail 2970 invoked by uid 109); 28 Jan 2019 16:15:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 16:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26487 invoked by uid 111); 28 Jan 2019 16:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 11:15:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 11:15:03 -0500
Date:   Mon, 28 Jan 2019 11:15:03 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] object_as_type: initialize commit-graph-related fields
 of 'struct commit'
Message-ID: <20190128161503.GC23588@sigill.intra.peff.net>
References: <20190125222126.GH6702@szeder.dev>
 <20190127130832.23652-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190127130832.23652-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 02:08:32PM +0100, SZEDER Gábor wrote:

> When the commit graph and generation numbers were introduced in
> commits 177722b344 (commit: integrate commit graph with commit
> parsing, 2018-04-10) and 83073cc994 (commit: add generation number to
> struct commit, 2018-04-25), they tried to make sure that the
> corresponding 'graph_pos' and 'generation' fields of 'struct commit'
> are initialized conservatively, as if the commit were not included in
> the commit-graph file.
> 
> Alas, initializing those fields only in alloc_commit_node() missed the
> case when an object that happens to be a commit is first looked up via
> lookup_unknown_object(), and is then later converted to a 'struct
> commit' via the object_as_type() helper function (either calling it
> directly, or as part of a subsequent lookup_commit() call).
> Consequently, both of those fields incorrectly remain set to zero,
> which means e.g. that the commit is present in and is the first entry
> of the commit-graph file.  This will result in wrong timestamp, parent
> and root tree hashes, if such a 'struct commit' instance is later
> filled from the commit-graph.
> 
> Extract the initialization of 'struct commit's fields from
> alloc_commit_node() into a helper function, and call it from
> object_as_type() as well, to make sure that it properly initializes
> the two commit-graph-related fields, too.  With this helper function
> it is hopefully less likely that any new fields added to 'struct
> commit' in the future would remain uninitialized.
> 
> With this change alloc_commit_index() won't have any remaining callers
> outside of 'alloc.c', so mark it as static.

Good find, and nicely explained.

> ---
> 
> So, it turns out that ec0c5798ee (revision: use commit graph in
> get_reference(), 2018-12-04) is not the culprit after all, it merely
> highlighted a bug that is as old as the commit-graph feature itself.
> This patch fixes this and all other related issues I reported
> upthread.
> 
> I couldn't find any other place where an object of unknown type is
> turned into a 'struct commit', so this might have been the only place
> that needed fixing.

This should be the only place. We already ran into this with the
commit-index field, which was what caused us to create object_as_type()
in the first place, to give a central place for coercing OBJ_NONE into
other types.

> Other object types seem to be fine, because they contain only fields
> that should be zero initialized.  At least for now, because a similar
> issue might arise in the future, if one of them gains a new field that
> should not be initialized to zero...  but will they ever get such a
> field?  So I'm not too keen on introducing similar init_tree_node(),
> etc. helper funcions at the moment.

Agreed. We can deal with those if it ever becomes necessary. In theory
adding empty placeholder functions might help somebody realize they'd
need to handle this case, but I have the feeling that they'd be as
likely to miss init_tree_node() as they would object_as_type().

I dunno. I guess if init_tree_node() were actually called from
alloc_tree_node(), it might be harder to miss.

>  alloc.c  | 11 ++++++++---
>  alloc.h  |  2 +-
>  object.c |  5 +++--
>  3 files changed, 12 insertions(+), 6 deletions(-)

The patch itself looks good to me.

-Peff
