Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAB120958
	for <e@80x24.org>; Tue, 21 Mar 2017 05:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdCUFbn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 01:31:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:48409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751433AbdCUFbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 01:31:42 -0400
Received: (qmail 27858 invoked by uid 109); 21 Mar 2017 05:31:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 05:31:40 +0000
Received: (qmail 11448 invoked by uid 111); 21 Mar 2017 05:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:31:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 01:31:36 -0400
Date:   Tue, 21 Mar 2017 01:31:36 -0400
From:   Jeff King <peff@peff.net>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC V2] stash: implement builtin stash
Message-ID: <20170321053135.thk77soxc4irxbqj@sigill.intra.peff.net>
References: <20170313222318.23312-1-joel@teichroeb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313222318.23312-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 03:23:18PM -0700, Joel Teichroeb wrote:

> I've been working on rewriting git stash as a c builtin and I have all
> but three tests passing. I'm having a bit of trouble fixing them, as
> well as a few other issues, so I'd really appreciate some help. Don't
> bother commenting on the small details yet as I still need to go
> though the code to make sure it matches the code style guidelines.

Be careful that this is a bit of a moving target. There's been some
feature work and some bug-fixes in git-stash.sh the past few weeks.

> git stash uses the GIT_INDEX_FILE environment variable in order to not
> trash the main index. I ended up doing things like this:
> 
>     discard_cache();
>     ret = read_cache_from(index_path);
>     write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL);
>     discard_cache();
>     ret = read_cache_from(index_path);
> 
> in order to have an empty cache. Could someone take a look at my uses
> of the index and point out better ways to do it?

I suspect in the long run that you could pull this off without writing
the intermediate index to disk at all. You can store multiple indices if
you need to (read_cache_from is just a wrapper to operate on the_index).
But while you're executing sub-programs, you're still probably going to
need to do a lot of re-reading of the index.

Two things that I think might help break up the work:

  1. Rather than convert stash all at once, you can implement a "stash
     helper" in C that does individual sub-commands (or even smaller
     chunks), and call that from git-stash.sh. Eventually it
     git-stash.sh will just be a skeleton, and you can move that over to
     C and call the functions directly.

  2. You may want to start purely as a C wrapper that calls the
     sub-programs, which communicate with each other via GIT_INDEX_FILE,
     etc. Then you don't need to worry about manipulating the index
     inside the C program at first, and can focus on all the other
     boilerplate.

     Then piece by piece, you can replace sub-program calls with C
     calls. But you know you'll be working on top of a functional base.

I don't know if that's helpful or not.

-Peff
