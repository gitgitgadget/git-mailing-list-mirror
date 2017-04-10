Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E773E20960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdDJVVq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:21:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdDJVVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:21:45 -0400
Received: (qmail 26713 invoked by uid 109); 10 Apr 2017 21:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 21:21:45 +0000
Received: (qmail 28951 invoked by uid 111); 10 Apr 2017 21:22:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 17:22:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 17:21:43 -0400
Date:   Mon, 10 Apr 2017 17:21:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 2/3] p0006-read-tree-checkout: perf test to time
 read-tree
Message-ID: <20170410212142.zc3tsnirjcuoewmw@sigill.intra.peff.net>
References: <20170410211403.25126-1-git@jeffhostetler.com>
 <20170410211403.25126-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410211403.25126-3-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 09:14:02PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Created t/perf/repos/many-files.sh to generate large, but
> artificial repositories.

I think this is a good direction. In the long run we might want some
kind of magic to pull from the "library" of repos when running perf
tests, but it's not a big deal to run the script manually and point
GIT_PERF_REPO at the result.

As a bonus, this should be faster when running perf tests, since we can
reuse the built repo when testing each version of Git.

> +## This test measures the performance of various read-tree
> +## and checkout operations.  It is primarily interested in
> +## the algorithmic costs of index operations and recursive
> +## tree traversal -- and NOT disk I/O on thousands of files.
> +## Therefore, it uses sparse-checkout to avoid populating
> +## the ballast files.
> +##
> +## It expects the test repo to have certain characteristics.
> +## Branches:
> +## () master        := an arbitrary commit.
> +## () ballast       := an arbitrary commit with a large number
> +##                     of changes relative to "master".
> +## () ballast-alias := a branch pointing to the same commit
> +##                     as "ballast".
> +## () ballast-1     := a commit with a 1 file difference from
> +##                     "ballast".

I'm OK with leaving these requirements on the repo in the name of
simplicity, though it does make it harder to perf-test against a regular
repo.

I wonder if we could make reasonable guesses, like:

  master => HEAD
  ballast => $(git rev-list HEAD | tail -n 1)
  ballast-alias => git branch $ballast
  ballast-1 => HEAD^

That would approximate your conditions in a real-world repository, and
it should be easy to make your synthetic one fit the bill exactly.

I don't know if you'd want to turn on sparse checkout manually or not
when testing a real-world repo.

-Peff
