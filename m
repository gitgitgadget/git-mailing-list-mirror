Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E921F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 16:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeKVDPb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 22:15:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727100AbeKVDPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 22:15:31 -0500
Received: (qmail 26835 invoked by uid 109); 21 Nov 2018 16:40:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 16:40:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10934 invoked by uid 111); 21 Nov 2018 16:39:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 11:39:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 11:40:19 -0500
Date:   Wed, 21 Nov 2018 11:40:19 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com,
        matvore@comcast.net
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
Message-ID: <20181121164019.GA24621@sigill.intra.peff.net>
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 06:13:42PM -0700, Matthew DeVore wrote:

> diff --git a/builtin/prune.c b/builtin/prune.c
> index 41230f8215..11284d0bf3 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -120,6 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  	save_commit_buffer = 0;
>  	read_replace_refs = 0;
>  	ref_paranoia = 1;
> +	revs.allow_exclude_promisor_objects_opt = 1;
>  	repo_init_revisions(the_repository, &revs, prefix);
>  
>  	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);

I think this line is in the wrong place. The very first thing
repo_init_revisions() will do is memset() the revs struct to all-zeroes,
so it cannot possibly be doing anything.

Normally it would need to go after init_revisions() but before
setup_revisions(), but we don't seem to call the latter at all in
builtin/prune.c. Which makes sense, because you cannot pass options to
influence the reachability traversal. So I don't think we need to care
about this flag at all here.

Speaking of which, would this flag work better as a field in
setup_revision_opt, which is passed to setup_revisions()? The intent
seem to be to influence how we parse command-line arguments, and that's
where other similar flags are (e.g., assume_dashdash).

-Peff
