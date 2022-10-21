Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5501C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUVlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUVlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:41:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750C71A853A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:41:03 -0700 (PDT)
Received: (qmail 14433 invoked by uid 109); 21 Oct 2022 21:41:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 21:41:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16413 invoked by uid 111); 21 Oct 2022 21:41:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 17:41:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 17:41:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/4] repack tempfile-cleanup signal deadlock
Message-ID: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a series which should fix the deadlock Jan reported in:

  https://lore.kernel.org/git/00af268377fb7c3b8efd059482ee7449b71f48b1.camel@fnusa.cz/

I split it into a new thread since the problem here is distinct from the
one fixed in that thread (but they're indeed the same class of problem).
The fix is along the same lines as what I showed there, switching to
using the tempfile API. But this has the cleanups I noted there, plus
nice things like commit messages and tests.

As I noted there, pack-objects is still happy to leave its internal
tempfiles sitting around. I didn't tackle that in this series, since it
really is orthogonal, at least in terms of implementation.

I've cc'd Taylor for review. The main problem here goes all the way back
to a1bbc6c017 (repack: rewrite the shell script in C, 2013-09-15), but
the solution is enabled by your more recent populate_pack_ext(), etc.

  [1/4]: repack: convert "names" util bitfield to array
  [2/4]: repack: populate extension bits incrementally
  [3/4]: repack: use tempfiles for signal cleanup
  [4/4]: repack: drop remove_temporary_files()

 builtin/repack.c  | 78 ++++++++++++++---------------------------------
 t/t7700-repack.sh | 16 ++++++++++
 2 files changed, 39 insertions(+), 55 deletions(-)

-Peff
