Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD17C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582D320732
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDJTmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:42:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:40054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726663AbgDJTmM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:42:12 -0400
Received: (qmail 7602 invoked by uid 109); 10 Apr 2020 19:42:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:42:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2158 invoked by uid 111); 10 Apr 2020 19:52:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:52:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:42:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] better handling of gigantic config files
Message-ID: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fact that parse_config_key() requires its callers to use an "int"
for a string length has bugged me for a while, and it re-bugged me when
looking at it today. So I finally decided to do something about it,
which led to an odyssey of other small fixes and cleanups.

In particular, I was curious what kinds of bad behavior you could
provoke by having a key name larger than 2GB (especially because we use
the same parser for .gitmodules files, which might not be trusted). It
turns out: basically none, because the config parser chokes immediately
dues to its own int/size_t confusion.

After patch 5, the config system _can_ actually handle stupidly-sized
config keys, but in the end I decided to explicitly disallow them.
There's downstream code that would be impossible to fix, and nobody
actually cares about this case working anyway. See patch 6 for more
discussion. I do still think the other patches are worth having as a
cleanup; the more code that is safe from unexpected integer truncation
the better.

  [1/6]: remote: drop auto-strlen behavior of make_branch() and make_rewrite()
  [2/6]: parse_config_key(): return subsection len as size_t
  [3/6]: config: drop useless length variable in write_pair()
  [4/6]: git_config_parse_key(): return baselen as size_t
  [5/6]: config: use size_t to store parsed variable baselen
  [6/6]: config: reject parsing of files over INT_MAX

 archive-tar.c      |  4 ++--
 builtin/help.c     |  2 +-
 builtin/reflog.c   |  2 +-
 config.c           | 42 +++++++++++++++++++++++++++++-------------
 config.h           |  4 ++--
 convert.c          |  2 +-
 fsck.c             |  2 +-
 ll-merge.c         |  2 +-
 promisor-remote.c  |  2 +-
 remote.c           | 37 +++++++++++++------------------------
 submodule-config.c |  3 ++-
 userdiff.c         |  4 ++--
 12 files changed, 56 insertions(+), 50 deletions(-)

-Peff
