Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348471FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbdFVONI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 10:13:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751094AbdFVONI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 10:13:08 -0400
Received: (qmail 32729 invoked by uid 109); 22 Jun 2017 14:13:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 14:13:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1167 invoked by uid 111); 22 Jun 2017 14:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 10:13:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 10:13:06 -0400
Date:   Thu, 22 Jun 2017 10:13:06 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: No "invalid option" message with git diff --cached
 --invalid-option
Message-ID: <20170622141305.lpso6r6yxejymvel@sigill.intra.peff.net>
References: <20170622124458.ilokr7acas2bzq4z@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170622124458.ilokr7acas2bzq4z@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 02:44:58PM +0200, Simon Ruderich wrote:

> I'm using Git 2.13.1 (from the Debian sid repository) and noticed
> the following issue when upgrading.
> 
>     $ git diff --compaction-heuristic
>     error: invalid option: --compaction-heuristic
> 
>     $ git diff --cached --compaction-heuristic
>     usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
> 
> I know that --compaction-heuristic is no longer supported but I
> was using it an alias and was confused that I got no proper error
> message warning me which option was wrong.
> 
> It seems to happen for any invalid option which is used in
> combination with --cached or --staged.

The diff command splits off into several sub-functions based on whether
we're doing an index-to-file diff, an index-to-tree diff, etc. It looks
like builtin_diff_files() and builtin_diff_index() just handle this case
differently. Probably both should issue an error() mentioning the
unknown option _and_ call usage().

I started on a patch, but maybe this would be good micro-project for
somebody wanting to get their feet wet with contributing to Git. Bonus
points for checking the other functions (builtin_diff_blobs,
builtin_diff_tree, builtin_diff_b_f) and making sure they all give
appropriate messages when showing the usage string.

-Peff
