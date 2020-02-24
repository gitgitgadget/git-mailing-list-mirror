Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6122C35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B420658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBXE00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:26:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:52280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727188AbgBXE00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:26:26 -0500
Received: (qmail 5158 invoked by uid 109); 24 Feb 2020 04:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:26:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6816 invoked by uid 111); 24 Feb 2020 04:35:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:35:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:26:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/10] removing nth_packed_object_sha1()
Message-ID: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series gets rid of nth_packed_object_sha1(), converting its
remaining callers to nth_packed_object_oid(). The latter provides better
type-safety in general, and it also allowed me to clean up some tricky
bits of the pack-verification code (patch 7 below).

This was inspired by brian's work in:

 https://lore.kernel.org/git/20200222201749.937983-2-sandals@crustytoothpaste.net/

but I decide not to base it on that series. It's semantically
independent, and with the exception of one line, textually independent
(patch 4 here touches a different parameter in the same call as the
patch linked above). So I think it's easier to handle them independently
and just resolve the trivial conflict.

  [01/10]: nth_packed_object_oid(): use customary integer return
  [02/10]: pack-objects: read delta base oid into object_id struct
  [03/10]: pack-objects: convert oe_set_delta_ext() to use object_id
  [04/10]: pack-objects: use object_id struct in pack-reuse code
  [05/10]: pack-bitmap: use object_id when loading on-disk bitmaps
  [06/10]: pack-check: convert "internal error" die to a BUG()
  [07/10]: pack-check: push oid lookup into loop
  [08/10]: packed_object_info(): use object_id for returning delta base
  [09/10]: packed_object_info(): use object_id internally for delta base
  [10/10]: packfile: drop nth_packed_object_sha1()

 builtin/cat-file.c     |  2 +-
 builtin/pack-objects.c | 48 +++++++++++++++--------------
 midx.c                 |  2 +-
 object-store.h         |  2 +-
 pack-bitmap.c          | 16 +++++-----
 pack-check.c           | 22 ++++++--------
 pack-objects.c         |  4 +--
 pack-objects.h         |  2 +-
 packfile.c             | 69 ++++++++++++++++++------------------------
 packfile.h             | 15 +++------
 ref-filter.c           |  4 +--
 sha1-file.c            |  8 ++---
 sha1-name.c            | 13 ++++----
 13 files changed, 94 insertions(+), 113 deletions(-)

-Peff
