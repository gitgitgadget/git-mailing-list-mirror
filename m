Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0665620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLKKnA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:43:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:37928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbeLKKnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:43:00 -0500
Received: (qmail 14475 invoked by uid 109); 11 Dec 2018 10:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:43:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3920 invoked by uid 111); 11 Dec 2018 10:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:42:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:42:36 -0500
Date:   Tue, 11 Dec 2018 05:42:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/3] protocol v2 and hidden refs
Message-ID: <20181211104236.GA6899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the v2 protocol, hidden-ref config is not respected at all:

  $ git config transfer.hiderefs refs/tags/
  $ git -c protocol.version=0 ls-remote . | grep -c refs/tags
  0
  $ git -c protocol.version=2 ls-remote . | grep -c refs/tags
  1424

The fix in patch 3 is pretty straightforward, but note:

  - I'm a little worried this may happen again with future features. The
    root cause is that "ls-refs" follows a different code path than the
    ref advertisement for "upload-pack". So if we add any new config,
    it needs to go both places (non ref-advertisement config is OK, as
    the v2 "fetch" command is a lot closer to a v0 upload-pack).

    I think this is just an issue for any future features. I looked for
    other existing features which might be missing in v2, but couldn't
    find any.

    I don't know if there's a good solution. I tried running the whole
    test suite with v2 as the default. It does find this bug, but it has
    a bunch of other problems (notably fetch-pack won't run as v2, but
    some other tests I think also depend on v0's reachability rules,
    which v2 is documented not to enforce).

  - The "serve" command is funky, because it has no concept of whether
    the "ls-refs" is for fetching or pushing. Is git-serve even a thing
    that we want to support going forward?  I know part of the original
    v2 conception was that one would be able to just connect to
    "git-serve" and do a number of operations. But in practice the v2
    probing requires saying "I'd like to git-upload-pack, and v2 if you
    please". So no client ever calls git-serve.

    Is this something we plan to eventually move to? Or can it be
    considered a funny vestige of the development? In the latter case, I
    think we should consider removing it.

    I've worked around it here with patch 2, but note that "git serve"
    would not ever respect uploadpack.hiderefs nor receive.hiderefs
    (since it has no idea which operation it's doing).

The patches are:

  [1/3]: serve: pass "config context" through to individual commands
  [2/3]: parse_hide_refs_config: handle NULL section
  [3/3]: upload-pack: support hidden refs with protocol v2

 builtin/upload-pack.c |  1 +
 ls-refs.c             | 16 +++++++++++++++-
 ls-refs.h             |  3 ++-
 refs.c                |  3 ++-
 serve.c               |  9 +++++----
 serve.h               |  7 +++++++
 t/t5512-ls-remote.sh  |  6 ++++++
 upload-pack.c         |  4 ++--
 upload-pack.h         |  4 ++--
 9 files changed, 42 insertions(+), 11 deletions(-)

-Peff
