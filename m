Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5DBC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFARh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFARh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:37:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B8136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:37:25 -0700 (PDT)
Received: (qmail 5841 invoked by uid 109); 1 Jun 2023 17:37:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:37:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25271 invoked by uid 111); 1 Jun 2023 17:37:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:37:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:37:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jim Pryor <dubiousjim@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 0/3] handling pathspec magic with --follow
Message-ID: <20230601173724.GA4158369@coredump.intra.peff.net>
References: <c2b73d05-1214-4e30-bab6-14e0b8d69773@app.fastmail.com>
 <20230527173903.GB1460206@coredump.intra.peff.net>
 <51012e79-c6ce-41dd-9755-960e065214ef@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51012e79-c6ce-41dd-9755-960e065214ef@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2023 at 09:00:27PM +0200, Jim Pryor wrote:

> Confirmed I have log.follow = true, and also GIT_NOGLOB_PATHSPECS set,
> thus the explicit `(glob)` magic.

OK, all of that makes sense. The same problem hits ":(icase)" and other
pathspec magic, too. So talking about :(glob) too much is kind of a red
herring, anyway.

> I'd be happy with --follow not working with the wildcard pathspecs,
> but with the crash avoided.

Here's a series that I think should improve things for you. For an
explicit --follow, it finds the forbidden magic sooner (which gives us a
nice error message instead of the BUG()), and for log.follow, it avoids
follow-mode when forbidden pathspecs are used rather than enabling it
and then complaining.

The interesting bits are in the third patch. The other two are
preparatory.

  [1/3]: pathspec: factor out magic-to-name function
  [2/3]: diff: factor out --follow pathspec check
  [3/3]: diff: detect pathspec magic not supported by --follow

 builtin/log.c  |  2 +-
 diff.c         | 29 +++++++++++++++++++++++++++--
 diff.h         |  7 +++++++
 pathspec.c     | 19 ++++++++++++-------
 pathspec.h     |  8 ++++++++
 t/t4202-log.sh | 15 +++++++++++++++
 6 files changed, 70 insertions(+), 10 deletions(-)

