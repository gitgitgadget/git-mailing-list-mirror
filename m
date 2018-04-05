Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8841F404
	for <e@80x24.org>; Thu,  5 Apr 2018 18:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeDES6I (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 14:58:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:54916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751802AbeDES6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 14:58:08 -0400
Received: (qmail 2346 invoked by uid 109); 5 Apr 2018 18:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 18:58:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18471 invoked by uid 111); 5 Apr 2018 18:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 14:59:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 14:58:06 -0400
Date:   Thu, 5 Apr 2018 14:58:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sxlijin@gmail.com
Subject: Re: [RFC PATCH 4/7] dir: Directories should be checked for matching
 pathspecs too
Message-ID: <20180405185805.GA21164@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com>
 <20180405173446.32372-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405173446.32372-5-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 10:34:43AM -0700, Elijah Newren wrote:

> Even if a directory doesn't match a pathspec, it is possible, depending
> on the precise pathspecs, that some file underneath it might.  So we
> special case and recurse into the directory for such situations.  However,
> we previously always added any untracked directory that we recursed into
> to the list of untracked paths, regardless of whether the directory
> itself matched the pathspec.
> 
> For the case of git-clean and a set of pathspecs of "dir/file" and "more",
> this caused a problem because we'd end up with dir entries for both of
>   "dir"
>   "dir/file"
> Then correct_untracked_entries() would try to helpfully prune duplicates
> for us by removing "dir/file" since it's under "dir", leaving us with
>   "dir"
> Since the original pathspec only had "dir/file", the only entry left
> doesn't match and leaves nothing to be removed.  (Note that if only one
> pathspec was specified, e.g. only "dir/file", then the common_prefix_len
> optimizations in fill_directory would cause us to bypass this problem,
> making it appear in simple tests that we could correctly remove manually
> specified pathspecs.)

It sounds like correct_untracked_entries() is doing the wrong thing, and
it should be aware of the pathspec-matching when culling entries. In
other words, my understanding was that read_directory() does not
necessarily promise to cull fully (which is what led to cf424f5fd in the
first place), and callers are forced to apply their own pathspecs.

The distinction is academic for this particular bug, but it makes me
wonder if there are other cases where "clean" needs to be more careful
with what comes out of dir.c.

-Peff
