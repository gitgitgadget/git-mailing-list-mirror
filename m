Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91398202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 08:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbdJXIYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 04:24:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751323AbdJXIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 04:24:13 -0400
Received: (qmail 3399 invoked by uid 109); 24 Oct 2017 08:24:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 08:24:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8634 invoked by uid 111); 24 Oct 2017 08:24:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 04:24:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 01:24:10 -0700
Date:   Tue, 24 Oct 2017 01:24:10 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: v2.15.0-rc2 ref deletion bug
Message-ID: <20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a potentially serious bug in v2.15.0-rc2 (and earlier release
candidates, too) that we may want to deal with before the release.

If I do:

git init -q repo
cd repo
obj=$(git hash-object -w /dev/null)
git update-ref refs/tags/foo $obj
git update-ref --stdin <<-EOF
delete refs/tags/foo
update refs/tags/foo/bar $obj
EOF
git for-each-ref

then at the end we have no refs at all!

I'd expect one of:

  1. We delete "foo" before updating "foo/bar", and we end up with a
     single ref.

  2. We complain that we cannot update "foo/bar" because "foo" still
     exists.

I was hoping for (1). But in earlier releases we did (2). That makes
sense because it's safer to do all updates in a transaction before doing
any deletes (since if there's a simultaneous prune we'd rather see both
refs present for a moment rather than neither).

But the v2.15 behavior is just buggy, and may lead to data loss (we
silently lose the refs, and then a subsequent prune may lose the
objects). This bisects to Michael's dc39e09942 (files_ref_store: use a
transaction to update packed refs, 2017-09-08).

Curiously, it doesn't happen if you reverse the order of the entries in
the transaction (which _shouldn't_ matter, since we try to process it
atomically, but obviously it just tickles this bug in a funny way).

I haven't figured out if the deletion has to be a prefix of the update
to trigger the bug, or if the problem is more widespread.

-Peff
