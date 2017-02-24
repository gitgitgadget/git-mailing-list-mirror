Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA582022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdBXAoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:44:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:33090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdBXAoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:44:04 -0500
Received: (qmail 475 invoked by uid 109); 24 Feb 2017 00:44:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 00:44:03 +0000
Received: (qmail 20259 invoked by uid 111); 24 Feb 2017 00:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:44:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 19:44:01 -0500
Date:   Thu, 23 Feb 2017 19:44:01 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, benpeart@microsoft.com
Subject: Re: [BUG] allowtipsha1inwant serves unreachable blobs if you know
 its hash
Message-ID: <20170224004401.iil6kcjfkrifrij2@sigill.intra.peff.net>
References: <20170223230358.30050-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223230358.30050-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 03:03:58PM -0800, Jonathan Tan wrote:

> If a server sets allowtipsha1inwant (or allowreachablesha1inwant), a
> client can call "git fetch <server> <SHA-1>" where SHA-1 is the hash of
> a blob (reachable or unreachable) to obtain it. The test below (which
> passes) demonstrates that.

Thanks for a nice demonstration.

TBH, I think the whole "we will not give you unreachable things" is
overblown as a security measure. There are a lot of ways to leak
information out of the repo. E.g., claiming you _do_ have the
unreachable thing, at which point pack-objects may create a delta
against it. Done repeatedly, it works as an oracle by which you can
guess the contents of the unreachable thing.

> This happens most likely because the "rev-list" call in
> "do_reachable_revlist" (called through "has_unreachable") is invoked
> without the "--objects" argument. "has_unreachable" determines that an
> object is unreachable if nothing is printed to stdout, which normally
> works, except that "rev-list" prints nothing when asked which commits
> are reachable from a blob (which makes sense).
> 
> Adding "--objects" works, and all existing tests pass, except for the
> potential performance issue and the side effect that even fetching a
> reachable blob no longer works. This is due to a possible bug where a
> call like "git rev-list --objects $tree ^master" (where $tree is the
> tree object corresponding to master) prints out objects even though all
> objects reachable from the tree are also reachable from master. (There
> should be no issue with "get_reachable_list", the other invoker of
> "do_reachable_revlist", because non-commits in the command's stdout are
> skipped.)

I think "--objects --use-bitmap-index" would be faster. If you have
bitmaps.

-Peff
