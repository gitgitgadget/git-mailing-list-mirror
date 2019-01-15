Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793C71F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfAOAkH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 19:40:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59194 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbfAOAkH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Jan 2019 19:40:07 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3685D6042D;
        Tue, 15 Jan 2019 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547512805;
        bh=MIcp+rSoV6n7pJZwsZnSeQucwVe5iK2F8betG100HM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GfXYZZx3WY5FvsVZNu3OTivzlN1ooyDUQIJW1O0wZMpXjaend8PCVMBqGp0kDozT1
         TWq6JsJ/xprEgB5W8SGBXOyleg+WA3u6UilElvDe5nhBbKRq3XYEg+a9/IAxq3F1xy
         8uL9qPhHfMsiDM8ZVl2M8ngmeMU7V/wqT1BuJ1Sb0MbFYnt7V0kq9/mQFWZsgn+rdp
         P5mt9TE6jnyLEHJnrVwU7vJeGql8aJWkgFGFqHmgFzkJmo1LbDm2RaMzOQF8ScnkAe
         XILS1nmIWFVxlzo/+ZCLz3If8ah9mntcGIUraF+lKvxikOW7AWz2++XGYDA3afNxoz
         H62b+lr3TZ71qIjZ+gBwqXFWEqfDP34zdqHSWcaomf5QZJvINW1EvLx/N/swtfk4kY
         2k/MpOVZxxRKT/NOcEMWrVFg0iZaXuHDbK0ehKAhNGxZofAX5LYsiuXgpj2JiK4cuF
         7NSldWGdRph3Wo/8mfiAE9zYI3ILZEltF8VLnJIdBCCx8dqPyVJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/5] tree-walk object_id refactor
Date:   Tue, 15 Jan 2019 00:39:40 +0000
Message-Id: <20190115003946.932078-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce
In-Reply-To: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a small number of places in our codebase where we cast a
buffer of unsigned char to a struct object_id pointer. When we have
GIT_MAX_RAWSZ set to 32 (because we have SHA-256), one of these places
(the buffer for tree objects) can lead to us copying too much data when
using SHA-1 as the hash, since there are only 20 bytes to read.

Changes from v1:
* Use hashcpy instead of memcpy.
* Adopt Peff's suggestion for improving patch 3.

brian m. carlson (5):
  tree-walk: copy object ID before use
  match-trees: compute buffer offset correctly when splicing
  match-trees: use hashcpy to splice trees
  tree-walk: store object_id in a separate member
  cache: make oidcpy always copy GIT_MAX_RAWSZ bytes

 builtin/grep.c                     |  8 ++++----
 builtin/merge-tree.c               | 20 ++++++++++----------
 builtin/pack-objects.c             |  4 ++--
 builtin/reflog.c                   |  4 ++--
 cache-tree.c                       |  4 ++--
 cache.h                            |  2 +-
 contrib/coccinelle/object_id.cocci | 30 ------------------------------
 delta-islands.c                    |  2 +-
 fsck.c                             |  4 ++--
 http-push.c                        |  4 ++--
 list-objects.c                     |  6 +++---
 match-trees.c                      | 27 ++++++++++++++++++++-------
 notes.c                            |  4 ++--
 packfile.c                         |  2 +-
 revision.c                         |  4 ++--
 tree-diff.c                        |  6 +++---
 tree-walk.c                        | 21 ++++++++++++---------
 tree-walk.h                        |  9 ++++++---
 tree.c                             | 10 +++++-----
 unpack-trees.c                     |  6 +++---
 walker.c                           |  4 ++--
 21 files changed, 85 insertions(+), 96 deletions(-)

