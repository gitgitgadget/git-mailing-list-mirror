Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C40664E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBPOoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:44:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:34158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhBPOod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:44:33 -0500
Received: (qmail 13361 invoked by uid 109); 16 Feb 2021 14:43:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:43:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24693 invoked by uid 111); 16 Feb 2021 14:43:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:43:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:43:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 0/6] open in-tree files with O_NOFOLLOW
Message-ID: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
 <87y2foaltl.fsf@evledraar.gmail.com>
 <YCsc0OePtrotjeg5@coredump.intra.peff.net>
 <YCu/FoLl8p15mwio@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCu/FoLl8p15mwio@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 07:48:23AM -0500, Jeff King wrote:

> I am beginning to wonder if just opening them all with O_NOFOLLOW (and a
> hacky 2-syscall fallback for portability) might be less ugly than all of
> this.

So here's what that series might look like. It would replace all of this
verify_path() stuff entirely (and fsck, though we might want to add
detection to fsck just as an informational thing). It gives similar
protections, and would similarly force people using an in-tree symlink
to stop doing that. But it makes it much less of a pain to do so,
because they can still check out, etc; the symlinks just won't be
followed.

I think we could even use the same technique to roll back the
restrictions on .gitmodules being a symlink. That one makes me a bit
more nervous, just because we also write it. I _think_ that might be
safe, because we only do so using a temp file and rename(), which should
replace the symlink.

  [1/6]: add open_nofollow() helper
  [2/6]: attr: convert "macro_ok" into a flags field
  [3/6]: exclude: add flags parameter to add_patterns()
  [4/6]: attr: do not respect symlinks for in-tree .gitattributes
  [5/6]: exclude: do not respect symlinks for in-tree .gitignore
  [6/6]: mailmap: do not respect symlinks for in-tree .mailmap

 attr.c                    | 60 +++++++++++++++++++++++++--------------
 builtin/sparse-checkout.c |  8 +++---
 dir.c                     | 21 ++++++++++----
 dir.h                     |  3 +-
 git-compat-util.h         |  7 +++++
 mailmap.c                 | 22 ++++++++++----
 t/t0003-attributes.sh     | 36 +++++++++++++++++++++--
 t/t0008-ignores.sh        | 34 ++++++++++++++++++++++
 t/t4203-mailmap.sh        | 31 ++++++++++++++++++++
 wrapper.c                 | 16 +++++++++++
 10 files changed, 197 insertions(+), 41 deletions(-)

-Peff
