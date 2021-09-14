Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D1C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1449460234
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 15:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhINPbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:31:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:47004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhINPbE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 11:31:04 -0400
Received: (qmail 24291 invoked by uid 109); 14 Sep 2021 15:29:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 15:29:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24180 invoked by uid 111); 14 Sep 2021 15:29:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 11:29:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 11:29:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/9] reducing memory allocations for v2 servers
Message-ID: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at [1], I noticed that v2 servers will read a few bits of
client input into strvecs. Even though we expect these to be small-ish,
there's nothing preventing a client from sending us a bunch of junk and
wasting memory.

This series changes that, putting a cap on how much data we'll receive.
The two spots are the "capabilities" list we receive (before we even
dispatch to a particular command like ls-refs or fetch), and the
ref-prefix list we receive for ls-refs.

To deal with the capabilities issue, we'll just handle each capability
line as it comes in, rather than storing a list. This requires a bit of
cleanup, which is why it takes up the first 6 patches. It also needs a
few other cleanups from ab/serve-cleanup (and so this series is based on
that). The dependencies there are both textual (e.g., using designated
initializers in the capabilities table) and functional (dropping the
"keys" parameter from v2 command() functions).

Patch 7 fixes the ls-refs issue by degrading when we see too many
prefixes (which works because the capability is optional in the first
place).

The final two patches aren't strictly necessary. They're a tightening of
the protocol against some bogus input that I noticed while doing the
earlier cleanups. That bogus input isn't really hurting anything, but I
think it makes sense to reject nonsense from the client rather than
ignoring it. The obvious risk is that some client for some reason would
send us nonsense, but I don't think Git ever has.

Once again, these are based on ab/serve-cleanup, which is currently in
next.

  [1/9]: serve: rename is_command() to parse_command()
  [2/9]: serve: return capability "value" from get_capability()
  [3/9]: serve: add "receive" method for v2 capabilities table
  [4/9]: serve: provide "receive" function for object-format capability
  [5/9]: serve: provide "receive" function for session-id capability
  [6/9]: serve: drop "keys" strvec
  [7/9]: ls-refs: ignore very long ref-prefix counts
  [8/9]: serve: reject bogus v2 "command=ls-refs=foo"
  [9/9]: serve: reject commands used as capabilities

 ls-refs.c            |  19 ++++++-
 serve.c              | 120 +++++++++++++++++++++++--------------------
 t/t5701-git-serve.sh |  60 ++++++++++++++++++++++
 3 files changed, 142 insertions(+), 57 deletions(-)

-Peff

[1] https://lore.kernel.org/git/YT54CNYgtGcqexwq@coredump.intra.peff.net/
